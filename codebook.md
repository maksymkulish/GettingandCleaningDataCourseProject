## First steps
Stage 1. Download sourse data from link below
Stage 2. Unzip dataSet to "./data" in working directory of R Studio. 
2. See the /data/UCI HAR Dataset/README.txt file for the detailed information on the dataset. 
The files that will be used to load data are listed as follows:
* /data/UCI HAR Dataset/test/subject_test.txt
* /data/UCI HAR Dataset/test/X_test.txt
* /data/UCI HAR Dataset/test/y_test.txt
* /data/UCI HAR Dataset/train/subject_train.txt
* /data/UCI HAR Dataset/train/X_train.txt
* /data/UCI HAR Dataset/train/y_train.txt
3. Run R script.

## Source data description
Sourse data for work was used Human Activity Recognition Using Smartphones Data Set. A full description is available at the site where the data was obtained:
  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Here are the data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## R script description
File with R code "run_analysis.R" goes following stages:   
Stage 3. Merge the training and the test sets and create one data set:
3.1 Read files    
3.1.1 Read trainings tables   
3.1.2 Read testing tables   
3.1.3 Read feature vector   
3.1.4 Read activity labels   
3.2 Assign column names   
3.3 Merge all data in one set   
Stage 4. Extract only the measurements on the mean and standard deviation for each measurement
4.1 Read column names  
4.2 Create vector for defining id, mean and standard deviation   
2.3 Make nessesary subset from "common_set"  
Stage 5. Use descriptive activity names to name the activities in the data set   
Stage 6. Appropriately label the data set with descriptive variable names   
Stage 7. Create a second, independent tidy data set with the average of each variable for each activity and each subject   
7.1 Make "dataset_tidy"   
7.2 Write "dataset_tidy" in txt file   

## Variables description   
* "x_training, "y_training, "x_testing", "y_testing", "subject_training" and "subject_testing" contain the data from the downloaded files.
* "features_vector" contains the correct names for the "x_data" dataset, which are applied to the column names stored in