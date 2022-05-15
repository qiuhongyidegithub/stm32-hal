%function DrawAttitude(pitch,roll,yaw)
%%

seriallist
pitch = 0;
roll = 0;
yaw = 0;
while 1:100
mode = 2;       %标记用那种方法进行计算表示用方向余弦矩阵进行计算



pitch=pitch+1;

r1 =3;        %大圆半径
r2 = 0.618*r1;    %小圆半径

if mode == 2
     pitch = -pitch;   
     roll = -roll;     
end
dc = [cosd(yaw)*cosd(pitch)-sind(yaw)*sind(roll)*sind(pitch)   sind(yaw)*cosd(pitch)+cosd(yaw)*sind(roll)*sind(pitch)   cosd(roll)*(-sind(pitch));
       sind(yaw)*(-cosd(roll))                          cosd(yaw)*cosd(roll)                            sind(roll)        ;
       cosd(yaw)*sind(pitch)+sind(yaw)*sind(roll)*cosd(pitch)   sind(yaw)*sind(pitch)-cosd(yaw)*sind(roll)*cosd(pitch)      cosd(roll)*cosd(pitch) ];
%三角形规约：A为定点，B C为两边的角，具体方位如下
%       A
%     B   C
t_fpa = 35;      %三角形定点角度设置为40度
t_b = (180 - t_fpa) / 2;
t_c = t_b;
  
if t_fpa > asind((r2/r1))*2
     t_fpa = asind((r2/r1))*2;
end
  
%xd,yd,zd存放真是数值，与符号xyz区分开来
%约定 xd yd zd 第 1 2 3 4位分别代表三角形ABC的 A、B、A、C坐标
if mode == 2
    xd=[3 -1.2735;3 -1.2735];
    yd=[0  1.3474;0  -1.3474];
    zd=[0 0;0 0];
    %上面几个初始化的点是根据 定义的。
    %pitch = 0;
    %roll = 0;
    %yaw = 0;
    %r1 =3;        %大圆半径
    %r2 = 0.618*r1;    %小圆半径
else
    xd=[];
    yd=[];
    zd=[];
    tempA =[];     %保存中间计算角度，目前之用来保存角BOA
end
    temp = [];
if mode == 2
    temp = [xd(1,1) yd(1,1) zd(1,1);
            xd(1,2) yd(1,2) zd(1,2);
            xd(2,2) yd(2,2) zd(2,2)];
    temp = temp*dc;
    xd = [temp(1:2,1)';temp(1,1),temp(3,1)];
    yd = [temp(1:2,2)';temp(1,2),temp(3,2)];
    zd = [temp(1:2,3)';temp(1,3),temp(3,3)];
    %到此位置，方向余弦矩阵已经计算完毕，可以直接用后面的函数进行显示
end

surf(xd,yd,zd)
axis([-3 3 -3 3 -3 3])
xlabel('X')
ylabel('Y')
zlabel('Z')
text(xd(1,1),yd(1,1),zd(1,1),'A点')
text(xd(1,2),yd(1,2),zd(1,2),'B点')
text(xd(2,2),yd(2,2),zd(2,2),'C点')

hold on 
pause(0.5);
%%
%测试用圆
hold on
alpha=0:pi/20:2*pi;
x=r1*cos(alpha);
y=r1*sin(alpha);
plot(x,y);
  
hold on
x=r2*cos(alpha);
y=r2*sin(alpha);
plot(x,y);
  
hold off
end