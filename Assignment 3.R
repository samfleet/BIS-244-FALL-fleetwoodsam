library(tidyverse)
library(ggplot2)

zero_data <- read.csv("us-counties-2020.csv")
one_data <- read.csv("us-counties-2021.csv")
two_data <- read.csv("us-counties-2022.csv")
recent_data <- read.csv("us-counties-recent.csv")
county_data <- read.csv("us-counties.csv")

covid_data <- rbind(zero_data, one_data, two_data, recent_data)

lehigh_covid_data <- covid_data %>% filter(county=="Lehigh")

lehigh_covid_data <- distinct(lehigh_covid_data, date, .keep_all = TRUE)

n <- length(lehigh_covid_data$date)

lehigh_covid_data$incr_cases <- 1

for (i in 2:n){
  lehigh_covid_data$incr_cases[i] <- (lehigh_covid_data$cases[i]-lehigh_covid_data$cases[i-1]) 
}

lehigh_covid_data$date <- as.Date(lehigh_covid_data$date , format = "%Y-%d")

view(lehigh_covid_data)

########################################################

#Start of ggplot code

ggplot(lehigh_covid_data, aes(x = date, y = incr_cases, group = 1)) + 
  geom_line(color = "blue") +
  labs(title = "COVID-19 Cases Reported in Lehigh PA", x = "Date", y = "New Cases Reported") +
  scale_x_date(date_labels = "%Y-%b", date_breaks = "3 month") +
  theme_gray()
