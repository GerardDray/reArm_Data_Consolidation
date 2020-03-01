% ======================================================================
% ReArm project
% Data Consolidation
% Data Integration
% Data Synchronisation
%
% G. Dray 2020/03/01
% ======================================================================
clear all;
close all;
clc;

% ======================================================================
addpath('C:\Users\Gerard\OneDrive\MATLAB\Toolboxes\xdf-Matlab-master');

nameFileC = ['../dta/xdf/' '002_BouCyr_1_20201402_c.xdf'];
streams = load_xdf(nameFileC, 'HandleJitterRemoval', true);
% nameFileR = ['../dta/xdf/' '002_BouCyr_1_20201402_r.xdf'];
% streams = load_xdf(nameFileR, 'HandleJitterRemoval', true);

% ======================================================================
% Initialisation
timeGlobal = [];
dataGlobal = [];
markGlobal = [];
labelDataGlobal = [];
labelMarkGlobal = [];

%% ======================================================================
% Search and concatenate timestamp vectors
for iStreams = 1 : size(streams,2)
    timeGlobal = [timeGlobal ; streams{1,iStreams}.time_stamps'];
end
timeGlobal = unique(timeGlobal);

%% ======================================================================
% Search and concatenate data
% NIC-Data-EEG (New)
% NIC-EEG (Old)
fieldName1 = 'NIC-EEG';
fieldName2 = '';
fieldName3 = 'NIC_EEG';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
dataTmp1 = streams{1,indiceFound}.time_series';
dataTmp2 = NaN(size(timeGlobal,1),size(dataTmp1,2));
indice2Match = ismember(timeGlobal,timeTmp1);
indice2Match = find(indice2Match);
dataTmp2(indice2Match,:) = dataTmp1;
dataGlobal = [dataGlobal dataTmp2];
labelTmp = cell(1,size(dataTmp1,2));
for iLabel = 1 : size(dataTmp1,2)
    labelTmp{1,iLabel} = [fieldName3 '_Data_' num2str(iLabel,'%02.0f')];
end
labelDataGlobal = [labelDataGlobal , labelTmp];

%% ======================================================================
% Search and concatenate markers
% NIC-Markers(New)
% NIC-Markers (Old)
fieldName1 = 'NIC-Markers';
fieldName2 = '';
fieldName3 = 'NIC';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
markTmp1 = streams{1,indiceFound}.time_series';
% Search for equal timestamp
[timeTmp2, ia, ic] = unique(timeTmp1);
markTmp2 = cell(size(timeTmp2,1),1);
for iTime = 1 : size(ic,1)
   iEqual = find(iTime == ic);
   nbEqual = size(iEqual,1);
   for ie = 1 : nbEqual
       markTmp2(iTime,ie) = num2cell(markTmp1(iEqual(ie),1));
   end
end
markTmp3 = cell(size(timeGlobal,1),size(markTmp2,2));
indice2Match = ismember(timeGlobal,timeTmp2);
indice2Match = find(indice2Match);
markTmp3(indice2Match,:) = markTmp2;
markGlobal = [markGlobal markTmp3];
labelTmp = cell(1,size(markTmp3,2));
for iLabel = 1 : size(markTmp3,2)
    labelTmp{1,iLabel} = [fieldName3 '_Mark_' num2str(iLabel,'%02.0f')]; 
end
labelMarkGlobal = [labelMarkGlobal , labelTmp];


%% ======================================================================
% Search and concatenate data
% Mouse-Data (New)
% Mouse Mocap(Old)
fieldName1 = 'Mouse';
fieldName2 = 'MoCap';
fieldName3 = 'Mouse';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1) ...
        && strcmp(streams{1,iStreams}.info.type,fieldName2)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
dataTmp1 = streams{1,indiceFound}.time_series';
dataTmp2 = NaN(size(timeGlobal,1),size(dataTmp1,2));
indice2Match = ismember(timeGlobal,timeTmp1);
indice2Match = find(indice2Match);
dataTmp2(indice2Match,:) = dataTmp1;
dataGlobal = [dataGlobal dataTmp2];
labelTmp = cell(1,size(dataTmp1,2));
for iLabel = 1 : size(dataTmp1,2)
    labelTmp{1,iLabel} = [fieldName3 '_Data_' num2str(iLabel,'%02.0f')];
