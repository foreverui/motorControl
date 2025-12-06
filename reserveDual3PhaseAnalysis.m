clc
clear
close all

cycleTime = 1/100;
resampleTime = 1e-7;


load('P3Phase.mat')
pTab = ScopeData;

load('N3Phase.mat')
nTab = ScopeData;

clear ScopeData

%% data idx

tEnd = 0.1;
tStart = tEnd - cycleTime;
pIdx = pTab.time>=tStart & pTab.time<=tEnd;
nIdx = nTab.time>=tStart & nTab.time<=tEnd;

newtime = tStart:resampleTime:tEnd;

%% rotor position
pRtr = interp1(pTab.time, squeeze(pTab.signals(7).values),newtime);
nRtr = interp1(nTab.time, squeeze(nTab.signals(7).values),newtime);


%% plot 3 phase current

figure(1)
set(gcf,'Position',[2600 100 1600 1200])
subplot(3,1,1)
plot(pTab.time(pIdx),pTab.signals(3).values(pIdx,:),'LineWidth',3)
hold on
plot(nTab.time(nIdx),nTab.signals(3).values(nIdx,:),'LineWidth',3)
legend('Ia_p','Ib_p','Ib_p','Ia_n','Ib_n','Ic_n')
pfig('Time','Current','Dual 3 Phase Current ')

subplot(3,1,2)
plot(pTab.time(pIdx),pTab.signals(1).values(pIdx,2),'LineWidth',2)
hold on
plot(nTab.time(nIdx),nTab.signals(1).values(nIdx,2),'LineWidth',2)
legend('Idc_p','Idc_n')
pfig('Time','Current','DC Current')

subplot(3,1,3)
plot(newtime,pRtr,'LineWidth',2)
hold on
plot(newtime,nRtr,'LineWidth',2)
plot(newtime,pRtr - nRtr,'LineWidth',2)
legend('rtrTheta_p','rtrTheta_n','p-n')
pfig('Time','Deg','Rotor ANgle')










