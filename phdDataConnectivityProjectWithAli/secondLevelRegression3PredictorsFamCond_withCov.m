function secondLevelRegression3PredictorsFamCond_withCov(isCovariate,memType)
% List of open inputs
% Factorial design specification: Directory - cfg_files
% Factorial design specification: Scans - cfg_files
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Factorial design specification: Vector - cfg_entry
% Factorial design specification: Name - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
% Contrast Manager: Name - cfg_entry
% Contrast Manager: T contrast vector - cfg_entry
contrastNum = 13;
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
nrun = 1; % enter the number of runs here
subjDir=dir([rootDir,'s0*.*']);
jobfile = {[rootDir,'matlabFunctions\secondLevelRegressionAnalysis_job.m']};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(18, nrun);
load([rootDir,'matlabFunctions\performanceDataConcatenated.mat']);
% faceFam_NFam = faceMem.totalFam - faceMem.totalNFam;
% houseFam_NFam = houseMem.totalFam - houseMem.totalNFam;
% pairFam_NFam = pairMem.avgFam - pairMem.avgNFam;

faceFam = faceMem.totalFam;
houseFam = houseMem.totalFam;
pairFam = pairMem.avgFam;

if nargin==2 && memType == 1 % 1, precise memory, using recollection face, hous and intact pair memory
faceFam = faceMem.firstRecFam;
houseFam = houseMem.firstRecFam;
pairFam = pairMem.intactFam;
end

if isCovariate ==1
faceFam = covariMemData(faceFam);
houseFam = covariMemData(houseFam);
pairFam = covariMemData(pairFam);
end

[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
gender  = subjInfo(:,3);


for crun = 1:nrun
    inputs{1, crun} = {[rootDir,'secondLevelReg\multiReg\Fam']};% Factorial design specification: Directory - cfg_files
    if ~exist([rootDir,'secondLevelReg\multiReg\Fam'],'dir')
        mkdir([rootDir,'secondLevelReg\multiReg\Fam']);
    end
        for n = 1:length(subjDir)
        inputs{2, crun}(n) = {[rootDir,subjDir(n).name,'\encoding\analysis\con_',sprintf('%04d',contrastNum),'.img']};
        % Factorial design specification: Scans - cfg_files
    end
    inputs{3, crun} = faceFam; % Factorial design specification: Vector - cfg_entry
    inputs{4, crun} = 'faceFam'; % Factorial design specification: Name - cfg_entry
    inputs{5, crun} = houseFam; % Factorial design specification: Vector - cfg_entry
    inputs{6, crun} = 'houseFam'; % Factorial design specification: Name - cfg_entry
    inputs{7, crun} = pairFam; % Factorial design specification: Vector - cfg_entry
    inputs{8, crun} = 'pairFam'; % Factorial design specification: Name - cfg_entry
    inputs{9, crun} = subjInfo(:,2); % Factorial design specification: Vector - cfg_entry
    inputs{10, crun} = 'age'; % Factorial design specification: Name - cfg_entry
    inputs{11, crun} = fameOrder; % Factorial design specification: Vector - cfg_entry
    inputs{12, crun} = 'fameOrder'; % Factorial design specification: Name - cfg_entry
    inputs{13, crun} = 'faceFam'; % Contrast Manager: Name - cfg_entry
    inputs{14, crun} = [0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{15, crun} = 'houseFam'; % Contrast Manager: Name - cfg_entry
    inputs{16, crun} = [0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
    inputs{17, crun} = 'pairFam'; % Contrast Manager: Name - cfg_entry
    inputs{18, crun} = [0 0 0 0 1]; % Contrast Manager: T contrast vector - cfg_entry
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});


function memData = covariMemData(memData)
rootDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\';
[subjInfo a]=xlsread([rootDir,'matlabFunctions\picpairSubjInfo.xlsx']);
fameOrder = zeros(size(subjInfo,1),1);
fameOrder(1:2:end,1) = 1;
age = subjInfo(:,2);
gender  = subjInfo(:,3);
[a b memData]=regress(memData,[ones(size(subjInfo,1),1),...
    fameOrder]);