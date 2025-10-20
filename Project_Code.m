clc;
clear all;

m = 10*10^-3;      % Mass of the ball
R = (2.5)*10^-2;   % Radius of the ball
g = 9.81;          % Acceleration due to gravity
d = (50)*10^-3;    % Lever arm offset
L = (35)*10^-2;    % Length of the beam
J = (2/3)*m*R^2;   % Moment of inertia of Hollow sphere (ball)

k = (m*g*d)/((m+(J/R^2))*L);

% Transfer function
Transfer_Function = tf(k, [1 0 0]);

poles = pole(Transfer_Function);
zeros = zero(Transfer_Function);

% Display
disp('Poles:');
disp(poles);
disp('Zeros:');
disp(zeros);

% Plotting: pole-zero map and open-loop step response,
figure();

% Pole-zero map
pzmap(Transfer_Function);
grid on;
title('Pole-Zero Map of the System');

hold on;
plot(real(poles), imag(poles), 'rx', 'MarkerSize',12, 'LineWidth',2); % poles
plot(real(zeros), imag(zeros), 'bo', 'MarkerSize',10, 'LineWidth',1.5); % zeros (if any)
axis equal;
legend({'Zeros','Poles'}, 'Location','best');
hold off;

figure();
% Choose time vector to show t^2 growth,
t_end = 50;               % seconds
t = linspace(0, t_end, 1000);
[y, tt] = step(Transfer_Function, t);
plot(tt, y, 'LineWidth',1.5);
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Open-Loop Step Response of T(s)=k/s^2');