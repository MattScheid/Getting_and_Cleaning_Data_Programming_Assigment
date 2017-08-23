run_analysis <- function() {
  
  library(dplyr)
  setwd("~/Desktop")
  
  if (!file.exists("UCI HAR Dataset")) { 
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename = "UCI HAR Dataset", method="curl")
  }  
    
  # Read in labels & features (as.is = TRUE prevents character columns from converting to factors)
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt",as.is = TRUE)
  features <- read.table("UCI HAR Dataset/features.txt", as.is = TRUE)
  feature_names <- as.character(features[,2])
  
  # Read in records
  xTrain <- read.table("UCI HAR Dataset/train/x_train.txt")
  xTest <- read.table("UCI HAR Dataset/test/x_test.txt")
  
  yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
  yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
  
  subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
  subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  # 1. Merge the Training and Test set
  X <- rbind(xTrain, xTest)
  Y <- rbind(yTrain, yTest)
  subject <- rbind(subject_train, subject_test)
  
  
  # 2. Extract only mean and standard deviation
  mean_std <- grep("[.]*mean\\()[.]*|[.]*std\\()[.]*",feature_names)
  measurements <- X[,mean_std]

  # 3. Replace Y with Descriptive activity labels
  activities_mapping <- merge(Y, activity_labels)
  activities <- activities_mapping[,2]
  
  finalData <- cbind(subject,activities,measurements)
  
  # 4. Appropriately Label Dataset
  column_names <- c("subject","activity",feature_names[mean_std])
  names(finalData) <- column_names
  
  # 5. Create second tidy dataset with the average of each variable by each activity and subject
  avgData <- group_by(finalData,subject,activity) %>%
             summarize_all(funs(mean)) %>%
             arrange(subject,activity)
  write.table(avgData, file = "tidyData.txt", row.names = FALSE, col.names = TRUE)
}
  