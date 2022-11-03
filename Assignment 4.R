library(tidyverse)
library(ggplot2)
library(gridExtra)

tankData <- read.csv("WOT.csv")
tankData <- filter(tankData, Battles > 3)

tankData$WR <- gsub("%","",as.character(tankData$WR))

tankData$WR = as.numeric(tankData$WR)

nationData = subset(tankData, select = -c(Tier,Class,Battles,WN8,DPG,Frags,DMG.ratio,K.D,Survival,Spots))
typeData = subset(tankData, select = -c(Nation,Tier,Battles,WN8,DPG,Frags,DMG.ratio,K.D,Survival,Spots))

view(tankData)
view(nationData)
view(typeData)

plot_a <- ggplot(nationData, aes(x = reorder(Nation, WR, mean), y = WR, group = Nation)) + 
  geom_boxplot(color = "black") +
  labs(title = "Stats by Nation Played", x = "Nation Played", y = "Win Rate (WR)") +
  theme_gray()

plot_b <- ggplot(typeData, aes(x = reorder(Class, WR, mean), y = WR, group = Class)) + 
  geom_boxplot(color = "black") +
  labs(title = "Stats by Type Played", x = "Type Played", y = "Win Rate (WR)") +
  theme_gray()

gridExtra::grid.arrange(
  plot_a,
  plot_b,
  ncol = 2
)