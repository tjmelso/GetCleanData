#### Getting and Cleaning Data Course Project
library(dplyr)
#Set working directory and read data sets into R
setwd("../Repos/GetCleanData/UCI HAR Dataset")
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt", col.names="Activity")
subtest <- read.table("test/subject_test.txt", col.names = "ID")
xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt", col.names = "Activity")
subtrain <- read.table("train/subject_train.txt", col.names = "ID")
# First merge x, y, and sub tables together
mergedtest <- cbind(subtest, ytest, xtest)
mergedtrain <- cbind(subtrain, ytrain, xtrain)
# Now merge test and train datasets together
both <- rbind(mergedtest, mergedtrain)

activity <- read.table("activity_labels.txt", stringsAsFactors=FALSE)
for(i in seq_along(activity$V2)){ #Put the activity labels into my dataset
    both$Activity <- gsub(i, activity[i,2], both$Activity)
}

features <- read.table("features.txt", stringsAsFactors=FALSE)
for(i in nrow(features):1){ #Only saving the mean and std columns
    if(grepl("meanFreq", features[i,2])){
        both[,i] <- NULL
    }
    else if(grepl("mean", features[i,2])){
        colnames(both)[i+2] <- features$V2[i]
    }
    else if(grepl("std", features[i,2])){
        colnames(both)[i+2] <- features$V2[i]
    }
    else{
        both[,i] <- NULL
    }
}
# And finally average out all duplicated activities by same ID
final <- aggregate(both[, -c(1:2)], by = list(both$ID, both$Activity), mean)
final <- rename(final, ID = Group.1, Activity = Group.2)
write.table(final, "../tidydata.txt", sep = "  ", row.names=FALSE)