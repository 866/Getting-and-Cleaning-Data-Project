# Load data into dataframes
sourcefile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"  
destfile <- "HAR_Dataset.zip"
if(!file.exists(destfile)) { 
  download.file(sourcefile, destfile=destfile, quiet=TRUE, method="curl") }
unzip(destfile)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", as.is = TRUE)
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", as.is = TRUE)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", as.is = TRUE)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", as.is = TRUE)
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = c("factor"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = c("factor"))
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", as.is = TRUE)[, 2]
features <- read.table("./UCI HAR Dataset/features.txt", as.is = TRUE)[, 2]

# Find columns with specific features
features_subset <- grepl("mean|std", features)
features <- features[features_subset]

# Subset data with specific features
X_test <- X_test[, features_subset]
X_train <- X_train[, features_subset]

# Assign names to columns
names(X_test) <- features
names(X_train) <- features

# Get activity labels
test_labels <- as.factor(activity_labels[y_test[,1]])
train_labels <- as.factor(activity_labels[y_train[,1]])

# Add new columns
X_test$SubjectID <- subject_test[, 1]
X_train$SubjectID <- subject_train[, 1]
X_test$Activity <- test_labels
X_train$Activity <- train_labels

# Join test and train set together
joined_data <- rbind(X_test, X_train)
tidy_data <- aggregate(.~SubjectID+Activity, data = joined_data, FUN=mean)

# Write results to file
write.table(tidy_data, file = "./tidy_data.txt")

