---
title: "Coursera John Hopkins Data Science in R Course 3"
author: "Carlos Martinez"
date: "11/22/2020"
output: html_document
---

## Assignment Instructions

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Explanation of Code in run_analysis.R

1. Download the data from the giving URL
2. Unzip the files
3. Read feature, activity, train and test data information
4. Extract ONLY the feature column index and labels needed (only columns with mean or std in their names)
5. Create a train data set that contains the subject, activity and the feature columns from step 4
6. Create a test data set that contains the subject, activity and the feature columns from step 4
7. Combine both train and test data sets
8. Since subject and activity are given as "ID", change these to factors and/or labels to manipulate later on
9. There are 30 subjects and 6 activities so clean data to have each measurement by subject and activity
10. Finally, find the average measurement by subject and activity (a total of 30 * 6 = 180 summarized records)