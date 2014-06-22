CodeBood.MD
============

This file describes the variables, the data and the transformations done to the raw files from the zip files.

The run_analysis.R script needs to reside in the same directory as the zip file getdata-projectfiles-UCI HAR Dataset. The script unzips the file and reads the appropriate files.
The output called wearable_data_mean.csv is created and stored in the same director as the script file.

See the readme.md file for the source of the zip file for the project and the Galaxy Smartphone original raw files.

**Descriptiion of features**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

-mean(): Mean value
-std(): Standard deviation
-mad(): Median absolute deviation 
-max(): Largest value in array
-min(): Smallest value in array
-sma(): Signal magnitude area
-energy(): Energy measure. Sum of the squares divided by the number of values. 
-iqr(): Interquartile range 
-entropy(): Signal entropy
-arCoeff(): Autorregresion coefficients with Burg order equal to 4
-correlation(): correlation coefficient between two signals
-maxInds(): index of the frequency component with largest magnitude
-meanFreq(): Weighted average of the frequency components to obtain a mean frequency
-skewness(): skewness of the frequency domain signal 
-kurtosis(): kurtosis of the frequency domain signal 
-bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
-angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

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

 


