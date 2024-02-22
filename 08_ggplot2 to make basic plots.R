library(tidyverse)
library(ggplot2)
library(plotly)
library(ggthemes)

Data = mtcars


# 1. Histogram
hist(Data$mpg)
ggplot(Data, aes(mpg)) + geom_histogram()
ggplot(Data, aes(mpg)) + geom_density()

f1 = ggplot(Data, aes(mpg)) + geom_density()

# 2. Bar plots
# count how many obs per cyl
Data %>% count(cyl)
Data %>% 
  count(cyl) %>% 
  ggplot(aes(x=cyl, y=n)) + geom_bar(stat = "identity")

f2 = Data %>% 
  count(cyl) %>% 
  ggplot(aes(x=cyl, y=n)) + geom_bar(stat = "identity")
f2

# 3. Scatter plots + regression line

f3 = Data %>%
  ggplot(aes(x=hp, y=mpg)) + geom_point() 
f3

# 4. Line plots
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

# 5. Interactive plots
plotly::ggplotly(f3)

plotly::ggplotly(f5)
