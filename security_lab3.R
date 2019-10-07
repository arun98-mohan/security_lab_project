#Reading the file
path<-'/Users/Arun/Desktop/train.csv'
kdd<-read.csv(path)

#Checking the first 6 and last 6 rows
head(kdd)
tail(kdd)

kdd_test<-kdd

sample_size=floor(0.80*nrow(kdd_test))
sample_size
train_ind = sample(seq_len(nrow(kdd_test)),size = sample_size)

#getting unique values in columns with strings, to RECODE the columns
cat<-unique(kdd[2])
kdd_test$tcp<-ifelse(kdd_test$tcp=="icmp",3,ifelse(kdd_test$tcp=="tcp",2,ifelse(kdd_test$tcp=="udp",1,0)))

cat<-unique(kdd[3])
flag=0
for(i in cat)
{
  flag=flag+1
  print(i)
  kdd_test$ftp_data<-ifelse(kdd_test$ftp_data==i,flag,kdd_test$ftp_data)
}

cat<-unique(kdd[4])
flag=0
for(i in cat)
{
  flag=flag+1
  print(i)
  kdd_test$SF<-ifelse(kdd_test$SF==i,flag,kdd_test$SF)
}

cat<-unique(kdd[42])
flag=0
for(i in cat)
{
  flag=flag+1
  print(i)
  kdd_test$normal<-ifelse(kdd_test$normal==i,flag,kdd_test$normal)
}

head(kdd_test)

library(rpart)
library(caret)
library(rpart.plot)

train<-kdd_test[train_ind,]
test<-kdd_test[-train_ind,]

#Using RPART Library for classification
fit<-rpart(normal~.,data=train,method="class")
rpart.plot(fit,extra="auto")

#Predict
predict_unseen <-predict(fit,test, type = "class")
table_mat<-table(test$normal,predict_unseen)
table_mat

sum=0

nrow(table_mat)
ncol(table_mat)

#Logic of this nested for
#check the table_mat 
#in that certain rows would be missing
#eg: row 3 would be missing and would be row 4
#now, check whatever rows are missing and accordingly add the values to variable temp
#eg: if 3 is missing, computer would see (i mean variable 'r') row 4 as row 3, so we add 1 to temp to make it
#row 4
#this needs to be done manually each time,since each time, a certain row may go missing if all the values in the
#row is 0
for (r in 1:nrow(table_mat))   
  for (c in 1:ncol(table_mat)) 
  {
    temp<-r
    if(temp>4 && temp<=12)
    {
      temp<-temp+1
    }
    else if(temp>12 && temp<=14)
    {
      temp<-temp+2
    }
    else if(temp>14&&temp<=20)
    {
      temp<-temp+3
    }
    if(temp==c)
    {
    print(table_mat[r,c])
    sum=sum+table_mat[r,c]
    }
  }

accuracy_Test <- sum / sum(table_mat)
accuracy_Test
print(paste("Accuracy is ",accuracy_Test*100,"%"))