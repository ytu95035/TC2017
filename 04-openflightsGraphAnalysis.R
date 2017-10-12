# load libraries and initialize pseudo random number generator
library(igraph)
library(dplyr)
set.seed(2811)

# load data, add and rename columns
data <- read.csv('openflights-routes-test.csv', 
                 stringsAsFactors = FALSE) %>% 
  mutate(pathOrder = 1) %>% 
  rename(weight = routes)
# extract unique list of airports
airports <- data.frame(airport = unique(data$from), 
                       stringsAsFactors = FALSE)

# generate logical graph model
g <- graph_from_data_frame(data)

# build graph layout, add airport names
coords <- layout_with_fr(g, 
                         weights = E(g)$weight) %>% 
  cbind(data.frame(airport = V(g)$name, 
                   betweenness = betweenness(g)))

# plot graph layout
plot(g, 
     layout = coords)
