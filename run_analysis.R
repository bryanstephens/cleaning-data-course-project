library(plyr)
library(dplyr)

# Running the run_analysis() function will write a file "output.txt" that follows the following process:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# The function will assume the data directory is in the root of the working directory at "data/", but dataDir
# can be specified
run_analysis <- function(dataDir = "data") {
  #Get nice human readable labels
  activity_labels <- read.table(file.path(dataDir, "activity_labels.txt"), sep = " ", col.names = c("activity_id", "activity_name"))
  feature_labels <- read.table(file.path(dataDir, "features.txt"), sep = " ", col.names = c("feature_id", "feature_name"))
  
  #load test data with human readable variable names
  subject_test <- read.table(file.path(dataDir, "test", "subject_test.txt"), col.names = c("subject_id"))
  X_test_data <- read.table(file.path(dataDir, "test", "X_test.txt"), col.names = feature_labels$feature_name)
  activity_test <- read.table(file.path(dataDir, "test", "y_test.txt"), col.names = c("activity_id"))
  
  #concatenate loaded test data
  subject_test_activity_data <- cbind(subject_test, activity_test, X_test_data)

  #load training data with human readable variable names
  subject_train <- read.table(file.path(dataDir, "train", "subject_train.txt"), col.names = c("subject_id"))
  X_train_data <- read.table(file.path(dataDir, "train", "X_train.txt"), col.names = feature_labels$feature_name)
  activity_train <- read.table(file.path(dataDir, "train", "y_train.txt"), col.names = c("activity_id"))
  
  #concatenate loaded training data
  subject_train_activity_data <- cbind(subject_train, activity_train, X_train_data)

  #concatenate test and training data frames
  all_data <- rbind(subject_test_activity_data, subject_train_activity_data)
  
  #merge the activity name and the full dataset so we can have human readable activities
  all_data_with_labels <- merge(all_data, activity_labels)
  
  #get only the subject, activity_name and all variables that contain mean or std
  subset_labeled_data <- select(all_data_with_labels, subject_id, activity_name, contains("mean"), contains("std"))
  
  #get the mean of the columns along the subject ids and their activities
  tidy_data <- ddply(subset_labeled_data, .(subject_id, activity_name), function(x) colMeans(x[,3:ncol(x)]))
  
  #output file
  write.table(tidy_data, file = file.path("output.txt"), row.name = FALSE)
}