library(gapminder)
library(tidyverse)
library(ggrepel)
library(scviz)

cityTemp <- read_csv("weather.csv")

cityTemp %>% select(State, Data.Temperature.Avg_Temp, Data.Temperature.Min_Temp, Data.Temperature.Max_Temp) %>%
	sample_n(5)

cityTemp <- as.data.frame(cityTemp)

color <- c(#FF0000)

install.packages(c("maps","mapdata"))
library(maps)
us_states <- map_data("state")
head(us_states)
dim(us_states)

p <- ggplot(data = us_states, mapping = aes(x = long, y = lat, group = group))

p + geom_polygon(fill = "white", color = "black")

p <- ggplot(data = us_states, aes(x = long, y = lat, group = group, fill = State))

cityTemp$State <- tolower(cityTemp$state)
cityTemp_map <- left_join(us_states, cityTemp)

p0 <- ggplot(data = cityTemp_map, mapping = aes(x = long, y = lat, group = group, fill = Data.Temperature.Avg_Temp))

p1 <- p0 + geom_polygon(color = "gray90", size = .1)

p1 + labs(title = "Avg Temperature") + theme_map() + labs(fill = "Temperature")

p2 <- p1 + scale_fill_gradient(low = "white", high = "#FF0000") + labs(title = "Avg Temperature")

p2 + theme_map() + labs(fill = "Tempurature")