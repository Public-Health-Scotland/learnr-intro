##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##
## Script Details ----
# Name of file - examples.R
# Original author - Russell McCreath
# Orginal date - August 2020
#
# Version of R - 3.6.1
#
# Description - An accompanying R script to work alongside the
# Introduction to R training. This provides example code from the slides.
# All blocks for each example are self contained, this means that packages
# are loaded repeatedly.
##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##


### Foundations ----

## Input (8) ----
# Example 1
hello_world <- "Hello World"
print(hello_world)


## Basic Data Types (9) ----
typeof("Hello World")
is.numeric(123.5)
print(typeof(2 + 2i))


## Type Conversion (10) ----
as.character(123.5)
as.numeric("123.5")
as.logical("False")


## Vectors (13) ----
vector("logical", 4)
c("a", "c", "f", "b")[1]
c(2, 5, 1, "abc")[2]


## Lists (14) ----
list("abc", 4, FALSE)[1:2]
list(list(2, 3), "abc")[[2]]


## Naming List Elements (15) ----
x <- list("Ch" = "a", "Nm" = 2)
names(x) <- c("Char", "Num")
x$Char

# Remove the created object, x
rm(x)


## Matrices (16) ----
x <- matrix(1:6, 2, 3)
x
x[2, 3]

# Remove the created object, x
rm(x)


## Factors (17) ----
x <- factor(c(1, 2, 1, 2, 2, 1), levels = c(2, 1))
x

# Remove the created object, x
rm(x)


## Data Frames (18) ----
data.frame(name = c("Harry", "Sarah"), score = c(62, 91))


### Data Flow ----

## Working Directory (25) ----
getwd()


## Read CSV (26) ----
library(readr)
borders_csv <- read_csv("data/Borders.csv")
View(borders_csv)


## Read SPSS (27) ----
library(haven)
borders_spss <- read_sav("data/Borders.sav")
View(borders_spss)


## Read Web (28) ----
library(readr)
hospital_codes <- read_csv("https://www.opendata.nhs.scot/dataset/cbd1802e-0e04-4282-88eb-d7bdcfb120f0/resource/c698f450-eeed-41a0-88f7-c1e40a568acc/download/current_nhs_hospitals_in_scotland_010720.csv")
View(hospital_codes)


## Database SMRA (29) ----
library(odbc)
# Establish connection
smra_connection <- dbConnect(drv = odbc(), 
                             dsn = "SMRA",
                             uid = .rs.askForPassword("SMRA Username:"), 
                             pwd = .rs.askForPassword("SMRA Password:"))
# Example extract
smr01 <- dbGetQuery(smra_connection, paste("select DISCHARGE_DATE, LOCATION, MAIN_OPERATION",
                                           "from SMR01_PI",
                                           "where ROWNUM <= 100"))


## RDS (30) ----
# Read in file
borders_RDS <- 	readRDS("data/borders.rds")
# Export/write file
saveRDS(borders_RDS, "data/borders.rds")


## Write CSV (31) ----
library(readr)
write_csv(borders_csv, "data/borders.csv")


### Explore ----

## Mean/Median & Summary (33) ----
borders <- readRDS("data/borders.RDS")
mean(borders[["LengthOfStay"]])
summary(borders$LengthOfStay)


## Frequencies & Crosstabs (34) ----
borders <- readRDS("data/borders.RDS")
addmargins(table(borders$HospitalCode, borders$Sex))


### Wrangle ----
# All examples in the wrangle section require dplyr to be loaded
library(dplyr)
# All examples in the wrangle section require the borders dataset
borders <- readRDS("data/borders.RDS")

## Pipe Operator (39) ----
# No pipe
arrange(filter(borders, HospitalCode == "B102H"), Dateofbirth)
# Pipe
borders %>%
  filter(HospitalCode == "B102H") %>%
  arrange(Dateofbirth)


## Filter (40) ----
# all cases with E12 specialty
borders %>% 
  filter(Specialty == "E12")

# B120H cases more than 10 days
borders %>%
  filter(HospitalCode == "B120H" &
           LengthOfStay > 10)


## Mutate (41) ----
# length of stay divided by 2
borders %>%
  mutate(los_div2 = LengthOfStay / 2)


## Arrange (42) ----
# sort by Hospital Code
borders %>%
  arrange(HospitalCode)


## Select (43) ----
# remove Postcode
borders %>%
  select(-Postcode)


## Group By (45) ----
# sort by Hospital Code
borders %>%
  group_by(HospitalCode)


## Summarise (46) ----
# avg length of stay by hospital
borders %>%
  group_by(HospitalCode) %>%
  summarise(mean_los = mean(LengthOfStay))


## Count (47) ----
# counts of specialty
borders %>%
  count(Specialty, sort = TRUE)


## Rename (49) ----
# rename Date of Birth column
borders %>%
  rename(date_of_birth = Dateofbirth)


## Recode (50) ----
# change hospital code
borders %>%
  mutate(HospitalCode = recode("B120V" = "B120H"))


## Joining Tables (52) ----
# merge baby data
baby5 <- read_csv("data/Baby5.csv")
baby6 <- read_csv("data/Baby6.csv")
baby_joined %>%
  left_join(baby5, baby6, by = c("FAMILYID", "DOB"))


### Visualise ----
# All examples in the wrangle section require ggplot2 to be loaded
library(ggplot2)

## Line Graph (56) ----
# Define data
line_data <- data.frame(x = c(1, 3, 2, 4), 
                   y = c(4, 8, 7, 11))

# Plot the data
line_plot <- ggplot(line_data, aes(x, y)) + 
  geom_line() +
  geom_point()

# View Plot
line_plot


## Bar Plot (57) ----
# Define data
bar_data <- read_csv("data/BORDERS (inc Age).csv")
                  
# Plot the data
bar_plot <- ggplot(bar_data) + 
  geom_bar(aes(x = admissionday))

# View plot
bar_plot


## Scatter Plot (58) ----
# Define data
scatter_data <- read_csv("data/BORDERS (inc Age).csv")

# Plot the data
scatter_plot <- ggplot(scatter_data, aes(x =	ageonadmission, 
                                          y = lengthofstay1)) + 
  geom_point()

# View plot
scatter_plot


## Customisation (59) ----
# Define data
custom_bar_data <- read_csv("data/BORDERS (inc Age).csv")

# Plot the data with customisations
custom_bar_plot <- ggplot(custom_bar_data) + 
  geom_bar(aes(x = admissionday), 
           fill = "magenta4", 
           width = 0.5) +
  # add titles
  xlab("Admission Day") +
  ylab("Num. Admissions") +
  ggtitle("Dist. Admissions")

# View plot
custom_bar_plot


### END OF SCRIPT ###