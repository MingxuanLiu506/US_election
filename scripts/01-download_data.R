poll<-read.csv(file = "F:/president_polls.csv")#### Preamble ####
# Purpose: Downloads and saves the data from poll-of-polls
# Author: Mingxuan Liu & Zilin Liu
# Date: 10-21-2024
# Contact:
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####

library(tidyverse)


#### Download data ####


poll<-read.csv(file = "data/01-raw_data/president_polls.csv")

#### Save data ####

# change the_raw_data to whatever name you assigned when you downloaded it.

write_csv(poll, "data/01-raw_data/raw_data.csv") 


