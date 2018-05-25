function conn_batch_5resting_Setup
% example batch process for experiment SETUP. Edit the fields below
% This example defines the information for the attention dataset (http://www.fil.ion.ucl.ac.uk/spm/data/attention/)  
% Information defined here includes: acquisition TR, number of subjects,
% number of sessions per subject, location of functional and anatomical
% volumes, location of ROI files, location of realignment parameters, and 
% definition of a single condition encompassing the entire session

%% BATCH INFORMATION (edit this section)
nsubj = 20;
rootfolder='/Volumes/Ryan3T1/myStudies/phdThesisData/Data/Conn_output';  %mac 
if ~exist(rootfolder,'dir')
    mkdir(rootfolder);
end
batch.filename=...                   % conn_* project file to be created/modified
    fullfile(rootfolder,'Conn_Bash.mat');

nsessions = 1;
nconditions = 3;
NSUBJECTS=nsubj;

%% EXPERIMENT INFORMATION (edit this section)
batch.Setup.isnew=1;                 % 0: modifies existing project; 1: creates new proejct
batch.Setup.RT=2;                    % TR (in seconds)
batch.Setup.nsubjects=nsubj;          % number of subjects
batch.Setup.analyses=[1,2];

% functional data files (cell array per subject and sessions): batch.Setup.functionals{nsub}{nses} is an array listing the (smoothed/normalized/realigned) functional file(s) for subject "nsub" and session "nses"
projDirG = 'D:\myStudy\picpairfMRI';
for i = 1: nsubj
funDir1 = [projDirG,'\s',sprintf('%03d',i),'\prepostEncoding\preBaseline\'];
funfiles1 = dir([funDir1,'*.img']);
batch.Setup.functionals{i}{1}= [repmat(funDir1,[180,1]),strvcat(funfiles1(1:180).name)];

funDir2 = [projDirG,'\s',sprintf('%03d',i),'\prepostEncoding\postFam\'];
funfiles2 = dir([funDir2,'*.img']);
batch.Setup.functionals{i}{2}= [repmat(funDir2,[180,1]),strvcat(funfiles2(1:180).name)];

funDir3 = [projDirG,'\s',sprintf('%03d',i),'\prepostEncoding\postNonFam\'];
funfiles3 = dir([funDir3,'*.img']);
batch.Setup.functionals{i}{3}= [repmat(funDir3,[180,1]),strvcat(funfiles3(1:180).name)];

if ismember(i,[1 2 5 6 9 10 13 14 17 18]) %  subject had thinkback first
funDir4 = [projDirG,'\s',sprintf('%03d',i),'\scanImgData\run_0012\'];
funfiles4 = dir([funDir4,'sw*.img']);
batch.Setup.functionals{i}{4}= [repmat(funDir4,[180,1]),strvcat(funfiles4(1:180).name)];

funDir5 = [projDirG,'\s',sprintf('%03d',i),'\scanImgData\run_0013\'];
funfiles5 = dir([funDir5,'sw*.img']);
batch.Setup.functionals{i}{5}= [repmat(funDir5,[180,1]),strvcat(funfiles5(1:180).name)];

elseif ismember(i,[3 4 7 8 11 12 15 16 19 20]) % subject had thinkahead first
funDir4 = [projDirG,'\s',sprintf('%03d',i),'\scanImgData\run_0013\'];
funfiles4 = dir([funDir4,'sw*.img']);
batch.Setup.functionals{i}{4}= [repmat(funDir4,[180,1]),strvcat(funfiles4(1:180).name)];

funDir5 = [projDirG,'\s',sprintf('%03d',i),'\scanImgData\run_0012\'];
funfiles5 = dir([funDir5,'sw*.img']);
batch.Setup.functionals{i}{5}= [repmat(funDir5,[180,1]),strvcat(funfiles5(1:180).name)]; 
    
end
end


% anatomical volumes (cell array per subject): batch.Setup.structurals{nsub} is an array pointing to the (normalized) anatomical volume for subject "nsub"
% structural image folder
projDirC='D:\myStudy\picpairfMRI\';
for i = 1: nsubj
batch.Setup.structurals{i} = get_structure(i);
batch.Setup.masks.Grey{i}= get_masks(i) fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wc1vol_0001.img');
batch.Setup.masks.White{i}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wc2vol_0001.img');
batch.Setup.masks.CSF{i}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\scanImgData\run_0003','wc3vol_0001.img');
end

batch.Setup.rois.names = {'AAL'};%%%
roiDirConnyAndrewHanna = 'D:\myStudy\picpairfMRI\masksFromConnyAndrewHanna\';
frois=dir([roiDirConnyAndrewHanna,'*.nii']);
for k = 1:20
   batch.Setup.rois.names{11+k} = frois(k).name;
end
for i = 1:nsubj
%   roiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\encoding\analysis\'];
% faceRoiDir=['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\localization\'];
% houseRoiDir = ['D:\myStudy\picpairfMRI\s',sprintf('%03d',i),'\localization\'];  
    
batch.Setup.rois.files{1}{i} =fullfile(fileparts(which('conn')),'utils','otherrois','AAL.nii');
% batch.Setup.rois.files{2}{i} = [roiDir,'lhpc-indivRoi-smBBox.img'];
% batch.Setup.rois.files{3}{i} = [roiDir,'rhpc-indivRoi-smBBox.img'];
% batch.Setup.rois.files{4}{i} =[roiDir,'ltpl-indivRoi-smBBox.img'];
% batch.Setup.rois.files{5}{i} =[roiDir,'rtpl-indivRoi-smBBox.img'];
% batch.Setup.rois.files{6}{i} =[roiDir,'lvmp-indivRoi-smBBox.img'];
% batch.Setup.rois.files{7}{i} =[roiDir,'rvmp-indivRoi-smBBox.img'];
% batch.Setup.rois.files{8}{i} =[faceRoiDir,'L_FFA.img'];
% batch.Setup.rois.files{9}{i} =[faceRoiDir,'R_FFA.img'];
% batch.Setup.rois.files{10}{i} =[houseRoiDir,'L_PPA.img'];
% batch.Setup.rois.files{11}{i} =[houseRoiDir,'R_PPA.img'];

for k=1:20
batch.Setup.rois.files{1+k}{i} = [roiDirConnyAndrewHanna,frois(k).name];
end

end

% batch.Setup.rois.dimensions={1,1,1,1,1,1,1,1,1,1,1};
% condition names: cell array of strings (one per condition)


batch.Setup.conditions.names={'preRest';'postFam';'postNonFam';'thinkBack';'thinkAhead'};
for ncond=1:nconditions,for nsub=1:NSUBJECTS,for nses=1:nsessions,  batch.Setup.conditions.onsets{ncond}{nsub}{nses}=[];batch.Setup.conditions.durations{ncond}{nsub}{nses}=[]; end;end;end
for ncond=1:nconditions,for nsub=1:NSUBJECTS,for nses=ncond,        batch.Setup.conditions.onsets{ncond}{nsub}{nses}=0; batch.Setup.conditions.durations{ncond}{nsub}{nses}=inf;end;end;end


% names of temporal (first-level) covariates
 batch.Setup.covariates.names={'motion'};      
% % cell array of strings (one per covariate and subject and condition): batch.Setup.covariates.files{ncovariate}{nsub}{nses} is an array pointing the a file defining the covariate "ncoviarate" for subject "nsub" and sessions "nses" (note: valid files are .txt or .mat files and should contain as many rows as scans for each given subject/session)
% X=kron(eye(4),ones(90,1));save(fullfile(rootfolder,'sessions.mat'),'X');
for i = 1:nsubj
    
getMotionMatchBOLDfile(fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\prepostEncoding\preBaseline','rp_avol_0004.txt'));
batch.Setup.covariates.files{1}{i}{1}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\prepostEncoding\preBaseline','rp_avol_0004-180.txt');

getMotionMatchBOLDfile(fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\prepostEncoding\postFam','rp_avol_0004.txt'));
batch.Setup.covariates.files{1}{i}{2}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\prepostEncoding\postFam','rp_avol_0004-180.txt');

getMotionMatchBOLDfile(fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\prepostEncoding\postNonFam','rp_avol_0004.txt'));
batch.Setup.covariates.files{1}{i}{3}=fullfile(projDirC,['s',sprintf('%03d',i)],...
    '\prepostEncoding\postNonFam','rp_avol_0004-180.txt');

if ismember(i,[1 2 5 6 9 10 13 14 17 18]) %  subject had thinkback first
getMotionMatchBOLDfile([projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0012\rp_avol_0004.txt']);    
batch.Setup.covariates.files{1}{i}{4}= [projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0012\rp_avol_0004-180.txt'];
                    
getMotionMatchBOLDfile([projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0013\rp_avol_0004.txt']);                     
batch.Setup.covariates.files{1}{i}{5}= [projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0013\rp_avol_0004-180.txt']; 
                    
elseif ismember(i,[3 4 7 8 11 12 15 16 19 20])  
getMotionMatchBOLDfile([projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0013\rp_avol_0004.txt']);     
batch.Setup.covariates.files{1}{i}{4}= [projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0013\rp_avol_0004-180.txt'];
                    
getMotionMatchBOLDfile([projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0012\rp_avol_0004.txt']);                     
batch.Setup.covariates.files{1}{i}{5}= [projDirC,'s',sprintf('%03d',i),...
                        '\scanImgData\run_0012\rp_avol_0004-180.txt'];  
end
end


%];

batch.Setup.done=1;                 % 0: only edits project fields (do not run Setup->'Done'); 1: run Setup->'Done'
                                    % 1: Performs initial steps (segmentation, data extraction, etc.) on the defined experiment (equivalent to pressing "Done" in the gui "Setup" window)
                                    % set to 0 if you prefer to further inspect/edit the experiment information in the gui before performing this step
batch.Setup.overwrite='Yes';        % overwrite existing results if they exist (set to 'No' if you want to skip preprocessing steps for subjects/ROIs already analyzed; if in doubt set to 'Yes')    
                                    % For example you would set this field to 'No' if you have already run this script and later you add a few more subjets and/or ROIs and want to run this modified script again without having the existing subjects unnecessarily reanalyzed. 
                                    % note: removing some subjects needs to be done through the gui, if done through the batch you need to set overwrite to 'Yes' 
conn_batch(batch);

function getMotionMatchBOLDfile(filename)
moData = textread(filename);
moData = moData(1:180,:); %because the original motion file has 181 lines
[fPath,fName,fExt]=fileparts(filename);
save([fPath,'\',fName,'-180','.txt'],'-ascii', 'moData');



