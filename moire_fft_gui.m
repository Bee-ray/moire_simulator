 function varargout = moire_fft_gui(varargin)
% MOIRE_FFT_GUI MATLAB code for moire_fft_gui.fig
%      MOIRE_FFT_GUI, by itself, creates a new MOIRE_FFT_GUI or raises the existing
%      singleton*.
%
%      H = MOIRE_FFT_GUI returns the handle to a new MOIRE_FFT_GUI or the handle to
%      the existing singleton*.
%
%      MOIRE_FFT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOIRE_FFT_GUI.M with the given input arguments.
%
%      MOIRE_FFT_GUI('Property','Value',...) creates a new MOIRE_FFT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before moire_fft_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to moire_fft_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help moire_fft_gui

% Last Modified by GUIDE v2.5 18-Nov-2016 19:34:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @moire_fft_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @moire_fft_gui_OutputFcn, ...
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


% --- Executes just before moire_fft_gui is made visible.
function moire_fft_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to moire_fft_gui (see VARARGIN)

%set initial data values

handles.top_lattice_enabled = true;
handles.top_lattice_type = 'hexagonal';
handles.top_lcx = 1;
handles.top_lcy = 1;
handles.top_lct = 60*pi/180;
handles.top_angle = 10*pi/180;
handles.top_disp_x = 0;
handles.top_disp_y = 0;
handles.top_dot_color = 'k';
handles.top_dot_size = 6;

handles.bot_lattice_enabled=true;
handles.bot_lattice_type = 'hexagonal';
handles.bot_lcx = 1;
handles.bot_lcy = 1;
handles.bot_lct = 60*pi/180;
handles.bot_angle = 0;
handles.bot_disp_x = 0;
handles.bot_disp_y = 0;
handles.bot_dot_color = 'k';
handles.bot_dot_size = 6;

handles.mesh_min = -15;
handles.mesh_max = 15;
handles.xaxis_min = -10;
handles.xaxis_max = 10;
handles.yaxis_min = -10;
handles.yaxis_max = 10;

handles.Pbottom = [0;0];
handles.Ptop = [0;0];
handles.D = [0;0];

handles.image_from_file=false;
dir=pwd;
handles.filename=dir;
handles.browse_bool=false;
handles.window_function = 'Bartlett';
handles.log_scale_z = true;
handles.colorbar_min = 4.5;
handles.colorbar_max = 8.5;

%handles.polar_axes_enabled = get(handles.polar_axes_enabled_checkbox,'Value');;

handles.pax_xpos = 30.1099;
handles.pax_ypos = 70.1099;
handles.pax_width = 450;
handles.pax_height = 450;

handles.pax = polaraxes(handles.fft_panel,'Color','none','ThetaColor','r','GridColor','r','RColor','r','GridAlpha',0.3,'Tag','global_pax');
handles.pax.Units = 'pixels';
handles.pax.ThetaDir = 'clockwise';
handles.pax.RMinorGrid = 'on';
handles.pax.MinorGridLineStyle = '--';
handles.pax.MinorGridAlpha = 0.3;
%handles.pax.RTick = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
handles.pax.Position = [handles.pax_xpos handles.pax_ypos handles.pax_width handles.pax_height];
handles.rtick_f = 0.1;
handles.rtick_c = 0.2;

% Choose default command line output for moire_fft_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes moire_fft_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = moire_fft_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           LATTICE PANE CALLBACK FUNCTIONS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in top_lattice_enabled_checkbox.
function top_lattice_enabled_checkbox_Callback(hObject, eventdata, handles)

handles.top_lattice_enabled = get(handles.top_lattice_enabled_checkbox,'Value');

if ~handles.top_lattice_enabled
    set(handles.top_lattice_type_menu,'Enable','off');
    set(handles.top_lcx_box,'Enable','off');
    set(handles.top_lcy_box,'Enable','off');
    set(handles.top_lct_box,'Enable','off');
    set(handles.top_angle_box,'Enable','off');
    set(handles.top_disp_x_box,'Enable','off');
    set(handles.top_disp_y_box,'Enable','off');
    set(handles.top_dot_color_menu,'Enable','off');
    set(handles.top_dot_size_box,'Enable','off');
elseif handles.top_lattice_enabled
    set(handles.top_lattice_type_menu,'Enable','on');
    set(handles.top_lcx_box,'Enable','on');
    if strcmp(handles.top_lattice_type,'rectangular')
        set(handles.top_lcy_box,'Enable','on');
    elseif strcmp(handles.top_lattice_type,'triangular')
        set(handles.top_lcy_box,'Enable','on');
        set(handles.top_lct_box,'Enable','on');
    end
    set(handles.top_angle_box,'Enable','on');
    set(handles.top_disp_x_box,'Enable','on');
    set(handles.top_disp_y_box,'Enable','on');
    set(handles.top_dot_color_menu,'Enable','on');
    set(handles.top_dot_size_box,'Enable','on');
end

guidata(hObject, handles);

function top_lattice_type_menu_Callback(hObject, eventdata, handles)
% hObject    handle to bot_lattice_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bot_lattice_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bot_lattice_type

