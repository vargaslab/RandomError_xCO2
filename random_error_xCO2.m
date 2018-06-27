% Alejandro Cueva
% Centro de Investigación Científica y de Educación Superior de Ensenada (CICESE)
% 25/Feb/2016
% Version: 1.0

% Contact email: 
% Janet J. Reimer: janetr[at]udel[dot]edu
% Alejandro Cueva: acueva[at]cicese[dot]edu[dot]mx, alexcueva88[at]gmail[dot]com
% Rodrigo Vargas : rvargas[at]udel[dot]edu

% Description:
% This code is used to estimate random erros in  measurements of marine xCO2 using the
% paired observation approach (Reimer et al. 2016).

%Please cite this manuscript when using this code
% Reimer, J.J., Cueva, A., Gaxiola-Castro, G., Lara-Lara, R. and Vargas, R., 2016. 
%Random error analysis of marine xCO2 measurements in a coastal upwelling region. Progress in Oceanography, 143, pp.1-12.

%% Loading data
%Water density, wind speed, sea surface temperature [sst]
%You should have six vectors, 
% 1)Vector of daily means of water density (e.g., 1*365)
% 2)Vector of daily standard deviation of water density (e.g., 1*365)
% 3)Vector of daily means of wind speed (e.g., 1*365)
% 4)Vector of daily standard deviation of wind speed (e.g., 1*365)
% 5)Vector of daily means of sea surface temperature (e.g., 1*365)
% 6)Vector of daily standard deviation of sea surface temperature (e.g., 1*365)
% 7)Matrix of hourly/half-hourly data of marine xCO2 sorted by hours/half-hours
% (rows) by days (columns) (e.g., 24*365); (24 hours for 365 days)


%Define variables:
wd=  mydata(1,:); %Loading water density data
ws=  mydata(2,:); %Loading wind speed data
sst= mydata(3,:); %Loading sea surface temperature data
xCO2=mydata(4,:); %Loading marine xCO2 data

wd_column=reshape(wd,24,365); %Creating a matrix of (24*365) of water density data
ws_column=reshape(ws,24,365); %Creating a matrix of (24*365) of wind speed data
sst_column=reshape(sst,24,365); %Creating a matrix of (24*365) of sea surface temperature data
xCO2_column=reshape(xCO2,24,365); %Creating a matrix of (24*365) of marine xCO2 data

wd_daily_mean=nanmean(wd_column); %Estimating daily averages, there are other ways to do this (e.g., grpstats)
wd_daily_std=nanstd(wd_column); %Estimating daily standard deviations, there are other ways to do this (e.g., grpstats)

ws_daily_mean=nanmean(ws_column); %Estimating daily averages, there are other ways to do this (e.g., grpstats)
ws_daily_std=nanstd(ws_column); %Estimating daily standard deviations, there are other ways to do this (e.g., grpstats)

sst_daily_mean=nanmean(sst_column); %Estimating daily averages, there are other ways to do this (e.g., grpstats)
sst_daily_std=nanstd(sst_column); %Estimating daily standard deviations, there are other ways to do this (e.g., grpstats)

%% Ranges to define similar conditions (e.g, mean+-2std)
%the threshold of ± 2 standard deviations cand be modified by the user


wd_sup=wd_daily_mean+(2*wd_daily_std); %Upper limit of the threshold (mean+2std)
wd_inf=wd_daily_mean-(2*wd_daily_std); %lower limit of the threshold (mean-2std)

ws_sup=ws_daily_mean+(2*ws_daily_std); %Upper limit of the threshold (mean+2std)
ws_inf=ws_daily_mean-(2*ws_daily_std); %lower limit of the threshold (mean-2std)

sst_sup=sst_daily_mean+(2*sst_daily_std); %Upper limit of the threshold (mean+2std)
sst_inf=sst_daily_mean-(2*sst_daily_std); %lower limit of the threshold (mean-2std)

%% Establishing similar days
%% By water density
% el = established limits
i=1:1:length(wd_daily_mean)-1; %Counter. The "-1" is because, in the next step, 
%                                 the algorithm will look at the mean value of 
%                                 the second day to make sure that it is  within the upper and 
%                                 lower limits of the first day,then, when
%                                 the counter arrives at the last number in the count (for example, 
%                                 you have a 1x365 vector, then
%                                 i=[1,...,364], thus the last number is
%                                 364) in the next step is specified
%                                 i+1(=365). In this way, if the "-1" is
%                                 not specified the program will look for a 366 scalar than does not exist. 
%                                 

