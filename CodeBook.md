# Project Code Book

### Input data

The input data used for this project is the Human Activity Recognition Using Smartphones Data Set. Documentation on this data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Transformations

THe plyr and dplyr libraries are required for this project 

```{r}
library(plyr);
library(dplyr);
```

We first red in the feature names

```{r}
features <- read.table("UCI HAR Dataset/features.txt")
features$V2 <- as.character(features$V2)
names(features) <- c("index", "name")
```
We then read in the activity labels

```{r}
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("level", "label"))
```
##### Step 1. 

We read the subject data sets for both training and test data. We then merge the two data sets together.

```{r}
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")

subject <- rbind(subject_test, subject_train)
```
We read the X variables for the testing and the training data sets. We merge the two together.

```{r}
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
X <- rbind(X_test, X_train)

```

We then read in the target variable, the activity from both train and test. We merge the two together.

```{r}
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
y <- rbind(y_test,y_train)

```

##### Step 2

We only keep the mean and std variables.

```{r}
X <- X[,grep("mean|std", features$name)]
```

##### Step 3

We create a factor variable for the target variable Activity. That way the proper description labels will be used.

```{r}
y$Activity <- factor(y$Activity, 
                     labels = activity_labels$label)
```

##### Step 4

We assign the labels of the variables based on the features names from the input data sets.

```{r}
names(X) <- grep("mean|std", features$name,value=TRUE)
```

We bind the X, y, and subject datasets together to create one single dataset.

```{r}
data <- cbind(X,y,subject)
```

We create the second tidy data set that calculated the mean of all variables by Subject and Activity.

```{r}
data2_tidy <- ddply(data,.(Activity, Subject),numcolwise(mean))

write.table(data2_tidy,file="tidy.txt", row.name=FALSE)

data2_tidy
```

### Output data

Two datasets are created. Both data sets have the exact same structure with 81 variables. The first contains all data observation from the input data sets (10299). The second contains a single row per Activity and Subject. The 79 observation variables are averaged per Subject and Activity.

Column | Variable Name                     | Definition
-------|-----------------------------------|-------------------------------------------------------
1     | tBodyAcc-mean()-X                  |
2	| tBodyAcc-mean()-Y                  |
3	| tBodyAcc-mean()-Z                  |
4	| tBodyAcc-std()-X                   |
5	| tBodyAcc-std()-Y                   |
6	| tBodyAcc-std()-Z                   |
7	| tGravityAcc-mean()-X               |
8	| tGravityAcc-mean()-Y               |
9	| tGravityAcc-mean()-Z               |
10	| tGravityAcc-std()-X                |
11	| tGravityAcc-std()-Y                |
12	| tGravityAcc-std()-Z                |
13	| tBodyAccJerk-mean()-X              |
14	| tBodyAccJerk-mean()-Y              |
15	| tBodyAccJerk-mean()-Z              |
16	| tBodyAccJerk-std()-X               |
17	| tBodyAccJerk-std()-Y               |
18	| tBodyAccJerk-std()-Z               |
19	| tBodyGyro-mean()-X                 |
20	| tBodyGyro-mean()-Y                 |
21	| tBodyGyro-mean()-Z                 |
22	| tBodyGyro-std()-X                  |
23	| tBodyGyro-std()-Y                  |
24	| tBodyGyro-std()-Z                  |
25	| tBodyGyroJerk-mean()-X             |
26	| tBodyGyroJerk-mean()-Y             |
27	| tBodyGyroJerk-mean()-Z             |
28	| tBodyGyroJerk-std()-X              |
29	| tBodyGyroJerk-std()-Y              |
30	| tBodyGyroJerk-std()-Z              |
31	| tBodyAccMag-mean()                 |
32	| tBodyAccMag-std()                  |
33	| tGravityAccMag-mean()              |
34	| tGravityAccMag-std()               |
35	| tBodyAccJerkMag-mean()             |
36	| tBodyAccJerkMag-std()              |
37	| tBodyGyroMag-mean()                |
38	| tBodyGyroMag-std()                 |
39	| tBodyGyroJerkMag-mean()            |
40	| tBodyGyroJerkMag-std()             |
41	| fBodyAcc-mean()-X                  |
42	| fBodyAcc-mean()-Y                  |
43	| fBodyAcc-mean()-Z                  |
44	| fBodyAcc-std()-X                   |
45	| fBodyAcc-std()-Y                   |
46	| fBodyAcc-std()-Z                   |
47	| fBodyAcc-meanFreq()-X              |
48	| fBodyAcc-meanFreq()-Y              |
49	| fBodyAcc-meanFreq()-Z              |
50	| fBodyAccJerk-mean()-X              |
51	| fBodyAccJerk-mean()-Y              |
52	| fBodyAccJerk-mean()-Z              |
53	| fBodyAccJerk-std()-X               |
54	| fBodyAccJerk-std()-Y               |
55	| fBodyAccJerk-std()-Z               |
56	| fBodyAccJerk-meanFreq()-X          |
57	| fBodyAccJerk-meanFreq()-Y          |
58	| fBodyAccJerk-meanFreq()-Z          |
59	| fBodyGyro-mean()-X                 |
60	| fBodyGyro-mean()-Y                 |
61	| fBodyGyro-mean()-Z                 |
62	| fBodyGyro-std()-X                  |
63	| fBodyGyro-std()-Y                  |
64	| fBodyGyro-std()-Z                  |
65	| fBodyGyro-meanFreq()-X             |
66	| fBodyGyro-meanFreq()-Y             |
67	| fBodyGyro-meanFreq()-Z             |
68	| fBodyAccMag-mean()                 |
69	| fBodyAccMag-std()                  |
70	| fBodyAccMag-meanFreq()             |
71	| fBodyBodyAccJerkMag-mean()         |
72	| fBodyBodyAccJerkMag-std()          |
73	| fBodyBodyAccJerkMag-meanFreq()     |
74	| fBodyBodyGyroMag-mean()            |
75	| fBodyBodyGyroMag-std()             |
76	| fBodyBodyGyroMag-meanFreq()        |
77	| fBodyBodyGyroJerkMag-mean()        |
78	| fBodyBodyGyroJerkMag-std()         |
79	| fBodyBodyGyroJerkMag-meanFreq()    |
80	| Activity                           |  Activity being performed by subject
81	| Subject                            |  Subject performing the activity
