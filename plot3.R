# This script is to  constract plot3.png in the repo
library(dplyr)
rm(list = ls())

#### Set the working directory; modify this to accommodate your local environment.
setwd("/Users/freefrog/coding/datascience/gitrepo/ExData_Plotting1")

#### obtain the dataset with url
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
localfile <- file.path(getwd(), "Dataset.zip")
download.file(url, localfile)
datafile <- unzip(localfile)

#### load data into r
data <- read.table(datafile, colClasses="character",na.strings="?", sep = ";", header = TRUE)

#### subset to get data from the dates 2007-02-01 and 2007-02-02
sub_data <- subset(data, Date == "1/2/2007"|Date == "2/2/2007", select = Date:Sub_metering_3)

#### set right format
sub_data$Global_active_power <- as.numeric(sub_data$Global_active_power)
sub_data <- mutate(sub_data, datatime = paste(Date,Time))
sub_data$datatime <- strptime(sub_data$datatime, format = "%d/%m/%Y %H:%M:%S")

#### Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels
png(filename = "plot3.png", width = 480, height = 480)
with(sub_data, plot(sub_data$datatime,sub_data$Sub_metering_1,type = "n",ylab = "Energy sub metering",xlab = ""))
lines(sub_data$datatime,sub_data$Sub_metering_1)
lines(sub_data$datatime,sub_data$Sub_metering_2, col = "red")
lines(sub_data$datatime,sub_data$Sub_metering_3, col = "blue")
legend(
  "topright", 
  lty = 1,
  lwd = 1, 
  col = c("black", "red", "blue"), 
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  )
dev.off()
