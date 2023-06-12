function varargout = pcd(varargin)
% PCD MATLAB code for pcd.fig
%      PCD, by itself, creates a new PCD or raises the existing
%      singleton*.
%
%      H = PCD returns the handle to a new PCD or the handle to
%      the existing singleton*.
%
%      PCD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PCD.M with the given input arguments.
%
%      PCD('Property','Value',...) creates a new PCD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pcd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pcd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pcd

% Last Modified by GUIDE v2.5 29-Sep-2022 13:14:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pcd_OpeningFcn, ...
                   'gui_OutputFcn',  @pcd_OutputFcn, ...
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


% --- Executes just before pcd is made visible.
function pcd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pcd (see VARARGIN)

% Choose default command line output for pcd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pcd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pcd_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
Ukuran = size(F);
tinggi = Ukuran(1);
lebar = Ukuran(2);
 
G = F;
for baris=2 : tinggi-1
    for kolom=2 : lebar-1
        minPiksel = min([F(baris-1, kolom-1)       ...
            F(baris-1, kolom) F(baris, kolom+1)    ...
            F(baris, kolom-1)                      ...
            F(baris, kolom+1) F(baris+1, kolom-1)  ...
            F(baris+1, kolom) F(baris+1, kolom+1)]);
        maksPiksel = max([F(baris-1, kolom-1)       ...
            F(baris-1, kolom) F(baris, kolom+1)    ...
            F(baris, kolom-1)                      ...
            F(baris, kolom+1) F(baris+1, kolom-1)  ...
            F(baris+1, kolom) F(baris+1, kolom+1)]);    
            
        if F(baris, kolom) < minPiksel
           G(baris, kolom) = minPiksel;
        else
            if F(baris, kolom) > maksPiksel
                G(baris, kolom) = maksPiksel;
            else
                G(baris, kolom) = F(baris, kolom);
            end
        end    
    end
end
axes(handles.axes2)
imshow(G);title('Filter Batas')

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);

F2 = double(F);
for baris=2 : tinggi-1
    for kolom=2 : lebar-1
        jum = F2(baris-1, kolom-1)+ ...
              F2(baris-1, kolom) + ...
              F2(baris-1, kolom-1) + ...
              F2(baris, kolom-1) + ...
              F2(baris, kolom) + ...
              F2(baris, kolom+1) + ...
              F2(baris+1, kolom-1) + ...
              F2(baris+1, kolom) + ...
              F2(baris+1, kolom+1);
         
         G(baris, kolom) = uint8(1/9 * jum);
    end
end
axes(handles.axes2)
imshow(G);title('Filter Rerata')

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 
for baris=2 : tinggi-1
    for kolom=2 : lebar-1
        data = [F(baris-1, kolom-1) ...
              F(baris-1, kolom)  ...
              F(baris-1, kolom+1)  ...
              F(baris, kolom-1)  ...
              F(baris, kolom)  ...
              F(baris, kolom+1)  ...
              F(baris+1, kolom-1)  ...
              F(baris+1, kolom)  ...
              F(baris+1, kolom+1)];
 
         % Urutkan
         for i=1 : 8
             for j=i+1 : 9
                 if data(i) > data(j)
                     tmp = data(i);
                     data(i) = data(j);
                     data(j) = tmp;
                 end
             end
         end
         
         % Ambil nilai median
         G(baris, kolom) = data(5);
    end
end
axes(handles.axes2)
imshow(G);title('Filter Median')

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename pathname]=uigetfile('*.jpg;*.bmp;*.jpeg;*.png;*.tif;');

imgname=[pathname filename];
axes(handles.axes1)
imshow(imgname);title('Gambar Mentah')
set(handles.text1,'string',imgname)
F=getimage(handles.axes1);
[rows, columns, numberOfColorChannels] = size(F);
ukuran = [num2str(rows) ' x ' num2str(columns) ' : ' num2str(numberOfColorChannels)];
    set(handles.text11,'string',ukuran)
    axis off;
%imshow(I,[]);
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 
for y=1 : tinggi
    for x=1 : lebar
        x2 = lebar - x + 1;
        y2 = y;
        
        G(y, x) = F(y2, x2); 
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Pencerminan Horizontal')

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 
for y=1 : tinggi
    for x=1 : lebar
        x2 = lebar - x + 1;
        y2 = tinggi - y + 1;
        
        G(y, x) = F(y2, x2); 
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Pencerminan Horizontal dan Vertikal')

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 
for y=1 : tinggi
    for x=1 : lebar
        x2 = x;
        y2 = tinggi - y + 1;
        
        G(y, x) = F(y2, x2); 
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Pencerminan Vertikal')


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
dimensi = size(F);
tinggi = dimensi(1);
lebar = dimensi(2);
xc = round(lebar / 2);
yc = round(tinggi / 2);
 
