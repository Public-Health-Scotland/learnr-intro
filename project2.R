## Project ----
## This is a small project to test your knowledge of many of the topics 
## covered in the training. Write your code under each instruction. Remember
## to use the help section, Google/StackOverflow, or ask for help if you get
## stuck. See you at the drop-in session!

# 1. Load the `dplyr` and `readr` packages ----




# 2. Read in both `PM_Borders1.csv` and `PM_Borders2.csv` separately 
#     using `read_csv()` ----




# 3. `PM_Borders1` and `PM_Borders2` have the same columns and there are ----
#     some records that exist within both files. Choose an appropriate join 
#     function to merge these data frames together and call this `joined_data`




# 4. Using `joined_data`, create a cross-tab of `ManagementofPatient` and ----
#     `Specialty`




# 5. Take all records in `joined_data` which have `ManagementofPatient` ----
#     values “Day Case in Inpatient Ward” or “Day Case in Day Bed Unit” and 
#     store them in a dataframe called `day_cases`. Calculate a new column `LOS2` 
#     for `LengthOfStay` multiplied by two.




# 6. Group `joined_data` by `Specialty` and then calculate the mean ----
#     `LengthOfStay` value for each `Specialty`. Arrange the data by mean 
#     `LengthOfStay` from largest to smallest.




# 7. Select the `LinkNo`, `HospitalCode` and `Main_op` columns in  ----
#     `joined_data` and rename the `Main_op` column to `Main_Operation`. Store 
#     this data in a dataframe called `filtered_data` and only keep records 
#     that do not have a missing value for `Main_Operation`. How many records 
#     have been removed?




# 8. Plot a histogram of `LengthOfStay` for records in `joined_data` with a
#     `DateofAdmission` in April 2015. Give your histogram a suitable title,
#     colour and axis labels.



