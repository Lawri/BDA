data {
  int N;
  int J; // Number predictors
  vector[J] V[N];
  int defaulted[N];
}

parameters {
  real<lower=0, upper=1> class_prob;   // Probability of defaulting or not

  // Means and SDs for outcome within each class (so 2 sets)
  vector[J] mu[2];              // Means of the outcome variables
  vector<lower=0>[J] sigma[2];  // SDs of the outcome variables
}

model {
  class_prob ~ beta(1, 1); // Uniform, improper prior

  for (k in 1:2) {
    mu[k] ~ normal(0, 100000);     // Massively uninformative, inappropriate priors
    sigma[k] ~ normal(0, 100000);
  }

  defaulted ~ bernoulli(class_prob);
  // Likelihood for each outcome, using the Mean and SD associated with the appropriate class
  // Have to add 1, as defaulted contains 0 & 1, but we need to index using 1 & 2
  for (n in 1:N) {
    V[n] ~ normal(mu[defaulted[n] + 1], sigma[defaulted[n] + 1]);
  }
}
