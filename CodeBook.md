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
X <- X[,grep("mean\\(\\)|std\\(\\)", features$name)]
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
names(X) <- grep("mean\\(\\)|std\\(\\)", features$name,value=TRUE)
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

Two datasets are created. Both data sets have the exact same structure with 68 variables. The first contains all data observation from the input data sets (10299). The second contains a single row per Activity and Subject. The 66 observation variables are averaged per Subject and Activity.

Column | Variable Name                     | Definition
-------|-----------------------------------|-------------------------------------------------------
1   | tBodyAcc-mean()-X                  | Mean X-axis Body Acceleration (Time)
2	| tBodyAcc-mean()-Y                  | Mean Y-axis Body Acceleration (Time)
3	| tBodyAcc-mean()-Z                  | Mean Z-axis Body Acceleration (Time)
4	| tBodyAcc-std()-X                   | Standard Deviation X-axis Body Acceleration (Time)
5	| tBodyAcc-std()-Y                   | Standard Deviation Y-axis Body Acceleration (Time)
6	| tBodyAcc-std()-Z                   | Standard Deviation Z-axis Body Acceleration (Time)
7	| tGravityAcc-mean()-X               | Mean X-axis Gravity Acceleration (Time)
8	| tGravityAcc-mean()-Y               | Mean Y-axis Gravity Acceleration (Time)
9	| tGravityAcc-mean()-Z               | Mean Z-axis Gravity Acceleration (Time)
10	| tGravityAcc-std()-X                | Standard Deviation X-axis Gravity Acceleration (Time)
11	| tGravityAcc-std()-Y                | Standard Deviation Y-axis Gravity Acceleration (Time)
12	| tGravityAcc-std()-Z                | Standard Deviation Z-axis Gravity Acceleration (Time)
13	| tBodyAccJerk-mean()-X              | Mean X-axis Body Acceleration Jerk (Time)
14	| tBodyAccJerk-mean()-Y              | Mean Y-axis Body Acceleration Jerk (Time)
15	| tBodyAccJerk-mean()-Z              | Mean Z-axis Body Acceleration Jerk (Time)
16	| tBodyAccJerk-std()-X               | Standard Deviation X-axis Body Acceleration Jerk (Time)
17	| tBodyAccJerk-std()-Y               | Standard Deviation Y-axis Body Acceleration Jerk (Time)
18	| tBodyAccJerk-std()-Z               | Standard Deviation Z-axis Body Acceleration Jerk (Time)
19	| tBodyGyro-mean()-X                 | Mean X-axis Body Gyroscope
20	| tBodyGyro-mean()-Y                 | Mean Y-axis Body Gyroscope
21	| tBodyGyro-mean()-Z                 | Mean Z-axis Body Gyroscope
22	| tBodyGyro-std()-X                  | Standard Deviation X-axis Body Gyroscope
23	| tBodyGyro-std()-Y                  | Standard Deviation Y-axis Body Gyroscope
24	| tBodyGyro-std()-Z                  | Standard Deviation Z-axis Body Gyroscope
25	| tBodyGyroJerk-mean()-X             | Mean X-axis Body Gyroscope Jerk
26	| tBodyGyroJerk-mean()-Y             | Mean Y-axis Body Gyroscope Jerk
27	| tBodyGyroJerk-mean()-Z             | Mean Z-axis Body Gyroscope Jerk
28	| tBodyGyroJerk-std()-X              | Standard Deviation X-axis Body Gyroscope Jerk
29	| tBodyGyroJerk-std()-Y              | Standard Deviation Y-axis Body Gyroscope Jerk
30	| tBodyGyroJerk-std()-Z              | Standard Deviation Z-axis Body Gyroscope Jerk
31	| tBodyAccMag-mean()                 | Mean Body Acceleration Mag
32	| tBodyAccMag-std()                  | Standard Deviation Body Accelaration Mag
33	| tGravityAccMag-mean()              | Mean Gravity Acceleration Mag
34	| tGravityAccMag-std()               | Standard Deviation Gravity Accelaration Mag
35	| tBodyAccJerkMag-mean()             | Mean Body Acceleration Jerk Mag
36	| tBodyAccJerkMag-std()              | Standard Deviation Body Accelaration Jerk Mag
37	| tBodyGyroMag-mean()                | Mean Gyroscope Mag
38	| tBodyGyroMag-std()                 | Standard Deviation Gyroscope Mag
39	| tBodyGyroJerkMag-mean()            | Mean Gyroscope Jerk Mag
40	| tBodyGyroJerkMag-std()             | Standard Deviation Gyroscope Jerk Mag
41	| fBodyAcc-mean()-X                  | Mean X-axis Body Acceleration (Fourier)
42	| fBodyAcc-mean()-Y                  | Mean Y-axis Body Acceleration (Fourier)
43	| fBodyAcc-mean()-Z                  | Mean Z-axis Body Acceleration (Fourier)
44	| fBodyAcc-std()-X                   | Standard Deviation X-axis Body Acceleration (Fourier)
45	| fBodyAcc-std()-Y                   | Standard Deviation Y-axis Body Acceleration (Fourier)
46	| fBodyAcc-std()-Z                   | Standard Deviation Z-axis Body Acceleration (Fourier)
47	| fBodyAccJerk-mean()-X              | Mean X-axis Body Acceleration Jerk (Fourier)
48	| fBodyAccJerk-mean()-Y              | Mean Y-axis Body Acceleration Jerk (Fourier)
49	| fBodyAccJerk-mean()-Z              | Mean Z-axis Body Acceleration Jerk (Fourier)
50	| fBodyAccJerk-std()-X               | Standard Deviation X-axis Body Acceleration Jerk (Fourier)
51	| fBodyAccJerk-std()-Y               | Standard Deviation Y-axis Body Acceleration Jerk (Fourier)
52	| fBodyAccJerk-std()-Z               | Standard Deviation Z-axis Body Acceleration Jerk (Fourier)
53	| fBodyGyro-mean()-X                 | Mean X-axis Body Gyroscope (Fourier)
54	| fBodyGyro-mean()-Y                 | Mean Y-axis Body Gyroscope (Fourier)
55	| fBodyGyro-mean()-Z                 | Mean Z-axis Body Gyroscope (Fourier)
56	| fBodyGyro-std()-X                  | Standard Deviation X-axis Body Gyroscope (Fourier)
57	| fBodyGyro-std()-Y                  | Standard Deviation Y-axis Body Gyroscope (Fourier)
58	| fBodyGyro-std()-Z                  | Standard Deviation Z-axis Body Gyroscope (Fourier)
59	| fBodyAccMag-mean()                 | Mean Body Acceleration Mag (Fourier)
60	| fBodyAccMag-std()                  | Standard Deviation Body Accelaration Mag (Fourier)
61	| fBodyBodyAccJerkMag-mean()         | Mean Body Acceleration Jerk Mag (Fourier)
62	| fBodyBodyAccJerkMag-std()          | Standard Deviation Body Accelaration Jerk Mag (Fourier)
63	| fBodyBodyGyroMag-mean()            | Mean Gyroscope Mag (Fourier)
64	| fBodyBodyGyroMag-std()             | Standard Deviation Gyroscope Mag (Fourier)
65	| fBodyBodyGyroJerkMag-mean()        | Mean Gyroscope Jerk Mag (Fourier)
66	| fBodyBodyGyroJerkMag-std()         | Standard Deviation Gyroscope Jerk Mag (Fourier)         
