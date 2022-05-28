clear all
close all
clc

Q = 216:3:360;
m = 3; % # of phases
p = 32; % # of poles
throw = 14;
L = 900e-3; % axial length, m
Di = 6197.6e-3; % inner diameter, m
Dr = 6172.2e-3; % rotor diameter, m
SlotWidth = 25.4e-3; % m
mu0 = 4*pi*1e-7; % permeability of the air
i = 1;

while(1)
    q = Q(i)/(m*p); % slots per pole per phase
    Pitch = Q(i)/p; % slots per pole
    PitchNumber = throw/Pitch;
    CoilSpan_rad = pi*PitchNumber; % coil pitch
    Alpha_rad = pi*p/Q(i);
    CoilSpan_deg = 180*PitchNumber;
    Alpha_deg = 180*p/Q(i);
    SlotPitch = pi*Di/Q(i); % m
    TeethWidth = SlotPitch-SlotWidth; % m
    HarmonicNumber = 1:2:2*length(Q);
    
    for j = 1:length(HarmonicNumber)
        kp(j) = sin(HarmonicNumber(j)*CoilSpan_rad/2);
        kp(j) = fix(kp(j)*1e6)/1e6;
        kd(j) = sin(q*HarmonicNumber(j)*Alpha_rad/2)/(q*sin(HarmonicNumber(j)*Alpha_rad/2));
        kd(j) = fix(kd(j)*1e6)/1e6;
        kw(j) = kd(j)*kp(j);
        kw(j) = fix(kw(j)*1e6)/1e6;
    end
    PhaseAngle_elec(1) = Alpha_deg; %degree
    PhaseAngle_mech(1) = 360/Q(i); % degree

    for k = 1:length(HarmonicNumber)
        PhaseAngle_elec(k) = mod(HarmonicNumber(k)*PhaseAngle_elec(1),360);
        PhaseAngle_mech(k) = mod(HarmonicNumber(k)*PhaseAngle_mech(1),360);
    end
    header = {'Harmonic Number','kp','kd','kw','Phase Angle (electrical)','Phase Angle (Mechanical)'};
    result = table(HarmonicNumber',kp',kd',kw',PhaseAngle_elec',PhaseAngle_mech','VariableNames',header);
    sheetName = num2str(Q(i));
    writetable(result,'Results.xlsx','sheet',i,'Sheet',sheetName);
%     figure;
%     bar(result.kw)
%     ticks = 1:1:length(HarmonicNumber);
%     xticks(ticks)
%     labels = compose("%i",HarmonicNumber);
%     xticklabels(labels)
%     xlabel('Harmonics')
%     ylabel('Winding Factor (k_\omega)')
    
    if i<length(Q)
        i = i+1;
    else
        break
    end

end