# install.packages("stringr")
# library("stringr")
install.packages("stringdist")
library("stringdist")
install.packages("dplyr")
library("dplyr")
install.packages("tidyr")
library("tidyr")
install.packages("dummies")
library("dummies")

# 0: Load the data in RStudio
dfOriginal <- read.csv("titanic_original.csv")
df <- dfOriginal
#View(df)

# 1: Port of embarkation
for (i in 1:length(df$embarked)) {
  if(is.na(df$embarked[i]) | is.null(trimws(df$embarked[i])) | trimws(df$embarked[i]) == "" ) {
    df$embarked[i] <- "S"
  }
}
#View(df)

# 2: Age
# Applying mean is better for missing values as it wont affect any calculations we got to perform on this column
meanAge <- mean(df$age, na.rm = TRUE)
df <- mutate(df, age = ifelse(is.na(age), meanAge, age))
#View(df)

# 3: Lifeboat
df <- mutate(df, boat = ifelse(is.null(boat) | is.na(boat) | trimws(boat) == "", NA, boat))
#View(df)

# 4: Cabin
df <- mutate(df, has_cabin_number = ifelse(is.null(cabin) | is.na(cabin) | trimws(cabin) == "", 0, 1))
#View(df)

#5 Write back to CSV file as titanic_clean.csv
write.csv(df, file = "titanic_clean.csv")