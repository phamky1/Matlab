function varargout = controllingLed(varargin)
% CONTROLLINGLED MATLAB code for controllingLed.fig
%      CONTROLLINGLED, by itself, creates a new CONTROLLINGLED or raises the existing
%      singleton*.
%
%      H = CONTROLLINGLED returns the handle to a new CONTROLLINGLED or the handle to
%      the existing singleton*.
%
%      CONTROLLINGLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROLLINGLED.popup1 with the given input arguments.
%
%      CONTROLLINGLED('Property','Value',...) creates a new CONTROLLINGLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before controllingLed_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to controllingLed_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help controllingLed

% Last Modified by GUIDE v2.5 10-Dec-2018 14:38:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @controllingLed_OpeningFcn, ...
                   'gui_OutputFcn',  @controllingLed_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before controllingLed is made visible.
function controllingLed_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to controllingLed (see VARARGIN)

% Choose default command line output for controllingLed
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes controllingLed wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = controllingLed_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear all;

global x;

x=serial('COM8','BAUD', 9600);



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
fprintf(x,'1');


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
fprintf(x,'0');


% --- Executes on selection change in popup1.
function popup1_Callback(hObject, eventdata, handles)
% hObject    handle to popup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup1

set(hObject,'String',getAvailableComPort);

% --- Executes during object creation, after setting all properties.
function popup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

delete(instrfindall);
set(hObject,'String',getAvailableComPort);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

comports=get(handles.popup1,'String');
chosencom=get(handles.popup1,'value');

global x;
if(~isempty(comports{chosencom}))
    set(x,'Port',comports{chosencom});
else
    cout(handles,'failed to conect u did not chose com port to conect')
end

try
  cout(handles,'conecting..')
  fopen(x);
catch
    try
      cout(handles,'Re-conecting..')
      %delete(instrfindall);
      fclose(instrfindall);
      fopen(x);
    catch
        cout(handles,strcat('can not conect with this port  :',...
        get(x,'Port')));
        return
    end
end

cout(handles,strcat('conected seccesfly to :', ...
    get(x,'port')))
set(handles.pushbutton1,'Enable','on');
set(handles.pushbutton2,'Enable','on');


% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
fclose(x);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x;
fclose(x);
cout(handles,'Disconected')
set(handles.pushbutton1,'Enable','off');
set(handles.pushbutton2,'Enable','off');



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cout(handles,str)
    currString= get(handles.edit3,'String');
    currString{end+1}=str;
    set(handles.edit3,'String',currString);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    tts('start the show');
    cout(handles,'start show');
    tts('hi my  name is azmy and iam a robot');
    tts('i was created at El shorouk academy');
    tts('under supervision of doctor  Abou El Oyoun');
    tts('and this is last update and final version to me');
    tts('in this version my team give me the ability to move my hand like this ');
    tts('as well as the ability of moving my head');
    tts('and they spent some effort to enhance my program and the speech communication');
    tts('and mix all this new features in executable program make me dance ');
    tts('and when i say dance, i mean literally robotics dance and i will show it to you');
    
    
    
    
