#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Mingxuan Liu & Zilin Liu
# Date: 10-21-2024
# Contact: 
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

library(tidyverse)
library(ggplot2)
library(modelsummary)
library(rstanarm)
library(collapse)
library(arrow)

## load data
poll<-read.csv(file = "data/01-raw_data/raw_data.csv")

## Data cleaning and processing
poll1<-select(poll,party, answer, candidate_id ,candidate_name, pct ,pollster,state)%>%
  filter(candidate_name=="Kamala Harris" | candidate_name=="Donald Trump" )%>%
  mutate(harris=ifelse(candidate_name=="Kamala Harris",1,0),
         vote=ifelse(pct>=50,"yes","no"))%>%na.omit()

## Analytic data set
logit_data<-filter(poll1,candidate_name=="Kamala Harris")%>%
  filter(state %in% c("Georgia","Michigan","Pennsylvania","Arizona"))%>%
  select(candidate_name,vote,harris,state)%>%
  mutate(is_vote=factor(ifelse(vote=="yes",1,0)))

## export data
write_parquet(logit_data,"data/02-analysis_data/poll_model.parquet")
write.csv(poll1,"data/02-analysis_data/clean_data.csv")
write.csv(logit_data,"data/02-analysis_data/analysis_data.csv")
