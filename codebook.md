data used: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

First I read all the features files

then the subject files

then the activity Labels

then the feature Names

Next I merged all the subject and train datasets by their Features, Activity, and  Subject

The activity labels were used to rename the columns in the activity data

I renamed the subject data column to subject

the features data was renamed using the features labels

now i put all the data together in one file

i searched for key words such as mean and std to pull out the relvant data i needed to create a new smaller sub data set

the data was then aggregated

finally it was saved in a txt file