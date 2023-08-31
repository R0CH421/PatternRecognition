clear
clc
load dados.mat
%Dados teste
xt = [1,1,2,3,3.5,4;1,1.5,2,4,5,3];
xt = x;
%Numero de gaussianas
k = 3;
%Tabela de pertencimento
N = length(xt);
table = zeros(k,N);
%media das gaussianas inicializada aleatoriamente
qtd_var = size(xt,1);%Quantidade de variaveis aleatorias
for i = 1:k
    u(:,:,i) =  xt(:,randi(N));
    %Matriz de correlacao inicializada aleatoriamente
    c(:,:,i) = eye(qtd_var,qtd_var);
end
p = rand(k,1);
iterations = 100;
for i = 1:iterations
    for m = 1:k
        for n = 1:N
            table(m,n) = p(m)*exp(-0.5*(xt(:,n)-u(:,:,m))'*inv(c(:,:,m))*(xt(:,n)-u(:,:,m)))/(2*pi*det(c(:,:,m))^0.5);
        end
    end
    table = table./sum(table);
    for m = 1:k
        c(:,:,m) = (xt-u(:,:,m))*diag(table(m,:))*(xt-u(:,:,m))'./sum(table(m,:));
        u(:,:,m) = sum(xt.*table(m,:),2)./sum(table(m,:));
        p(m,1) = sum(table(m,:))./N;
    end
    stable(i) = log(sum(sum(p.*table)));
end
subplot(2,1,1)
plot(xt(1,:), xt(2,:),'*')
hold on
plot([u(1,1,1),u(1,1,2), u(1,1,3)], [u(2,1,1),u(2,1,2),u(2,1,3)], '*')
legend('Dados','Média')
subplot(2,1,2)
plot(stable)
c
u
p
