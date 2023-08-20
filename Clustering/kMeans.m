clc
clear
close all
x = load('iris.txt');
%Como temos 3 classes na base de dados, tentaremos separar em 3 clusters
k = 3; 
%Sorteamos entre os dados para inicializar nosso centro do k-means
idc = randi(length(x),k,1);
centro = x(idc,:);
d = zeros(k,1);
%Na variavel cluster iremos colocar os dados e sua respectiva atribuicao
%dada pelo k-means
cluster = zeros(length(x),size(x,2)+1);
for iter = 1:100
    for i = 1:length(x)
        for j = 1:k
            %Calculamos qual o centro mais proximo
            d(j) = sqrt(sum((x(i,:) - centro(j,:)).^2));
        end
        idc = find(d == min(d));
        %atribuimos a classe dada pelo k-means
        %Selecionamos idc(1) para evitar erros quando temos mais de um
        %centro com a mesma distancia para o dado
        cluster(i,:) = [x(i,:), idc(1)];
    end
    for id = 1:k
        %atualizamos o centro pela media dos dados atribuidos
        centro(id,:) = mean(cluster(find(cluster(:,6) == id),1:5));
    end
end
classe1 = cluster(find(cluster(:,5) == 1),:);
classe2 = cluster(find(cluster(:,5) == 2),:);
classe3 = cluster(find(cluster(:,5) == 3),:);
cluster1 = cluster(find(cluster(:,6) == 1),:);
cluster2 = cluster(find(cluster(:,6) == 2),:);
cluster3 = cluster(find(cluster(:,6) == 3),:);
plot(cluster1(:,1),cluster1(:,2), 'r*');
hold on;
plot(cluster2(:,1),cluster2(:,2), 'b*');
hold on;
plot(cluster3(:,1),cluster3(:,2), 'k*');
hold on;
scatter(centro(1,1),centro(1,2), 200, "red" ,"filled");
hold on;
scatter(centro(2,1),centro(2,2), 200, "blue" ,"filled");
hold on;
scatter(centro(3,1),centro(3,2), 200, "black" ,"filled");
legend("Cluster 1", "Cluster 2", " Cluster 3", "Centro 1", "Centro 2", "Centro 3")
title('Resultado do K-Means');