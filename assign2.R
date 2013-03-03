# Assignment 2
# 1. Remove everything from the workspace
rm(list=ls())
# 2. Set Working Directory
setwd("/home/steveo/coursera/data_analysis/data_analysis_2")
# 3.Download Data
fileUrl <- "https://spark-public.s3.amazonaws.com/dataanalysis/samsungData.rda"
fileLocal <- "./samsungData.rda"
download.file(fileUrl,fileLocal,method="curl")
# 4.Load Data to R
dateDownloaded <- date()
load(fileLocal)
# 5. Complete validation tests on the data
# (i) Get unique number of subjects within data-set and view the unique values
length(unique(samsungData$subject))
unique(samsungData$subject)
# (ii) Get unique number of activities to predict in the data-set and view the unique values
length(unique(samsungData$activity))
unique(samsungData$activity)
# (iii) test for duplicate names within the data-set
names(samsungData)[duplicated(names(samsungData))]
# Duplicate names exist so we have to amend the data - pushing the same data to a data frame object removes the duplicate names
samsungData <- data.frame(samsungData)
# 6. Sub-set the data into training, validation and testing data-sets
trainData <- samsungData [samsungData$subject < 10,]
validationData <-samsungData [samsungData$subject %in% c(10:20),]
testData <- samsungData [samsungData$subject %in% c(27:30),]
# 7. Split the training set into 2 data sets in order to pick
# (i) features
# (ii) prediction function
trainData1 <- trainData [trainData$subject < 6,]
trainData2 <- trainData [trainData$subject > 5,]
# 8. Create a tree function to determine significant features
library(tree)
treetd1 <- tree(factor(activity) ~ .,data=trainData1)
summary(treetd1)
plot(treetd1)
text(treetd1)

