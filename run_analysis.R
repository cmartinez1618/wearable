#load reshape2
library(reshape2)

# download the data and unzip files if they don't exist

filename <- "uci_data.zip"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(filename)){
  download.file(url = fileURL, destfile = filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}


# read in data and information 
train_dat <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
test_dat <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")

# read the labels and subjects
train_activity <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")

test_activity <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")

# read in features and activity and label the columns 
features <- read.table(file = "./UCI HAR Dataset/features.txt", sep =  " ", header = FALSE)
names(features) <- c("id", "feature")
activity <- read.table(file = "./UCI HAR Dataset/activity_labels.txt", sep =  " ", header = FALSE)
names(activity) <- c("identifier", "activity")


# we only need features that contain the mean and the standard deviation (std)
# Extract only mean and std features
features_needed <- grep(".*mean.*|.*std.*", features[,2])
features_needed_names <- features[features_needed,2]
features_needed_names <- gsub('-mean', 'Mean', features_needed_names)
features_needed_names <- gsub('-std', 'Std', features_needed_names)
features_needed_names <- gsub('[-()]', '', features_needed_names)

# Create a train and test dataset with only the desired featured values and the label and activities
train_needed <- train_dat[,features_needed]
train_final <- cbind(train_subject,train_activity,train_needed)
names(train_final) <- c("subject", "activity", features_needed_names)

test_needed <- test_dat[,features_needed]
test_final <- cbind(test_subject,test_activity,test_needed)
names(test_final) <- c("subject", "activity", features_needed_names)

# merge the two datasets 
combined_dat <- rbind(train_final, test_final)

# convert the subject and activity columns into factors
combined_dat$subject <- as.factor(combined_dat$subject)
combined_dat$activity <- factor(combined_dat$activity, levels = activity$identifier, labels = activity$activity)

# create a tidy data set that displays the average of each measurement for each subject and activity
# Since there are 30 subjects and 6 activities you should get a total of 180 records

combined_melted <- melt(combined_dat, id = c("subject","activity"))
combined_final <- dcast(combined_melted, subject + activity ~ variable, mean)

# save the final data set 
write.table(combined_final, file ="./final_dat.txt")





