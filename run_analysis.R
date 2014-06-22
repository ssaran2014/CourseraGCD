## Script for GCD Project
## This script should reside in the same folder as the features.txt file. Subfolders within this folder are /test and /train.
## Expects files to be unzipped already

## Needs the reshape2 package
library(reshape2)

## Step 1. Upzip and then read the various text files

unzip("getdata-projectfiles-UCI HAR Dataset.zip")
features <- character() #read features as a character class
features <- read.table("./UCI HAR Dataset/features.txt", header=FALSE, sep=" ") ##reading the features.txt file

y_train <- data.frame() #read y_train as a character calss
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE, sep="") ##reading the y_train.txt file

subject_train <- character()
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE, sep="") ##reading the subject_train file

x_train <- data.frame()
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt", header=FALSE, sep="") ##reading the x_train file

y_test <- data.frame() #read y_train as a character calss
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE, sep="") ##reading the y_test.txt file

subject_test <- character()
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE, sep="") ##reading the subject_test file

x_test <- data.frame()
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt", header=FALSE, sep="") ##reading the x_test file

## Step 2. Cleaning y_train and y_test. Also removing caps. First letter of second word in caps for easier reading
## Give y_train variables descriptive names
y_train[,1] <- gsub(1, "walking", y_train[,1])
y_train[,1] <- gsub(2, "walkingUp", y_train[,1])
y_train[,1] <- gsub(3, "walkingDownstairs", y_train[,1])
y_train[,1] <- gsub(4, "sitting", y_train[,1])
y_train[,1] <- gsub(5, "standing", y_train[,1])
y_train[,1] <- gsub(6, "laying", y_train[,1])

## Give y_test variables descriptive names
## This step is redundant. It could also be done once the data has been combined?
y_test[,1] <- gsub(1, "walking", y_test[,1])
y_test[,1] <- gsub(2, "walkingUp", y_test[,1])
y_test[,1] <- gsub(3, "walkingDownstairs", y_test[,1])
y_test[,1] <- gsub(4, "sitting", y_test[,1])
y_test[,1] <- gsub(5, "standing", y_test[,1])
y_test[,1] <- gsub(6, "laying", y_test[,1])


## Step 3. cleaning up the column names in feature
## removes () , -. Leaves caps in as it is easier to read the column with caps
features1 <- "character"
features1 <- features[,2] ##extracts just the second column with the feature names
features2 <- gsub("\\(", "", features1) ## removes (
features3 <- gsub("\\)", "", features2) ## removes )
features4 <- gsub("\\-", "", features3) ## removes -
features5 <- gsub("\\,", "", features4) ## removes ,

## Add the subject id and the activity to x_train
x_train1 <- cbind(subject_train, y_train, x_train)

## Add the subject id and the activity to x_train
x_test1 <- cbind(subject_test, y_test, x_test)

## Step 4. Merge the train and test data sets
combine <- rbind(x_train1, x_test1)

## Step 5. Add the column names
colnames(combine) <- c("subject", "activity", features5)

## Step 6. Extracting columns with only mean and std
columns <- colnames(combine) ## extracting names of columns
col_mean <- grep("mean", columns, value=TRUE) ## extracts names of columns with mean
col_std <- grep("std", columns, value=TRUE) ## extracts names of columns with std
col_meanFreq <- grep("meanFreq", columns, value=TRUE) ## extracts names of columns with meanFreq, which we don't want
col_wanted <- c("subject", "activity", col_mean, col_std) ##list of wanted column names

##c creating new data.frame with only the wanted columns
combine2 <- combine[,which(names(combine) %in% col_wanted)]
combine3 <- combine2[,-which(names(combine2) %in% col_meanFreq)] ##removes columns with meanFreq

## Step 7. Summary by each subject each activity and mean of each variable
## Uses the reshape2 package
summ <- melt(combine3, id.vars = c("subject", "activity"))
summ2 <- dcast(summ, subject + activity ~ variable, fun.aggregate = mean)

## save the file in the same directory as the script in a csv file
write.table(summ2, file="wearable_data_mean.txt", sep=" ", row.names=TRUE, col.names=TRUE)