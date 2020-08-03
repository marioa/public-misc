# Script produced on 29/07/20 for a Virtual Data Carpentry for Heriot Watt
# https://edcarp.github.io/2020-07-28-heriotwatt-dc-online/
# Based on the R for Social Science
# https://datacarpentry.org/r-socialsci/
# Setup -------------------------------------------------------------------

# Initial setup
dir.create("data")
dir.create("data_output")
dir.create("fig_output")
download.file("https://ndownloader.figshare.com/files/11492171","data/SAFI_clean.csv",mode="wb")


# Introduction ------------------------------------------------------------

3+5
12/7

# Assignments
x <- 5
x = 6
7 -> x
x

area_hectares <- 1.0
area_hectares
(area_hectares <- 1.0)

2.47 * area_hectares

area_acres <- 2.47 * area_hectares

area_hectares <- 50

####
# Exercise: Create a width and length variables, assign them values, calculate 
#           the area or a rectangle
#           (use a variable area) and print out the result.
#
#           Create height and weight, give it your height in m and weight in kg, 
#           calculate your BMI
#           (weight/(height*height)). Calculate your BMI.
####
height <- 1.72
weight <- 81.7
(bmi <- weight/(height* height))

# Functions
sqrt(4)
a <- 4
sqrt(a)

round(3.14159)

# Ways of getting help
args(round)
help(round)
?round
??round

round(3.14159, digits=2)
round(3.14159,2)
round(digits=2, x=3.14159)
round(3.14159)
round( 55.5)

# Vectors and data types

hh_members <- c(3,7,10,6)
hh_members   

respondet_wall_type <-  c("muddaub","burntbrick",
                          "sunbricks")
length(hh_members)
length(respondet_wall_type)

class(hh_members)
class(respondet_wall_type)

str(hh_members)
str(respondet_wall_type)

possessions <- c("bicycles","radio","television")
possessions <- c(possessions, "mobile_phone")
possessions
possessions <- c("car", possessions)
possessions

# Logical or Boolean
1 == 1
1 == 0 
x <-  1 == 1
typeof(x) 
class(x)

# integers (counting numbers) and doubles
x <- 1
typeof(x)
x <- 1L
typeof(x)
class(x)

# Complex
x <- 1 + 4i
typeof(x)
class(x)

# Characters
x <- "Mario"
typeof(x)
class(x)

n <-  c(1,2,3,"a")
typeof(n)
n <- c(TRUE, 1, 2, 3, FALSE)
typeof(n)
class(n)

# Automatic Coercion: Logicals -> Integers -> Doubles -> Complex -> Characters

# Subsetting vectors
ls()
respondet_wall_type
respondet_wall_type[2]
respondet_wall_type[c(3,2)]
respondet_wall_type[c(1,2,3,2,3,2,4)]

# Conditional subsetting
ls()
hh_members
hh_members[c(TRUE,FALSE,TRUE,FALSE)]
hh_members > 5
hh_members[hh_members > 5]

# & - logical and - all values must be TRUE
# | - logical or - at least one value is TRUE
hh_members[hh_members < 3 | hh_members > 5]
hh_members[hh_members >= 7 & hh_members == 3]

# ==, >, <, >=, <=, !

possessions
possessions[possessions =="car" | possessions == "bicycles"]

# %in%
possessions %in% c("car","bicycles")
possessions[possessions %in% c("car","bicycles")]

# Missing data - NA
rooms <- c(2,1,2, NA, 4)

mean(rooms)
max(rooms)

is.na(rooms)
!is.na(rooms)

rooms[!is.na(rooms)]

mean(rooms, na.rm = TRUE)
max(rooms, na.rm =TRUE)

mean(rooms[!is.na(rooms)])

# na.omit
# complete.cases

###
# Exercise
#
# 1. Using this vector of rooms, create a new vector with the NAs removed.
#
rooms <- c(1, 2, 1, 1, NA, 3, 1, 3, 2, 1, 1, 8, 3, 1, NA, 1)
crooms <- rooms[!is.na(rooms)]

#
# 2. Use the function median() to calculate the median of the rooms vector.

median(rooms,na.rm = TRUE)
median(crooms)

# 3. Use R to figure out how many households in the set use more than 2 
#    rooms for sleeping
crooms[crooms > 2]
length(crooms[crooms > 2])
####


# Dataframes and Tibbles --------------------------------------------------

library(tidyverse)

interviews <- read_csv("data/SAFI_clean.csv",na = "NULL")
interviews
View(interviews)
?read_csv
class(interviews)
typeof(interviews)

# Inspecting data frames
dim(interviews)
nrow(interviews)
ncol(interviews)

head(interviews)
tail(interviews)

names(interviews)
names(interviews)[2]
# names(interviews)[2] <- "Villages"

str(interviews)
summary(interviews)

# Index and subset data frames

# [row_number, col_number]
interviews[1,1]
interviews[1,6]

interviews[1]
interviews[[1]]

1:3
c(1,2,3)
1:10
10:1
seq(1,10)
seq(1,10,2)

interviews[1:3,7]

interviews[3,]
interviews[1:3,]
head_interviews <- interviews[1:6,]

interviews[,1]
interviews[,-1]
interviews[,-c(7:8)]

names(interviews)
interviews["years_liv"]
interviews[["years_liv"]]
interviews$rooms

# Factors

# red - 1
# green - 2
# blue - 3

favcol <- 
  factor(c("red","blue", "green","green","blue","red"))
favcol
plot(favcol)


# dplyr -------------------------------------------------------------------

library(tidyverse)

names(interviews)
select(interviews, village, no_membrs, years_liv)
filter(interviews, village == "God")

select(filter(interviews, village =="God"), village, 
       no_membrs, years_liv)

interviews %>% filter(village == "God") %>%
               select(village, no_membrs, years_liv)

interviews_God <-  interviews %>%
                   filter( village == "God") %>%
                   select(village, no_membrs,years_liv)

interviews %>% filter(village == "God") %>%
  select(village,no_membrs, years_liv) -> interviews_God

interviews %>% mutate(people_per_room = no_membrs/rooms)

interviews %>% group_by(village) %>% 
               summarise(mean_no_members= mean(no_membrs))

interviews %>% group_by(village) %>% 
             summarise(mean_no_members = mean(no_membrs)) %>% 
             ungroup()

interviews %>% group_by(village, memb_assoc) %>% 
               filter(!is.na(memb_assoc))  %>% 
              summarize(mean_no_membrs=mean(no_membrs)) %>% 
              arrange(desc(mean_no_membrs))

interviews %>% count(village)
