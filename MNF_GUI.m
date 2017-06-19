function varargout = MNF_GUI(varargin)
% MNF_GUI MATLAB code for MNF_GUI.fig
%      MNF_GUI, by itself, creates a new MNF_GUI or raises the existing
%      singleton*.
%
%      H = MNF_GUI returns the handle to a new MNF_GUI or the handle to
%      the existing singleton*.
%
%      MNF_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MNF_GUI.M with the given input arguments.
%
%      MNF_GUI('Property','Value',...) creates a new MNF_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MNF_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MNF_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MNF_GUI

% Last Modified by GUIDE v2.5 28-Apr-2017 02:24:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MNF_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MNF_GUI_OutputFcn, ...
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


% --- Executes just before MNF_GUI is made visible.
function MNF_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MNF_GUI (see VARARGIN)

% Choose default command line output for MNF_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MNF_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MNF_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
global image 
global row 
global col
global band_num
global N

[a b]=uigetfile('*.*','All Files');
%image=imread([b a]);
s=load([b a]);
image= struct2array(s);
[row,col,band_num] = size(image);
min1 = min(image(:));
image = image - min1*ones(row,col,band_num);
max1 = max(image(:));
image = image.*255/max1;
r=image(:,:,45);
g=image(:,:,20);
b=image(:,:,15);
trial=uint8(cat(3,r,g,b));
imshow(trial,'parent',handles.axes1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global pct_img

%figure,imshow([pct_img(:,:,5),pct_img(:,:,5),pct_img(:,:,5)])
 figure,imshow(pct_img(:,:,5),[]);
 title('pct 5');
 figure,imshow(pct_img(:,:,6),[]);
 title('pct 6');
 figure,imshow(pct_img(:,:,7),[]);
 title('pct 7');
 figure,imshow(pct_img(:,:,8),[]);
 title('pct 8');
 figure,imshow(pct_img(:,:,9),[]);
 title('pct 9');
 figure,imshow(pct_img(:,:,10),[]);
 title('pct 10');
 
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global mnf_img

figure, imshow(mnf_img(:,:,5),[]);
title('mnf 5');
figure, imshow(mnf_img(:,:,6),[]);
title('mnf 6');
figure, imshow(mnf_img(:,:,7),[]);
title('mnf 7');
figure, imshow(mnf_img(:,:,8),[]);
title('mnf 8');
figure, imshow(mnf_img(:,:,9),[]);
title('mnf 9');
figure, imshow(mnf_img(:,:,10),[]);
title('mnf 10');

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
%pct
global image
global pct_img
%s=load('Indian_pines.mat');
%image= struct2array(s);
[row,col,band_num] = size(image);
% convert image pixels to floating numbers
image = double(image);

% mean and normalizing image
for i=1:band_num
    % finding bandwise mean 
    mean(1,i) = mean2(image(:,:,i));
    % bandwise normalization
    X(:,:,i)=image(:,:,i)-mean(1,i)*ones(row,col);
    Y(:,:,i)=image(:,:,i)-mean(1,i)*ones(row,col);
end

% for covariance matrix
sum1=0;
for m=1:band_num
    for k=1:band_num
         for ro=1:row
            for co=1:col
                z=X(ro,co,m)*Y(ro,co,k);
                sum1= sum1+z;
            end
         end
         cov = sum1/((row*col)-1);
         cov_mat(m,k)=cov;
         sum1=0;
    end
end
    
                

% eigen value(val) and eigen vector(vect)
[vect,val] = eig(cov_mat);
% columnise eigen value
val = diag(val);
% sorting eigen value in descending order with their indices
[sort_val,index]=sort(val,'descend');

% sorting eigen vectors according to corresponding sorted eigen values
for j=1:length(sort_val)
    sort_vect(:,j) = vect(:,index(j));
end

% 
for r=1:row
    for c=1:col
        for b=1:band_num
            % pixel value of normalized image
            norml_img(b,1)= X(r,c,b);
        end
        % transformed value of each pixel
        % transformed = feture vector transpose * normalized image
        pct1 = sort_vect.'*norml_img;
        for count=1:band_num
            % principal component
            pct_img(r,c,count)=pct1(count,1);
        end
    end
end

pct_img = uint8(pct_img);

 imshow(pct_img(:,:,1),[],'parent',handles.axes7);
imshow(pct_img(:,:,2),[],'parent',handles.axes8);
imshow(pct_img(:,:,3),[],'parent',handles.axes9);


% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in mnf.
function mnf_Callback(hObject, eventdata, handles)
global image
global row 
global col
global band_num
global mnf_img
global N

for a=1:band_num
    DN(:,:,a)=[image(:,:,a);image(row,:,a)];
end
   

for band=1:band_num
    for c=1:row
        N(c,:,band)=DN(c,:,band)-DN(c+1,:,band);
    end
end


for n=1:band_num
    % finding bandwise mean of noise matrix
    mean_N(1,n) = mean2(N(:,:,n));
    % bandwise normalization of noise matrix
    X1(:,:,n)=N(:,:,n)-mean_N(1,n)*ones(row,col);
    Y1(:,:,n)=N(:,:,n)-mean_N(1,n)*ones(row,col);
end

% for covariance matrix
cov_N=zeros(band_num,band_num);
for t=1:band_num
    for s=t:band_num
        cov_N(t,s)=(sum(dot(X1(:,:,t),Y1(:,:,s))))/(row*col);
        cov_N(s,t)=cov_N(t,s);
    end
end

% eigen value(val_N) and eigen vector(vect_N) of noise
[vect_N,val_N] = eig(cov_N);
% columnise eigen value of N
val_N = diag(val_N);
% sorting eigen value in descending order with their indices
[sort_val_N,index_N]=sort(val_N,'descend');


% sorting eigen vectors according to corresponding sorted eigen values
for o=1:length(sort_val_N)
    sort_vect_N(:,o) = vect_N(:,index_N(o));
end


% transformation with noise eigenvector
Y_N = zeros(band_num,band_num);% Y_N normalize noise
for i=1:band_num
Y_N(:,i) = sort_vect_N(:,i)/sqrt(sort_val_N(i,1));
end


for r1=1:row
    for c1=1:col
        for b1=1:band_num
            % pixel value of image
            norml_img_N(b1,1)= image(r1,c1,b1);
        end
        % transformed value of each pixel with noise vector
        % transformed = feture noise vector transpose * original image
        pct_N = Y_N'*norml_img_N;
        for count1=1:band_num
            % principal component (noise)
            F(r1,c1,count1)=pct_N(count1,1);
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                          %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%       PCA                %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%                           %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% mean and normalizing image
for i=1:band_num
    % finding bandwise mean 
    mean(1,i) = mean2(F(:,:,i));
    % bandwise normalization
    X(:,:,i)=F(:,:,i)-mean(1,i)*ones(row,col);
    Y(:,:,i)=F(:,:,i)-mean(1,i)*ones(row,col);
end

% for covariance matrix
sum1=0;
for m=1:band_num
    for k=1:band_num
         for ro=1:row
            for co=1:col
                z = X(ro,co,m)*Y(ro,co,k);
                sum1= sum1+z;
            end
         end
         cov = sum1/((row*col)-1);
         cov_mat(m,k)=cov;
         sum1=0;
    end
end
    
                

% eigen value(val) and eigen vector(vect)
[vect,val] = eig(cov_mat);
% columnise eigen value
val = diag(val);
% sorting eigen value in descending order with their indices
[sort_val,index]=sort(val,'descend');

% sorting eigen vectors according to corresponding sorted eigen values
for j=1:length(sort_val)
    sort_vect(:,j) = vect(:,index(j));
end

% transformation
for r=1:row
    for c=1:col
        for b=1:band_num
            % pixel value of normalized image
            norml_img(b,1)= X(r,c,b);
        end
        % transformed value of each pixel
        % transformed = feture vector transpose * normalized image
        pct1 = sort_vect.'*norml_img;
        for count=1:band_num
            % principal component
            mnf_img(r,c,count)=pct1(count,1);
        end
    end
end
mnf_img = uint8(mnf_img);

SN1= reshape(N(:,:,14),[1,row*col]);
SN2= reshape(N(:,:,15),[1,row*col]);
scatter(SN1,SN2, 'parent', handles.axes6);

imshow(mnf_img(:,:,1),[],'parent',handles.axes10);
imshow(mnf_img(:,:,2),[],'parent',handles.axes11);
imshow(mnf_img(:,:,3),[],'parent',handles.axes12);

% hObject    handle to mnf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
