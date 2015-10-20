==================================================================
Getting and Cleaning Data Course Project

==================================================================

There is only one script I wrote for this project and it is pretty straight forward. 

First I wanted to add in the ID numbers and activity variable into each data set, test and train, individually. To do this I used cbind(), then to merge the two datasets together I used rbind(). 

Then I added the descriptive activity name to my 'Activity' columnin place of the reference number to which activity it was.

Next I got rid of all the column names that didn't include mean or std which narrowed my dataset down to just 81 different column variables. 

Lastly, I combined and averaged all the data that had the same ID and Activity values to narrow down the number of rows to 180. This is a vast improvement to the over 10,000 that I started with. 

Wrote my dataset using write.table(). It is named tidydata.txt. To read data set use read.table command in R command prompt. 
