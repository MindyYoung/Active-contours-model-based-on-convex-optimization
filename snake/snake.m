
% =========================================================================
%                   Snakes：Active Contour Models
% =========================================================================
% 基于KASS等的论文思想
% 参考文献：
% [1] KASS etc.Snakes：Active Contour Models
% [2] CSDN 博客 - Author：乐不思蜀Tone
% [3] Ritwik Kumar(Harvard University),D.Kroon（Twente University)的程序
% [4] 《数学建模与数学实验》
% ------
clc;clf;clear all;

% =========================================================================
%                      获取手动取点坐标
% =========================================================================
% 读取显示图像
%I = imread('Coronary_MPR.jpg');
I =  imread('dog2.jpg');
% 转化为双精度型
I = im2double(I); 
% 若为彩色，转化为灰度
if(size(I,3)==3), I=rgb2gray(I); end
figure(1),imshow(I);
%---------------------------
%        高斯滤波
%---------------------------
sigma=1;
% 创建特定形式的二维高斯滤波器H
H = fspecial('gaussian',ceil(3*sigma), sigma);
% 对图像进行高斯滤波,返回和I等大小矩阵
Igs = filter2(H,I,'same');
%---------------------------
%      获取Snake的点坐标
%---------------------------
figure(2),imshow(Igs);
x=[];y=[];c=1;N=100; %定义取点个数c,上限N
% 获取User手动取点的坐标
% [x,y]=getpts
while c<N
    [xi,yi,button]=ginput(1);
    % 获取坐标向量
    x=[x xi];
    y=[y yi];
    hold on
    % text(xi,yi,'o','FontSize',10,'Color','red');
    plot(xi,yi,'ro');
    % 若为右击，则停止循环
    if(button==3), break; end
    c=c+1;
end

% 将第一个点复制到矩阵最后，构成Snake环
xy = [x;y];
c=c+1;
xy(:,c)=xy(:,1);
% 样条曲线差值
t=1:c;
ts = 1:0.1:c;
xys = spline(t,xy,ts);
xs = xys(1,:);
ys = xys(2,:);
% 样条差值效果
hold on
temp=plot(x(1),y(1),'ro',xs,ys,'b.');
legend(temp,'原点','插值点');

% =========================================================================
%                     Snakes算法实现部分
% =========================================================================
NIter =1000; % 迭代次数
alpha=0.2; beta=0.2; gamma = 1; kappa = 0.1;
wl = 0; we=0.4; wt=0;
[row col] = size(Igs);

% 图像力-线函数
Eline = Igs;
% 图像力-边函数
[gx,gy]=gradient(Igs);
Eedge = -1*sqrt((gx.*gx+gy.*gy));
% 图像力-终点函数
% 卷积是为了求解偏导数，而离散点的偏导即差分求解
m1 = [-1 1]; 
m2 = [-1;1];
m3 = [1 -2 1]; 
m4 = [1;-2;1];
m5 = [1 -1;-1 1];
cx = conv2(Igs,m1,'same');
cy = conv2(Igs,m2,'same');
cxx = conv2(Igs,m3,'same');
cyy = conv2(Igs,m4,'same');
cxy = conv2(Igs,m5,'same');

for i = 1:row
    for j= 1:col
        Eterm(i,j) = (cyy(i,j)*cx(i,j)*cx(i,j) -2 *cxy(i,j)*cx(i,j)*cy(i,j) + cxx(i,j)*cy(i,j)*cy(i,j))/((1+cx(i,j)*cx(i,j) + cy(i,j)*cy(i,j))^1.5);
    end
end

%figure(3),imshow(Eterm);
%figure(4),imshow(abs(Eedge));
% 外部力 Eext = Eimage + Econ
Eext = wl*Eline + we*Eedge + wt*Eterm;
% 计算梯度
[fx,fy]=gradient(Eext);

xs=xs';
ys=ys';
[m n] = size(xs);
[mm nn] = size(fx);

% 计算五对角状矩阵
% 附录: 公式（14） b(i)表示vi系数(i=i-2 到 i+2)
b(1)=beta;
b(2)=-(alpha + 4*beta);
b(3)=(2*alpha + 6 *beta);
b(4)=b(2);
b(5)=b(1);

A=b(1)*circshift(eye(m),2);
A=A+b(2)*circshift(eye(m),1);
A=A+b(3)*circshift(eye(m),0);
A=A+b(4)*circshift(eye(m),-1);
A=A+b(5)*circshift(eye(m),-2);

% 计算矩阵的逆
[L U] = lu(A + gamma.* eye(m));
Ainv = inv(U) * inv(L); 

% =========================================================================
%                      画图部分
% =========================================================================
%text(10,10,'+','FontName','Time','FontSize',20,'Color','red');
% 迭代计算
figure(3)
for i=1:NIter;
    ssx = gamma*xs - kappa*interp2(fx,xs,ys);
    ssy = gamma*ys - kappa*interp2(fy,xs,ys);
 
    % 计算snake的新位置
    xs = Ainv * ssx;
    ys = Ainv * ssy;
    
    % 显示snake的新位置
    imshow(I); 
    hold on;
    plot([xs; xs(1)], [ys; ys(1)], 'r-');
    hold off;
    pause(0.001)    
end