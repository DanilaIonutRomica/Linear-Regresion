Y = [1; 0; 1; 0; 1];
X2 = [1 0.01 0.98 0.01 0.78];
X3 = [0.1 0.5 0.7 0.7  0.19];
X4 = rand(1,5)  %[0.4 0 0.3 0.01];

X1 = [1 1 1 1 1];

X = [X1; X2; X3;X4;].'
B =inv(X.'*X)*X.'*Y 

x_11 = 1.001;
x_22 = 0.05;
x_33 = rand(1,1);

Preditc_Model_Val = @(x_1,x_2,x_3) B(1) + x_1*B(2)+x_2*B(3)+x_3*B(4)

Preditc_Model_Val_Ex = Preditc_Model_Val(x_11,x_22,x_33)

%[0.5 0.5 0.5] *B new entry times B matrix
[m n] = size(Y);

SumOfSquaredResiduals=0;
VarianceInData=0;
StandardErrorByB1 = 0;
StandardErrorByB2 = 0;
StandardErrorByB3 = 0;
StandardErrorByB4 = 0;
average_Y = mean(Y);

for i=1:m
    SumOfSquaredResiduals=SumOfSquaredResiduals+(Y(i)- Preditc_Model_Val(X2(i),X3(i),X4(i)))^2;
    VarianceInData=VarianceInData+(Y(i)- average_Y)^2;
    StandardErrorByB1 = StandardErrorByB1 + ((X1(i)*B(1)) - Y(i))^2;
    StandardErrorByB2 = StandardErrorByB2 + ((X2(i)*B(2)+X1(i)*B(1) ) - Y(i))^2;
    StandardErrorByB3 = StandardErrorByB3 + ((X3(i)*B(3)+X1(i)*B(1)) - Y(i))^2;
    StandardErrorByB4 = StandardErrorByB3 + ((X4(i)*B(4)+X1(i)*B(1)) - Y(i))^2;
end
freedom_degrees = 5 - 2; %# observations - #params in the model 
StandardErrorByB1 = sqrt(StandardErrorByB1/4);
StandardErrorByB2 = sqrt(StandardErrorByB2/freedom_degrees);
StandardErrorByB3 = sqrt(StandardErrorByB3/freedom_degrees);
StandardErrorByB4 = sqrt(StandardErrorByB4/freedom_degrees);

R_square = 1- (SumOfSquaredResiduals)/(VarianceInData)

%t test for determining p-value

t1= B(1)/StandardErrorByB1
t2= B(2)/StandardErrorByB2 
t3= B(3)/StandardErrorByB3
t4= B(4)/StandardErrorByB4
