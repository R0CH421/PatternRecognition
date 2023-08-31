clear
clc
%gerar 1e3 instancia da V.A cuja distribuição é
%fx(x) = 0.1*N([0;0][0.1,0;0,0.1])+0.7*N([1;1][1,0.9;0.9,1])+0.2*N([1;-1][1,-0.9;-0.9,1])
pa = 0.7; %Probabilidade da gaussiana A
pb = 0.1;%Probabilidade da gaussiana B
pc = 0.2; %Probabilidade da gaussiana C
%Duas variaveis aleatorias:
ra = [1,0.9;0.9,1]; %matriz de correlação da gaussiana A
ma = [1;1]; %media da gaussiana A
rb = [0.1,0;0,0.1];
mb = [0;0];
rc = [1,-0.9;-0.9,1];
mc = [1;-1];
Aa = ra^1/2;
Ab = rb^1/2;
Ac = rc^1/2;
x = ones(2,1000);
for i = 1:1000
    sorteio = rand;
    if sorteio <= pb      
        x(:,i) = Ab*randn(2,1) + mb;
    elseif sorteio > pb && sorteio <= pc
        x(:,i) = Ac*randn(2,1) +mc;
    else
        x(:,i) = Aa*randn(2,1) + ma;
    end
end
plot(x(1,:),x(2,:), '*');
