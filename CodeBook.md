run_analysis.R Code Book
========================

##Data
The data that this script is cleaning has been obtained from the following study: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The downloaded zip: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Variables
subject_id - The subject that has the smart phone whose values we are reading from.

activity_name - The reported activity being performed by the subject.

The means and standard deviations of the features - These variables contain the mean of the feature with respect to the subject_id and the activity that is measured.

##Method
1. The labels for the activities were read into memory from the "data/activity_labels.txt" file, the columns are given nice human readable names upon reading.
2. The feature names are read into a single column dataframe from the "data/features.txt" file, the column is given a nice human readable name upon reading.
3. The test subject ids for the test data are read into a single column data frame with a human readable name of "subject_id" from the file "data/test/subject_test.txt" file.  
4. The test data is read into a data frame from the file "data/test/X_test.txt" mapping the column names using the human readable forms that were read from step 2.
5. The activity ids are loaded from the "data/test/y_test.txt" file and is given the human readable name of "activity_id".
6. The data frames loaded in steps 3, 4 and 5 are all concatenated into one data frame containing the subject id, activity id and feature columns.
7. Repeated steps 3-6 for the "train" data, which is read from the "data/train/" directory.
8. Concatenate the "test" and "train" data frames so now we have one big data frame with both data sets.
9. Do a merge on the full data set with the activity labels that were loaded in step 1 so now we have columns that contain subject id, activity id, activity name and the feature variables.
10. Do a select to obtain a data frame that only contains the subject id, activity name, and only the features that are means or averages.
11. Apply the colMeans function on all the measured feature columns for each subject according to their activities.
12. Output a file using the table.write() function to the filename "output.txt"