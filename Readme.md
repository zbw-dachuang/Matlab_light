## Readme

制作人：zbw    完成时间：2020.11.24

#### 功能描述

提供一个GUI界面，用于显示四种状态，分别为：

- 红色的‘红’字
- 红色的‘绿’字
- 绿色的‘红’字
- 绿色的‘绿’字

运行之后，通过按下键盘上的按键给出自己的判断。

在目前的程序中，选择是‘n’字母认为为‘红’，‘m’字母认为为‘绿’。代码自身会记录使用者的回答是否正确，并记录反应时间，导出Excel表格。

Excel表格结果分为三列，分别为‘展示内容’、‘判断正确与否’、‘反应时间’

其中前两列使用数字进行代替，分别为：

| 信息         | 编号表示 |
| ------------ | -------- |
| 红色的‘红’字 | 2        |
| 绿色的‘红’字 | 3        |
| 红色的‘绿’字 | 1        |
| 绿色的‘绿’字 | 4        |
| 结果正确     | 1        |
| 结果错误     | 0        |

#### 使用方式

用户可自定义内容为：

- 显示次数（务必为4的倍数）：四种状态的全部出现次数
- 判断的按键【在现在的代码中，使用‘n’字母代表‘红’，‘m’字母代表‘绿】，可以自定义为其他的选项
- Excel存储路径

自定义内容已经在代码的头部使用【‘参数设置（自定义）’】进行标识，用于用户接口

#### 开发环境

- 开发平台：Matlab2017b
- 操作系统：Mac 【如果出现画面不兼容状况，请使用者按照实际情况进行更改】

#### 文件说明

- final_RedGreen的fig和m文件均为最终版本，界面中紧紧包含显示的字体
- RedGreen的fig和m文件中可以在操作过程中查看每一次的操作结果以及耗费时间

#### 写在最后

由于能力有限，代码并非十分完善和通用，如果有大佬愿意进行讨论，非常愿意学习！！！

