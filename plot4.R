if(!file.exists("./data/household_power_consumption.RData")){
  dat<-read.table("./data/household_power_consumption.txt",sep=";"
                  ,comment.char="",header=TRUE)
  save(dat,file="./data/household_power_consumption.RData")
}else{
  load("./data/household_power_consumption.RData")
}

Sys.setlocale("LC_TIME", "C");
d1<-as.Date("2007-02-01")
d2<-as.Date("2007-02-02")

Date<-as.Date(dat$Date,format='%d/%m/%Y')
index<- Date==d1 | Date==d2
Dat<-dat[index,]


times<-as.vector(Dat$Time)
dates<-as.vector(Dat$Date)
z<-paste(dates, times)
tmp<-strptime(z, "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2), mar = c(4, 4, 1, 1), oma = c(0, 0, 2, 0))
plot(tmp,as.numeric(as.vector(Dat$Global_active_power)),type="l",
     ylab="Global Active Power",xlab="datetime")
plot(tmp,as.vector(Dat$Voltage),type="l",ylab="Voltage",xlab="datetime")
plot(tmp,as.vector(Dat$Sub_metering_1),type="l",col="black",
     ylim=c(0,40),ylab="Energy sub metering",xlab="datetime")
lines(tmp,as.vector(Dat$Sub_metering_2),type="l",col="red",
      xlab = "", ylab = "",ylim=c(0,40))
lines(tmp,as.vector(Dat$Sub_metering_3),type="l",col="blue",
      xlab = "", ylab = "",ylim=c(0,40))
legend("topright",c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'), lty=c(1),cex=0.6,bty="n",text.width=60000)
plot(tmp,as.vector( Dat$Global_reactive_power ),type="l",ylab="Global Reactive Power"
     ,xlab="datetime")

dev.copy(png, file = "./data/plot4.png", width=480, height=480)
dev.off()