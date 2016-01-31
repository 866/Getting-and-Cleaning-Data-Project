CodeBook
=====

This is a code book that describes the variables, the data, and any transformations or work that were performed to clean up the data.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The text below describes code flow and explains code chunks separated by comments in *run_analysis.R*.

### 1. Loading data
This script part downloads archive from the Internet source if necessary and unzips it. Then it reads table files and puts data into variables:

* ```subject_test``` : subject IDs for test
* ```subject_train``` : subject IDs for train
* ```X_test``` : values of variables in test
* ```X_train``` : values of variables in train
* ```y_test``` : activity ID in test
* ```y_train``` : activity ID in train
* ```activity_labels``` : Description of activity IDs in y_test and y_train
* ```features``` : description(label) of each variables in X_test and X_train

### 2. Find columns with specific features
Subsets features that correspond to mean or std value.

### 3. Subset data with specific features
Subsets ```X_test``` and ```X_train``` columns only with needed features.

### 4. Assign names to columns
For suitability script assigns feature names to columns of ```X_test``` and ```X_train```

### 5. Get activity labels
This code chunk extracts activity labels stored in ```y_test``` and ```y_train``` and transforms them into factors in ```test_labels``` and ```train_labels```.

### 6. Add new columns
Adds new columns to ```X_test``` and ```X_train```:

* ```SubjectID``` - numerical identifier of subject
* ```Activity``` - string factor of activity

### 7. Join test and train set together
Script binds rows of ```X_test``` and ```X_train``` i.e. joins together test and training set and assigns to ```joined_data```. Also it creates new dataframe ```tidy_data``` which contains average of each variable for each activity and each subject.

### 8. Write results to file
Final script saves obtained table in "tidy_data.txt".