end
labelDataGlobal = [labelDataGlobal , labelTmp];

%% ======================================================================
% Search and concatenate markers
% Mouse-Markers (New)
% Mouse Markers(Old)
fieldName1 = 'Mouse';
fieldName2 = 'Markers';
fieldName3 = 'Mouse';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1) ...
        && strcmp(streams{1,iStreams}.info.type,fieldName2)
    indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
markTmp1 = streams{1,indiceFound}.time_series';
% Search for equal timestamp
[timeTmp2, ia, ic] = unique(timeTmp1);
markTmp2 = cell(size(timeTmp2,1),1);
for iTime = 1 : size(ic,1)
   iEqual = find(iTime == ic);
   nbEqual = size(iEqual,1);
   for ie = 1 : nbEqual
       markTmp2(iTime,ie) = num2cell(markTmp1(iEqual(ie),1));
   end
end
markTmp3 = cell(size(timeGlobal,1),size(markTmp2,2));
indice2Match = ismember(timeGlobal,timeTmp2);
indice2Match = find(indice2Match);
markTmp3(indice2Match,:) = markTmp2;
markGlobal = [markGlobal markTmp3];
labelTmp = cell(1,size(markTmp3,2));
for iLabel = 1 : size(markTmp3,2)
    labelTmp{1,iLabel} = [fieldName3 '_Mark_' num2str(iLabel,'%02.0f')]; 
end
labelMarkGlobal = [labelMarkGlobal , labelTmp];

%% ======================================================================
% Search and concatenate data
% NIC-Data-Accelerometer (New)
% NIC-Accelerometer (Old)
fieldName1 = 'NIC-Accelerometer';
fieldName2 = '';
fieldName3 = 'NIC_Accelerometer';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
dataTmp1 = streams{1,indiceFound}.time_series';
dataTmp2 = NaN(size(timeGlobal,1),size(dataTmp1,2));
indice2Match = ismember(timeGlobal,timeTmp1);
indice2Match = find(indice2Match);
dataTmp2(indice2Match,:) = dataTmp1;
dataGlobal = [dataGlobal dataTmp2];
labelTmp = cell(1,size(dataTmp1,2));
for iLabel = 1 : size(dataTmp1,2)
    labelTmp{1,iLabel} = [fieldName3 '_Data_' num2str(iLabel,'%02.0f')];
end
labelDataGlobal = [labelDataGlobal , labelTmp];

%% ======================================================================
% Search and concatenate data
% NIC-Data-Quality (New)
% NIC-Quality (Old)
fieldName1 = 'NIC-Quality';
fieldName2 = '';
fieldName3 = 'NIC_Quality';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
dataTmp1 = streams{1,indiceFound}.time_series';
dataTmp2 = NaN(size(timeGlobal,1),size(dataTmp1,2));
indice2Match = ismember(timeGlobal,timeTmp1);
indice2Match = find(indice2Match);
dataTmp2(indice2Match,:) = dataTmp1;
dataGlobal = [dataGlobal dataTmp2];
labelTmp = cell(1,size(dataTmp1,2));
for iLabel = 1 : size(dataTmp1,2)
    labelTmp{1,iLabel} = [fieldName3 '_Data_' num2str(iLabel,'%02.0f')];
end
labelDataGlobal = [labelDataGlobal , labelTmp];

%% ======================================================================
% Search and concatenate data
% Oxysoft-Data (New)
% Oxysoft (Old)
fieldName1 = 'Oxysoft';
fieldName2 = '';
fieldName3 = 'Oxysoft';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
dataTmp1 = streams{1,indiceFound}.time_series';
dataTmp2 = NaN(size(timeGlobal,1),size(dataTmp1,2));
indice2Match = ismember(timeGlobal,timeTmp1);
indice2Match = find(indice2Match);
dataTmp2(indice2Match,:) = dataTmp1;
dataGlobal = [dataGlobal dataTmp2];
labelTmp = cell(1,size(dataTmp1,2));
for iLabel = 1 : size(dataTmp1,2)
    labelTmp{1,iLabel} = [fieldName3 '_Data_' num2str(iLabel,'%02.0f')];
