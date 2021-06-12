#  Final Year Capstone Project in HKUST
This project aims to replicate the Simple Low Rank Tensor Completion (SiLRTC) algorithm [https://ieeexplore.ieee.org/document/6138863]. The research has proposed that tensor rank as the convex combination of all matrices unfolded along each direction of the tensor.

This tensor rank is used to solved the optimization problem of missing pixel in an image.
# Process 
* The SiLRTC is developed in MATLAB. 
* Images are generated from video and random pixels are being removed from the images. The goal is to recover the missing pixels and determine the optimum parameters for lowest error rate and fastest computation time.
* Based on various experiment rounds, dividing the input image into 8 blocks of dimension [120 x 427 x 3] produces the most optimum result with constant alpha and beta.

# Details of depository
* SLTRC2.m contains the function that is able to recover part of the tensor that is being removed using a modified SVD function. SLTRC2.m uses 2 main functions,  MySVDTau.m and Pro2TraceNorm.m, located in the folder LRTC_Package_Ji.
* my test.m is the main function that reads in test images and recovers the removed pixels.
