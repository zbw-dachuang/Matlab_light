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

% �������ã����Զ��壩
handles.sum_count = 12; % ȫ��ѭ������
handles.Red_label = 'n'; % ���'��'�ı�ʾ����
handles.Green_label = 'm'; % ���'��'�ı�ʾ����

% ��ʼ����
handles.current_number = 1; % ��ǰ��ָ���
        % ����һ����Ҫ��Ժ��ֽ�����ɫ�޸��Լ������޸�

        % style1 - ��ɫ�ġ��̡� ���Ϊ1
        % style2 - ��ɫ�ġ��졯 ���Ϊ2
        % style3 - ��ɫ�ġ��졯 ���Ϊ3
        % style4 - ��ɫ�ġ��̡� ���Ϊ4
        style1_num = ones(1,handles.sum_count/4);
        style2_num = ones(1,handles.sum_count/4) + 1;
        style3_num = ones(1,handles.sum_count/4) + 2;
        style4_num = ones(1,handles.sum_count/4) + 3;
        % ȫ������
        number = [style1_num,style2_num,style3_num,style4_num];

        %������������
        numberIndex = randperm(handles.sum_count);
        handles.number_order = number(numberIndex);
% ����Ԫ�طֱ�Ϊչʾ���ݣ�ʵ����Ա�������ȷ���ߴ��󣩣��ķ�ʱ��
handles.result = 1:handles.sum_count; % ���
handles.time = 1:handles.sum_count; % ����ʱ��
% Update handles structure
guidata(hObject, handles);
end

% --- Outputs from this function are returned to the command line.
function varargout = RedGreen_OutputFcn(hObject, eventdata, handles)
% �����ʾ
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

%%  ������Ӧ

% figure
% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)

% �ж��Ƿ�Ϊ�״ε��
    if handles.current_number ==1 || handles.current_number > handles.sum_count + 1
    else
        % �����״ε�����鿴��ǰ��ʾ������
        current_content = handles.number_order(handles.current_number-1);
        % ��ȡ��ǰ�ĵ����ť
        current_button = get(gcf,'currentcharacter');
        % ��ǰΪ���̡�
        if current_content == 1 || current_content == 4
            if current_button == handles.Green_label
                handles.result(handles.current_number-1) = 1; % '1'������ȷ
                set(handles.edit_result,'String','��ȷ');
            elseif current_button == handles.Red_label
                handles.result(handles.current_number-1) = 0; % '0'������ȷ
                set(handles.edit_result,'String','����');
            else
                % ������Ч����
                set(handles.edit_result,'String','������Ч');
                handles.result(handles.current_number-1) = 2; % '2'������Ч
            end
             
        % ��ǰΪ'��'
        elseif current_content == 2 || current_content == 3
            if current_button == handles.Red_label
                handles.result(handles.current_number-1) = 1; % '1'������ȷ
                set(handles.edit_result,'String','��ȷ');
            elseif current_button == handles.Green_label
                handles.result(handles.current_number-1) = 0; % '0'������ȷ
                set(handles.edit_result,'String','����');
            else
                % ������Ч����
                set(handles.edit_result,'String','������Ч');
                handles.result(handles.current_number-1) = 2; % '2'������Ч
            end

        end
    end
% Update handles structure
guidata(hObject, handles);

    mm(hObject, eventdata, handles);

    
end

%% �Զ�������״̬�仯ͼ��

% ʵ�ֺ���״̬�仯
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
            set(handles.label,'String','��');
         case 2
            set(handles.label,'ForegroundColor',[1,0,0]);
            set(handles.label,'String','��');
         case 3
            set(handles.label,'ForegroundColor',[0,1,0]);
            set(handles.label,'String','��');
         case 4
            set(handles.label,'ForegroundColor',[0,1,0]);
            set(handles.label,'String','��');
        end
    elseif handles.current_number > handles.sum_count
        set(handles.label,'ForegroundColor',[0,0,0]);
        set(handles.label,'String','����');
%        handles.time(handles.sum_count) = toc;
        % ������
        exportData(hObject, eventdata, handles); 
     
     end
     handles.current_number = handles.current_number + 1;
      
tic;       
% Update handles structure
guidata(hObject, handles);
end

%% ������
% ���ڽ����ݽ��������excel��
function exportData(hObject, eventdata, handles)
    % ���·��
    pathout = '/Users/cx/Desktop/RedGreenResult.csv';
    % �������ֱ��ʾչʾ��š��жϽ��������ʱ��
    resultCell_title = { 'order_number','result','time'};
    handles.number_order = handles.number_order';
    handles.result = handles.result';
    handles.time = handles.time';
    resultCell = cat(2,handles.number_order,handles.result);
    resultCell = cat(2,resultCell,handles.time);
    xlswrite(pathout, resultCell_title,1,'A1');
    xlswrite(pathout, resultCell,1,'A2');
    
end



%% ����

% �����ʾ
% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% ����ʱ����ʾ
% --- Executes during object creation, after setting all properties.
function edit_time_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
