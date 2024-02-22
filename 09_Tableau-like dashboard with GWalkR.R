library(tidyverse)
library(GWalkR)

Data = mtcars
Data
gwalkr(Data)

Data %>% 
  group_by(cyl) %>% 
  summarize(mpg=mean(mpg)) %>% 
  ungroup() %>% head()
  gwalkr()

# important note:
  # click the Cube (Aggregation) button: applied aggregate functions like mean, median, sum
  # unclick the Cube: raw data
  
  
