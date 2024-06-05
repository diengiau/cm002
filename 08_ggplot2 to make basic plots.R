library(tidyverse)
library(ggplot2)
library(plotly)
library(ggthemes)

Data = mtcars


# PART A: Aggregation or summarize data -----------------------------------

# 1. For categorical variables: count
CountCyl = Data %>% count(cyl)
CountCyl

# 2. For numeric variables: group_by and summarize
Mpg_Mean = Data %>% 
  group_by(cyl) %>% 
  summarize(
    mpg_mean = mean(mpg, na.rm=TRUE)
  ) %>% 
  ungroup()
Mpg_Mean

# a faster way:
Mpg_Mean = Data %>% 
  summarize(
    mpg_mean = mean(mpg, na.rm=TRUE), .by = c(cyl)
  ) 
Mpg_Mean


# PART B: Some important plots --------------------------------------------


# 1. Histogram: for numeric var
hist(Data$mpg)
ggplot(Data, aes(mpg)) + geom_histogram()
ggplot(Data, aes(mpg)) + geom_density()

f1 = ggplot(Data, aes(mpg)) + geom_density()
f1

# 2. Bar plots: for category count or summarized data
# count how many obs per cyl
CountCyl = Data %>% count(cyl)
CountCyl

f2 = CountCyl %>% 
  ggplot(aes(x=cyl, y=n)) + geom_bar(stat = "identity")
f2

# Question: can you draw the bar plot for mean of mpg by different cyl group?
  

# 3. Scatter plots + regression line: for two numeric variables

f3 = Data %>%
  ggplot(aes(x=hp, y=mpg)) + geom_point() 
f3

f3 = f3 + geom_smooth(method = "lm")
f3

# 4. Line plots: for time series
f4 = Data %>%
  ggplot(aes(x=1:nrow(Data), y=mpg)) + geom_line() 
f4

# 5. Deco your plots
f4 + xlab("Row number")
f4 + xlab("Row number") + ylab("Mile per gallon")
f4 + xlab("Row number") + ylab("Mile per gallon") + ggtitle("The line plot of MPG")
f4 + xlab("Row number") + ylab("Mile per gallon") + ggtitle("The line plot of MPG") +
  theme_minimal()
f4 + xlab("Row number") + ylab("Mile per gallon") + ggtitle("The line plot of MPG") +
  theme_bw()
f5 = f4 + xlab("Row number") + ylab("Mile per gallon") + ggtitle("The line plot of MPG") +
  ggthemes::theme_economist()

# 6. Interactive plots
plotly::ggplotly(f3)

plotly::ggplotly(f5)
