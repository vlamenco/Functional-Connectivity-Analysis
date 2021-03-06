function convertROIMasks(inputMask,outputMask,templateImage, threshold)
% convert a mask to have the same bounding box size, (ie., matrix size) and
% M matrix. expeically when using REST toolbox functions, it requires the mask has the
% same size as the data file.
% zhongxu Liu 

if nargin<4; threshold = 0;end;
%read in the input mask
a=spm_vol(inputMask);
[gridx,gridy,gridz]=ndgrid(1:a.dim(1),1:a.dim(2),1:a.dim(3));
xyz=[gridx(:),gridy(:),gridz(:)]';%,ones(numel(gridx),1)]';
b=reshape(spm_get_data(a,xyz),a.dim);

%find mask region matrix indces that satisfies the threshold
idxvoxels=find(b>threshold);
XYZww=b(idxvoxels)';
xyz=xyz(:,idxvoxels);

% find the coordinates of the mask region
XYZMM=a.mat(1:3,:)*[xyz;ones(1,length(idxvoxels))];

% read in the templateImage header
outV = spm_vol(templateImage);
% revert the matrix M
c_iM=inv(outV.mat);

%convert the coordinates into matrix indices
c_XYZ = c_iM(1:3,:)*[XYZMM; ones(1,size(XYZMM,2))];

%read in the template image and set all data to zoeros
c_data = spm_read_vols(outV);
c_data(:,:,:) = 0;

% add the mask by settiing 1 for all the matrix indcees 
for i = 1: size(c_XYZ,2)
c_data(c_XYZ(1,i),c_XYZ(2,i),c_XYZ(3,i)) = 1;
end

%change file name info in header
outV.fname = outputMask;
outV.descrip = 'convertROIMasks-zx';
% write the new mask image
rest_WriteNiftiImage(c_data,outV,outputMask);