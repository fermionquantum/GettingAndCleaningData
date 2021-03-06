# Course Project Description

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The script run_analysis.R makes the follow sequence of operations:

0. Set libraries dependencies and the correct directory and workspace;
1. Merges the training (variables X, Y and Subject) and the test (variables X, Y and Subject) to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement in the feature.txt;
3. Uses descriptive activity names to name the activities in the data set with the help to the activity_labels.txt and factor();
4. Appropriately labels the data set with descriptive variable names through replacements made by gsub();
5. From the data set in step 4, creates a second, independent tidy data set, named Average.txt, with the average of each variable for each activity and each subject.
