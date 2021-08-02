##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##
## Script Details ----
# Name of file - examples.R
# Original author - Russell McCreath
#
# Version of R - 3.6.1
#
# Description - An accompanying R script to work alongside the
# Introduction to R training. This provides example code from the slides.
# All blocks for each example are self contained, this means that packages
# are loaded repeatedly.
##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##--##

#### Day 1 ----

### Foundations ----


## Basic Data Types (7) ----
typeof("Hello World")
is.numeric(123.5)
print(typeof(TRUE))


## Type Conversion (8) ----
as.character(123.5)
as.numeric("123.5")
as.logical("False")


## Anatomy of a Program (12) ----
# Example 1
hello_world <- "Hello World"
print(hello_world)

# Remove the created object, hello_world
rm(hello_world)


## Style Guide (13) ----
# Bad
pts = c ( 'Al','Bert' )
# Good
patients <- c("Al", "Bert")

# Remove the created objects, pts & patients
rm(pts, patients)


## Vectors (16) ----
c("a", "c", "f", "b")[1]
c(2, 5, 1, "abc")[3:4]
vector("logical", 4)


## Lists (18) ----
list("abc", 4, FALSE)[1:2]
list(list(2, 3), "abc")[[2]]


## Naming List Elements (19) ----
x <- list("Ch" = "a", "Nm" = 2)
names(x) <- c("Char", "Num")
x$Char

# Remove the created object, x
rm(x)


## Factors (20) ----
x <- factor(c("M", "F", "M"), levels = c("F", "M"))
x

# Remove the created object, x
rm(x)


## Matrices (22) ----
x <- matrix(1:6, 2, 3)
x
x[2, 3]

# Remove the created object, x
rm(x)


## Data Frames (23) ----
data.frame(name = c("Harry", "Sarah"), score = c(62, 91))


## Tibbles (25) ----
tibble(name = c("Harry", "Sarah"), score = c(62, 91))


## Anatomy of a Function (27) ----
mult_2 <- function(x) {
  x <- x * 2
  return(x)
}
mult_2(4)

# Remove the created object, mult_2
rm(mult_2)


## Packages (28) ----
install.packages("tidyverse")
library(tidyverse)


## Control Flow - if statements (29) ----
library(dplyr)
x <- 5
if_else(x > 10, TRUE, FALSE)

# Remove the created object, x
rm(x)


## Control Flow - case statements (31) ----
library(dplyr)
x <- c(1, 2, 3, 4, 5)
case_when(
  x < 3 ~ "LT3",
  x %% 2 == 0 ~ "Even",
  TRUE ~ "Other"
)
# Doesn't need to be 'Other' necessarily but do think we should show what happens if none of the conditions apply

# Remove the created object, x
rm(x)


## Iteration - for loop (33) ----
library(readr)
files <- list.files(path = here::here("data"), pattern = ".csv")
all_files <- list()
for (i in seq_along(files)) {
  all_files[[i]] <- read_csv(paste0("data/", files[i]))
}

# Remove the created object, files & all_files
rm(files, all_files)


## Iteration - loop with purrr (34) ----
library(readr)
library(purrr)
files <- list.files(path = here::here("data"), pattern = ".csv")
all_files <- map(paste0("data/", files), read_csv)

# Remove the created object, files & all_files
rm(files, all_files)


### Data Flow ----

## Working Directory (39) ----
getwd()
here()


## Read CSV (40) ----
library(readr)
borders_csv <- read_csv("data/Borders.csv")
View(borders_csv)


## Read RDS (41) ----
library(readr)
borders_rds <- read_rds("data/borders.rds")
write_rds(borders_rds, "data/borders.rds")


## Read SPSS (42) ----
library(haven)
borders_spss <- read_sav("data/Borders.sav")
View(borders_spss)


## Read Web (43) ----
library(readr)
hospital_codes <- read_csv("https://www.opendata.nhs.scot/dataset/cbd1802e-0e04-4282-88eb-d7bdcfb120f0/resource/c698f450-eeed-41a0-88f7-c1e40a568acc/download/current_nhs_hospitals_in_scotland_010720.csv")
View(hospital_codes)


## Open Data - CKAN API (44) ----
library(ckanr)
ckan <- src_ckan("https://www.opendata.nhs.scot")
res_id <- "<ID>"
resource <- dplyr::tbl(src = ckan$con, from = res_id) %>%
  as_tibble()


## Database SMRA (45) ----
library(odbc)
# Establish connection
smra_connection <- dbConnect(
  drv = odbc(),
  dsn = "SMRA",
  uid = .rs.askForPassword("SMRA Username:"),
  pwd = .rs.askForPassword("SMRA Password:")
)
# Example extract
smr01 <- dbGetQuery(smra_connection, paste(
  "select DISCHARGE_DATE, LOCATION, MAIN_OPERATION",
  "from SMR01_PI",
  "where ROWNUM <= 100"
))


## Write CSV (46) ----
library(readr)
write_csv(borders_csv, "data/borders.csv")


### Explore ----

## Mean/Median & Summary (48) ----
borders <- readRDS("data/borders.RDS")
mean(borders[["LengthOfStay"]])
summary(borders$LengthOfStay)


## Frequencies & Crosstabs (49) ----
library(readr)
borders <- read_rds("data/borders.rds")

# Frequency Table
table(borders$HospitalCode)

# Crosstabs
table(borders$HospitalCode, borders$Sex)
# Include NAs
table(borders$HospitalCode, borders$Sex, exclude = NULL)

# Add Totals
addmargins(table(borders$HospitalCode, borders$Sex))


### Wrangle ----
library(readr)
# All examples in the wrangle section require dplyr to be loaded
library(dplyr)
# All examples in the wrangle section require the borders dataset
borders <- read_rds("data/borders.rds")


#### Day 2 ----

## Pipe Operator (6) ----
# No pipe
arrange(filter(borders, HospitalCode == "B102H"), Dateofbirth)
# Pipe
borders %>%
  filter(HospitalCode == "B102H") %>%
  arrange(Dateofbirth)


## Filter (7) ----
# all cases with E12 specialty
borders %>%
  filter(Specialty == "E12")

# B120H cases more than 10 days
borders %>%
  filter(HospitalCode == "B120H" &
    LengthOfStay > 10)


## Mutate (8) ----
# length of stay divided by 2
borders %>%
  mutate(los_div2 = LengthOfStay / 2)


## Arrange (9) ----
# sort by Hospital Code
borders %>%
  arrange(HospitalCode)


## Select (10) ----
# remove Postcode
borders %>%
  select(-Postcode)


## Group By (12) ----
# sort by Hospital Code
borders %>%
  group_by(HospitalCode)


## Summarise (13) ----
# avg length of stay by hospital
borders %>%
  group_by(HospitalCode) %>%
  summarise(mean_los = mean(LengthOfStay))


## Count (14) ----
# counts of specialty
borders %>%
  count(Specialty, sort = TRUE)


## Rename (16) ----
# rename Date of Birth column
borders %>%
  rename(date_of_birth = Dateofbirth)


## Recode (17) ----
# change hospital code
borders %>%
  mutate(HospitalCode = recode("B120V" = "B120H"))


## Joining Tables (19) ----
library(readr)
# merge baby data
baby5 <- read_csv("data/Baby5.csv")
baby6 <- read_csv("data/Baby6.csv")
baby_joined %>%
  left_join(baby5, baby6, by = c("FAMILYID", "DOB"))


### END OF SCRIPT ###