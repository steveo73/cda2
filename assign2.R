# Assignment 2
# 1. Remove everything from the workspace
rm(list=ls())
# 2. Set Working Directory
setwd("/home/steveo/coursera/data_analysis/data_analysis_2")
# 3.Download Data
fileUrl <- "https://spark-public.s3.amazonaws.com/dataanalysis/samsungData.rda"
download.file(file.url,file.local,mode="wb")

