CourseraGCD
===========

This repo is to store the project required for the Coursera GCD course.

The project is related to data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Contents of this repo include
i) run_analysis.R script [This needs to reside in the same directory as the zip file. The R script will unzip the file]
ii) a code book that describes the variables, the data, and transformations to clean the data
iii) a tidy data set which is the mean output for all the mean and standard deviation variables for each activity of each participant. 

**Step by step function of the code and the transformations performed**
- Step 1. Files unziped. The files must be in the same folder as the R script
- Step 2. The features, x_train, y_train, subjust_train, x_test, y_test, subject_test files are read
- Step 3. y_train and y_test contain activity codes 1-6. Activity codes are given their descriptive names which are: walking, walkingUp, walkingDownstairs, sitting, standing, laying
- Step 4. Clean the variables in feature by removing special characters like ( ) - , The caps are left in place since they make it easier to read the variable names.
- Step 5. Combine the train data to have subject id as the first column, activity name as the second column and then the x_train data. Same with the testing data.
- Step 6. Merge the train and the test data sets
- Step 7. Extract the names of the columns in the merged data set. Find the column names with mean and std. A new data set with just subject id, activity and variables with mean and std is created. Columns with meanFreq is removed
since that isn't really an average of the frequency readings. So, the first required tidy dataset is called combine3.
Step 8. Using melt and dcast, a new dataset, called summ2, is created which extracts the mean of all the variables in combine3 for each activity of each subject. This dataset has 180 rows (30 subjects * 6 activities/subject).
This dataset is downloaded as a txt file, wearable_data_mean.txt,  in the same folder as the run_analysis.R file. It can be opened using read.table("path/wearable_data_mean.txt", sep=" ", header=TRUE)
