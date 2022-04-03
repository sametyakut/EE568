% Linearization of Steel 1010
clear
clc

H = 0:100:318000;
perm0 = 4*pi*10^-7;
perm = 667.5;
B = perm*perm0.*H;
plot(H,B)

bh = [B' H'];

writematrix(bh,'bh.xlsx')