end
labelDataGlobal = [labelDataGlobal , labelTmp];

%% ======================================================================
% Search and concatenate markers
% Oxysoft-Markers(New)
% Oxysoft Event (Old)
fieldName1 = 'Oxysoft Event';
fieldName2 = '';
fieldName3 = 'Oxysoft';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
markTmp1 = streams{1,indiceFound}.time_series';
% Search for equal timestamp
[timeTmp2, ia, ic] = unique(timeTmp1);
markTmp2 = cell(size(timeTmp2,1),1);
for iTime = 1 : size(ic,1)
    iEqual = find(iTime == ic);
    nbEqual = size(iEqual,1);
    for ie = 1 : nbEqual
        markTmp2(iTime,ie) = num2cell(markTmp1(iEqual(ie),1));
    end
end
markTmp3 = cell(size(timeGlobal,1),size(markTmp2,2));
indice2Match = ismember(timeGlobal,timeTmp2);
indice2Match = find(indice2Match);
markTmp3(indice2Match,:) = markTmp2;
markGlobal = [markGlobal markTmp3];
labelTmp = cell(1,size(markTmp3,2));
for iLabel = 1 : size(markTmp3,2)
    labelTmp{1,iLabel} = [fieldName3 '_Mark_' num2str(iLabel,'%02.0f')]; 
end
labelMarkGlobal = [labelMarkGlobal , labelTmp];

%% ======================================================================
% Search and concatenate data
% Kinect-Data (New)
% Kinect-LSL-Data (Old)
fieldName1 = 'Kinect-LSL-Data';
fieldName2 = '';
fieldName3 = 'Kinect';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
dataTmp1 = streams{1,indiceFound}.time_series';
dataTmp2 = NaN(size(timeGlobal,1),size(dataTmp1,2));
indice2Match = ismember(timeGlobal,timeTmp1);
indice2Match = find(indice2Match);
dataTmp2(indice2Match,:) = dataTmp1;
dataGlobal = [dataGlobal dataTmp2];
labelTmp = cell(1,size(dataTmp1,2));
for iLabel = 1 : size(dataTmp1,2)
    labelTmp{1,iLabel} = [fieldName3 '_Data_' num2str(iLabel,'%02.0f')];
end
labelDataGlobal = [labelDataGlobal , labelTmp];

%% ======================================================================
% Search and concatenate markers
% Kinect-Markers(New)
% Kinect-LSL-Markers (Old)
fieldName1 = 'Kinect-LSL-Markers';
fieldName2 = '';
fieldName3 = 'Kinect';
for iStreams = 1 : size(streams,2)
    if strcmp(streams{1,iStreams}.info.name,fieldName1)
        indiceFound = iStreams;
    end
end
timeTmp1 = streams{1,indiceFound}.time_stamps';
markTmp1 = streams{1,indiceFound}.time_series';
% Search for equal timestamp
[timeTmp2, ia, ic] = unique(timeTmp1);
markTmp2 = cell(size(timeTmp2,1),1);
for iTime = 1 : size(ic,1)
    iEqual = find(iTime == ic);
    nbEqual = size(iEqual,1);
    for ie = 1 : nbEqual
        markTmp2(iTime,ie) = num2cell(markTmp1(iEqual(ie),1));
    end
end
markTmp3 = cell(size(timeGlobal,1),size(markTmp2,2));
indice2Match = ismember(timeGlobal,timeTmp2);
indice2Match = find(indice2Match);
markTmp3(indice2Match,:) = markTmp2;
markGlobal = [markGlobal markTmp3];
labelTmp = cell(1,size(markTmp3,2));
for iLabel = 1 : size(markTmp3,2)
    labelTmp{1,iLabel} = [fieldName3 '_Mark_' num2str(iLabel,'%02.0f')]; 
end
labelMarkGlobal = [labelMarkGlobal , labelTmp];


% ======================================================================
% Table creation
tableGlobal = [array2table(timeGlobal,'VariableNames',{'Time'})...
    array2table(dataGlobal,'VariableNames',labelDataGlobal)...
    array2table(markGlobal,'VariableNames',labelMarkGlobal)];

