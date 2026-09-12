# Install necessary packages
install.packages("tm")
install.packages("textclean")
install.packages("tokenizers")
install.packages("SnowballC")
install.packages("reshape2")

# Load necessary libraries
library(tm)
library(textclean)
library(tokenizers)
library(SnowballC)
library(dplyr)
library(writexl)
library(readxl)
library(ggplot2)
library(dplyr)
library(reshape2)

data <- read.csv("C:/Users/Uzair Khan/Downloads/Assignments/Dissertation/DataSet.csv")

summary(data)

data$fraudulent<- factor(data$fraudulent)


# Create a bar plot for the 'fraudulent' column
ggplot(data, aes(x = fraudulent)) +
  geom_bar(fill = "blue", color = "black") +
  labs(title = "Count of True and False Job Postings",
       x = "Fraudulent",
       y = "Count") +
  theme_minimal()

# Calculate missing values in character columns
missing_values_char <- sapply(data, function(col) {
  if (is.character(col)) {
    sum(is.na(col) | col == "")
  } else {
    NA
  }
})

# Remove NA values from the result (for non-character columns)
missing_values_char <- missing_values_char[!is.na(missing_values_char)]

print(missing_values_char)

# Convert to data frame for plotting
missing_values_df <- data.frame(
  column = names(missing_values_char),
  missing_count = missing_values_char
)

# Plot the missing values
ggplot(missing_values_df, aes(x = column, y = missing_count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  geom_text(aes(label = missing_count), vjust = -0.5) +
  labs(title = "Missing Values in Character Columns",
       x = "Column",
       y = "Number of Missing Values") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

summary(data)


# Preprocessing function
preprocess_text <- function(text) {
  text <- tolower(text)
  text <- replace_html(text)
  text <- removePunctuation(text)
  tokens <- unlist(tokenize_words(text))
  stop_words <- stopwords("en")
  tokens <- tokens[!tokens %in% stop_words]
  tokens <- wordStem(tokens, language = "en")
  processed_text <- paste(tokens, collapse = " ")
  # Truncate if exceeds Excel's limit
  if (nchar(processed_text) > 32767) {
    processed_text <- substr(processed_text, 1, 32767)
  }
  return(processed_text)
}

# Apply preprocessing to multiple columns
clean_data <- data %>%
  mutate(
    company_profile = sapply(company_profile, preprocess_text),
    description = sapply(description, preprocess_text),
    requirements = sapply(requirements, preprocess_text),
    benefits = sapply(benefits, preprocess_text)
  )

# Convert specified columns to factors
clean_data$has_company_logo <- factor(clean_data$has_company_logo)
clean_data$has_questions <- factor(clean_data$has_questions)
clean_data$telecommuting <- factor(clean_data$telecommuting)
clean_data$employment_type <- factor(clean_data$employment_type)
clean_data$required_experience <- factor(clean_data$required_experience)
clean_data$required_education <- factor(clean_data$required_education)
clean_data$fraudulent <- factor(clean_data$fraudulent)

# Verify the changes
str(data)

# Create the plot for has_company_logo
ggplot(clean_data, aes(x = has_company_logo, fill = fraudulent)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, position = position_dodge(0.9)) +
  labs(title = "Count of Fraudulent and Real Jobs by Company Logo Presence",
       x = "Company Logo",
       y = "Count",
       fill = "Job Type") +
  theme_minimal()

# Create the plot for Telecommuting
ggplot(clean_data, aes(x = telecommuting, fill = fraudulent)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, position = position_dodge(0.9)) +
  labs(title = "Count of Fraudulent and Real Jobs by telecommuting",
       x = "telecommuting",
       y = "Count",
       fill = "Job Type") +
  theme_minimal()

# Create the plot for has_questions
ggplot(clean_data, aes(x = has_questions, fill = fraudulent)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, position = position_dodge(0.9)) +
  labs(title = "Count of Fraudulent and Real Jobs by has_questions",
       x = "has_questions",
       y = "Count",
       fill = "Job Type") +
  theme_minimal()

# Create the plot for required_experience
ggplot(clean_data, aes(x = required_experience, fill = fraudulent)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, position = position_dodge(0.9)) +
  labs(title = "Count of Fraudulent and Real Jobs by required_experience",
       x = "required_experience",
       y = "Count",
       fill = "Job Type") +
  theme_minimal()

# Create the plot for required_education
ggplot(clean_data, aes(x = required_education, fill = fraudulent)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, position = position_dodge(0.9)) +
  labs(title = "Count of Fraudulent and Real Jobs by required_education",
       x = "required_education",
       y = "Count",
       fill = "Job Type") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Create the plot for employment_type
ggplot(clean_data, aes(x = employment_type, fill = fraudulent)) +
  geom_bar(position = "dodge") +
  geom_text(stat = "count", aes(label = ..count..), vjust = -0.5, position = position_dodge(0.9)) +
  labs(title = "Count of Fraudulent and Real Jobs by employment_type",
       x = "employment_type",
       y = "Count",
       fill = "Job Type") +
  theme_minimal()
