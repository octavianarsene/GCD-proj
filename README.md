### Description

Create a tidy data set with the average of each variable (mean-s and standard deviation-s only) for each activity and each subject. These **Human Activity Recognition Using Smartphones** measurements were done during the UCI research project `http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones`.

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


### Components

There is one R script: `run_analysis.R` that processes the `Human Activity Recognition` raw data

The R script assumes that the raw data parent folder `UCI HAR Dataset` should be in the same location as R script is.

The `UCI HAR Dataset` parent folder has the following structure:

1. test
2. train
3. activity_labels.txt
4. features.txt
5. features_info.txt

(all the details are provided in the `CodeBook.md`)

### How to run

In order to process the raw data the following commands should be run:

1. unzip the `getdata-projectfiles-UCI HAR Dataset.zip` file in a specific location (e.g. review); check to have `UCI HAR Dataset` folder
2. get the R script in the working folder
3. `source('run_analysis.R')`
4. call `getHumanActv()` function by assigning its result to a variable (no input parameter needed, it takes all the files from the `UCI HAR Dataset`)

The R script has internal functions designed for the following tasks:

* `createFeatsNames()` : filters the *mean* and *standard deviation* measurements
* `aggregateSubjActv()` : computes the average of the measurements grouped by subject and activity

### R script purpose

The R script `run_analysis.R` does the following:

1. merges the training and the test sets to create one data set
2. extracts only the measurements on the mean and standard deviation for each measurement 
3. uses descriptive activity names to name the activities in the data set
4. appropriately labels the data set with descriptive variable names. 
5. creates a tidy data set with the average of each variable for each activity and each subject


### Data details

The variables, the data, and any transformations or work performed to clean up the data can be found in `CodeBook.md` file.