%handles.top_lattice_type = get(hObject,'String')
val = get(hObject, 'Value');
str = get(hObject, 'String');
switch str{val}
    case 'hexagonal'
        handles.top_lattice_type = 'hexagonal';
        set(handles.top_lcy_box,'Enable','off');
        set(handles.top_lct_box,'Enable','off');
    case 'rectangular'
        handles.top_lattice_type = 'rectangular';
        set(handles.top_lcy_box,'Enable','on');
        set(handles.top_lct_box,'Enable','off');
    case 'triangular'
        handles.top_lattice_type = 'triangular';
        set(handles.top_lcy_box,'Enable','on');
        set(handles.top_lct_box,'Enable','on');
end
guidata(hObject, handles);

function top_lcx_box_Callback(hObject, eventdata, handles)
% hObject    handle to top_lcx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of top_lcx as text
%        str2double(get(hObject,'String')) returns contents of top_lcx as a double

val = str2double(get(hObject,'String'));
handles.top_lcx = val;
guidata(hObject, handles);

function top_lcy_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.top_lcy = val;
guidata(hObject, handles);

function top_lct_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.top_lct = val*pi/180;
guidata(hObject, handles);

function top_angle_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.top_angle = val*pi/180;
guidata(hObject, handles);

function top_disp_x_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.top_disp_x = val;
guidata(hObject, handles);

function top_disp_y_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.top_disp_y = val;
guidata(hObject, handles);

function top_dot_color_menu_Callback(hObject, eventdata, handles)
%handles.top_dot_color = get(hObject,'String')<--this doesn't work
%you have to do this stuff instead:
val = get(hObject, 'Value');
str = get(hObject, 'String');
switch str{val}
    case 'black'
        handles.top_dot_color = 'k';
    case 'blue'
        handles.top_dot_color = 'b';
    case 'cyan'
        handles.top_dot_color = 'c';
    case 'green'
        handles.top_dot_color = 'g';
    case 'magenta'
        handles.top_dot_color = 'm';
    case 'red'
        handles.top_dot_color = 'r';
    case 'white'
        handles.top_dot_color = 'w';
    case 'yellow'
        handles.top_dot_color = 'y';
end
guidata(hObject, handles);

function top_dot_size_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.top_dot_size = val;
guidata(hObject, handles);



function bot_lattice_enabled_checkbox_Callback(hObject, eventdata, handles)

handles.bot_lattice_enabled = get(handles.bot_lattice_enabled_checkbox,'Value');

if ~handles.bot_lattice_enabled
    set(handles.bot_lattice_type_menu,'Enable','off');
    set(handles.bot_lcx_box,'Enable','off');
    set(handles.bot_lcy_box,'Enable','off');
    set(handles.bot_lct_box,'Enable','off');
    set(handles.bot_angle_box,'Enable','off');
    set(handles.bot_disp_x_box,'Enable','off');
    set(handles.bot_disp_y_box,'Enable','off');
    set(handles.bot_dot_color_menu,'Enable','off');
    set(handles.bot_dot_size_box,'Enable','off');
elseif handles.bot_lattice_enabled
    set(handles.bot_lattice_type_menu,'Enable','on');
    set(handles.bot_lcx_box,'Enable','on');
    if strcmp(handles.bot_lattice_type,'rectangular')
        set(handles.bot_lcy_box,'Enable','on');
    elseif strcmp(handles.bot_lattice_type,'triangular')
        set(handles.bot_lcy_box,'Enable','on');
        set(handles.bot_lct_box,'Enable','on');
    end
    set(handles.bot_angle_box,'Enable','on');
    set(handles.bot_disp_x_box,'Enable','on');
    set(handles.bot_disp_y_box,'Enable','on');
    set(handles.bot_dot_color_menu,'Enable','on');
    set(handles.bot_dot_size_box,'Enable','on');
end

guidata(hObject, handles);

function bot_lattice_type_menu_Callback(hObject, eventdata, handles)
%handles.bot_lattice_type = get(hObject,'String')
val = get(hObject, 'Value');
str = get(hObject, 'String');
switch str{val}
    case 'hexagonal'
        handles.bot_lattice_type = 'hexagonal';
        set(handles.bot_lcy_box,'Enable','off');
        set(handles.bot_lct_box,'Enable','off');
    case 'rectangular'
        handles.bot_lattice_type = 'rectangular';
        set(handles.bot_lcy_box,'Enable','on');
        set(handles.bot_lct_box,'Enable','off');
    case 'triangular'
        handles.bot_lattice_type = 'triangular';
        set(handles.bot_lcy_box,'Enable','on');
        set(handles.bot_lct_box,'Enable','on');
end
guidata(hObject, handles);

function bot_lcx_box_Callback(hObject, eventdata, handles)
    
val = str2double(get(hObject,'String'));
handles.bot_lcx = val;
guidata(hObject, handles);

function bot_lcy_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.bot_lcy = val;
guidata(hObject, handles);

function bot_lct_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.bot_lct = val*pi/180;
guidata(hObject, handles);

function bot_angle_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.bot_angle = val*pi/180;
guidata(hObject, handles);

