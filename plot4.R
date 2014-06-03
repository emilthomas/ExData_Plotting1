# Author : Emil Thomas


#Read first 2 rows, determine the class, then read the entire file for fast reading
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", nrows= 2, na.strings="?")
classes <- sapply(dat, class)
dat <- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings="?", colClasses= classes)

dat <- dat[grepl("^[12]/2/2007", dat$Date), ]            #search and retain the date starting with 1 or 2 of feb
dat$Date <- as.Date(dat$Date, format = "%d/%m/%Y")      #this is the format in the input file
temp <- paste(dat$Date, dat$Time)
datetime <- strptime(temp, format="%Y-%m-%d %H:%M:%S")   #convert to POSIXct datatype

#Begin Plotting
png(filename= "plot4.png", width=480, height=480)
par(mfrow=c(2,2))

#PLOT 1
plot(datetime, dat$Global_active_power, type="l", ylab="Global Active Power", xlab = "")

#PLOT 2
plot(datetime, dat$Voltage, type="l", ylab="Voltage", xlab = "datetime")

#PLOT 3
plot(datetime, dat$Sub_metering_1, type = "l", col="black", xlab = "", ylab = "Energy sub metering")
lines(datetime, dat$Sub_metering_2, type = "l", col= "red")                                                                                             
lines(datetime, dat$Sub_metering_3, type = "l", col= "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        lty= c(1,1,1), col=c("black", "red", "blue"), bty = "n", title.adj = 1) 

#PLOT 4
plot(datetime, dat$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(datetime, dat$Global_reactive_power, type = "l")

dev.off()                                               #For PNG
