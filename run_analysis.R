library(data.table)

# Helper functions

getData <- function(name, colNames) {
  d <- read.table(gsub("name", name, "UCI HAR Dataset/name/X_name.txt"), col.names=colNames)
  a <- read.table(gsub("name", name, "UCI HAR Dataset/name/Y_name.txt"))
  s <- read.table(gsub("name", name, "UCI HAR Dataset/name/subject_name.txt"))
  d$Activity <- a[,1]
  d$Subject <- s[,1]
  d <- d[, append(c("Activity", "Subject"), head(colnames(d), 561))]
}

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Check for zip data 

if (!file.exists("uci_har_dataset.zip")) { 
  download.file(url, destfile = "uci_har_dataset.zip", method = "curl")
}
unzip("uci_har_dataset.zip")

# Merge training and test to create one data set.

colNames <- read.table("UCI HAR Dataset/features.txt")[,2]
train <- getData("train", colNames)
test <- getData("test", colNames)
obsData <- merge(train, test, all = TRUE, sort = FALSE)

# Create clean data

keepCols <- grep("Activity|Subject|\\.mean\\.|\\.std\\.", colnames(obsData))
obsData <- obsData[,keepCols]

# Apply activity names

activities <- read.table("UCI HAR Dataset/activity_labels.txt")
obsData <- merge(obsData, activities, by.x = "Activity", by.y = "V1")
obsData$Activity <- NULL
colnames(obsData)[68] <- "Activity"
obsData <- obsData[c(1,68,2:67)]

# Export averages as CSV

dt <- data.table(obsData)
avData <- dt[, lapply(.SD,mean), by = "Activity,Subject"]
write.table(avData, file = "averages.txt", sep = ",", row.names = FALSE)
