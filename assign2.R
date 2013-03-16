# Assignment 2
# 1. Remove everything from the workspace & install required libaries
rm(list=ls())
library(randomForest)
library(tree)
# 2. Set Working Directory
setwd("/home/steveo/coursera/data_analysis/data_analysis_2")
# 3.Download Data
fileUrl <- "https://spark-public.s3.amazonaws.com/dataanalysis/samsungData.rda"
fileLocal <- "./samsungData.rda"
download.file(fileUrl,fileLocal,method="curl")
# 4.Load Data to R
dateDownloaded <- date()
load(fileLocal)
# 5. Complete analysis on the data
# (i) Get unique number of subjects within data-set and view the unique values
length(unique(samsungData$subject))
unique(samsungData$subject)
# (ii) Get unique number of activities to predict in the data-set and view the unique values
length(unique(samsungData$activity))
unique(samsungData$activity)
# (iii) test for duplicate names within the data-set
names(samsungData)[duplicated(names(samsungData))]
# Duplicate names exist so we have to amend the data - pushing the same data to a data frame object removes the duplicate names
samsungDataAmend <- data.frame(samsungData)
# 6. Sub-set the data into training, validation and testing data-sets
trainData <- samsungDataAmend [samsungDataAmend$subject < 10,]
validationData <-samsungDataAmend [samsungDataAmend$subject %in% c(10:20),]
testData <- samsungDataAmend [samsungDataAmend$subject %in% c(27:30),]
# 7. Split the training set into 2 data sets in order to pick
# (i) features
# (ii) prediction function
trainData1 <- trainData [trainData$subject < 6,]
trainData2 <- trainData [trainData$subject > 5,]
# 8. Create a tree function to determine significant features
treetd1 <- tree(factor(activity) ~ .,data=trainData1)
summary(treetd1)
plot(treetd1)
pngTree + text(treetd1)
pngTree + title(main="Predictive Tree Model")
# 9. Cross-validate the results
# create a prediction based upon the tree model using the 2nd training data-set
pred1 <- predict(treetd1, newdata=trainData2, type="class")
# create a confusion matrix to test the results
mytable <-table(pred1, trainData2$activity)
mytable
# obtain the misclassifcation error rate
misclass <- (sum(mytable[row(mytable) != col(mytable)]) / sum(mytable)) *100
misclass
# 10. try to improve the result via pruning the tree
pruneTree <- prune.tree(treetd1,best=6)
# complete cross-validation
pred1 <- predict(pruneTree, newdata=trainData2, type="class")
mytable <-table(pred1, trainData2$activity)
misclass <- (sum(mytable[row(mytable) != col(mytable)]) / sum(mytable)) *100
misclass
summary(pruneTree)
# iterating multiple values suggests that pruning the tree does not help in regards to lowering the misclassication error rate
# 11. Build a random forest model to attempt to improve tree models prediction
fModel <- randomForest(factor(activity) ~ .,data=trainData1)
fModel
# complete cross-validation
pred1 <- predict(fModel, newdata=trainData2, type="class")
mytable <-table(pred1, trainData2$activity)
mytable
misclass <- (sum(mytable[row(mytable) != col(mytable)]) / sum(mytable)) *100
misclass
# 12. Predict the results on the Validation data-set
pred1 <- predict(fModel, newdata=validationData, type="class")
mytable <-table(pred1, validationData$activity)
misclass <- (sum(mytable[row(mytable) != col(mytable)]) / sum(mytable)) *100
misclass
pred1 <- predict(treetd1, newdata=validationData, type="class")
mytable <-table(pred1, validationData$activity)
misclass <- (sum(mytable[row(mytable) != col(mytable)]) / sum(mytable)) *100
misclass
# 12. Predict the results on the test data-set
pred1 <- predict(fModel, newdata=testData, type="class")
mytable <-table(pred1, testData$activity)
mytable
misclass <- (sum(mytable[row(mytable) != col(mytable)]) / sum(mytable)) *100
misclass

