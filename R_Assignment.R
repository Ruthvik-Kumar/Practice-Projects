# Using help to access the R documentation
?mean

## Objects and functions

# Arithmetic operation is performed by passing the values with a plus '+' operator to find the sum of the given numbers
5 + 6

# Create two variables or objects of numeric class, and use them to store desired values
a <- 15
b <- 16

# Perform the arithmetic operation (addition) by passing the objects to find the sum of the given numbers
a + b

# Use the in-built sum function to perform the addition operation
sum(a,b)

# Store multiple numeric values in an object using the concatenate 'c()' function
ages <- c(5,6)

# Perform the arithmetic operation (addition) by passing in a vector
sum(ages)

# Store multiple values of character class in an object using the concatenate 'c()' function
names <- c("John", "James")

# Create a dataframe with the function data.frame where we pass in vectors as input that translate into columns in the output frame
friends <- data.frame(names, ages)

# The view function is used to display the dataframe as a table in new tab
View(friends)

# Str function displays the dataframe contents and structure within the console along with the data type of the columns
str(friends)

# To view values of a specific column in the dataframe, pass the name of the dataframe with '$' symbol and the column name as variable to retrieve the values of the given column name
friends$names
friends$ages

# To fetch a specific value in the dataframe, the dataframe name along with the row index number and column index number are passed in square brackets that retrieves the subset of the given indices
friends[1,1]

# To view the values of a specific row in the dataframe, the dataframe name along with the row index number are passed in square brackets leaving the column index blank to get the subset of the given row index
friends[1,]

# To fetch the values by column index in the dataframe, the dataframe name along with the column index number are passed in square brackets leaving the row index blank to get the subset of the given column index 
friends[,1]

# Explore built in datasets


data()

# Install and use packages

# to install packages for R the function install.packages is used where we give the package name as input
install.packages("tidyverse")

# the installed package name gets passed to the library function to load it into our working session
library(tidyverse)


View(starwars)


starwars %>% 
  filter(height > 150 & mass < 200) %>% 
  mutate(height_in_meters = height/100) %>% 
  select(height_in_meters, mass) %>% 
  arrange(mass) %>%
  View()
  plot()
  
  
  # Data Structure and types of Variables
  
  
View(msleep)
  
  # Quick overview of data
glimpse(msleep)
  
  # Returns first six rows or records
head(msleep)
  
  # Gives the data type of the variable passed, here we passed the name of a column
class(msleep$name)
  
  # Gives names of all the variables (column names)
names(msleep)
  
  # Gives the unique values in a vector or column
unique(msleep$vore)
  
  # Find the empty records in the dataframe, complete.cases function returns records with no empty data, including '!' before the function would do the opposite i.e returns records with missing data
missing <- !complete.cases(msleep)
  
  # Filter rows with empty values, we pass in the 'missing' object in place of row index to fetch the rows with empty values and column index is kept empty to fetch data of all the columns 
msleep[missing, ]
  
  
  # select variables
  
starwars %>% 
  select (name, height, mass)
  
starwars %>% 
  select(1:3)
  
starwars %>% 
  select(ends_with("color"))
  
  
# Changing variable order
  
starwars %>% 
  select(name, mass, height, everything()) %>% 
  View()
  
# Changing variable name
starwars %>% 
  rename("characters" = "name") %>%
  head()
  
  # Changing variable type
class(starwars$hair_color)
  
starwars$hair_color <- as.factor(starwars$hair_color)
  
class(starwars$hair_color)
  
starwars %>% 
  mutate(hair_color = as.character(hair_color)) %>% 
  glimpse()


# Changing factor levels
df <- starwars
df$sex <- as.factor(df$sex)

levels(df$sex)

df <- df %>% 
  mutate(sex = factor(sex,
                      levels = c("male", "female", "hermaphroditic", "none")))

# Filter rows
starwars %>% 
  select(mass, sex) %>% 
  filter(mass < 55 &
           sex == "male")

# Recode data
starwars %>% 
  select(sex) %>% 
  mutate(sex = recode(sex,
                      "male" = "man",
                      "female" = "woman"))

# Dealing with missing data

mean(starwars$height, na.rm = TRUE)

# Dealing with duplicates

Names <- c("Peter", "John", "Andrew")
Age <- c(22, 33, 44)

