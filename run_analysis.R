# Load libraries
library(tidyverse)

# Load data
if (!file.exists("./data")) {
  dir.create("./data")
}

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url, destfile = "data/smartphone.zip")

unzip("data/smartphone.zip")

activity_labels <- read.delim("UCI HAR Dataset/activity_labels.txt", sep = "", header = FALSE)
features <- read.delim("UCI HAR Dataset/features.txt", sep = "", header = FALSE)

X_test <- read.delim("UCI HAR Dataset/test/X_test.txt", sep = "", header = FALSE)
y_test <- read.delim("UCI HAR Dataset/test/y_test.txt", sep = "", header = FALSE)
subject_test <- read.delim("UCI HAR Dataset/test/subject_test.txt", sep = "", header = FALSE)

X_train <- read.delim("UCI HAR Dataset/train/X_train.txt", sep = "", header = FALSE)
y_train <- read.delim("UCI HAR Dataset/train/y_train.txt", sep = "", header = FALSE)
subject_train <- read.delim("UCI HAR Dataset/train/subject_train.txt", sep = "", header = FALSE)

# Set variable names
features <- data.frame(t(select(features, V2)))
colnames(X_test) <- features[1,]
colnames(X_train) <- features[1,]
colnames(y_train) <- "y_train"
colnames(y_test) <- "y_test"

# Merge datasets
Xy_train <- bind_cols(X_train, y_train)
Xy_test <- bind_cols(X_test, y_test)
data <- bind_rows(Xy_train, Xy_test)

# Extract mean and std
rel_col <- grep("mean[^Freq]()|std()", colnames(data))
data <- data[,rel_col]

# Descriptive activity names