function bot_disp_x_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.bot_disp_x = val;
guidata(hObject, handles);

function bot_disp_y_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.bot_disp_y = val;
guidata(hObject, handles);

function bot_dot_color_menu_Callback(hObject, eventdata, handles)
%handles.bot_dot_color = get(hObject,'String')
val = get(hObject, 'Value');
str = get(hObject, 'String');
switch str{val}
    case 'black'
        handles.bot_dot_color = 'k';
    case 'blue'
        handles.bot_dot_color = 'b';
    case 'cyan'
        handles.bot_dot_color = 'c';
    case 'green'
        handles.bot_dot_color = 'g';
    case 'magenta'
        handles.bot_dot_color = 'm';
    case 'red'
        handles.bot_dot_color = 'r';
    case 'white'
        handles.bot_dot_color = 'w';
    case 'yellow'
        handles.bot_dot_color = 'y';
end
guidata(hObject, handles);

function bot_dot_size_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.bot_dot_size = val;
guidata(hObject, handles);


function xaxis_min_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.xaxis_min = val;
guidata(hObject, handles);

function xaxis_max_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.xaxis_max = val;
guidata(hObject, handles);

function yaxis_min_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.yaxis_min = val;
guidata(hObject, handles);

function yaxis_max_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.yaxis_max = val;
guidata(hObject, handles);

function mesh_min_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.mesh_min = val;
guidata(hObject, handles);

function mesh_max_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.mesh_max = val;
guidata(hObject, handles);


% --- Executes on button press in clear_lattice_plot.
function clear_lattice_plot_button_Callback(hObject, eventdata, handles)

%h=moire_fft_gui;
h = hObject.Parent.Parent;
set(h,'CurrentAxes',handles.lattice_plot);

%comments below are a workaround that was replaced with the current line
%hold off;
%plot([handles.xaxis_min+1:handles.xaxis_max-1],[handles.yaxis_min+1:handles.yaxis_max-1],'w.','MarkerFaceColor','w');
%axis([handles.xaxis_min,handles.xaxis_max,handles.yaxis_min,handles.yaxis_max]);

%the following comments and 'delete' line written by Winry R. Vulcu
%'handles' passes all handles of the caller as a struct (or more
%accurately, when this function is called all of the GUI figure handles are
%passed to it via this struct), in the form of handles.('object_tag')
%Thus, 'handles.lattice_plot' is the handle of the axes who's plot data
%(children, in the matlab GUI hierarchy) we want to delete
delete(get(handles.lattice_plot,'Children'));
guidata(hObject, handles);

% --- Executes on button press in generate_lattice_plot.
function generate_lattice_plot_button_Callback(hObject, eventdata, handles)
% hObject    handle to generate_lattice_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if handles.top_lattice_enabled
    %generates top lattice based on type selected
    if strcmp(handles.top_lattice_type, 'hexagonal')
        handles.Ptop = hex_grid(handles.top_lcx, handles.top_angle, handles.top_disp_x, handles.top_disp_y, handles.mesh_min, handles.mesh_max);
    elseif strcmp(handles.top_lattice_type, 'rectangular')
        handles.Ptop = rect_grid(handles.top_lcx, handles.top_lcy, handles.top_angle, handles.top_disp_x, handles.top_disp_y, handles.mesh_min, handles.mesh_max);
    elseif strcmp(handles.top_lattice_type, 'triangular')
        handles.Ptop = tri_grid(handles.top_lcx, handles.top_lcy, handles.top_lct, handles.top_angle, handles.top_disp_x, handles.top_disp_y, handles.mesh_min, handles.mesh_max);
    else
        error_message = 'the top lattice type was not determined'
    end
elseif ~handles.top_lattice_enabled
    Ptop = [0 0; 0 0];
end

if handles.bot_lattice_enabled
    %generates bottom lattice based on type selected
    if strcmp(handles.bot_lattice_type, 'hexagonal')
        handles.Pbottom = hex_grid(handles.bot_lcx, handles.bot_angle, handles.bot_disp_x, handles.bot_disp_y, handles.mesh_min, handles.mesh_max);
    elseif strcmp(handles.bot_lattice_type, 'rectangular')
        handles.Pbottom = rect_grid(handles.bot_lcx, handles.bot_lcy, handles.bot_angle, handles.bot_disp_x, handles.bot_disp_y, handles.mesh_min, handles.mesh_max);
    elseif strcmp(handles.bot_lattice_type, 'triangular')
        handles.Pbottom = tri_grid(handles.bot_lcx, handles.bot_lcy, handles.bot_lct, handles.bot_angle, handles.bot_disp_x, handles.bot_disp_y, handles.mesh_min, handles.mesh_max);
    else
        error_message = 'the bottom lattice type was not determined'
    end
elseif ~handles.bot_lattice_enabled
    Pbottom = [0 0; 0 0];
end


%clear any previous plot:
delete(get(handles.lattice_plot, 'Children'));

%these lines make sure that the lattice_plot axes are selected before
%drawing the plot:
h = hObject.Parent.Parent;
set(h,'CurrentAxes',handles.lattice_plot);

