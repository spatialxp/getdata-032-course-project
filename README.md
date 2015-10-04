# About
This project contains the exercises for the Getting and Cleaning Data course project.

This project contains the following items:
-	CodeBook.md
-	Run_analysis.R
-	Averages.txt
	
##CodeBook.md
This is the code book describing the source data variables.

##Run_analysis.R
This is an R script that processes the data into a tidy form and generates a data set with the average of each variable for each activity and each subject. The script completes the following steps:

- checks if the source data exists and downloads it if required
- extracts the source data zip file
- merges the test and training data into a single data set
- filters the data set to keep only mean and standard deviation variables
- applies descriptive variable names
- exports the average of each variable for each activity and each subject

This script can be run with no arguments.

##Averages.txt
This text file contains CSV data with the average of each variable for each activity and each subject