friends <- data.frame(Names, Age)

friends %>% 
  distinct()

distinct(friends)


# Data Manipulation

# Create or change a variable (mutate)
starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m)


# Conditional change

starwars %>% 
  mutate(height_m = height/100) %>% 
  select(name, height, height_m) %>% 
  mutate(tallness = 
           if_else(height_m < 1,
                   "short",
                   "tall"))


# Reshape data with Pivot Wider

library(gapminder)
View(gapminder)

data <- select(gapminder, country, year, lifeExp)

View(data)

wide_data <- data %>% 
  pivot_wider(names_from = year, values_from = lifeExp)

View(wide_data)

# Reshape data with Pivot longer

long_data <- wide_data %>% 
  pivot_longer(2:13,
               names_to = "year",
               values_to = "lifeExp")

View(long_data)

# Describe data

# Range/ Spread
min(msleep$awake)
max(msleep$awake)
range(msleep$awake)
IQR(msleep$awake)

# Centrality

mean(msleep$awake)
median(msleep$awake)

# Variance

var(msleep$awake)

summary(msleep$awake)

msleep %>% 
  select(awake, sleep_total) %>% 
  summary()


 # Summarize data
msleep %>% 
  drop_na(vore) %>% 
  group_by(vore) %>% 
  summarise(Lower = min(sleep_total),
            Average = mean(sleep_total),
            Upper = max(sleep_total),
            Difference=
              max(sleep_total)-min(sleep_total)) %>% 
  arrange(Average) %>% 
  View()


# Create tables

table(mslepp$vore)

msleep %>% 
  select(vore, order) %>% 
  filter(order %n% c("Rodentia", "Primates")) %>% 
  table()


# Data Visualization

plot(pressure)

# Bar plots
ggplot(data = starwars,
       mapping = aes(x = gender))+
  geom_bar()

# Histogram
starwars %>% 
  drop_na(height) %>% 
  ggplot(mapping = aes(x = height))+
  geom_histogram()

# Box plots
starwars %>% 
  drop_na(height) %>% 
  ggplot(aes(height))+
  geom_boxplot(fill = "steelblue")+
  theme_bw()+
  labs(title = "Boxplot of height",
       x = "Height of characters")


# Density plots
starwars %>% 
  drop_na(height) %>% 
  filter(sex %in% c("male", "female")) %>% 
  ggplot(mapping = aes(x = height,
                       color = sex,
                       fill = sex))+
  geom_density(alpha = 0.2)+
  theme_bw()


# Scatter plots
starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(height, mass, color = sex))+
  geom_point(size = 5, alpha = 0.5)+
  theme_minimal()+
  labs(title = "Height and mass by sex")


# Smoothed model

starwars %>% 
  filter(mass < 200) %>% 
  ggplot(aes(height, mass, color = sex))+
  geom_point(size = 3, alpha = 0.8)+
  geom_smooth()+
  facet_wrap(~sex)+
  theme_bw()+
  labs(title = "Height and mass by sex")


# Analyze

# Hypothesis Testing
library(gapminder)
View(gapminder)

t_test_plot

gapminder %>% 
  filter(continent %in% c("Africa", "Europe")) %>% 
  t.test(lifeExp ~ continent, data = .,
         alternative = "two.sided",
         paired = FALSE)

# ANOVA

ANOVA_plot

gapminder %>% 
  filter(year == 2007) %>% 
  filter(constinent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>% 
  summary()

gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>% 
  TukeyHSD()


gapminder %>% 
  filter(year == 2007) %>% 
  filter(continent %in% c("Americas", "Europe", "Asia")) %>% 
  aov(lifeExp ~ continent, data = .) %>% 
  TukeyHSD() %>% 
  plot()

# chi squared
chi_plot

head(iris)

flowers <- iris %>% 
  mutate(size = cut(Sepal.Length,
                    breaks = 3,
                    labels = c("small", "Medium", "Large"))) %>% 
  select(Species, size)

# chi squared goodness of fit test
flowers %>% 
  select(size) %>% 
  table() %>% 
  chisq.test()

# chi squared test of independence
flowers %>% 
  table() %>% 
  chisq.test()

# Linear Model

linear_plot

head(cars, 10)

cars %>% 
  lm(dist ~ speed, data = .) %>% 
  summary()


#####

  
  
