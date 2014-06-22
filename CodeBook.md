###Getting and Cleaning Data Course Project

James Wu

#Source Data
For a full description of the data used, please visit: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data can be found: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Section 1. Merge the training and the test sets to create one data set
Once the source directory has been set and the workspace cleared, we read the following files into R:
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Then we assign column names and merge all into one large dataset.


## Section 2. Extract only the measurements on the mean and standard deviation for each measurement. 
We created 3 lists with all the column names which includes "mean" and "std" and "meanFreq". The meanFreq list is subtracted from the mean list and then both the mean and std lists are combined to form one comprehensive list which includes all the mean (sans meanFreq) and std measurements.

Subset the full data to only include items on that list.

## Section 3. Use descriptive activity names to name the activities in the data set
The merge function was inexplicitly changing all the activityids to "1" so I decided to use this loop function. The for loop function takes each element in the 'activityId' column of the data set and returns the associated activity type from the activity_labls.txt.

## Section 4. Appropriately label the data set with descriptive activity names.
Use gsub function for pattern replacement to clean up the data labels. Replaced starting t's wth "Time" and f with "Freq" as detailed in the feature_info.txt.

## Section 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
Creates a seperate table which summarizes the mean based on the subject number and activity type.