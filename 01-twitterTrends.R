########## Load/Explore data ###########

# Read data
twitter = read.csv('tweets.csv')

# Explore data
head(twitter)
tail(twitter)
plot(twitter)

# Save columns as vectors with better names
timestamp = twitter$Timestamp
tweets = twitter$Tweets

# Convert timestamp to actual timestamp
timestamp = as.POSIXct(timestamp, tz = 'GMT')

# Create new dataframe
cleanTweets = data.frame(timestamp, tweets)

# Plot data again
plot(cleanTweets)  # Notice better x-axis labels
