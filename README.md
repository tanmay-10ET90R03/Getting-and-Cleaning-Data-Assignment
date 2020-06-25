# Getting-and-Cleaning-Data-Assignment

This is the readme file for the Peer-graded Assignment: Getting and Cleaning Data Course Project. Here the data set has been according to the instruction provided. 

Data Set:

Data Set has been downloaded according to Coursera assignment instructions. Following URL was visited to download the data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

=======================

This project repository containes the following files:

-Readme.md --> explains the analysis files is clear and understandable

-Tidy Data Set --> The created dataset

-CodeBook.md --> describes the contents of the Tidy data set (data, variables and transformations used to generate the data).

-run_analysis.R --> The R script that was used to create the data set. 

=======================

To create the data set, the following steps need to follow:

-Download and unzip the dataset.

-Use library "data.table" for handling large data and "dplyr" to aggregate variables to create the tidy data set.

-Reading of Supporting Metadata, which are in the name of the features and activity_labels in the dataset.

-Reading of Training Data.

-Reading of Test Data

-Merge the training and the test sets to create one data set.

-Extract only the measurements on the mean and standard deviation for each measurement.

-Use descriptive activity names to name the activities in the data set.

-Appropriately label the data set with descriptive variable names.

-Create a second, independent tidy set with the average of each variable for each activity and each subject.

-Write the data set to the Tidy.txt file.

==============================================================
