## Load reshape2 library for melt().
library(reshape2)

## Read raw test and training datasets.

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")


## Merge test and training datasets into one dataset.

data_test <- cbind(y_test,subject_test,X_test)
data_train <- cbind(y_train,subject_train,X_train)
data1 <- rbind(data_test,data_train)


## Extract measurements on the mean and standard deviation from dataset.

data1 <- data1[,c(1:8,43:48,83:88,123:128,163:168,203,204,216,
                                 217,229,230,242,243,255,256,268:273,347:352,
                                 426:431,505,506,518,519,531,532,544,545)]
names(data1) <- c(1:68)

## Read descriptive activity names and use them for activities
## in the extracted dataset.

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
data1 <- merge(data1,activity_labels,by.x="1",by.y="V1",sort=FALSE)
data1 <- cbind(data1$V2,factor(data1[,2]),data1[,c(3:68)])

## Read descriptive variable names and use them in the extracted dataset.

features <- read.table("./UCI HAR Dataset/features.txt")
feature_names <- make.names(features$V2[c(1:6,41:46,81:86,121:126,161:166,201,
                                          202,214,215,227,228,240,241,253,254,
                                          266:271,345:350,424:429,503,504,516,
                                          517,529,530,542,543)])
variable_names <- c("ActivityID","SubjectID",feature_names)
names(data1) <- variable_names


## Create & write tidy dataset with average of each feature variable for each
## combination of subject and activity.
Activity_SubjectID <- paste(data1$ActivityID,data1$SubjectID)
data2premelt <- cbind(Activity_SubjectID,data1)[,c(1,4:69)]
data2melt <- melt(data2premelt,id.vars="Activity_SubjectID",
                  measure.vars=feature_names)
data2 <- dcast(data2melt, Activity_SubjectID ~ variable,mean)


## Tidy data can be exported to the working directory with: 
## write.table(data2,file="tidydata.txt",row.names=FALSE)
## 
## This file can be retrieved with:
## data2 <- read.table("tidydata.txt",header=TRUE)