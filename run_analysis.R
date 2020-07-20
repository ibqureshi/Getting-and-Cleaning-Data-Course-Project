library(data.table)
library(dplyr)

activitytest <- read.table("./test/y_test.txt", header = F)
activitytrain <- read.table("./train/y_train.txt", header = F)

subjecttest <- read.table("./test/subject_test.txt")
subjecttrain <- read.table("./train/subject_train.txt")

featurestest <- read.table("./test/X_test.txt")
featurestrain <- read.table("./train/X_train.txt")

activitylabels <- read.table("./activity_labels.txt", header = F)

featuresnames <- read.table("./features.txt", header = F)

featuresbind <- rbind(featurestest, featurestrain)
subjectbind <- rbind(subjecttest, subjecttrain)
activitybind <- rbind(activitytest, activitytrain)

names(activitylabels) <- c("ActivityN", "Activity")
names(activitybind) <- "ActivityN"

activitydata <- left_join(activitybind, activitylabels, "ActivityN")[, 2]

names(subjectbind) <- "Subject"

names(featuresbind) <- featuresnames$V2

data <- cbind(subjectbind, activitydata)
data <- cbind(data, featuresbind)

datanames <- c("Subject", "Activity", featuresnames$V2[grep("mean\\(\\)|std\\(\\)", featuresnames$V2)])
datanames <- as.character(datanames)

data <- subset(data, select = datanames)

