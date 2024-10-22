#### Preamble ####
# Purpose: Models... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(modelsummary)
library(rstanarm)
library(collapse)
library(arrow)
library(marginaleffects)

#### Read data ####
analysis_data <- read_csv("starter_folder-main/data/02-analysis_data/analysis_data.csv")

### Model data ####
## Bayesian logistic model 
poll_model <-stan_glm(
  is_vote ~ state,data = logit_data,
  family = binomial(link = "logit"),
  prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
  prior_intercept = 
    normal(location = 0, scale = 2.5, autoscale = TRUE))


modelsummary(list("Support Harris" = poll_model),statistic = "mad")

saveRDS(
  poll_model,
  file = "poll_model.rds")

##  Logistic regression probability results
poll_predictions <-predictions(poll_model) %>%as_tibble()

poll_predictions

poll_predictions %>%mutate(vote=factor(is_vote))%>%
  ggplot(aes(x =state , y = estimate, color = vote)) +
  geom_jitter(width = 0.01, height = 0.01, alpha = 0.3) +
  labs(
    x = "state",
    y = "Estimated probability voted",
    color = "is voted" ) +
  theme_classic() +
  scale_color_brewer(palette = "Set1") +
  theme(legend.position = "bottom")


## Credible intervals for predictors of support for harris
modelplot( poll_model, conf_level = 0.9) +
  labs(x = "90 percent credibility interval")

