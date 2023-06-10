clear all

kappa = 10;
alpha = zeros(2);
alpha(1, 1) = 1 / (3 * kappa);
alpha(1, 2) = 2 * alpha(1, 1);
alpha(2, 1) = 2 * alpha(1, 1) / 5;
alpha(2, 2) = 4 * alpha(1, 1) / 5 + 9 / (35 * kappa);
alpha

eps = 0.5;  # поварьировать - посмотреть, что будет с разницей между решениями
rho_d = 0.2;
rho_s = 1 - (eps + rho_d)


gamma = zeros(2);
gamma(1, 1) = eps / (2 * (2 - eps));
gamma(1, 2) = 5 * eps / (8 * (2 - eps));
gamma(2, 1) = eps / (8 * (2 - eps));
gamma(2, 2) = 5 * eps / (8 * (2 - eps)) ...
  + 15 * rho_d / (16 * (1 + rho_s) * (2 - eps));
gamma

lam1 = (alpha(2, 2) - alpha(1, 1)) / (2 * alpha(2, 1)) ...
  - 1 / (2 * alpha(2, 1)) ...
  * sqrt((alpha(1, 1) - alpha(2, 2)) ^ 2 + 4 * alpha(1, 2) * alpha(2, 1));
lam2 = (alpha(2, 2) - alpha(1, 1)) / (2 * alpha(2, 1)) ...
  + 1 / (2 * alpha(2, 1)) ...
  * sqrt((alpha(1, 1) - alpha(2, 2)) ^ 2 + 4 * alpha(1, 2) * alpha(2, 1));
T = [1, lam1 ; 1, lam2];
alpha_diag = T * alpha * T^-1
beta = T * gamma * T^-1
eta = T * gamma(:, 1)

omega1 = lam2 / (lam2 - lam1)
omega2 = lam1 / (lam1 - lam2)

omega1 * beta(1, 1) + omega2 * beta(2, 1)
omega1 * beta(1, 2) + omega2 * beta(2, 2)
