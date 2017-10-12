# convert degrees to radians
deg2rad <- function(deg) return(as.numeric(deg) * pi / 180)

# calculate the geodesic distance between two points specified 
# by radian latitude/longitude using the Haversine formula (hf)
gcd.hf <- function(long1, lat1, long2, lat2) {
  R <- ifelse(.arg5[1] == 'km', 6371, 3959) # Earth mean radius [km/mi, as per parameter]
  long1 <- deg2rad(long1)
  long2 <- deg2rad(long2)
  lat1 <- deg2rad(lat1)
  lat2 <- deg2rad(lat2)
  delta.long <- (long2 - long1)
  delta.lat <- (lat2 - lat1)
  a <- sin(delta.lat / 2) ^ 2 + cos(lat1) * cos(lat2) * sin(delta.long / 2) ^ 2
  c <- 2 * asin(sapply(a, function (b) min(1, sqrt(b))))
  d <- R * c
  return(d) # Distance in km/mi
}

# initiate n as per parameter or number of features
n <- min(c(as.integer(.arg4[1]) + 1, length(.arg1) - 1))

# initiate the character vector that will be returned
closestLocations <- rep('', length(.arg1) - 1)

# identify n closest features
for (index in 1:length(.arg1)) {
  storelat <- .arg1[index]
  storelong <- .arg2[index]
  
  distances <- gcd.hf(storelong, storelat, .arg2, .arg1)
  
  closest <- order(distances)
  d <- distances[closest][2:n]
  closest <- .arg3[closest[2:n]]
  
  text <- paste(1:length(closest), '. ', closest, ' - ', round(d, digits = 1), ' ', .arg5[1], ' away\n',  collapse = '', sep = '')
  closestLocations[index] <- text
}

closestLocations
