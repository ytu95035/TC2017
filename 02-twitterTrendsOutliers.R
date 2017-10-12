########## Outlier/Anomaly Detection ###########

# Load library
library(AnomalyDetection)

# Read data
twitter = read.csv('tweets.csv')

# Save columns as vectors with better names
timestamp = twitter$Timestamp
tweets = twitter$Tweets

# Convert timestamp to actual timestamp
timestamp = as.POSIXct(timestamp, tz = 'GMT')

# Create new dataframe
cleanTweets = data.frame(timestamp, tweets)

# Find outliers
tweetOutliers = AnomalyDetectionTs(cleanTweets)

# Extract just the timestamp and assign proper time zone
outlierTimestamps = tweetOutliers$anoms$timestamp
outlierTimestamps = as.POSIXct(outlierTimestamps, tz = 'GMT')

# Determine which values in timestamp are in the outlierTimestamps
isOutlier = timestamp %in% outlierTimestamps

# Plot cleanTweets, colored by isOutlier
colors = isOutlier + 1
plot(cleanTweets, col = colors)
