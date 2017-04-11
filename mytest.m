clc;
clear;
inData = double(imread('testImg.png','png'));
%figure; imshow(inData/256);

% those white spaces are being labelled as 1, i.e. those pixels are being
% removed.
mark = inData(:,:,:)>250; 

                                        
%if value greater than 250, 1; otherwise 0                                       

maxIter = 1000;                  % maximun iteration number
initial = [];                           % '[]' means no initial setting for this problem;
                                           % otherwise the function will use the 'initial' value as the starting point

%% parameters setting %%
alpha = [2, 2, 2];                  % relaxation parameter: a larger value
                                    % means that the solution in eqn.(12) in our paper is
                                    % closer to eqn. (8) in our paper. In the matrix
                                    % case, eqn.(8) is exactly equivalent to
                                    % eqn.(12). You can choose any value
                                    % for \alpha
beta = [0.2,0.2,0.2];                   % you can always set its value as 1
%gamma = [100, 100, 0];              % the weights of trace norm terms


%% tensor completion
% rImg:     recover Result
% errList:  the function value
% R:        the real rank value of each mode
tic;
[rImg, errList] = SLRTC2(inData, alpha, beta, mark, maxIter, initial);
toc;

figure; plot(errList);                       % plot the convergence curve
figure; imshow(inData/256);         % show the original image
figure; imshow(rImg/256);            % show the result
errList(1000,1)
