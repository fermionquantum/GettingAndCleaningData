#necessary library to calculate the final mean
library(reshape2)

# Setting the path to the current directory 
setwd("./GettingAndCleaningData/W4")
myPath <- "./GettingAndCleaningData/W4/project"

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./project/data.zip")
unZiped <- unzip("./project/data.zip", exdir = "./project")

# Merging training and test sets in only one data set: fullDataTestTrain  
train_X <- read.table("./project/UCI HAR Dataset/train/X_train.txt", header = FALSE)
test_X <- read.table("./project/UCI HAR Dataset/test/X_test.txt", header = FALSE)

train_Y <- read.table("./project/UCI HAR Dataset/train/y_train.txt", header = FALSE)
test_Y <- read.table("./project/UCI HAR Dataset/test/y_test.txt", header = FALSE)

train_Subject <- read.table("project/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
test_Subject <- read.table("./project/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Merge the train and test sets
trainDt <- cbind(train_Subject, train_Y, train_X)
testDt <- cbind(test_Subject, test_Y, test_X)

# Full data set merged
fullDataTestTrain <- rbind(testDt, trainDt)

# Loading the feature names
features <- read.table("./project/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)

# Selecting only the mean and std of measures
indexMeanStd <- grep(("-(mean|std)\\(\\)"), features[,2])

# Indexing the fullData variable with only the mean and std measuments
fullData <- fullDataTestTrain[,c(1,2,indexMeanStd+2)]

# Adding names to the right columns 
colnames(fullData) <- c("subject", "activity", features[indexMeanStd,2])

# Get activity labels and indexing in to fullData
descriptiveNames <- read.table("./project/UCI HAR Dataset/activity_labels.txt")
fullData$activity <- factor(fullData$activity, levels = descriptiveNames[,1], labels = descriptiveNames[,2])

# Changes in the labels
names(fullData) <- gsub("\\()","",names(fullData)) 
names(fullData) <- gsub("mean","Mean",names(fullData)) 
names(fullData) <- gsub("std","StandardDev.",names(fullData))
names(fullData) <- gsub("Acc","Acceler.",names(fullData))
names(fullData) <- gsub("Mag","Magnitude",names(fullData))
names(fullData) <- gsub("^t","Time",names(fullData))
names(fullData) <- gsub("^f","Freq.",names(fullData))
names(fullData) <- gsub("Gyro","Gyroscope",names(fullData))

# Create the melt data already labeled 
DataTrainTest <- melt(fullData, id.vars = c("subject", "activity"))

# Applying mean function to the new data set
DataTrainTest <- dcast(DataTrainTest, subject + activity ~ variable, mean)

# Tidy data created and nomead as Average.txt
write.table(DataTrainTest, file = "./Average.txt", sep = " ", row.names = FALSE)


################################################################################
