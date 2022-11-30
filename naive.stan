data {
  int N;
  int J;
  matrix[N, J] V;
  int[N] defaulted;
}

parameters {
  real<lower=0, upper=1> class_prob;

  array[2] vector[J] mu;
  array[2] vector<lower=0>[J] sigma;
}

model {
  class_prob ~ beta(1, 1)

  for (k in 1:2) {
    mu[k] ~ normal(0, 100000);
    sigma[k] ~ normal(0, 100000);
  }

  defaulted ~ bernoulli(class_prob);
  
  for (n in 1:N) {
    V[n] ~ normal(mu[defaulted[n] + 1], sigma[defaulted[n] + 1]);
  }
}