alpha = 43 * pi / 180;
rmaks = 0.5 * sqrt(xc^2 + yc ^ 2); % 1/2 diagonal citra
 
for y=1 : tinggi
    for x=1 : lebar
        r = sqrt((x-xc)^2+(y-yc)^2);
        beta = atan2(y-yc, x-xc) + alpha * (rmaks - r) / rmaks;
        x2 = xc + r * cos(beta);
        y2 = yc + r * sin(beta);
       

        if (x2>=1) && (x2<=lebar) && ...
           (y2>=1) && (y2<=tinggi)
       
           % Lakukan interpolasi bilinear 
           p = floor(y2);
           q = floor(x2);
           a = y2-p;
           b = x2-q;
 
           if (floor(x2)==lebar) || ...
              (floor(y2) == tinggi)
              G(y, x) = F(floor(y2), floor(x2));
           else
              intensitas = (1-a)*((1-b)*F(p,q) +  ...
              b * F(p, q+1)) +      ...
              a *((1-b)* F(p+1, q) + ...
              b * F(p+1, q+1));
 
              G(y, x) = intensitas;
           end
        else
           G(y, x) = 0; 
        end   
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Transformasi Twirl')

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
ax = 10;
ay = 15;
tx = 150;
ty = 250;
dimensi = size(F);
tinggi = dimensi(1);
lebar = dimensi(2);
for y=1 : tinggi
    for x=1 : lebar
        x2 = x + ax * sin(2 * pi * y / tx);
        y2 = y + ay * sin(2 * pi * x / ty);
        if (x2>=1) && (x2<=lebar) && ...
           (y2>=1) && (y2<=tinggi)
       
           % Lakukan interpolasi bilinear 
           p = floor(y2);
           q = floor(x2);
           a = y2-p;
           b = x2-q;
 
           if (floor(x2)==lebar) || ...
              (floor(y2) == tinggi)
              G(y, x) = F(floor(y2), floor(x2));
           else
              intensitas = (1-a)*((1-b)*F(p,q) +  ...
              b * F(p, q+1)) +      ...
              a *((1-b)* F(p+1, q) + ...
              b * F(p+1, q+1));
 
              G(y, x) = intensitas;
           end
        else
           G(y, x) = 0; 
        end   
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Transformasi Ripple')

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
pro_img=getimage(handles.axes2);
[name path] = uiputfile({'*.png','PNG (*.PNG)';'*.jpg','JPG (*.jpg)'},'Save Image');
imwrite(pro_img,fullfile(path,name));
msgbox('Gambar berhasil disimpan!')


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
dimensi = size(F);
tinggi = dimensi(1);
lebar = dimensi(2);
xc = round(lebar / 2);
yc = round(tinggi / 2);
rho = 1.8;
rmaks = xc;  % 1/2 lebar gambar
 
for y=1 : tinggi
    for x=1 : lebar
        r = sqrt((x-xc)^2+(y-yc)^2);
        z = sqrt(rmaks^2-r^2);
        bx = (1 - 1/rho) * asin((x-xc)/...
             sqrt((x-xc)^2+z^2));
        by = (1 - 1/rho) * asin((y-yc)/...
             sqrt((y-yc)^2+z^2));
        if r <= rmaks
            x2 = x - z * tan(bx);
            y2 = y - z * tan(by);
        else
            x2 = x;
            y2 = y;
        end
        
        if (x2>=1) && (x2<=lebar) && ...
           (y2>=1) && (y2<=tinggi)
       
           % Lakukan interpolasi bilinear 
           p = floor(y2);
           q = floor(x2);
           a = y2-p;
           b = x2-q;
 
           if (floor(x2)==lebar) || ...
              (floor(y2) == tinggi)
              G(y, x) = F(floor(y2), floor(x2));
           else
              intensitas = (1-a)*((1-b)*F(p,q) +  ...
              b * F(p, q+1)) +      ...
              a *((1-b)* F(p+1, q) + ...
              b * F(p+1, q+1));
 
              G(y, x) = intensitas;
           end
        else
           G(y, x) = 0; 
        end   
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Transformasi Spherical')

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
dimensi = size(F);
tinggi = dimensi(1);
lebar = dimensi(2);
a1 = 1.2;
a2 = 0.1;
a3 = 0.005;
a4 = -45;
b1 = 0.1;
b2 = 1;
b3 = 0.005;
b4 = -30
for y=1 : tinggi
    for x=1 : lebar
        x2 = a1 * x + a2 * y + a3 * x * y + a4;
        y2 = b1 * x + b2 * y + b3 * x * y + b4;
        
        if (x2>=1) && (x2<=lebar) && ...
           (y2>=1) && (y2<=tinggi)
       
           % Lakukan interpolasi bilinear 
           p = floor(y2);
           q = floor(x2);
           a = y2-p;
           b = x2-q;
 
           if (floor(x2)==lebar) || ...
              (floor(y2) == tinggi)
              G(y, x) = F(floor(y2), floor(x2));
           else
              intensitas = (1-a)*((1-b)*F(p,q) +  ...
              b * F(p, q+1)) +      ...
              a *((1-b)* F(p+1, q) + ...
              b * F(p+1, q+1));
 
              G(y, x) = intensitas;
           end
        else
           G(y, x) = 0; 
        end   
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Transformasi Bilinier')



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);

