library(data.table)
library(dplyr)

setwd("/Users/ibraheemqureshi/R/Getting-and-Cleaning-Data-Course-Project")

atest <- read.table("./test/y_test.txt", header = F)
atrain <- read.table("./train/y_train.txt", header = F)

###Read features files
ftest <- read.table("./test/X_test.txt", header = F)
ftrain <- read.table("./train/X_train.txt", header = F)

#Read subject files
stest <- read.table("./test/subject_test.txt", header = F)
strain <- read.table("./train/subject_train.txt", header = F)

####Read Activity Labels
alabels <- read.table("./activity_labels.txt", header = F)

#####Read Feature Names
fnames <- read.table("./features.txt", header = F)

#####Merg dataframes: Features Test&Train,Activity Test&Train, Subject Test&Train
fdata <- rbind(ftest, ftrain)
sdata <- rbind(stest, strain)
adata <- rbind(atest, atrain)

####Renaming colums in ActivityData & ActivityLabels dataframes
names(adata) <- "ActivityN"
names(alabels) <- c("ActivityN", "Activity")

####Get factor of Activity names
activity <- left_join(adata, alabels, "ActivityN")[, 2]

####Rename SubjectData columns
names(sdata) <- "Subject"

#Rename FeaturesData columns using columns from FeaturesNames
names(fdata) <- fnames$V2

###Create one large Dataset with only these variables: SubjectData,  Activity,  FeaturesData
data <- cbind(sdata, activity)
data <- cbind(data, fdata)

###Create New datasets by extracting only the measurements on the mean and standard deviation for each measurement
subfnames <- fnames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
datanames <- c("Subject", "Activity", as.character(subfnames))
data <- subset(data, select=datanames)

#####Rename the columns of the large dataset using more descriptive activity names
names(DataSet)<-gsub("^t", "time", names(DataSet))
names(DataSet)<-gsub("^f", "frequency", names(DataSet))
names(DataSet)<-gsub("Acc", "Accelerometer", names(DataSet))
names(DataSet)<-gsub("Gyro", "Gyroscope", names(DataSet))
names(DataSet)<-gsub("Mag", "Magnitude", names(DataSet))
names(DataSet)<-gsub("BodyBody", "Body", names(DataSet))

####Create a second, independent tidy data set with the average of each variable for each activity and each subject
data2<-aggregate(. ~Subject + activity, data, mean)
data2<-data2[order(data2$Subject,data2$activity),]

#Save this tidy dataset to local file
write.table(data2, file = "finaldata.txt",row.name=FALSE)