#clear workspace
rm(list=ls())

#Set working directory
setwd('C:/Users/james_000/Documents/R/UCI HAR Dataset/')

# 1. Merge the training and the test sets to create one data set

#Assign variables to the datasets
features <- read.table("features.txt")
actType <- read.table("activity_labels.txt")

##test datasets variables
subjecttest<-read.table("./test/subject_test.txt")
xtest<-read.table("./test/X_test.txt")
ytest<-read.table("./test/y_test.txt")

##training datasets variables
subjecttrain<-read.table("./train/subject_train.txt")
xtrain<-read.table("./train/X_train.txt")
ytrain<-read.table("./train/y_train.txt")

#Assigning column names to the tables
colnames(actType)<-c("activityId","activitytype")

##test data
colnames(subjecttest)<-"subjectid"
colnames(xtest)<-features[,2]
colnames(ytest)<-"activityId"

##train data
colnames(subjecttrain)<-"subjectid"
colnames(xtrain)<-features[,2]
colnames(ytrain)<-"activityId"

#create merged test/train dataframe
testdata<-cbind(subjecttest,ytest,xtest)
traindata<-cbind(subjecttrain,ytrain,xtrain)

#finalized merged dataframe
finaldata<-rbind(testdata,traindata)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#create a list with all the variables with "mean()" and "std()"
meanlist<-grep("mean()",names(finaldata))
freq<-grep("meanFreq()",names(finaldata))
stdlist<-grep("std()",names(finaldata))

meanstdlist<-sort(c(meanlist[!meanlist %in% freq],stdlist))

#Update finaldata to only show mean/std columns
finaldata<-finaldata[c(2,1,meanstdlist)]

# 3. Use descriptive activity names to name the activities in the data set
#Since my merge function for some reason replaces all the activityID's with 1's, going for a for loop function
activityType<-vector() #create an empty vector
for(i in 1:nrow(finaldata)){
        j<-finaldata$activityId[i]
        activityType<-c(activityType,as.character(actType[[2]][which(j==actType[[1]])]))
        
} #returns the activityType as a character and binds it to a large list
finaldata<-cbind(activityType,finaldata)

# 4. Appropriately labels the data set with descriptive variable names. 
colNames<-colnames(finaldata)
for(i in 1:length(colNames)){
        colNames[i]<-sub("-"," ",colNames[i])
        colNames[i]<-gsub("\\()","",colNames[i])
        colNames[i]<-gsub("std","StdDev",colNames[i])
        colNames[i]<-gsub("mean","Mean",colNames[i])
        colNames[i]<-gsub("^t","Time",colNames[i])
        colNames[i]<-gsub("^f","Freq",colNames[i])
}
colnames(finaldata)<-colNames

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
finalnotype<- finaldata[,names(finaldata) != 'activityType']
tidyData<-aggregate(finalnotype[,names(finalnotype) != c('activityId','subjectid')],by=list(activityId=finalnotype$activityId,subjectid = finalnotype$subjectid),mean)
tidyData<-merge(actType,tidyData,by='activityId',all.x=TRUE)

#export it
write.table(tidyData, './tidyData.txt',row.names=TRUE,sep='\t')