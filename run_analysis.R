library(dplyr)

## extracting and cleaning type of activities
activity.labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("actid", "activity"))
activity.labels$activity <- tolower(activity.labels$activity)
activity.labels$activity <- sub("_", " ", activity.labels$activity)

## selecting mean and standard deviation columns
features.labels <- read.table("UCI HAR Dataset/features.txt", col.names = c("featid", "featname"))
selectcols <- grep("mean\\(|std\\(", features.labels$featname)

## creating test dataset
subject.test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject.id")
x.test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features.labels$featname)
filter.x.test <- select(x.test, selectcols)
y.test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity.id")
test.data <- cbind(subject.test, y.test, filter.x.test)
test.data <- merge(test.data, activity.labels, by.x = "activity.id", by.y = "actid")
test.data$datatype <- paste("test")

## creating train dataset
subject.train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject.id")
x.train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features.labels[,2])
filter.x.train <- select(x.train, selectcols)
y.train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity.id")
train.data <- cbind(subject.train, y.train, filter.x.train)
train.data <- merge(train.data, activity.labels, by.x = "activity.id", by.y = "actid")
train.data$datatype <- paste("train")

## combining test and train data into 1 dataset
complete.data <- tbl_df(rbind(test.data, train.data))
group.data <- complete.data %>% 
        group_by(activity, subject.id)

## producing averages
average <- group.data %>% 
        select(-activity.id, -datatype) %>% 
        summarize_all(mean, na.rm = TRUE)

View(average)
write.table(average, file = "solution.txt", row.name=FALSE) 
