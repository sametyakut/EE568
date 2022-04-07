%Inductance Plot
clear
clc
close all

teta = 0:0.01:2*pi;
min = 4.71e-3;
max = 23.7e-3;

L=(min+max)/2+(min-max)/2.*cos(2.*teta);
plot(teta,L,'LineWidth',1.5,'Color',[0.7 0 0]);
set(gca,'XTick',0:pi/2:2*pi); 
set(gca,'XTickLabel',{'0','\pi/2','\pi','3\pi/2','2\pi'});
xlim([0 2*pi])
grid on;
xlabel('Angle (\theta)')
ylabel('Inductance (H)')
title('Inductance vs Rotation Angle Waveform')
%% Torque Plot
clear
clc
close all

teta = 0:0.01:2*pi;

T=0.5*9*37.98e-3.*sin(2.*teta);
plot(teta,T,'LineWidth',1.5,'Color',[0.7 0 0]);
set(gca,'XTick',0:pi/2:2*pi); 
set(gca,'XTickLabel',{'0','\pi/2','\pi','3\pi/2','2\pi'});
xlim([0 2*pi])
grid on;
xlabel('Angle (\theta)')
ylabel('Torque (N.m)')
title('Torque vs Rotation Angle Waveform')