%this should change the axes mins and maxes to the user input values
axis([handles.xaxis_min,handles.xaxis_max,handles.yaxis_min,handles.yaxis_max]);

%turn on hold, plot the bottom lattice, then plot the top lattice on top of
%it
hold on;
top_marker_style = strcat(handles.top_dot_color,'o');
bot_marker_style = strcat(handles.bot_dot_color,'o');
if handles.bot_lattice_enabled
    plot(handles.Pbottom(1,:),handles.Pbottom(2,:),bot_marker_style,'MarkerSize',handles.bot_dot_size,'MarkerFaceColor',handles.bot_dot_color);
end
if handles.top_lattice_enabled
    plot(handles.Ptop(1,:),handles.Ptop(2,:),top_marker_style,'MarkerSize',handles.top_dot_size,'MarkerFaceColor',handles.top_dot_color);
end

guidata(hObject, handles);

% --- Executes on button press in generate_figure.
function create_lattice_figure_button_Callback(hObject, eventdata, handles)

%opens a new figure
lattice_fig1 = figure('Units','pixels','InnerPosition',[50 50 580 580],'Color','w','Resize','off');
hold on;
axis square;
axis([handles.xaxis_min, handles.xaxis_max, handles.yaxis_min, handles.yaxis_max]);

%plots the two lattices
top_marker_style = strcat(handles.top_dot_color,'o');
bot_marker_style = strcat(handles.bot_dot_color,'o');
plot(handles.Pbottom(1,:),handles.Pbottom(2,:),bot_marker_style,'MarkerSize',handles.bot_dot_size,'MarkerFaceColor',handles.bot_dot_color);
plot(handles.Ptop(1,:),handles.Ptop(2,:),top_marker_style,'MarkerSize',handles.top_dot_size,'MarkerFaceColor',handles.top_dot_color);

axis off;
ax = get(lattice_fig1,'CurrentAxes');
frame = getframe(ax);
axis on;

lattice_fig2 = figure('Units','pixels','InnerPosition',[500 50 450 450],'Color','w','Resize','off');
imshow(frame.cdata);

