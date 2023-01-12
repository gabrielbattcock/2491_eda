#       _/_/    _/  _/      _/_/      _/   
#    _/    _/  _/  _/    _/    _/  _/_/    
#       _/    _/_/_/_/    _/_/_/    _/     
#    _/          _/          _/    _/      
# _/_/_/_/      _/    _/_/_/    _/_/_/     

# Exploratory Data Analysis of Gestation data

library(tidyverse)
library(mosaicData)

library(janitor)
# if you don't have mosaicData, install it

data(Gestation)

# Activity 1 - Quick look at the data

head(Gestation)
names(Gestation)
# number of observations
count(Gestation)

# number of observations per racial group
count(Gestation, race)

# number of observations by racial group and level of mother's education
Gestation %>% count(ed, race) %>% arrange(-n) -> Gestation_n_race_ed


# Activity 2 - Further summary statistics

# mean age of mothers across all births
summarise_at(Gestation, 
          .vars = vars(age, wt, gestation),
          .funs = list(mean = mean, 
                       sd = sd), na.rm = T)
# ensure you use a human friendly name for the value you're creating

# calculate both mothers' mean age and babies' mean weight
summarise(Gestation, 
          `Mean age` = mean(age, na.rm = T),
          `Mean weight`  = mean(wt))


# Activity 3 - Grouped summaries

# make a new data frame containing only id, age and race variables

Gestation %>% select(id, age, race) -> Gestation_id_race_age

# calculate the mean age by race

Gestation_id_race_age %>% group_by(race) %>% summarise(mean_age = mean(age, na.rm = T))

# new data frame that is then 

Gestation %>% select(wt, age, smoke, sex) %>% group_by(sex) %>% 
  summarise_at(.vars = vars(age, wt),
               .funs = list(mean = mean, 
                            sd = sd,
                            max = max,
                            min = min), na.rm = T
  )



# Activity 4 - Extensions


# Activity 4a - Correlation

# Calculate the correlation between age and weight across all births

Gestation_clean <- 
# Calculate the correlation between age and weight for each race group


# Activity 4b - Multiple summary statistics

# Calculate the sample mean of the ages and weights of the mothers in each race group


# Activity 4c - Pivoting wider

# Make a wide table from the summary data frame calculated in Activity 1 that
# has the number of observations for each combination of mother's education level and race.
# Make each row is an education level and each column a race group.

Gestation %>% count(ed, race) -> Gestation_n_race_ed
Gestation_n_race_ed %>% pivot_wider(names_from = race,
                                    values_from = n,
                                    values_fill = 0
                                    )



# Hint: Look at the help file for `pivot_wider` for what to do with missing cells (where there is no combination of these variables) and set the argument to be 0.


# Activity 4d - Multiple summary statistics

# Calculate the mean, standard deviation, minimum, maximum and proportion of values missing for the mothers' ages for each race group.
# Hint: you *can* use summarise_at() for this but you could also just summarise()