library(data.table) #used for handling large data
library(dplyr) #aggregate variables to create the tidy data

##Reading of Supporting Metadata, they are in the name of the features and activity_labels in the dataset
feature_Names <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/features.txt")
activity_Labels <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Reading of Training Data
sub_Train <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
act_Train <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/train/y_train.txt", header = FALSE)
feat_Train <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/train/X_train.txt", header = FALSE)

##Reading of Test Data
sub_Test <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
act_Test <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/test/y_test.txt", header = FALSE)
feat_Test <- read.table("C:/Users/tanmay.bhowmik/Downloads/Online_Certificates/Cleaning Data Assignment/UCI HAR Dataset/test/X_test.txt", header = FALSE)

## 1. Merge the train and the test data sets to create a single data set
subject_combine <- rbind(sub_Train, sub_Test)
activity_combine <- rbind(act_Train, act_Test)
features_combine <- rbind(feat_Train, feat_Test)

##Column Naming
colnames(features_combine) <- t(feature_Names[2])


##Merging and storing into 'complete_Data'
colnames(activity_combine) <- "Activity"
colnames(subject_combine) <- "Subject"
complete_Data <- cbind(features_combine,activity_combine,subject_combine)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(complete_Data), ignore.case=TRUE)

requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(complete_Data)

extracted_Data <- complete_Data[,requiredColumns]
dim(extracted_Data)


## 3. Uses descriptive activity names to name the activities in the data set
extracted_Data$Activity <- as.character(extracted_Data$Activity)
for (i in 1:6){
  extracted_Data$Activity[extracted_Data$Activity == i] <- as.character(activity_Labels[i,2])
}

extracted_Data$Activity <- as.factor(extracted_Data$Activity)


## 4. Appropriately labels the data set with descriptive variable names.
names(extracted_Data)

##change of Labels
names(extracted_Data)<-gsub("BodyAcc", "Body_Accelerometer", names(extracted_Data))
names(extracted_Data)<-gsub("BodyGyro", "Body_Gyroscope", names(extracted_Data))
names(extracted_Data)<-gsub("BodyBody", "Body", names(extracted_Data))
names(extracted_Data)<-gsub("Mag", "Magnitude", names(extracted_Data))
names(extracted_Data)<-gsub("^t", "Time_", names(extracted_Data))
names(extracted_Data)<-gsub("^f", "Frequency_", names(extracted_Data))
names(extracted_Data)<-gsub("tBody", "Time_Body", names(extracted_Data))
names(extracted_Data)<-gsub("-mean", "_Mean", names(extracted_Data))
names(extracted_Data)<-gsub("-Std", "_StdDeviation", names(extracted_Data))
names(extracted_Data)<-gsub("Magnitudenitude", "_Magnitude", names(extracted_Data))
names(extracted_Data)<-gsub("TimeGravityAcc", "TimeGravity_Accelerometer", names(extracted_Data))
names(extracted_Data)<-gsub("Time", "Time_", names(extracted_Data))
names(extracted_Data)<-gsub("Frequency", "Frequency_", names(extracted_Data))

names(extracted_Data)


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

extracted_Data$Subject <- as.factor(extracted_Data$Subject)
extracted_Data <- data.table(extracted_Data)

tidyData <- aggregate(. ~Subject + Activity, extracted_Data, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)

