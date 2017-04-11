function [input_m,errList] =SLRTC2(input_m, alpha, beta, reduced,max_iter,initial)

n = ndims(input_m);
dim = size(input_m);
unfold = cell(n,1);
%output_m = zeros(size(input_m));
Ysum = zeros(dim);
Xsum = zeros(dim);
%copy = cell(max_iter,1);
errList = zeros(max_iter, 1);

% reduced is the logical matrix indicating which values are removed.
if isempty(initial)
    %if reduced = 1, value = 0, meaning the grid is black;
    input_m(reduced) = 0;
else
    input_m(reduced) = initial(reduced);
end


Csum = alpha + beta;
X = input_m;
for k = 1:max_iter
    Xsum = Xsum * 0;
    Ysum = Ysum * 0;
    for i = 1:n
        % site records along which direction the unfolding happens
        site = circshift(dim, [1-i, 1-i]);

        % QUESTION:Why do we need this process? If this is excluded, there
        % is no change to the input matrix.This is a smoothening process.
        %Mpro = alpha(i)/Csum(i) * X + beta(i)/Csum(i) * input_m;

        % Unfolding process, unfold is a 1x3 cell that contains all the unfolded tensor
        unfold{i} = reshape(shiftdim(X,i-1), dim(i), []);
        tau =  alpha(i)/beta(i);

        % Pro2Trace is the shrinkage operator. Applying shrinkage operator to unfolded tensor, mid is the matrix
        % after being reduced by Pro2TraceNorm.

        % mid is the same for every iteration
        [mid, D(i)] = Pro2TraceNorm(unfold{i},tau);

        % Fold back matrix into tensor
        fold = shiftdim(reshape(mid, site), -i+1+ndims(input_m));
        % Ysum is a tensor of same dimension as the target matrix.
        Ysum = Ysum + beta(i)*fold;


    end
    % QUESTION: what is the purpose of 1e-10?Error boundary
    Ysum = Ysum/(sum(beta) + 1e-10);
    
    errList(k) = norm(input_m(reduced)-Ysum(reduced));
    input_m(reduced) = Ysum(reduced);
    X = input_m;

end
