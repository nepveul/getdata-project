#install.packages("dplyr")
library(plyr);
library(dplyr);


# Read the feature names
features <- read.table("UCI HAR Dataset/features.txt");
features$V2 <- as.character(features$V2);
names(features) <- c("index", "name");

# Read in the activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("level", "label"));

# Step #1: Merges the training and the test sets to create one data set.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject");
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject");

subject <- rbind(subject_test, subject_train);

X_test <- read.table("UCI HAR Dataset/test/X_test.txt");
X_train <- read.table("UCI HAR Dataset/train/X_train.txt");
X <- rbind(X_test, X_train);

y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity");
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity");
y <- rbind(y_test,y_train);

# Step #2: Extracts only the measurements on the mean and standard deviation for each measurement. 
X <- X[,grep("mean|std", features$name)];

# Step #3: Uses descriptive activity names to name the activities in the data set
y$Activity <- factor(y$Activity, 
                     labels = activity_labels$label);

# Step #4: Appropriately labels the data set with descriptive variable names. 
names(X) <- grep("mean|std", features$name,value=TRUE);

data <- cbind(X,y,subject);
data2_tidy <- ddply(data,.(Activity, Subject),numcolwise(mean));

write.table(data2_tidy,file="tidy.txt", row.name=FALSE);
data2_tidy;

