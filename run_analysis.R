# run_analysis.R

#setup

#load library
options(warn=-1) 
library(plyr)

#set working directory
setwd("~/GettingCleaning")

get.data = function() {

#create WearableComputingData directory
if (!file.exists("WearableComputingData")) {
dir.create("WearableComputingData")
}

#download and unzip file
if (!file.exists("WearableComputingData/UCI HAR Dataset")) {
URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipName="WearableComputingData/UCI_HAR_data.zip"
download.file(url=URL, destfile=zipName, method="auto")
unzip(zipName, exdir="WearableComputingData")
}


}

# Merges the training and the test sets to create one data set.
merge.data = function() {

#read data into tables
train.x <- read.table("WearableComputingData/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("WearableComputingData/UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("WearableComputingData/UCI HAR Dataset/train/subject_train.txt")
test.x <- read.table("WearableComputingData/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("WearableComputingData/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("WearableComputingData/UCI HAR Dataset/test/subject_test.txt")

#combines tables by rows
combine.x <- rbind(train.x, test.x)
combine.y <- rbind(train.y, test.y)
combine.subject <- rbind(train.subject, test.subject)

#return combines data
list(x=combine.x, y=combine.y, subject=combine.subject)

}

# Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std.data = function(df) {

#read features data into tables
features <- read.table("WearableComputingData/UCI HAR Dataset/features.txt")

#grep mean and stardard deviation
mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))

#extract from megrged data
edf <- df[, (mean.col | std.col)]
#add column names
colnames(edf) <- features[(mean.col | std.col), 2]

#return 
edf

}

# Uses descriptive activity names to name the activities in the data set
descriptive.names = function(df) {

#add column names
colnames(df) <- "activity"

#translate activity numbers to descriptions from activity_labels.txt
df$activity[df$activity == 1] = "WALKING"
df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
df$activity[df$activity == 4] = "SITTING"
df$activity[df$activity == 5] = "STANDING"
df$activity[df$activity == 6] = "LAYING"

#return translated activities
df

}

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
average.data = function(df) {

#For each subset of a data frame, find the average then combine results into a data frame. 
average_dataframe <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))

#return X values, y values and subjects, along with average of each variable for each activity and each subject.
average_dataframe

}

tidy.data = function() {
# get data
get.data()
# merge data
merged <- merge.data()
#extract mean and standard deviation for each measurement
cx <- mean_std.data(merged$x)
#tranform activities
cy <- descriptive.names(merged$y)
#add column names for subjects
colnames(merged$subject) <- c("subject")
# Combine data frames into one
combined <- cbind(cx, cy, merged$subject)
#add averages and created tidy dataset
tidydataset <- average.data(combined)
# Write out tidy dataset as csv
write.csv(tidydataset, "WearableComputingData.csv", row.names=FALSE)
}
