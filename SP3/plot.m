% MATLAB/Octave code

clear all

function [x, y, theta, phi] = read_data (input_file)
  f = fopen(input_file);
  A = textscan(f, '%f %f %f %f');
  x = A{1};
  y = A{2};
  phi = A{3};
  theta = A{4};
end

function [X, Y, Z] = process_data(x, y, field)
  K = 100;
  N = K + 1;
  X = zeros(N, N);
  Y = X; Z = X;
  xi = 0;
  i = 0;
  for nX = 0 : K
      xi = xi + 1;
      yi = 0;
      for nY = 0 : K
          yi = yi + 1;
          i = i + 1;
          X(xi, yi) = x(i);
          Y(xi, yi) = y(i);
          Z(xi, yi) = field(i);
      end
  end
end

function rms = compare_data(x, y, field1, field2)
  data_size = length(field1);
  rms = sqrt(sum((field1 - field2) .^ 2) / data_size);
end

[x, y, theta1, phi1] = read_data('P1.txt');
[X, Y, Z1_theta] = process_data(x, y, theta1);
[X, Y, Z1_phi] = process_data(x, y, phi1);
[x, y, theta3, phi3] = read_data('SP3.txt');
[X, Y, Z3_theta] = process_data(x, y, theta3);
[X, Y, Z3_phi] = process_data(x, y, phi3);

rms_theta = compare_data(x, y, theta1, theta3)
rms_phi = compare_data(x, y, phi1, phi3)

figure
A = contour(X, Y, Z3_theta, 'k', 0:0.05:1);
axis equal
clabel(A, 0:0.05:1);

figure
A = contour(X, Y, Z3_phi, 'k', 0:0.05:1);
axis equal
clabel(A, 0:0.05:1);
