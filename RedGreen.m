function varargout = RedGreen(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RedGreen_OpeningFcn, ...
                   'gui_OutputFcn',  @RedGreen_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

 if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
  else
    gui_mainfcn(gui_State, varargin{:});
 end
end

% --- Executes just before RedGreen is made visible.
function RedGreen_OpeningFcn(hObject, eventdata, handles, varargin)
% hObject    handle to figure
handles.output = hObject;

% 参数设置（可自定义）
handles.sum_count = 12; % 全部循环次数
handles.Red_label = 'n'; % 结果'红'的表示符号
handles.Green_label = 'm'; % 结果'绿'的表示符号

% 初始设置
handles.current_number = 1; % 当前所指序号
        % 按照一定的要求对汉字进行颜色修改以及本身修改

        % style1 - 红色的‘绿’ 编号为1
        % style2 - 红色的‘红’ 编号为2
        % style3 - 绿色的‘红’ 编号为3
        % style4 - 绿色的‘绿’ 编号为4
        style1_num = ones(1,handles.sum_count/4);
        style2_num = ones(1,handles.sum_count/4) + 1;
        style3_num = ones(1,handles.sum_count/4) + 2;
        style4_num = ones(1,handles.sum_count/4) + 3;
        % 全部序列
        number = [style1_num,style2_num,style3_num,style4_num];

        %进行重新排序
        numberIndex = randperm(handles.sum_count);
        handles.number_order = number(numberIndex);
% 三列元素分别为展示内容，实验人员结果（正确或者错误），耗费时间
handles.result = 1:handles.sum_count; % 结果
handles.time = 1:handles.sum_count; % 花费时间
% Update handles structure
guidata(hObject, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = RedGreen_OutputFcn(hObject, eventdata, handles)
% 最大化显示
figFrame = get( handles.figure1, 'JavaFrame' );
set(figFrame,'Maximized',1); 

varargout{1} = handles.output;
end

%% label
% --- Executes during object creation, after setting all properties.
function label_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% Update handles structure
guidata(hObject, handles);
end

%%  按键反应

% figure
% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)

% 判断是否为首次点击
    if handles.current_number ==1 || handles.current_number > handles.sum_count + 1
    else
        % 不是首次点击，查看当前显示的内容
        current_content = handles.number_order(handles.current_number-1);
        % 获取当前的点击按钮
        current_button = get(gcf,'currentcharacter');
        % 当前为‘绿’
        if current_content == 1 || current_content == 4
            if current_button == handles.Green_label
                handles.result(handles.current_number-1) = 1; % '1'代表正确
                set(handles.edit_result,'String','正确');
            elseif current_button == handles.Red_label
                handles.result(handles.current_number-1) = 0; % '0'代表正确
                set(handles.edit_result,'String','错误');
            else
                % 输入无效按键
                set(handles.edit_result,'String','输入无效');
                handles.result(handles.current_number-1) = 2; % '2'代表无效
            end
             
        % 当前为'红'
        elseif current_content == 2 || current_content == 3
            if current_button == handles.Red_label
                handles.result(handles.current_number-1) = 1; % '1'代表正确
                set(handles.edit_result,'String','正确');
            elseif current_button == handles.Green_label
                handles.result(handles.current_number-1) = 0; % '0'代表正确
                set(handles.edit_result,'String','错误');
            else
                % 输入无效按键
                set(handles.edit_result,'String','输入无效');
                handles.result(handles.current_number-1) = 2; % '2'代表无效
            end

        end
    end
% Update handles structure
guidata(hObject, handles);

    mm(hObject, eventdata, handles);

    
end

%% 自定义字体状态变化图像

% 实现汉字状态变化
function mm(hObject, eventdata, handles)
    if handles.current_number ==1
         tic;
    end
    set(handles.edit_time,'String',num2str(toc));
    if handles.current_number > 1 && handles.current_number <= handles.sum_count + 1
        handles.time(handles.current_number-1) = toc;
    end
     if handles.current_number <= handles.sum_count
        switch handles.number_order(handles.current_number) ;
        case 1
            set(handles.label,'ForegroundColor',[1,0,0]);
            set(handles.label,'String','绿');
         case 2
            set(handles.label,'ForegroundColor',[1,0,0]);
            set(handles.label,'String','红');
         case 3
            set(handles.label,'ForegroundColor',[0,1,0]);
            set(handles.label,'String','红');
         case 4
            set(handles.label,'ForegroundColor',[0,1,0]);
            set(handles.label,'String','绿');
        end
    elseif handles.current_number > handles.sum_count
        set(handles.label,'ForegroundColor',[0,0,0]);
        set(handles.label,'String','结束');
%        handles.time(handles.sum_count) = toc;
        % 输出结果
        exportData(hObject, eventdata, handles); 
     
     end
     handles.current_number = handles.current_number + 1;
      
tic;       
% Update handles structure
guidata(hObject, handles);
end

%% 结果输出
% 用于将数据进行输出到excel中
function exportData(hObject, eventdata, handles)
    % 输出路径
    pathout = '/Users/cx/Desktop/RedGreenResult.csv';
    % 结果标题分别表示展示序号、判断结果、花费时间
    resultCell_title = { 'order_number','result','time'};
    handles.number_order = handles.number_order';
    handles.result = handles.result';
    handles.time = handles.time';
    resultCell = cat(2,handles.number_order,handles.result);
    resultCell = cat(2,resultCell,handles.time);
    xlswrite(pathout, resultCell_title,1,'A1');
    xlswrite(pathout, resultCell,1,'A2');
    
end



%% 其他

% 结果显示
% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% 花费时间显示
% --- Executes during object creation, after setting all properties.
function edit_time_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
