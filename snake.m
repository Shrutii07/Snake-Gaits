close all;
clc; clear all;

P = zeros(4,11);    % Positions of all the Joints.
P(:,1) = [0;0;0;1];
b = pi/2;
syms t;

% DH parameters of all links in the sequence "r,d,alpha,theta".
A0_1 = trans(10,0,b,angle(1));
A1_2 = trans(10,0,-b,angle(2));
A2_3 = trans(10,0,b,angle(3));
A3_4 = trans(10,0,-b,angle(4));
A4_5 = trans(10,0,b,angle(5));
A5_6 = trans(10,0,-b,angle(6));
A6_7 = trans(10,0,b,angle(7));
A7_8 = trans(10,0,-b,angle(8));
A8_9 = trans(10,0,b,angle(9));
A9_10= trans(10,0,-b,angle(10));

for j= 0:0.1:30
    
    P(:,2) = double(subs(A0_1,t,j))*P(:,1);
    P(:,3) = double(subs((A0_1*A1_2),t,j))*P(:,1);
    P(:,4) = double(subs((A0_1*A1_2*A2_3),t,j))*P(:,1);
    P(:,5) = double(subs((A0_1*A1_2*A2_3*A3_4),t,j))*P(:,1);
    P(:,6) = double(subs((A0_1*A1_2*A2_3*A3_4*A4_5),t,j))*P(:,1);
    P(:,7) = double(subs((A0_1*A1_2*A2_3*A3_4*A4_5*A5_6),t,j))*P(:,1);
    P(:,8) = double(subs((A0_1*A1_2*A2_3*A3_4*A4_5*A5_6*A6_7),t,j))*P(:,1);
    P(:,9) = double(subs((A0_1*A1_2*A2_3*A3_4*A4_5*A5_6*A6_7*A7_8),t,j))*P(:,1);
    P(:,10) = double(subs((A0_1*A1_2*A2_3*A3_4*A4_5*A5_6*A6_7*A7_8*A8_9),t,j))*P(:,1);
    P(:,11)= double(subs((A0_1*A1_2*A2_3*A3_4*A4_5*A5_6*A6_7*A7_8*A8_9*A9_10),t,j))*P(:,1);

    p_x=P(1,:);
    p_y=P(2,:);
    p_z=P(3,:);
    
    hold on;
    fig = plot3(p_x,p_y,p_z,'o-','LineWidth',4,'color','0,0,0','MarkerSize',4,...
    'MarkerEdgeColor','[0,0,1]');
    grid on;
    xlim([-150,150]);
    ylim([-150,150]);
    zlim([-150,150]);
    pause(0.1);

    delete(fig);
end
  
function trans_out = trans(a,d,az,ax) %outputs transformation matrix trans_out

%Transformation Matrix
trans_out = [cos(ax)  ,-sin(ax)*cos(az)  ,sin(ax)*sin(az) ,  a*cos(ax);
             sin(ax)  ,cos(ax)*cos(az)   ,-cos(ax)*sin(az),  a*sin(ax);
              0       , sin(az)          ,    cos(az)     ,  d        ;
              0       ,   0              ,      0         ,  1       ];
end

function ax = angle(n) %outputs snake gait angles
syms t
%Gait parameters 
Ax=pi/3;        %Amplitude
Ay=0;
Wx=5*pi/6;      %Frequency
Wy=5*pi/6;
deltax= 2*pi/3;     %Phase Difference
deltay =0;
phi=0;          %phi

if mod(n,2) == 0  %if n is even
    ax= Ax * sin(Wx*t + n*deltax);
else    %if n is odd
    ax = Ay*sin(Wy*t  + n* deltay + phi);
end

end