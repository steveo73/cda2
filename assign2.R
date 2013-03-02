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
# 5 Get unique number of subjects within data-set and view the unique values
length(unique(samsungData$subject))
unique(samsungData$subject)
# 6 Get unique number of activities to predict in the data-set and view the unique values
length(unique(samsungData$activity))
unique(samsungData$activity)
# 7 complete some data validation checks


# Sub-set the data into training, validation and testing data-sets
trainData <- samsungData [samsungData$subject < 10,]
validationData <-samsungData [samsungData$subject %in% c(10:20),]
testData <- samsungData [samsungData$subject %in% c(27:30),]


