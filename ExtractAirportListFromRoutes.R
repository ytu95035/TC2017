data <- read.csv('openflights-routes-north-america.csv')
output <- data.frame(airport = levels(data$from))
write.csv(output, 'airports-north-america.csv', row.names = FALSE, quote = FALSE)
