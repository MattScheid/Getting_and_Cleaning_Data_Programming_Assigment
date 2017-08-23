# Getting and Cleaning Data Programming Assignment

This repo was created to analyze the UCI HAR Dataset. The run_analysis.R script will perform the following:

* Downloads the data file
* Download the R source code into your R working directory.
* Execute R source code to generate tidy data file.

__Variables Description__

* The measurements (X) in the dataset are sensor signals from Samsung smartphones.
* The activities (Y) indicates activity type the subjects performed during recording.

__Code Explaination__

* First the "run_analysis.R" code reads in data from the UCI HAR Dataset
* Then it combines the training test data
* Then it selects only the variables we are interested in (mean and standard deviation)
* Then it changes out activity numbers for appropriate descriptions
* Then it labels the columns appropriately
* Lastly it produces a tidyDataset which takes an average of each measurement for each subject and activity
