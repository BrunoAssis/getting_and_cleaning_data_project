# run_analysis.R
# This code is used to get and clean the UCI HAR Dataset, generating
# a tidy one, for easier to run analyses.

library(data.table)
library(dplyr)

# Read subject data.
subject.training.data <- fread("UCI\ HAR\ Dataset/train/subject_train.txt")
subject.test.data <- fread("UCI\ HAR\ Dataset/test/subject_test.txt")

# Read activity data.
activity.training.data <- fread("UCI\ HAR\ Dataset/train/y_train.txt")
activity.test.data <- fread("UCI\ HAR\ Dataset/test/y_test.txt")

# Read activity observations.
activity.training.obs <- fread("UCI\ HAR\ Dataset/train/x_train.txt")
activity.test.obs <- fread("UCI\ HAR\ Dataset/test/x_test.txt")

# Merge training and test data together.
subject.data <- rbind(subject.training.data, subject.test.data)
activity.data <- rbind(activity.training.data, activity.test.data)
activity.obs <- rbind(activity.training.obs, activity.test.obs)

# Set more descriptive names to subject and activity columns.
names(subject.data) <- "subject.id"
names(activity.data) <- "activity.id"

# Merge data together.
all.data <- cbind(subject.data, activity.data, activity.obs)

# Read Features file to know which columns are needed.
features.data <- fread("UCI\ HAR\ Dataset/features.txt")

# Set more descriptive names to feature columns.
names(features.data) <- c("feature.id", "feature.name")

# Select only mean and standard deviation features.
selected.features <- grepl("(mean|std)\\(\\)", features.data$feature.name)
selected.features.data <- features.data[selected.features]

# Convert features ids to activities standard.
# Activities' features start with a 'V'.
feature.activity.id <- paste0("V", features.data[selected.features]$feature.id)
selected.features.data$feature.activity.id <- feature.activity.id

# Filter data to select only mean and standard deviation features.
selected.columns <- selected.features.data$feature.activity.id
selected.columns <- c("subject.id", "activity.id", selected.columns)
matched.columns <- match(selected.columns, names(all.data))
selected.data <- select(all.data, matched.columns)

# Name the columns as their features.
selected.columns.names <- selected.features.data$feature.name
names(selected.data) <- c("subject.id", "activity.id", selected.columns.names)

# Read activity labels.
activity.labels <- fread("UCI\ HAR\ Dataset/activity_labels.txt")

# Set more descriptive names to activity labels columns.
names(activity.labels) <- c("activity.id", "activity.name")

# Merge activity labels for better reading.
selected.data <- merge(selected.data, activity.labels, by="activity.id")

# Change variable names for better reading.
names(selected.data) <- gsub("^t", "Time", names(selected.data))
names(selected.data) <- gsub("^f", "Frequency", names(selected.data))
names(selected.data) <- gsub("Acc", "Accelerometer", names(selected.data))
names(selected.data) <- gsub("Gyro", "Gyroscope", names(selected.data))
names(selected.data) <- gsub("BodyBody", "Body", names(selected.data))
names(selected.data) <- gsub("Mag", "Magnitude", names(selected.data))
names(selected.data) <- gsub("-mean\\(\\)", "Mean", names(selected.data))
names(selected.data) <- gsub("-std\\(\\)", "STD", names(selected.data))
names(selected.data) <- gsub("angle", "Angle", names(selected.data))
names(selected.data) <- gsub("gravity", "Gravity", names(selected.data))

# Create a tidy data set.
tidy.data <- aggregate(. ~ subject.id + activity.name, selected.data, mean)

# Remove unused columns.
tidy.data$activity.id <- NULL

# Convert some columns to factors.
tidy.data$subject.id <- as.factor(tidy.data$subject.id)
tidy.data$activity.name <- as.factor(tidy.data$activity.name)

# Order data set for better viewing.
tidy.data <- tidy.data[order(tidy.data$subject.id, tidy.data$activity.name), ]


View(tidy.data)
