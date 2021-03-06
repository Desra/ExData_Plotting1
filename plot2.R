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
names(selected_power_data) <- names(power_data)


#5. Remove table containing unwanted records from Environment

message("... Removing data frame containing unwanted records ...")
rm(power_data)
message("... Unwanted data removed ... Complete!")


#6. Convert the Date and Time variables to Date/Time variable

message("... Converting Date and Time variable into single Date/Time variable ...")
date_time <- paste(selected_power_data$Date, selected_power_data$Time, sep=" ")
new_date_time <- strptime(date_time, "%d/%m/%Y %H:%M:%S")
day_of_week <- weekdays(as.Date(new_date_time,'%d/%m/%Y %H:%M:%S'))


#7. Create new data frame with new Date/Time and day variable

message("... Creating new table with new Date/Time and day variable  ...")
new_power_data <- data.frame( DateTime = new_date_time, 
                              day = day_of_week, 
                              Global_active_power = selected_power_data$Global_active_power, 
                              Global_reactive_power = selected_power_data$Global_reactive_power,
                              Voltage = selected_power_data$Voltage,
                              Global_intensity = selected_power_data$Global_intensity,
                              Sub_metering_1 = selected_power_data$Sub_metering_1, 
                              Sub_metering_2 = selected_power_data$Sub_metering_2,
                              Sub_metering_3 = selected_power_data$Sub_metering_3 )


#8. Create plot on screen device

message("... Creating plot on screen device ...")
par(mfrow=c(1,1))
plot(new_power_data$DateTime, new_power_data$Global_active_power, type="l", xlab="",  ylab="Global Active Power (kilowatts)")


#9. Copy/save drawn plot on PNG file, plot2.png and closing PNG device 

message("... Saving plot from screen into file named plot2.png  ...")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
