## Readme - Getting and Cleaning Data Course Project
### Assignment Instructions

We are asked to create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Original data

The data originally was presented in following files:

* activity_labels.txt
* features.txt
* test\subject_test.txt
* test\X_test.txt
* test\y_test.txt
* train\subject_test.txt
* train\X_test.txt
* train\y_test.txt

The folder structure **must** be preserved for the script run_analysis.R to work. 

### Cleaning and Processing

The script run_analysis.R processes by the following steps:

1. Load dplyr package
2. Extracting the activities labels and their corresponding activity IDs, with conversion into lowercase and removing of "_" for readability.
3. Extracting the main variables of the data.
4. Creating numeric string for selection of the columns  showing mean and standard deviation by searching for the string "mean(" and "std("  
5. Reading "test\subject\_test.txt", "test\X\_test.txt", and "test\y_test.txt"
6. Selecting columns in "X\_test.txt" using numeric string described above in step 4. 
7. Creating table for all test data by combining subject id, activity id, and values
8. Merging the table with activities labels and ID
9. Introducing a new column to mark information as test data
10. Repeat 5 to 9, but for training data
11. Combining test and training data by rowbind
12. Grouping data by activity, and subject ID
13. Producing the average values using summarize_each() 
14. Outputting a text file with average values for submission