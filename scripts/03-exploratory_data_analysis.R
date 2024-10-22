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

#### Read data ####
poll1 <- read_csv("starter_folder-main/data/02-analysis_data/clean_data.csv")

poll1%>%filter(state %in% c("Georgia","Michigan","Pennsylvania","Arizona"))%>%
  ggplot(aes(x = state, fill =candidate_name)) +
  stat_count(position = "dodge") +
  facet_wrap(facets = vars(vote)) +
  theme_minimal() +
  labs(title="Figure 1 Bar chart of Harris and Trump's four-state support rate",
       x = "State",
       y = "Number of respondents",
       fill = "Voted for") +
  coord_flip() +
  scale_fill_brewer(palette = "Set1") +
  theme(legend.position = "bottom")


