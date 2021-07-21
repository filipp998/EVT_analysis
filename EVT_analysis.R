library(evir)
library(quantmod)
library(ineq)
library(stringr)
library(poweRlaw)
library(FinTS)
library(ggplot2)
tech<-getSymbols(c('AAPL','GOOGL','AMZN','TSLA','MSFT'),src="yahoo", from="2007-01-01")
dates<-index(AAPL)
aapl<-as.data.frame(AAPL)
aapl<-cbind(date=dates,aapl)
rownames(aapl)<-NULL
head(aapl)
dim(aapl)
returns_a<-Delt(aapl$AAPL.Adjusted,type = 'log')
returns_a<-na.omit(returns_a)
losses_a=-returns_a[returns_a<0]
acf(returns_a)
pacf(returns_a)
qqnorm(returns)
qqline(returns,col='steelblue')

summary(losses_a)
evir::qplot(losses_a) #convex => no signal for heavy tail
emplot(losses_a,'xy',col='blue') #non-linear => no signal for power law
meplot(losses_a,col='red') #downward trend, linear on the first part
CP_plot(losses_a)
MSplot(losses_a)
hill(losses_a)

gpd(losses_a,0.04)$par.ests
gpd(losses_a,0.04)$par.ses


unlist(losses_a)
head(losses_a)

#fitting continuous power law
a_pl<- conpl$new(losses_a) 
est_a<-estimate_xmin(a_pl)
a_pl$setXmin(est_a)

#fitting continuous log-normal
a_ln=conlnorm$new(losses_a)
est2_a<-estimate_xmin(a_ln)
a_ln$setXmin(est2_a)
#plotting
plot(a_pl,ylab='1-CDF')
lines(a_pl,col=4)
lines(a_ln,col=2)
title('Power law and lognormal fitted to Apple losses')
legend('bottomleft',legend=c('Power law','Lognormal'),pch=15,col = c('blue','red'))

a_pl$pars
a_ln$pars
bs_a=bootstrap(a_ln,no_of_sims=100)
bs_a$gof
bs_ap=bootstrap_p(a_pl,no_of_sims = 1000,threads = 4)
bs_ap

length(losses_a)
loss_a_tail=losses_a[losses_a>quantile(losses_a,0.95)]
loss_a_bulk=losses_a[losses_a<=quantile(losses_a,0.95)]
length(loss_a_tail)
length(loss_a_bulk)

a_pl_t=conpl$new(loss_a_tail)
est_a_t<-estimate_xmin(a_pl_t)
a_pl_t$setXmin(est_a_t)
a_pl_b=conpl$new(loss_a_bulk)
est_a_bp<-estimate_xmin(a_pl_b)
a_pl_b$setXmin(est_a_bp)

bs_apt=bootstrap_p(a_pl_t,no_of_sims = 1000,threads = 4)
bs_apt #cannot rule out power law

bs_apb=bootstrap_p(a_pl_b,no_of_sims = 500,threads = 4)
bs_apb

a_ln_b=conlnorm$new(loss_a_bulk)
est_a_b=estimate_xmin(a_ln_b)
a_ln_b$setXmin(est_a_b)

plot(a_ln_b,ylab='1-CDF')
lines(a_ln_b,col=2)
title('Loognormal fitted to the bulk of Apple losses')

plot(a_pl_t,ylab='1-CDF')
lines(a_pl_t,col=4)
title('Power law fitted to the tail of Apple losses')

a_pl_t$pars
a_ln_b$pars

hill(loss_a_tail)

evir::qplot(loss_a_tail)
meplot(loss_a_tail)
MSplot(loss_a_tail)

fit_tail=gpd(loss_a_tail,0.045)
gpd(loss_a_tail,0.048)$par.ests[1]
gpd(loss_a_tail,0.048)$par.ses[1]


old.par <- par(mar = c(0, 0, 0, 0))
par(old.par)

