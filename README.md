# security_lab_project
--------

The Aim is to create a decision tree model using R to detect network intrusion using the NSL-KDD Dataset

## Sample prediction_table 
### table_mat
    predict_unseen
         1     2     3     4     5     6     7     8     9    10    11    12    13    14    15    16    17
      1    220     0     0     0     0    20     0     0     0   349     8   595     0     0     0    19     0
      2      0     0     0     0     0     1     0     0     0     0     0     6     0     0     0     0     0
      3      0     0     0     0     0     0     0     0     0     0     0     2     0     0     0     0     0
      4      0     0     0     0     0     0     0     0     0     0     0    10     0     0     0     0     0
      6      0     0     0     0     0   523     0     0     0     0     3   131     0     0     0    19     0
      7      0     0     0     0     0     0     0     0     0     2     0     0     0     0     0     0     0
      8      0     0     0     0     0     0     0     0     0     0     0     3     0     0     0     0     0
      9      0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0
      10     0     0     0     0     0     0     0     0     0  7833     1    34     0     0     0     1     0
      11     0     0     0     0     0     0     0     0     0    43   180    76     0     0     0     0     0
      12     8     0     0     0     0    12     0     0     0     2    20 12708     0     0     0    16     0
      13     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0
      15     0     0     0     0     0     8     0     0     0     0     0    13     0     0     0     0     0
      16     1     0     0     0     0     0     0     0     0    35     0   153     0     0     0   313     0
      18     0     0     0     0     0     0     0     0     0    10     0   165     0     0     0     1     0
      19     0     0     0     0     0     0     0     0     0     0     0    25     0     0     0     0     0
      20     0     0     0     0     0     0     0     0     0     0     0     1     0     0     0     0     0
      21     0     0     0     0     0     0     0     0     0     0     0    11     0     0     0     0     0
      22    18     0     0     0     0     0     0     0     0     0     2   172     0     0     0     0     0
      23     0     0     0     0     0     0     0     0     0     0     0     7     0     0     0     0     0

### continuation
    predict_unseen
            18    19    20    21    22    23
      1     25    25     0     7     0     0
      2      0     0     0     0     0     0
      3      0     0     0     0     0     0
      4      0     0     0     0     0     0
      6      0     0     0     0     0     0
      7      1     0     0     0     0     0
      8      0     0     0     0     0     0
      9      0     0     0     0     0     0
      10    26     0     0     0     0     0
      11     0     0     0     0     0     0
      12    98     0     0     0     0     0
      13     0     0     0     0     0     0
      15     0     5     0     0     0     0
      16    74     0     0     0     0     0
      18   531     0     0     0     0     0
      19     0   462     0     0     0     0
      20     0     0     0     0     0     0
      21    20     0     0   139     0     0
      22     0     0     0     0     0     0
      23     0     0     0     0     0     0
  
  ### Sum of the Diagonal Elements = 22909
  ### Sum of Entire Prediction table = 25195
  ### Finding Accuracy which is (TP+TN)/Entire Dataset
  
  #### For finding the sum of the diagonal matrix, there needs to be a special logic applied.
  #### R ignores certain rows
  #### hence, from the above table we can find that row 5 is ignored and directly row 6 is shown
  #### (6,6) is 523
  #### But when we iterate with two nested for loops, what happens is instead of 6, system reads it as 5, and hence we dont get the correct value 523 if you apply the logic of (row==column)
  #### Hence, a custom loop is necessary where you ignore the system-ignored rows
  #### eg:
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

We can see that, for wherever necessary, i have added 1 or more to the variable temp to get the actual logic of row==column

## Accuracy = sum(diagonal)/totalsum = 0.909 ~ 90.9 % for this trial