guidata(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           FFT PANEL CALLBACK FUNCTIONS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in the lattice plot radio button lattice_plot_rb.
function lattice_plot_rb_Callback(hObject, eventdata, handles)
% hObject    handle to lattice_plot_rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of lattice_plot_rb
handles.image_from_file=false;
set(handles.browse_button,'Enable','off');
set(handles.filename_box,'Enable','off');
guidata(hObject, handles);

% --- Executes on button press in file_rb.
function file_rb_Callback(hObject, eventdata, handles)
% hObject    handle to file_rb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of file_rb
%handles
handles.image_from_file=true;
set(handles.browse_button,'Enable','on');
set(handles.filename_box,'Enable','on');
guidata(hObject, handles);

function filename_box_Callback(hObject, eventdata, handles)
%handles.browse_bool
if handles.browse_bool==true
    set(hObject,'String',handles.filename);
elseif handles.browse_bool==false
    handles.filename = get(hObject,'String');
end
handles.browse_bool=false;
guidata(hObject, handles);

% --- Executes on button press in browse_button.
function browse_button_Callback(hObject, eventdata, handles)
x = imformats;
j=1;
for i=1:19
    if i==3 || i==7 || i==9 || i==10 || i==18
        y=x(i).ext;
        formats(j) = y(1);
        j=j+1;
        formats(j) = y(2);
    else
        formats(j) = x(i).ext;
    end
    j=j+1;
end
%formats.'
[fn,pn] = uigetfile(formats.','Please select an image file.');
handles.filename=strcat(pn,fn);
set(handles.filename_box,'String',handles.filename);
handles.browse_bool=true;
guidata(hObject, handles);

% --- Executes on selection change in window_function.
function window_function_menu_Callback(hObject, eventdata, handles)
val = get(hObject, 'Value');
str = get(hObject, 'String');
switch str{val}
    case 'Bartlett'
        handles.window_function = 'Bartlett';
    case 'Blackman'
        handles.window_function = 'Blackman';
    case 'Chebyshev'
        handles.window_function = 'Chebyshev';
    case 'Hamming'
        handles.window_function = 'Hamming';
    case 'Hann'
        handles.window_function = 'Hann';
    case 'Kaiser'
        handles.window_function = 'Kaiser';
    case 'Taylor'
        handles.window_function = 'Taylor';
    case 'rectangular'
        handles.window_function = 'rectangular';
    case 'triangular'
        handles.window_function = 'triangular';
end
guidata(hObject, handles);

% --- Executes on button press in polar_axes_enabled_checkbox.
function polar_axes_enabled_checkbox_Callback(hObject, eventdata, handles)

pax_on = get(handles.polar_axes_enabled_checkbox,'Value');

if pax_on
    handles.pax.Visible = 'on';
elseif ~pax_on
    handles.pax.Visible = 'off';
end

% --- Executes on button press in logarithmic_rb.
function logarithmic_rb_Callback(hObject, eventdata, handles)

handles.log_scale_z = true;
guidata(hObject, handles);

% --- Executes on button press in linear_rb.
function linear_rb_Callback(hObject, eventdata, handles)

handles.log_scale_z = false;
guidata(hObject, handles);

function colorbar_min_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.colorbar_min = val;
guidata(hObject, handles);

function colorbar_max_box_Callback(hObject, eventdata, handles)

val = str2double(get(hObject,'String'));
handles.colorbar_max = val;
guidata(hObject, handles);

% --- Executes on button press in generate_fft.
function generate_fft_button_Callback(hObject, eventdata, handles)

h = hObject.Parent.Parent; %h is set to the handle for the moire_fft_gui figure; this
                  %is used in the else statement below (if image_from_file
                  %is false) and again after the if/else statement
                  %(regardless of the value of image_from_file).
                  
h_children = h.Children; %this matrix contains the Children of the h graphics object

if handles.image_from_file == true
    raw_map = imread(handles.filename); %this line creates a matrix map of the image in the file
    map = double(rgb2gray(raw_map))./255; %this line converts raw_map to a
                    %grayscale map and stores the result as map; it then
                    %converts the values in map to doubles (from unsigned
                    %8-bit integers) and scales them to be between 0 and 1.
elseif handles.image_from_file == false
    h.CurrentAxes = handles.lattice_plot; %sets the current axes to lattice_plot
    
    %this next bit of code sets lat_pan to the graphics object that
    %contains the lattice plot; this is done so that the next block of code
    %can temporarily change its background color in order to minimize
    %artifacts in the fft
    j = size(h_children); %reminder that h_children is a matrix which contains all of the Children of the h graphics object
    for i=1:j(1)
        %get(h_children(i),'Tag');
        if strcmp(get(h_children(i),'Tag'),'lattice_panel')
            lat_pan = h_children(i);
        end
    end
    
    %this block of code changes the background color of the panel with the
    %lattice plot on it to white, then gets the image from the plot, then
    %changes the panel color back to its default gray. this is done in
    %order to minimize some of the artifacts in the fft.
    axis off; %turns off the lattice_plot axes lines and ticks
    lat_pan.BackgroundColor = 'w'; %sets the lattice_panel background color to white
    cartax = h.CurrentAxes; %creates an axes object from the figure handle
    frame = getframe(cartax); %creates a frame struct from the axes object
    lat_pan.BackgroundColor = [0.94 0.94 0.94]; %sets the lattice_panel background color back to its default grey
    axis on; %turns the lattice_plot axes back on
    
    d1 = size(frame.cdata); %this variable is used a couple lines down from here,
    
    h.CurrentAxes = handles.fft_plot; %sets the current axes to fft_plot

    map = double(frame.cdata(:,:,1))./255; %this line creates a matrix called map; it is the rows and columns of the
                                         %p=1 slice of the m by n by p 3D matrix that represents the image stored in
                                         %the frame struct; the values of map are then normalized to be btwn zero
                                         %and one.
    
    %map = map(3:d1, 1:d1-2); %this was done to cut off some white space that matlab
                             %added to the edges of the lattice plot
end

if ndims(map) ~= 2
    error_message = 'ERROR: map is not a 2D matrix!'
end

if strcmp(handles.window_function, 'Bartlett')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = bartlett(size(map, 1));
    Wc = bartlett(size(map, 2)).';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'Blackman')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = blackman(size(map, 1), 'periodic');
    Wc = blackman(size(map, 2), 'periodic').';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'Chebyshev')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = chebwin(size(map, 1));
    Wc = chebwin(size(map, 2)).';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'Hamming')
    %this applies a hamming window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = hamming(size(map, 1), 'periodic');
    Wc = hamming(size(map, 2), 'periodic').';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'Hann')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = hann(size(map, 1), 'periodic');
    Wc = hann(size(map, 2), 'periodic').';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'Kaiser')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = kaiser(size(map, 1));
    Wc = kaiser(size(map, 2)).';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'Taylor')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = taylorwin(size(map, 1));
    Wc = taylorwin(size(map, 2)).';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
elseif strcmp(handles.window_function, 'rectangular')
    %map does not need to be altered in this case because a rectangular
    %window function is automatically applied by virtue of the finite size
    %of the image
elseif strcmp(handles.window_function, 'triangular')
    %this applies a hann window function to the map (can handle both n-by-n and
    %n-by-m matricies)
    Wr = triang(size(map, 1));
    Wc = triang(size(map, 2)).';
    map = bsxfun(@times, bsxfun(@times, map, Wr), Wc);
else
    error_message = 'the window function was not determined'
end

%this if-block creates a padded 2D FFT of 'map'
[r,c]=size(map); %r is the number of rows in 'map' and c is the number of columns
if (r < 2048) && (c < 2048) %if map has fewer than 2048 rows AND columns ...
    fft_map = fft2(map, 2048, 2048); %... pad both to 2048
elseif r > c %if r OR c is > 2048 and r > c ...
    fft_map = fft2(map, r, r); %... pad the number of columns to r
elseif r < c %if r OR c is > 2048 and r < c ...
    fft_map = fft2(map, c, c); %... pad the number of rows to c
else %if r = c >= 2048 ...
    fft_map = fft2(map); %... don't pad fft_map
end

h.CurrentAxes = handles.fft_plot; %sets the current axes to fft_plot; this
                 %line is necessary to make sure that the fft image is
                 %drawn in the proper place

%These lines print the image of the fft to the fft_plot on the gui figure.
%The fft image is the shifted (so zero 'frequency' is at the center of the
%plot) natural log of the absolute value of the fft map.
cartax = h.CurrentAxes;
cartax.Color = 'none';
%imshow(fftshift(log(abs(fft_map))),[handles.colorbar_min handles.colorbar_max],'InitialMagnification',20);
if handles.log_scale_z == true
    himage = imshow(fftshift(log(abs(fft_map))),[handles.colorbar_min handles.colorbar_max],'InitialMagnification',30);
elseif handles.log_scale_z == false
    himage = imshow(fftshift(abs(fft_map)),[handles.colorbar_min handles.colorbar_max],'InitialMagnification',30);
else
    error_message = 'logarithmic vs. linear z-scale was not determined'
end
axis xy;
%h.CurrentAxes = handles.fft_plot;
%ax = h.CurrentAxes;
cm = pmkmp(128, 'LinearL');
colormap(cartax,cm);
c = colorbar(cartax);
c.Limits = [handles.colorbar_min handles.colorbar_max];

%Thes lines change the size and location of the colorbar are altered in
%order to make sure the plot and colorbar are of the proper size and in the
%correct place.
axpos = cartax.Position;
cpos = c.Position;
%c.Label.String = 'log of abs of fft2 of normalized intensity vals of lattice plot';
cpos(1) = .7313; %x_pos of colorbar, equals (x_pos of plot [30 pixels] plus
                %width of plot [450 pixels] plus gap btwn plot and colorbar
                %[10 pixels]) divided by the width of the fft panel (670
                %pixels)
cpos(2) = .1061; %y_pos of colorbar, equals y_pos of plot (70 pixels)
                 %divided by the height of the fft panel (660 pixels)
cpos(3) = .75*cpos(3); %width of colorbar set to 3/4 default
cpos(4) = .7031; %height of colorbar, equals height of plot (450 pixels)
                 %divided by (the height of the fft panel [660 pixels]
                 %minus 20 pixels [i don't know why])

cpos;
axpos;
c.Position = cpos;
%cartax.Position = axpos;

if handles.image_from_file == true
    %polar axes scaled to images not generated by moire_fft_gui is not
    %available at this time (Oct 18th, 2016)
    handles.pax.Visible = 'off';
elseif handles.image_from_file == false
    pax_on = get(handles.polar_axes_enabled_checkbox,'Value');
    if pax_on
        handles.pax.Visible = 'on';
    elseif ~pax_on
        handles.pax.Visible = 'off';
    end
    %the following code makes sure that handles.pax has the correct position
    xLeft = cartax.XLim(1);
    xRight = cartax.XLim(2);
    yBot = cartax.YLim(1);
    yTop = cartax.YLim(2);

    handles.pax_xpos = (xLeft*450/2048)+30;
    handles.pax_ypos = (yBot*450/2048)+70;
    handles.pax_width = ( (xRight - xLeft)*450/2048 );
    handles.pax_height = ( (yTop - yBot)*450/2048 );

    handles.pax.Position = [handles.pax_xpos handles.pax_ypos handles.pax_width handles.pax_height];

    %this block is used to calculate the radial values for the FFT
    Lx = handles.xaxis_max - handles.xaxis_min;
    Ly = handles.yaxis_max - handles.yaxis_min;
    %hold on;
    origFormat = get(0, 'format');
    format('long');
    if(handles.top_lattice_enabled)
        %Nx_top = Lx/handles.top_lcx;
        %Ny_top = Ly/handles.top_lcy;
        if strcmp(handles.top_lattice_type, 'hexagonal')
            Nx_top = Lx/( handles.top_lcx*cos(pi/6) );
            Ny_top = Ly/( handles.top_lcx*sin(pi/3) );
        elseif strcmp(handles.top_lattice_type, 'rectangular')
            Nx_top = Lx/handles.top_lcx;
            Ny_top = Ly/handles.top_lcy;
        elseif strcmp(handles.top_lattice_type, 'triangular')
            Nx_top = Lx/( handles.top_lcx*cos(handles.top_lct/2) );
            Ny_top = Ly/( handles.top_lcy*sin(handles.top_lct) );
        end
        x_top = 1025 + Nx_top*(2048/450);
        y_top = 1025 + Ny_top*(2048/450);
        top_xdat = [1025 x_top];
        top_ydat = [y_top 1025];
        %y_top2 = ((x_top - 1025)/2) + 1025;
        %top_ydat = [y_top y_top2];
        %plot(cartax,top_xdat,top_ydat,'mo');
    end
    if(handles.bot_lattice_enabled)
        %Nx_bot = Lx/handles.bot_lcx;
        %Ny_bot = Ly/handles.bot_lcy;
        if strcmp(handles.bot_lattice_type, 'hexagonal')
            Nx_bot = Lx/( handles.bot_lcx*cos(pi/6) );
            Ny_bot = Ly/( handles.bot_lcx*sin(pi/3) );
        elseif strcmp(handles.bot_lattice_type, 'rectangular')
            Nx_bot = Lx/handles.bot_lcx;
            Ny_bot = Ly/handles.bot_lcy;
        elseif strcmp(handles.bot_lattice_type, 'triangular')
            Nx_bot = Lx/( handles.bot_lcx*cos(handles.bot_lct/2) );
            Ny_bot = Ly/( handles.bot_lcy*sin(handles.bot_lct) );
        end
        x_bot = 1025 + Nx_bot*(2048/450);
        y_bot = 1025 + Ny_bot*(2048/450);
        bot_xdat = [1025 x_bot];
        bot_ydat = [y_bot 1025];
        %y_bot2 = ((x_bot - 1025)/2) + 1025;
        %bot_ydat = [y_bot y_bot2];
        %plot(cartax,bot_xdat,bot_ydat,'rx');
    end
    set(0,'format', origFormat);
    %hold off;

    if(handles.top_lattice_enabled)
        rtick_fine = (22.5/Ny_top)*(1/handles.top_lcy);
        rtick_course = (45/Ny_top)*(1/handles.top_lcy);
    elseif(handles.bot_lattice_enabled)
        rtick_fine = (22.5/Ny_bot)*(1/handles.bot_lcy);
        rtick_course = (45/Ny_bot)*(1/handles.bot_lcy);
    else
        rtick_fine = 0.1;
        rtick_course = 0.2;
    end

    handles.rtick_f = rtick_fine;
    handles.rtick_c = rtick_course;

    %handles.pax.RTickLabel = {'0'; num2str(rtick_fine); num2str(2*rtick_fine); num2str(3*rtick_fine); num2str(4*rtick_fine); num2str(5*rtick_fine); num2str(6*rtick_fine); num2str(7*rtick_fine); num2str(8*rtick_fine); num2str(9*rtick_fine); num2str(10*rtick_fine)};
    handles.pax.RTickLabel = {'0'; num2str(rtick_course); num2str(2*rtick_course); num2str(3*rtick_course); num2str(4*rtick_course); num2str(5*rtick_course)};

    %makes a pan object so i can redraw the polaraxes before and after a
    %pan operation is executed
    p = pan;
    p.ActionPreCallback = @fft_pan_button_down_Callback;
    p.ActionPostCallback = @fft_zoom_or_pan_Callback;
    p.Enable = 'on';

    %make a zoom obect so that i can redraw the polaraxes after a zoom
    %operation is executed
    z = zoom;
    z.ActionPostCallback = @fft_zoom_or_pan_Callback;
    z.Enable = 'on';
end

guidata(hObject, handles);

%this function executes after the fft_plot completes a zoom or a pan
%operation; it is used to redraw the polaraxes on the fft plot so that it
%stays accurate when using zoom or pan on the fft image
function fft_zoom_or_pan_Callback(hObj, event_obj)
% hObj         handle to the figure clicked on
% event_obj   object containing struct of event data 

%debug_message1 = 'this message is at the beginning of fft_zoom_or_pan_Callback'
hand = guidata(hObj); %this thing is like 'handles' object everywhere else in this program
hObj.CurrentAxes = hand.fft_plot; %sets hObj's CurrentAxes to the fft_plot
fft_cartax = hObj.CurrentAxes; %sets fft_cartax to the cartesian axes object associated with fft_plot
    
if hand.image_from_file == false
    %these lines store the new x and y limits of the cartesian axes as
    %variables for added clarity
    new_xLeft = fft_cartax.XLim(1);
    new_xRight = fft_cartax.XLim(2);
    new_yBot = fft_cartax.YLim(1);
    new_yTop = fft_cartax.YLim(2);

    %save the old width and height for pax so that the new ones can be
    %calculated from them
    old_pax_width = hand.pax_width;
    old_pax_height = hand.pax_height;

    %the magnification factors in the x- and y-directions are calculated
    %(although they should both be the same)
    x_magnif = 2048/(new_xRight - new_xLeft);
    y_magnif = 2048/(new_yTop - new_yBot);

    %the new pax x-position, y-position, width, and height are calculated here
    new_pax_xpos = (450/2048)*(1 - new_xLeft)*x_magnif + 30;
    new_pax_ypos = (450/2048)*(1 - new_yBot)*y_magnif + 70;
    new_pax_width = old_pax_width*x_magnif;
    new_pax_height = old_pax_height*y_magnif;

    %update the position for hand.pax
    hand.pax.Position = [new_pax_xpos new_pax_ypos new_pax_width new_pax_height];
    
    %check magnification, then determine whether RTicks are fine or course
    if (x_magnif >= 5) || (y_magnif >= 5)
        %hand.pax.GridAlpha = 0.35;
        %hand.pax.MinorGridAlpha = 0.35;
        hand.pax.RTick = [0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0];
        hand.pax.RTickLabel = {'0'; num2str(hand.rtick_f); num2str(2*hand.rtick_f); num2str(3*hand.rtick_f); num2str(4*hand.rtick_f); num2str(5*hand.rtick_f); num2str(6*hand.rtick_f); num2str(7*hand.rtick_f); num2str(8*hand.rtick_f); num2str(9*hand.rtick_f); num2str(10*hand.rtick_f)};
    else
        %hand.pax.GridAlpha = 0.25;
        %hand.pax.MinorGridAlpha = 0.25;
        hand.pax.RTick = [0 0.2 0.4 0.6 0.8 1.0];
        hand.pax.RTickLabel = {'0'; num2str(hand.rtick_c); num2str(2*hand.rtick_c); num2str(3*hand.rtick_c); num2str(4*hand.rtick_c); num2str(5*hand.rtick_c)};
    end
    
    %make sure that pax.Visible = 'on', assuming hand.polar_axes_enabled is true
    pax_on = get(hand.polar_axes_enabled_checkbox,'Value');
    if pax_on
        hand.pax.Visible = 'on';
    elseif ~pax_on
        hand.pax.Visible = 'off';
    end
end
guidata(hObj, hand);

%this function is like fft_zoom_or_pan_Callback above, except that it only
%deletes the polaraxes without redrawing them; this function executes after
%the mouse is clicked but before the pan operation is performed. this
%function exists as a stopgap: it looks kinda bad to have an incorrect and
%static polaraxes drawn on the plot while you're panning the image around.
function fft_pan_button_down_Callback(hObj, event_obj)

hand = guidata(hObj); %this thing is like 'handles' object everywhere else in this program

pax_on = get(hand.polar_axes_enabled_checkbox,'Value');
if pax_on
    hand.pax.Visible = 'off';
end

guidata(hObj, hand);


% --- Executes on button press in generate_fft_fig.
function create_fft_fig_button_Callback(hObject, eventdata, handles)
% hObject    handle to generate_fft_fig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = hObject.Parent.Parent; %sets the Panel h to the moire_gui_fft figure
fft_pan = hObject.Parent;

rect = [650 45 545 495];
fft_pan.BackgroundColor = 'w';
frame = getframe(h,rect); %creates a frame struct from the axes object
fft_pan.BackgroundColor = [0.94 0.94 0.94];

%opens a new figure
fft_fig = figure('Units','pixels','Color','w','InnerPosition',[600 50 535 495],'Resize','off');
imshow(frame.cdata);

guidata(hObject, handles);



% --- Executes on button press in clear_fft.
function clear_fft_button_Callback(hObject, eventdata, handles)

h = hObject.Parent.Parent;
h.CurrentAxes = handles.fft_plot;

delete(handles.fft_plot.Children);
guidata(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           LATTICE PANE CREATE FUNCTIONS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes during object creation, after setting all properties.
 function top_lattice_type_menu_CreateFcn(hObject, eventdata, handles)
 % hObject    handle to top_lattice_type_menu (see GCBO)
 % eventdata  reserved - to be defined in a future version of MATLAB
 % handles    empty - handles not created until after all CreateFcns called
 
 % Hint: popupmenu controls usually have a white background on Windows.
 %       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_lcx_box_CreateFcn(hObject, eventdata, handles)
 % hObject    handle to top_lcx_box (see GCBO)
 % eventdata  reserved - to be defined in a future version of MATLAB
 % handles    empty - handles not created until after all CreateFcns called
 
 % Hint: edit controls usually have a white background on Windows.
 %       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_lcy_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_lct_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_angle_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_disp_x_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_disp_y_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
  % --- Executes during object creation, after setting all properties.
 function top_dot_color_menu_CreateFcn(hObject, eventdata, handles)
 % hObject    handle to top_dot_color (see GCBO)
 % eventdata  reserved - to be defined in a future version of MATLAB
 % handles    empty - handles not created until after all CreateFcns called
 
 % Hint: popupmenu controls usually have a white background on Windows.
 %       See ISPC and COMPUTER.
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function top_dot_size_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 
 % --- Executes during object creation, after setting all properties.
 function bot_lattice_type_menu_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function bot_lcx_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function bot_lcy_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function bot_lct_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function bot_angle_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bot_angle_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 % --- Executes during object creation, after setting all properties.
 function bot_disp_x_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bot_disp_x_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 % --- Executes during object creation, after setting all properties.
 function bot_disp_y_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bot_disp_y_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
 function bot_dot_color_menu_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function bot_dot_size_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 
 % --- Executes during object creation, after setting all properties.
 function mesh_min_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
 function mesh_max_box_CreateFcn(hObject, eventdata, handles)
 
 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
 end
 % --- Executes during object creation, after setting all properties.
function xaxis_min_box_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function xaxis_max_box_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function yaxis_min_box_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes during object creation, after setting all properties.
function yaxis_max_box_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           FFT PANE CREATE FUNCTIONS          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes during object creation, after setting all properties.
function filename_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
dir=strcat(pwd,'\');
set(hObject,'String',dir);

% --- Executes during object creation, after setting all properties.
function window_function_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function colorbar_min_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorbar_min_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function colorbar_max_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorbar_max_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
