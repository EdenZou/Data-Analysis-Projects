library(quantmod) 
rm(list=ls(all=TRUE))
# ,"Blegium" ,"Indonesia"
double <- c("Australia","Denmark","France","Germany","Greece","Hong Kong","India","Ireland","Netherlands","Norway","Philippines","Poland","Spain","Sweden","Switzerland","Taiwan","United Kingdom","United States")
single <- c("Thailand","South Korea","Russia","Malaysia","Israel","Czech Republic" )

for(i in 1:length(double)){
  country <- double[i]
  file1 <- paste("~/R/7011/final/",country," 10-Year Bond Yield Historical Data.csv",sep='')
  file2 <- paste("~/R/7011/final/",country," 10-Year Bond Yield Historical Data (1).csv",sep='')
  part1 <- read.csv(file1,header = T)
  part2 <- read.csv(file2,header = T)
  dates1 <- as.Date(part1$ï..Date)
  dates2 <- as.Date(part2$ï..Date)
  part3 <- xts(x = part1$Price, order.by = dates1)
  part4 <- xts(x = part2$Price, order.by = dates2)
  assign(country,rbind(part3,part4))
}

for(i in 1:length(single)){
  country <- single[i]
  file <- paste("~/R/7011/final/",country," 10-Year Bond Yield Historical Data.csv",sep='')
  part <- read.csv(file,header = T)
  dates <- as.Date(part$ï..Date)
  part5 <- xts(x = part$Price, order.by = dates)
  assign(country,part5)
}


Blegium1 <- read.csv("~/R/7011/final/Belgium 10-Year Bond Yield Historical Data.csv",header = T)
dates1 <- as.Date(Blegium1$ï..Date)
Blegium1 <- xts(x = Blegium1$Price, order.by = dates1)
Blegium2 <- read.csv("~/R/7011/final/Belgium 10-Year Bond Yield Historical Data (1).csv",header = T)
dates2 <- as.Date(Blegium2$ï..Date)
Blegium2 <- xts(x = Blegium2$Price, order.by = dates2)                 
Blegium <- rbind(Blegium1,Blegium2)

bonds <- merge(Australia,Blegium,Denmark,France,Germany,Greece,`Hong Kong`,India,Ireland,Netherlands,Norway,Philippines,Poland,
               Spain,Sweden,Switzerland,Taiwan,`United Kingdom`,`United States`,Thailand,`South Korea`,Malaysia,Israel,`Czech Republic`)

plot(bonds[,1])
head(bonds)
new_bonds <- bonds["2002-04-10/2020-03-20"]
head(new_bonds)

# Explore underlying units of temps in two commands: .index() and .indexwday()
.index(new_bonds)
.indexwday(new_bonds)
# Create an index of weekend days using which()
index <- which(.indexwday(new_bonds) == 6 | .indexwday(new_bonds) == 0)
# Select the index
bonds.week <- new_bonds[-index]
sum(is.na(bonds.week))

plot(bonds.week[,12])
bondm <- as.matrix(bonds.week)
b <- splinefun(x = as.vector(bondm[,0]), y = as.vector(bondm[,7]),
              method = "natural",
              ties = mean)
#bonds.week <- to.period(new_bonds, period = "weeks")
# Get the temporary file name
# Write the xts object using zoo to tmp 
bonds.linear <- na.approx(bonds.week)
bonds.spline <- na.spline(bonds.week)
write.zoo(bonds.week, sep = ",", file = "Bonds.csv")
bonds.linear <- bonds.linear["2002-04-17/2020-03-20"]
write.zoo(bonds.linear, sep = ",", file = "New_Bonds.csv")
write.zoo(bonds.spline, sep = ",", file = "Bonds_Spline.csv")
