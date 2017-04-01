library(plyr)

# Stage 1. Download dataset
getwd()
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Stage 2. Unzip dataSet to "./data" directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")
# See the /data/UCI HAR Dataset/README.txt file for the detailed information on the dataset. 
# The files that will be used to load data are listed as follows:
# /data/UCI HAR Dataset/test/subject_test.txt
# /data/UCI HAR Dataset/test/X_test.txt
# /data/UCI HAR Dataset/test/y_test.txt
# /data/UCI HAR Dataset/train/subject_train.txt
# /data/UCI HAR Dataset/train/X_train.txt
# /data/UCI HAR Dataset/train/y_train.txt

# 3. Merge the training and the test sets and create one data set:

# 3.1 Read files

# 3.1.1 Read trainings tables:
x_training <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_training <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_training <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")

# 3.1.2 Read testing tables:
x_testing <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_testing <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_testing <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# 3.1.3 Read feature vector:
features_vector <- read.table('./data/UCI HAR Dataset/features.txt')

# 3.1.4 Read activity labels:
labels_activity = read.table('./data/UCI HAR Dataset/activity_labels.txt')

# 3.2 Assign column names:
colnames(x_training) <- features_vector[,2] 
colnames(y_training) <-"id_activity"
colnames(subject_training) <- "id_subject"

colnames(x_testing) <- features_vector[,2] 
colnames(y_testing) <- "id_activity"
colnames(subject_testing) <- "id_subject"

colnames(labels_activity) <- c('id_activity','type_activity')

# 3.3 Merge all data in one set:
common_training <- cbind(y_training, subject_training, x_training)
common_testing <- cbind(y_testing, subject_testing, x_testing)
common_set <- rbind(common_training, common_testing)

# 4. Extract only the measurements on the mean and standard deviation for each measurement

# 4.1 Read column names:
column_names <- colnames(common_set)

# 4.2 Create vector for defining id, mean and standard deviation:
vector_mean_and_std <- (grepl("id_activity" , column_names) | 
                        grepl("id_subject" , column_names) | 
                        grepl("mean.." , column_names) | 
                        grepl("std.." , column_names) 
)

# 4.3 Make nessesary subset from common_set:
set_mean_std <- common_set[ , vector_mean_and_std == TRUE]

# 5. Use descriptive activity names to name the activities in the data set:
set_activity_names <- merge(set_mean_std, labels_activity,
                              by='id_activity',
                              all.x=TRUE)

# 6. Appropriately label the data set with descriptive variable names.
# This step was made in previos stages - See 3.3, 3.2, 3.3.

# 7. Create a second, independent tidy data set with the average of each variable for each activity and each subject:

# 7.1 Make "dataset_tidy"
dataset_tidy <- aggregate(. ~id_subject + id_activity, set_activity_names, mean)
dataset_tidy <- dataset_tidy[order(dataset_tidy$id_subject, dataset_tidy$id_activity),]

# 7.2 Write "dataset_tidy" in txt file
write.table(dataset_tidy, "dataset_tidy.txt", row.name=FALSE)
str(dataset_tidy)
View(dataset_tidy)