sx = str2num(get(handles.edit2,'string')); % Penggesaran arah horisontal
sy = str2num(get(handles.edit3,'string')); % Penggesaran arah vertikal
 
F2 = double(F);
G = zeros(size(F2));
for y=1 : tinggi
    for x=1 : lebar
        xlama = x - sx;
        ylama = y - sy;
        
        if (xlama>=1) && (xlama<=lebar) && ...
           (ylama>=1) && (ylama<=tinggi)
           G(y, x) = F2(ylama, xlama);
        else
           G(y, x) = 0; 
        end
    end
end
 
G = uint8(G);
axes(handles.axes2)
imshow(G);title('Hasil Translasi')

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double

% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);

sx = str2num(get(handles.edit4,'string')); % Penggesaran arah horisontal
sy = str2num(get(handles.edit5,'string')); % Penggesaran arah vertikal
sudut = str2num(get(handles.edit6,'string')); % Sudut pemutaran
rad = pi * sudut/180;
cosa = cos(rad);
sina = sin(rad);
F2 = double(F);
for y=1 : tinggi
    for x=1 : lebar    
        x2 = round((x-sx) * cosa + (y-sy) * sina) + sx;        
        y2 = round((y-sy) * cosa - (x-sx) * sina) + sy;         
        
        if (x2>=1) && (x2<=lebar) && ...
           (y2>=1) && (y2<=tinggi)
           G(y, x) = F2(y2, x2);
        else   
           G(y, x) = 0;
        end
    end
end
G = uint8(G);
axes(handles.axes2)
judul = ['Rotasi pusat (' get(handles.edit4,'string') ',' get(handles.edit5,'string') ')']
imshow(G);title(judul)

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
S = get(handles.popupmenu1, 'UserData');
[rows, columns, numberOfColorChannels] = size(F);
if numberOfColorChannels > 1
    F = rgb2gray(F);
end
G = edge(F, S.segmentasi);
axes(handles.axes2)
imshow(G);title(sprintf('Segmentasi %s', S.segmentasi));


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
switch get(handles.popupmenu1,'Value')   
    case 1
      S.segmentasi='Sobel';
    case 2
      S.segmentasi='Prewitt';
    case 3
        S.segmentasi='Roberts';
    case 4
        S.segmentasi='log';
    case 5
        S.segmentasi='Canny';
    otherwise
 end  
set(handles.popupmenu1, 'UserData', S);
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 
sudut = str2num(get(handles.edit6,'string')); % Sudut pemutaran
rad = pi * sudut/180;
cosa = cos(rad);
sina = sin(rad);
 
x11 = 1;     y11 = 1;
x12 = lebar; y12 = 1;
x13 = lebar; y13 = tinggi;
x14 = 1;     y14 = tinggi;
 
m = floor(tinggi/2);
n = floor(lebar/2);
 
% Menentukan pojok
x21 = ((x11-n) * cosa + (y11-m) * sina + n);
y21 = ((y11-m) * cosa - (x11-n) * sina + m);         
 
x22 = ((x12-n) * cosa + (y12-m) * sina + n);
y22 = ((y12-m) * cosa - (x12-n) * sina + m);         
 
x23 = ((x13-n) * cosa + (y13-m) * sina + n);
y23 = ((y13-m) * cosa - (x13-n) * sina + m);         
 
