library(dplyr)
library(MTS)
library(ggplot2)
dane <- read.csv("dane.csv", header=T, sep=",")
dane$Date <- as.Date(dane$Date,"%d/%m/%Y")
BUMIX <- dane[dane$Name=="BUMIX",]
BUX <-dane[dane$Name=="BUX",]
CETOP <- dane[dane$Name=="CETOP",]
df0<-merge(BUX,BUMIX,by="Date")
df<-merge(df0,CETOP,by="Date")
df<-na.omit(df)

#stopy logarytmiczne

stoplog<-function(dane){
  wynik<-c(0)
  for(i in 1:(length(dane)-1)){
    
    stopa<-100*log(dane[i+1]/dane[i])
    wynik[i]<-stopa
  }
  
  return(wynik)
}

stopa.cetop<-stoplog(df$Close.price)
stopa.bux<-stoplog(df$Close.price.x)
stopa.bumix<-stoplog(df$Close.price.y)

dane1<-df[-1,]
dane1$stopa.cetop<-as.numeric(stopa.cetop)
dane1$stopa.bux<-as.numeric(stopa.bux)
dane1$stopa.bumix<-as.numeric(stopa.bumix)
dane1<-na.omit(dane1)
strata_bux<-data.frame(Data=dane1$Date,logreturn=-(dane1$stopa.bux))
strata_cetop<-data.frame(Data=dane1$Date,logreturn=-(dane1$stopa.cetop))
strata_bumix<-data.frame(Data=dane1$Date,logreturn=-(dane1$stopa.bumix))
strata_bux <- strata_bux %>% add_row()  
strata_bumix <- strata_bumix %>% add_row()
strata_cetop <- strata_cetop %>% add_row()


#deklaracja kolumn


strata_bux$var_99_250_EWMA <- NA
strata_bux$es_99_250_EWMA <- NA
strata_bux$var_95_250_EWMA<- NA
strata_bux$es_95_250_EWMA <- NA
strata_bumix$var_99_250_EWMA <- NA
strata_bumix$es_99_250_EWMA <- NA
strata_bumix$var_95_250_EWMA<- NA
strata_bumix$es_95_250_EWMA <- NA
strata_cetop$var_99_250_EWMA <- NA
strata_cetop$es_99_250_EWMA <- NA
strata_cetop$var_95_250_EWMA <- NA
strata_cetop$es_95_250_EWMA <- NA


# EWMA

for (i in seq(1,nrow(strata_bux)-250,1)){
  probka <- strata_bux[i:(249+i),]
  probka$vol<-EWMAvol(probka$logreturn, lambda=0.999)$Sigma.t
  probka<-probka %>% mutate(Z = logreturn * lead(vol)/vol)
  kwantyl_99<-quantile(probka$Z, .99, na.rm = T)
  kwantyl_95<-quantile(probka$Z, .95, na.rm=T)
  strata_bux$var_99_250_EWMA[250+i] <- kwantyl_99
  strata_bux$var_95_250_EWMA[250+i] <- kwantyl_95
  probka2 <- probka %>% filter(Z > kwantyl_99)
  w_99 = mean(probka2$Z)
  strata_bux$es_99_250_EWMA[250+i] <- w_99
  probka3 <- probka %>% filter(Z > kwantyl_95)
  w_95 = mean(probka3$Z)
  strata_bux$es_95_250_EWMA[250+i] <- w_95
}

for (i in seq(1,nrow(strata_bumix)-250,1)){
  probka <- strata_bumix[i:(249+i),]
  probka$vol<-EWMAvol(probka$logreturn, lambda=0.999)$Sigma.t
  probka<-probka %>% mutate(Z = logreturn * lead(vol)/vol)
  kwantyl_99<-quantile(probka$Z, .99, na.rm = T)
  kwantyl_95<-quantile(probka$Z, .95, na.rm=T)
  strata_bumix$var_99_250_EWMA[250+i] <- kwantyl_99
  strata_bumix$var_95_250_EWMA[250+i] <- kwantyl_95
  probka2 <- probka %>% filter(Z > kwantyl_99)
  w_99 = mean(probka2$Z)
  strata_bumix$es_99_250_EWMA[250+i] <- w_99
  probka3 <- probka %>% filter(Z > kwantyl_95)
  w_95 = mean(probka3$Z)
  strata_bumix$es_95_250_EWMA[250+i] <- w_95
}

for (i in seq(1,nrow(strata_cetop)-250,1)){
  probka <- strata_cetop[i:(249+i),]
  probka$vol<-EWMAvol(probka$logreturn, lambda=0.999)$Sigma.t
  probka<-probka %>% mutate(Z = logreturn * lead(vol)/vol)
  kwantyl_99<-quantile(probka$Z, .99, na.rm = T)
  kwantyl_95<-quantile(probka$Z, .95, na.rm= T)
  strata_cetop$var_99_250_EWMA[250+i] <- kwantyl_99
  strata_cetop$var_95_250_EWMA[250+i] <- kwantyl_95
  probka2 <- probka %>% filter(Z > kwantyl_99)
  w_99 = mean(probka2$Z)
  strata_cetop$es_99_250_EWMA[250+i] <- w_99
  probka3 <- probka %>% filter(Z > kwantyl_95)
  w_95 = mean(probka3$Z)
  strata_cetop$es_95_250_EWMA[250+i] <- w_95
}







