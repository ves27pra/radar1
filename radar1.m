% Radar Maximum Range Calculation (Lab Experiment)
clear; clc; close all;

%% 1. Given Parameters
Pt = 10e3;                  % Transmit Power: 10 kW = 10,000 W
f = 10e9;                   % Frequency: 10 GHz = 10 x 10^9 Hz
c = 3e8;                    % Speed of light (m/s)
lambda = c / f;             % Wavelength = 0.03 m

Gt_dB = 30;                 % Transmitter Gain in dB
Gr_dB = 30;                 % Receiver Gain in dB
Gt = 10^(Gt_dB / 10);       % Linear Transmitter Gain (1000)
Gr = 10^(Gr_dB / 10);       % Linear Receiver Gain (1000)

sigma = 1.0;                % Radar Cross Section (m^2)
L_dB = 6;                   % System Losses in dB
L = 10^(L_dB / 10);         % Linear Loss Factor (~3.981)

Pmin_dBm = -100;            % Minimum Detectable Signal in dBm
Pmin = 10^((Pmin_dBm - 30)/10); % Convert dBm to Watts (1e-13 W)

%% 2. Calculate Maximum Radar Range (R_max)
% Formula: R_max = [ (Pt * Gt * Gr * sigma * lambda^2) / ((4*pi)^3 * Pmin * L) ]^(1/4)
R_max = ((Pt * Gt * Gr * sigma * (lambda^2)) / ((4*pi)^3 * Pmin * L))^(1/4);

% Display Result
fprintf('Maximum Radar Range (R_max): %.2f meters (%.2f km)\n', R_max, R_max / 1000);

%% 3. Plot Received Power vs Range
R = linspace(100, R_max * 1.2, 1000); % Range vector
Pr = (Pt * Gt * Gr * sigma * (lambda^2)) ./ ((4*pi)^3 * (R.^4) * L); % Received Power (W)
Pr_dBm = 10*log10(Pr / 1e-3); % Convert to dBm

figure('Name', 'Radar Performance');
plot(R / 1000, Pr_dBm, 'b-', 'LineWidth', 2); hold on;
yline(Pmin_dBm, 'r--', 'P_{min} Threshold (-100 dBm)', 'LineWidth', 1.5);
xline(R_max / 1000, 'g--', sprintf('R_{max} = %.2f km', R_max/1000), 'LineWidth', 1.5);

xlabel('Range R (km)');
ylabel('Received Power P_r (dBm)');
title('Received Power vs. Target Range');
grid on;