x24 = ((x14-n) * cosa + (y14-m) * sina + n);
y24 = ((y14-m) * cosa - (x14-n) * sina + m);         
 
ymin = min([y21 y22 y23 y24]);
xmin = min([x21 x22 x23 x24]);
 
ymak = max([y21 y22 y23 y24]);
xmak = max([x21 x22 x23 x24]);
 
lebar_baru = xmak - xmin + 1;
tinggi_baru = ymak - ymin + 1;
tambahan_y = floor((tinggi_baru-tinggi)/2);
tambahan_x = floor((lebar_baru-lebar)/2);
F2=zeros(tinggi_baru, lebar_baru);
for y=1 : tinggi
   for x=1 : lebar
       F2(y+tambahan_y, x+tambahan_x) = F(y, x);
   end
end
 
% Putar citra
m = floor(tinggi_baru/2);
n = floor(lebar_baru/2);
 
for y=1 : tinggi_baru
    for x=1 : lebar_baru    
        x2 = round((x-n) * cosa + (y-m) * sina + n);        
        y2 = round((y-m) * cosa - (x-n) * sina + m);         
        
        if (x2>=1) && (x2<=lebar_baru) && ...
           (y2>=1) && (y2<=tinggi_baru)
           G(y, x) = F2(y2,x2);
        else
           G(y,x) = 0; 
        end
    end
end
 

G = uint8(G);
axes(handles.axes2)
imshow(G);title('Hasil Rotasi Pusat Gambar Pas')

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 
sudut = str2num(get(handles.edit6,'string')); % Sudut pemutaran
rad = pi * sudut/180;
cosa = cos(rad);
sina = sin(rad);
F2 = double(F);
 
m = floor(tinggi / 2); 
n = floor(lebar / 2); 
 
for y=1 : tinggi
    for x=1 : lebar  
        x2 = round((x-n) * cosa + (y-m) * sina + n);        
        y2 = round((y-m) * cosa - (x-n) * sina + m);         
        
        if (x2>=1) && (x2<=lebar) && ...
           (y2>=1) && (y2<=tinggi)
           G(y, x) = F2(y2,x2);
        else
           G(y,x) = 0; 
        end
    end
end
 

G = uint8(G);
axes(handles.axes2)
imshow(G);title('Hasil Rotasi Pusat Gambar')

function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
S = get(handles.popupmenu1, 'UserData');
[tinggi, lebar] = size(F);

sx = str2num(get(handles.edit7,'string')); % Penggesaran arah horisontal
sy = str2num(get(handles.edit8,'string')); % Penggesaran arah vertikal

tinggi_baru = round(tinggi * sy);
lebar_baru = round(lebar * sx);
 
F2 = double(F);
for y=1 : tinggi_baru
    y2 = (y-1) / sy + 1;
    for x=1 : lebar_baru
        x2 = (x-1) / sx + 1; 
        % Lakukan interpolasi bilinear 
        p = floor(y2);
        q = floor(x2);
        a = y2-p;
        b = x2-q;
 
        if (floor(x2)==lebar) || (floor(y2) == tinggi)
            G(y, x) = F(floor(y2), floor(x2));
        else
            intensitas = (1-a)*((1-b)*F(p,q) +  ...
            b * F(p, q+1)) +      ...
            a *((1-b)* F(p+1, q) + ...
            b * F(p+1, q+1));
 
            G(y, x) = intensitas;
        end
    end
end
 
G = uint8(G);
axes(handles.axes2)
[rows, columns, numberOfColorChannels] = size(G);
ukuran = [num2str(rows) ' x ' num2str(columns) ' : ' num2str(numberOfColorChannels)];
    set(handles.text11,'string',ukuran)
    axis off;
imagesc(G);title('Hasil Resize')
axis off;


% --- Executes on button press in pushbtton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes2);
axes(handles.axes1)
imshow(F);title('Gambar Mentah')
axis off;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F=getimage(handles.axes1);
[tinggi, lebar] = size(F);
 % mengkonversi citra rgb menjadi grayscale
 J = rgb2gray(F);
 % membuat inisial masking
 m = zeros(size(J,1),size(J,2));
 m(111:231,123:243) = 1;
 % segmentasi citra menggunakan active contour
 seg = activecontour(J,m,350);
 axes(handles.axes2)
 G = uint8(F);
 imshow(G);
 hold on
 contour(seg, 'y','LineWidth',2);
 hold off
 

axes(handles.axes2)
title('Kontur Aktif')
