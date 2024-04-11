#Step 1: Clean data
# Run the packages
library(tidyverse) # for MacOS: library(dplyr)
library(stringr)
library(janitor)
library(tidyr)
library(skimr)
library(readxl)

#1. Import the data file to R
Starbucks = read_excel("data/raw/starbucks-nutrition.xlsx")

#2. The column names are not clean
Starbucks = clean_names(Starbucks)
head(Starbucks[,1:3])

#3. Notice that some rows are totally missing. Try to delete all these rows in R (not Excel).
Starbucks = Starbucks %>% 
  filter(!is.na(product_name))

#4. Some rows are duplicated
Starbucks = Starbucks %>% distinct() #If they are totally the same, just keep a unique row
Starbucks = Starbucks[-74, ] #Keep the rows with more information

#5. Some size has typo: instead of "venti", we make typo to "vendi"
Starbucks %>% count(size)


Starbucks = Starbucks %>% 
  mutate(
    size = str_replace(size, "vendi", "venti")
  )

#6. Any column has the wrong data type? If you can find them, let's convert them into the correct data format.
#No!

#7. The whip column should have only two values: 1 if we added whip cream and 0 otherwise.
#But we have some other values like 2 or 3. Please change all these typos to 1.
Starbucks %>% count(whip)

Starbucks = Starbucks %>% mutate(
  whip = str_replace(whip, "2", "1"),
  whip = str_replace(whip, "3", "1"),
  whip = as.numeric(whip)
)

# alternative way:
Starbucks %>% count(whip)
Starbucks %>% mutate(
  whip2 = ifelse(whip > 1, 1, whip),
) %>% 
  count(whip2) # same freq as whip above

#8. Some size is not quite popular, let's skip them. Only keep these size: short, tall, grande, venti
Starbucks = Starbucks %>% filter(size == "short"|size == "tall"|size == "grande"|size == "venti")

#9. Create a new column milk_type as follow:
Starbucks %>% count(milk)

Starbucks = Starbucks %>% 
  mutate(
    milk_type = case_when(
      milk == "0" ~ "none",
      milk == "1" ~ "nonfat",
      milk == "2" ~ "2%",
      milk == "3" ~ "soy",
      milk == "4" ~ "coconut",
      milk == "5" ~ "whole",
    )
  )

Starbucks %>% count(milk_type)


#10. Save your final data into the "data/process" folder as the name: starbucks_clean.rds
saveRDS(Starbucks, "data/process/starbucks_clean.rds")