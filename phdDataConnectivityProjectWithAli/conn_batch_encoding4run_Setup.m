function conn_batch_encoding4run_Setup
% example batch process for experiment SETUP. Edit the fields below
% This example defines the information for the attention dataset (http://www.fil.ion.ucl.ac.uk/spm/data/attention/)  
% Information defined here includes: acquisition TR, number of subjects,
% number of sessions per subject, location of functional and anatomical
% volumes, location of ROI files, location of realignment parameters, and 
% definition of a single condition encompassing the entire session

%% BATCH INFORMATION (edit this section)
nsubj = 20;
rootfolder='G:\myStudy\picpairfMRI\encoding4run';
if ~exist(rootfolder,'dir')
    mkdir(rootfolder);
end
batch.filename=...                   % conn_* project file to be created/modified
    fullfile(rootfolder,'encoding4run.mat');

nsessions = 4;
nconditions = 4;
NSUBJECTS=nsubj;
%% EXPERIMENT INFORMATION (edit this section)
batch.Setup.isnew=1;                 % 0: modifies existing project; 1: creates new proejct
batch.Setup.RT=2;                 % TR (in seconds)
batch.Setup.nsubjects=nsubj;             % number of subjects

% functional data files (cell array per subject and sessions): batch.Setup.functionals{nsub}{nses} is an array listing the (smoothed/normalized/realigned) functional file(s) for subject "nsub" and session "nses"
projDirG = 'D:\myStudy\picpairfMRI';
for i = 1: nsubj
funDir = [projDirG,'\s',sprintf('%03d',i),'\encoding\taskRunsConcatenate\'];
funfiles = dir([funDir,'*.img']);
batch.Setup.functionals{i}{1}= [repmat(funDir,[287,1]),strvcat(funfiles(1:287).name)];
batch.Setup.functionals{i}{2}= [repmat(funDir,[287,1]),strvcat(funfiles(287*1+1:287*2).name)];
batch.Setup.functionals{i}{3}= [repmat(funDir,[287,1]),strvcat(funfiles(287*2+1:287*3).name)];
batch.Setup.functionals{i}{4}= [repmat(funDir,[287,1]),strvcat(funfiles(287*3+1:287*4).name)];
end


% anatomical volumes (cell array per subject): batch.Setup.structurals{nsub} is an array pointing to the (normalized) anatomical volume for subject "nsub"
% structural image folder
projDirC='D:\myStudy\picpairfMRI';
for i = 1: nsubj
batch.Setup.structurals{i}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wvol_0001.img');
batch.Setup.masks.Grey{i}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wc1vol_0001.img');
batch.Setup.masks.White{i}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wc2vol_0001.img');
batch.Setup.masks.CSF{i}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wc3vol_0001.img');
end

roiDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysis\picEffect_Pic-Scramble\';
faceRoiDir='C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysisLocalizer\face-house\';
houseRoiDir = 'C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\secondLevelAnalysisLocalizer\house-face-object\';
% roi files (cell array per roi): batch.Setup.rois{nroi} is a string pointing to a (normalized) ROI file (if not specified all .nii & .img & .tal files in the conn/roi folder will be interpreted as ROI files)
batch.Setup.rois.names = {'AAL','L_HPC','R_HPC','L_aHC','R_aHC','L_mHC','R_mHC',...
    'L_pHC','R_pHC','L_preCun','R_preCun','L_TMP','R_TMP','L_vmP','R_vmP',...
    'L_FFA','R_FFA','L_PPA','R_PPA'};
batch.Setup.rois ={fullfile(fileparts(which('conn')),'utils','otherrois','AAL.nii'),...
    [roiDir,'L_HPC.img'],[roiDir,'R_HPC.img'],...
    [roiDir,'L_aHC.img'],[roiDir,'R_aHC.img'],...
    [roiDir,'L_mHC.img'],[roiDir,'R_mHC.img'],...
    [roiDir,'L_pHC.img'],[roiDir,'R_pHC.img'],...
    [roiDir,'L_preCun.img'],[roiDir,'R_preCun.img'],...
    [roiDir,'L_TMP.img'],[roiDir,'R_TMP.img'],...
    [roiDir,'L_vmP.img'],[roiDir,'R_vmP.img']...
    [faceRoiDir,'L_FFA.img'],[faceRoiDir,'R_FFA.img']...
    [houseRoiDir,'L_PPA.img'],[houseRoiDir,'R_PPA.img']};
% for i = 1:nsubj
% batch.Setup.rois.files{1}{i} ={fullfile(fileparts(which('conn')),'utils','otherrois','AAL.nii')};
% batch.Setup.rois.files{2}{i} ={[roiDir,'L_HPC.img']};
% batch.Setup.rois.files{3}{i} ={[roiDir,'R_HPC.img']};
% batch.Setup.rois.files{4}{i} ={[roiDir,'L_aHC.img']};
% batch.Setup.rois.files{5}{i} ={[roiDir,'R_aHC.img']};
% batch.Setup.rois.files{6}{i} ={[roiDir,'L_mHC.img']};
% batch.Setup.rois.files{7}{i} ={[roiDir,'R_mHC.img']};
% batch.Setup.rois.files{8}{i} ={[roiDir,'L_pHC.img']};
% batch.Setup.rois.files{9}{i} ={[roiDir,'R_pHC.img']};
% batch.Setup.rois.files{10}{i} ={[roiDir,'L_preCun.img']};
% batch.Setup.rois.files{11}{i} ={[roiDir,'R_preCun.img']};
% batch.Setup.rois.files{12}{i} ={[roiDir,'L_TMP.img']};
% batch.Setup.rois.files{13}{i} ={[roiDir,'R_TMP.img']};
% batch.Setup.rois.files{14}{i} ={[roiDir,'L_vmP.img']};
% batch.Setup.rois.files{15}{i} ={[roiDir,'R_vmP.img']};
% batch.Setup.rois.files{16}{i} ={[faceRoiDir,'L_FFA.img']};
% batch.Setup.rois.files{17}{i} ={[faceRoiDir,'R_FFA.img']};
% batch.Setup.rois.files{18}{i} ={[houseRoiDir,'L_PPA.img']};
% batch.Setup.rois.files{19}{i} ={[houseRoiDir,'R_PPA.img']};
% end

BATCH.Setup.rois.dimensions={1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
% condition names: cell array of strings (one per condition)
batch.Setup.conditions.names={'fam1';'fam2';'nonfam1';'nonfam2'};

for ncond=1:nconditions,for nsub=1:NSUBJECTS,for nses=1:nsessions,  batch.Setup.conditions.onsets{ncond}{nsub}{nses}=[];batch.Setup.conditions.durations{ncond}{nsub}{nses}=[]; end;end;end
for ncond=1:nconditions,for nsub=1:NSUBJECTS,for nses=ncond,        batch.Setup.conditions.onsets{ncond}{nsub}{nses}=0; batch.Setup.conditions.durations{ncond}{nsub}{nses}=inf;end;end;end

% names of temporal (first-level) covariates
 batch.Setup.covariates.names={'motion'};      
% % cell array of strings (one per covariate and subject and condition): batch.Setup.covariates.files{ncovariate}{nsub}{nses} is an array pointing the a file defining the covariate "ncoviarate" for subject "nsub" and sessions "nses" (note: valid files are .txt or .mat files and should contain as many rows as scans for each given subject/session)
% X=kron(eye(4),ones(90,1));save(fullfile(rootfolder,'sessions.mat'),'X');
for i = 1:nsubj

batch.Setup.covariates.files{1}{i}{1}=fullfile(projDirC,['s',sprintf('%03d',i)],'\encoding\taskRunsConcatenate',...
    'motionParameter-287-1.txt');
   
batch.Setup.covariates.files{1}{i}{2}=fullfile(projDirC,['s',sprintf('%03d',i)],'\encoding\taskRunsConcatenate',...
    'motionParameter-287-2.txt');
                    
batch.Setup.covariates.files{1}{i}{3}=fullfile(projDirC,['s',sprintf('%03d',i)],'\encoding\taskRunsConcatenate',...
    'motionParameter-287-3.txt');
                    
                   
batch.Setup.covariates.files{1}{i}{4}=fullfile(projDirC,['s',sprintf('%03d',i)],'\encoding\taskRunsConcatenate',...
    'motionParameter-287-4.txt');
end

% names of temporal (second-level) covariates
batch.Setup.subjects.effect_names={'subjFamFirst','subjNonfamFirst','subjFamNfamContr',...
                                'famFaceRecM','famFaceTotalM',...
                              'famHouseRecM','famHouseTotalM',...
                              'famPairIntactM','famPairtotalM',...
                              'nonfamFaceRecM','nonfamFaceTotalM',...
                              'nonfamHouseRecM','nonfamHouseTotalM',...
                              'nonfamPairIntactM','nonfamPairtotalM','fam-nfamPairIntact'};      
% cell array of strings (one per covariate and subject and condition): batch.Setup.covariates.files{ncovariate}{nsub}{nses} is an array pointing the a file defining the covariate "ncoviarate" for subject "nsub" and sessions "nses" (note: valid files are .txt or .mat files and should contain as many rows as scans for each given subject/session)
load(['C:\Users\Zhongxu\Documents\myStudy\picpairfMRI\matlabFunctions\performanceDataConcatenated.mat']);

batch.Setup.subjects.effects{1}=[1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
batch.Setup.subjects.effects{2}=[0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1];
batch.Setup.subjects.effects{3}=[1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1 1 -1];

batch.Setup.subjects.effects{4}=replaceOutliers(faceMem.firstRecFam,2.5,2);
batch.Setup.subjects.effects{5}=replaceOutliers(faceMem.totalFam,2.5,2);
batch.Setup.subjects.effects{6}=replaceOutliers(houseMem.firstRecFam,2.5,2);
batch.Setup.subjects.effects{7}=replaceOutliers(houseMem.totalFam,2.5,2);
batch.Setup.subjects.effects{8}=replaceOutliers(pairMem.intactFam,2.5,2);
batch.Setup.subjects.effects{9}=replaceOutliers(pairMem.avgFam,2.5,2);

batch.Setup.subjects.effects{10}=replaceOutliers(faceMem.firstRecNFam,2.5,2);
batch.Setup.subjects.effects{11}=replaceOutliers(faceMem.totalNFam,2.5,2);
batch.Setup.subjects.effects{12}=replaceOutliers(houseMem.firstRecNFam,2.5,2);
batch.Setup.subjects.effects{13}=replaceOutliers(houseMem.totalNFam,2.5,2);
batch.Setup.subjects.effects{14}=replaceOutliers(pairMem.intactNFam,2.5,2);
batch.Setup.subjects.effects{15}=replaceOutliers(pairMem.avgNFam,2.5,2);
batch.Setup.subjects.effects{16}=replaceOutliers(pairMem.intactFam-pairMem.intactNFam,2.5,2);


batch.Setup.done=1;                 % 0: only edits project fields (do not run Setup->'Done'); 1: run Setup->'Done'
                                    % 1: Performs initial steps (segmentation, data extraction, etc.) on the defined experiment (equivalent to pressing "Done" in the gui "Setup" window)
                                    % set to 0 if you prefer to further inspect/edit the experiment information in the gui before performing this step
batch.Setup.overwrite='Yes';        % overwrite existing results if they exist (set to 'No' if you want to skip preprocessing steps for subjects/ROIs already analyzed; if in doubt set to 'Yes')    
                                    % For example you would set this field to 'No' if you have already run this script and later you add a few more subjets and/or ROIs and want to run this modified script again without having the existing subjects unnecessarily reanalyzed. 
                                    % note: removing some subjects needs to be done through the gui, if done through the batch you need to set overwrite to 'Yes' 
conn_batch(batch);




