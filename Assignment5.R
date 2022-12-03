library(readr)
library(dplyr)
library(gapminder)
library(tidyverse)
library(ggrepel)
library(scviz)

cityTemp <- read_csv("weather.csv")

cityTemp %>% select(Station.State, Data.Temperature.Avg.Temp, Data.Temperature.Min.Temp, Data.Temperature.Max.Temp) %>%
  sample_n(5)

cityTemp <- as.data.frame(cityTemp)

install.packages("maps","mapdata")
library(maps)
us_states <- map_data("state")
head(us_states)
dim(us_states)
    
p <- ggplot(data = us_states, mapping = aes(x = long, y = lat, group = group))
    + geom_polygon(fill = "white", color = "black")
  
p <- ggplot(data = us_states, aes(x = long, y = lat, group = group, fill = Station.State))
  
cityTemp$region <- tolower(cityTemp$Station.State)
cityTemp_map <- left_join(us_states, cityTemp)

p0 <- ggplot(data = cityTemp_map, mapping = aes(x = long, y = lat, group = group, fill = Data.Temperature.Avg.Temp))
  
p1 <- p0 + geom_polygon(color = "gray90", size = .1)
    + labs(title = "Avg Temperature") + theme_map() + labs(fill = "Temperature")
  
p2 <- p1 + scale_fill_gradient(low = "white", high = "#CB454A") + labs(title = "Avg Temperature")
     + theme_map() + labs(fill = "Tempurature")
