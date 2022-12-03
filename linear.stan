data {
  int<lower=0> N;   // number of observations
  int<lower=0> K;   // number of columns
  matrix[N,K] x;   // training data
  vector[N] y;      // outcome vector
}

parameters {
  real alpha;           // intercept
  vector[K] beta;       // coefficients for predictors
  real<lower=0> sigma;  // error scale
}
model {
  alpha ~ normal(0, 2);
  beta ~ normal(0, 2);
  sigma ~ normal(0, 10);
  y ~ normal(x * beta + alpha, sigma);  // likelihood
}

generated quantities {
  vector[N] ypred;
  ypred = y;
}
