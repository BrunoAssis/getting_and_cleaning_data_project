library(data.table)

subject.training.data <- fread("UCI\ HAR\ Dataset/train/subject_train.txt")
subject.test.data <- fread("UCI\ HAR\ Dataset/test/subject_test.txt")

activity.training.data <- fread("UCI\ HAR\ Dataset/train/x_train.txt")
activity.test.data <- fread("UCI\ HAR\ Dataset/test/x_test.txt")

activity.training.labels <- fread("UCI\ HAR\ Dataset/train/y_train.txt")
activity.test.labels <- fread("UCI\ HAR\ Dataset/test/y_test.txt")

subject.data <- rbind(subject.training.data, subject.test.data)
activity.data <- rbind(activity.training.data, activity.test.data)
activity.labels <- rbind(activity.training.labels, activity.test.labels)


