#1. Set project working directory

message("... Setting Working Directory ...")
directory <- c("C:")
setwd(directory)


#2.   Download and unzip data file

message("... Downloading archived data from site ...")
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
message("... Unzipping archived data ...")
unzip("household_power_consumption.zip")


#3. Load household power consumption data into a table

message("... Loading household power consumption data ...")
message("... This will take a while ;)  ...")
filename <- c("./household_power_consumption.txt")
power_data <- read.table(filename, header = TRUE, sep = ";", na.strings="?")
message("... Loading data ... Complete!")


#4. Subset data for dates between 2007-02-01 to 2007-02-02

message("... Searching and subsetting data for dates between 2007-02-01 to 2007-02-02 ...")
selected_power_data <- subset(power_data, power_data$Date=="1/2/2007" | power_data$Date== "2/2/2007")


#5. Remove data frame containing unwanted records from Environment

message("... Removing data frame containing unwanted records ...")
rm(power_data)
message("... Unwanted data removed ... Complete!")


#6. Convert the Date and Time variables to Date/Time variable

message("... Converting Date and Time variable into single Date/Time variable ...")
date_time <- paste(selected_power_data$Date, selected_power_data$Time)
new_date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")
day_of_week <- weekdays(as.Date(new_date_time,'%d/%m/%Y %H:%M:%S'))


#7. Create new data frame with new Date/Time and day variable

message("... Creating new data frame with new Date/Time and day variable  ...")
new_power_data <- data.frame( DateTime = new_date_time, 
                              day = day_of_week, 
                              Global_active_power = selected_power_data$Global_active_power, 
                              Global_reactive_power = selected_power_data$Global_reactive_power,
                              Voltage = selected_power_data$Voltage,
                              Global_intensity = selected_power_data$Global_intensity,
                              Sub_metering_1 = selected_power_data$Sub_metering_1, 
                              Sub_metering_2 = selected_power_data$Sub_metering_2,
                              Sub_metering_3 = selected_power_data$Sub_metering_3 )


#8. Create 4 combined plots directly on PNG device and saving it into PNG file, plot4.png 
#   (if drawn on screen device, the legend on plot 3 wil not fit the 480x480 png size)

message("... Creating 4 combined plots on png device, skipping screen device ...")
message("... And saving plot into file named plot4.png  ...")

png(file="plot4.png", width=480, height=480)

par(mfrow=c(2,2))

#9. Create 1st plot at top left screen

message("... Creating 1st plot at top left screen ...")
plot(new_power_data$DateTime, new_power_data$Global_active_power, type="l", xlab="",  ylab="Global Active Power")


#10. Create 2nd plot at top right screen

message("... Creating 2nd plot at top right screen ...")
plot(new_power_data$DateTime, new_power_data$Voltage, type="l", ylab="Voltage", xlab="datetime")


#11. Create 3rd plot at bottom left screen (removed legend border)

message("... Creating 3rd plot at bottom left screen ...")
plot(new_power_data$DateTime, new_power_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black")
lines(new_power_data$DateTime, new_power_data$Sub_metering_2, type="l", col="red")
lines(new_power_data$DateTime, new_power_data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty=1, lwd=2.5, col=c("black", "red", "blue"))

#12. Create 4th plot at bottom right screen

message("... Creating 4th plot at bottom right screen ...")
plot(new_power_data$DateTime, new_power_data$Global_reactive_power, cex=0.95, type="l", ylab="Global_reactive_power", xlab="datetime")

#11. Closing PNG device to generate PNG file containing the plot

message("... Closing graphics device to complete PNG file creation  ...")
dev.off()