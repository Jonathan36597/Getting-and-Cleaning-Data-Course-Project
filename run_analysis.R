#Question 1: Merged the data sets
-------------------------------------------------
library(data.table)
library(dplyr)


#Import label data
act_Lab <- read.table('activity_labels.txt', 
                     col.names = c('activityLabels', 'activityName'), quote = "")
#Import feature label data
feat <- read.table('features.txt', 
                       col.names = c('featureLabels', 'featureName'), quote = "")

#Import all test data
sub_test <- read.table('subject_test.txt',
                       col.names = c('subjectId'))
X_test <- read.table('X_test.txt')
y_test <- read.table('Y_test.txt')

#Rename the column labels 
colnames(X_test) <- feat$featureName
colnames(y_test) <- c('activityLabels')

#Combine the test data
test_Data <- cbind(sub_test, X_test, y_test)
View(test_Data)


#Import all training data
sub_train <- read.table('subject_train.txt', col.names = c('subjectId'))
X_train <- read.table('X_train.txt')
y_train <- read.table('y_train.txt')

#Renaming the column labels 
colnames(X_train) <- feat$featureName
colnames(y_train) <- c('activityLabels')

#Combine the training sets
train_Data <- cbind(sub_train, X_train, y_train)
View(train_Data)


#Combine train and test data
all_Data <- rbind(train_Data, test_Data)
#View(all_Data)


#Question 2: Extract mean and standard deviation for each measurement 
#-------------------------------------------------

#Get all columns with mean and std in them
mean_std <- all_Data[, c(1, grep(pattern = 'mean\\(\\)|std\\(\\)', x = names(all_Data)), 563)]

#Question 3: Uses descriptive activity names to name the activities in the data set
#-------------------------------------------------

#Subbing in the acivity labels 
mean_std$subjectId <- as.factor(mean_std$subjectId)

mean_std$activity <- factor(mean_std$activityLabels,
                              levels = act_Lab$activityLabels,
                              labels = act_Lab$activityName)

#Question 4: Appropriately labels the data set with descriptive variable names. 
#-------------------------------------------------
colnames(mean_std) 

#Remove all bracket from the names hyphens
colnames(mean_std) <- gsub(pattern = '\\(\\)', replacement = "", x = names(mean_std))

#Export the tidy data set 


#Question 5 Create a tidy data set with the average of each variable 
write.table(mean_std, file = 'tidyData.txt', row.names = F, quote = F, sep = "\t")


