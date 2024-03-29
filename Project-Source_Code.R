              # Importing 'dplyr' and 'naivebayes' packages using 'library' function

library(dplyr)
library(naivebayes)

# Importing CSV Dataset
patient_data<-read.csv("C:\\R\\R-4.1.2\\DataSets\\Heart.csv",header=TRUE)

# printing Dataset
print(patient_data)

                                    # Data Pre-processing
# Gives no of rows and columns
dim(patient_data)

# Gives structure of attributes with Datatypes
str(patient_data)

# No of columns
length(patient_data)

# print respective column
print(patient_data$ChestPain)

# Prints Detailed Summary of data
summary(patient_data)

# Renaming Column names
patient_data=rename(patient_data,Electro_CardioGram=RestECG)
patient_data=rename(patient_data,Fasting_Blood_Sugar=Fbs)
patient_data=rename(patient_data,Heart_Disease=AHD)

# Converting character datatype to categorical
patient_data$ChestPain=as.factor(patient_data$ChestPain)
patient_data$Heart_Disease=as.factor(patient_data$Heart_Disease)

summary(patient_data)

                                # Visualization of data
# Barplot
barplot(table(patient_data$Heart_Disease),main="Risk of HEART DISEASE",
        xlab="Occurance of Heart Disease",ylab="No of patients",col=c("Green","red"))

# Histogtram
hist(patient_data$Chol,main="Report of Cholestrol-Tests",xlab="Levels of Cholestrol (mg/dl)",
     ylab="No of Patients",col=c("green","yellow","yellow","red","red","red"))

legend("topright",c("Normal","Average","High"),fill=c("green","yellow","red"))

# Sampling of datasets
ind<-sample(2,nrow(patient_data),replace=TRUE,prob=c(0.8,0.2))
trainData<-patient_data[ind==1,]
testData<-patient_data[ind==2,]
print(trainData)
print(testData)

                           # Training model using naive_bayes algorithm

naive_model<-naive_bayes(Heart_Disease~Age+Gender+ChestPain+RestBP+
            Chol+Fasting_Blood_Sugar+Electro_CardioGram+Heart_Disease,data=trainData)
print(naive_model)
plot(naive_model)

# Predicting dataset
testData1=testData[,-8]
testData1
testPred<-predict(naive_model,newdata=testData1)

# Predicted results
print(testPred)

# Original results
print(testData$Heart_Disease)

# Prediction for Manual input
patient<-data.frame(Age=53,Gender=1,ChestPain="nontypical",RestBp=165,Chol=335,
                    Fasting_Blood_Sugar=1,Electro_CardioGram=0)

patient

result<-predict(naive_model,patient)

# Result
print(result)