limits_wd=(wd_daily_mean(i+1)<wd_sup(i)) & (wd_daily_mean(i+1)>wd_inf(i)); 
% Logical line. This creates a logical or Boolean vector (1,0).
% wd_daily_mean(i+1)<wd_sup(i) looks at the mean value
% of the second day (i+1) is less than the upper limit of the first day (i).
% wd_daily_mean(i+1)>wd_inf(i) looks at the mean value
% of the second day (i+1) is more than the lower limit of the first day (i)

%% By wind speed
% el = establised limits
i=1:1:length(ws_daily_mean)-1; %Counter. The "-1" is because, in the next step, 
%                                 the algorithm will look at the mean value of 
%                                 the second day to make sure that it is within the upper and 
%                                 lower limits of the first day,then, when
%                                 the counter arrives at the last number in the count (for example, 
%                                 you have a 1x365 vector, then
%                                 i=[1,...,364], thus the last number is
%                                 364) in the next step is specified
%                                 i+1(=365). In this way, if the "-1" is
%                                 not specified the program will look for a 366 scalar than does not exist. 
%                                 

limits_ws=(ws_daily_mean(i+1)<ws_sup(i)) & (ws_daily_mean(i+1)>ws_inf(i)); 
% Logical line. This creates a logical or Boolean vector (1,0).
% ws_daily_mean(i+1)<ws_sup(i) looks at the mean value
% of the second day (i+1) is less than the upper limit of the first day (i).
% ws_daily_mean(i+1)>ws_inf(i) looks at the mean value
% of the second day (i+1) is more than the lower limit of the first day (i)

%% By Sea Surface Temperature
% el = establised limits
i=1:1:length(sst_daily_mean)-1; %Counter. The "-1" is because, in the next step, 
%                                 the algorithm will look at the mean value of 
%                                 the second day to make sure that it is within the upper and 
%                                 lower limits of the first day,then, when
%                                 the counter arrives to the last number in the count (for example, 
%                                 you have a 1x365 vector, then
%                                 i=[1,...,364], thus the last number is
%                                 364) in the next step is specified
%                                 i+1(=365). In this way, if the "-1" is
%                                 not specified the program will look for a 366 scalar than does not exist. 
%                                 

limits_sst=(sst_daily_mean(i+1)<sst_sup(i)) & (sst_daily_mean(i+1)>sst_inf(i)); 
% Logical line. This creates a logical or Boolean vector (1,0).
% sst_daily_mean(i+1)<sst_sup(i) looks at the mean value
% of the second day (i+1) is less than the upper limit of the first day (i).
% sst_daily_mean(i+1)>sst_inf(i) looks at the mean value
% of the second day (i+1) is more than the lower limit of the first dy (i)
%%
% To discard days that are not similar it does not matter the order of the
% following analysis


% considered as not similar days

xCO2_simday_sst=xCO2_column(:,limits_sst); 
% Here "xCO2_column" is a matrix of e.g. [24*365] and "limits_sst" is a Boolean
% vector of 1*365
xCO2_simday_sst_wd=xCO2_simday_sst(:,limits_wd);
% Here we substituted "xCO2_column" for "xCO2_simday_sst" that is a matrix of e.g. 
%[24*365], butnote that some columns 
%should be NaN's since in the previous step we say that those columns were
%not "similar days" for SST, and "limits_wd" is a Boolean vector of 1*365
xCO2_simday_sst_wd_ws=xCO2_simday_sst_wd(:,limits_ws);
% Here we substituted "xCO2_simday_sst" for "xCO2_simday_sst_wd" that is a matrix of e.g. 
%[24*365], butnote that some columns 
%should be as NaN's since in the previous step we say that those columns were
%not "similar days" for SST and WD, and "limits_ws" is a Boolean vector of 1*365
xCO2_simday_sst_wd_ws=xCO2_simday_sst_wd_ws(:); 
% Just a reshape from matrix to vector



%% Estimating errors

xCO2_error=(xCO2_simday_sst_wd_ws(1:1:length(xCO2_simday_sst_wd_ws)-24)-xCO2_simday_sst_wd_ws(25:1:length(xCO2_simday_sst_wd_ws)))/sqrt(2); 
%In this line you are estimating the random error using the
%paired-observation approach. You are using the vector that only meets the
%criteria of "similar days". 
%You are using a vector (xCO2_simday_sst_wd_ws) of length [1,...,N-24] and then you are 
%substracting the same vector only 24 hour apart [25,...,N]. At every 
%substraction of X1-X2 you are dividing it by sqrt of 2 (so that [X1-X2/sqrt(2)])  







