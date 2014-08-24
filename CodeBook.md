CodeBook.md

Code Book: 

Function:

get.data : 
1. create a directory to load the data
2. download and unzip the data

merge.data:
1. read data files into tables
2. use rbind to combine the tables 
3. return a list of combined tables

mean_std.data :
1. read data files into tables
2. extract mean & stardard deviation
3. add columns names

descriptive.names:
1. add columns names for activies
2. transform activies to meaningful desciptions

average.data: 
1. use  ddply to find that column means and combine results into a dataframe

tidy.data :
1. call all other functions in order 
2.  add subject names
3. combine columns
4. create the results csv

Variable:
URL : The uniform resource locator, abbreviated as URL (also known as web address, particularly when used with HTTP), used to locate the zip file containing the data

zipName : path and name to download the zip file into.

train.x : table with data from X_train.txt

train.y : table with data from y_train.txt

train.subject : table with data from subject_train.txt

test.x : table with data from X_test.txt

test.y : table with data from y_test.txt

test.subject : table with data from subject_test.txt

combine.x : table with data from train.x and test.x

combine.y : table with data from train.y and test.y

combine.subject : table with data from train.subject and test.subject)

merged : list orx=combine.x, y=combine.y and subject=combine.subject

features : table with data from features.txt

mean.col : column data matching mean()

std.col  : column data matching std()

edf : extracted meal and standard deviation data

cx : extracted meal and standard deviation data

cy : transformed activity data

combined : combined result  cx, cy merge$subject by columns 

tidydataset <- contains tidy dataset and averages


Study Design :
Data:
Raw data : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data Description : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Transformations :
translate activity numbers to descriptions from activity_labels.txt
activity
1 = "WALKING"
2 = "WALKING_UPSTAIRS"
3 = "WALKING_DOWNSTAIRS"
4 = "SITTING"
5 = "STANDING"
6 = "LAYING"

Recipe : 
1. Create a directory at the R rood called GettingCleaning

2. Copy run_analysis.R into the directory

3. Start R studio

4. Set the work directory

setwd("~/GettingCleaning")

5. Load the run_analysis.R

source('run_analysis.R')

6. Execute the "tidy process"

tidy.data()

7. Use the resulting file for further analysis

WearableComputingData.csv 
