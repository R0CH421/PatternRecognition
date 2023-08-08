%-------------------------------------------------------------------------------
%Autor: Thiago Rocha de Melo
%Departamento de Engenharia Eletrica - Universidade Federal de Sergipe
%
%-------------------------------------------------------------------------------

% 1.Estimacao da PDF usando Janelas Parzen com Janela Gaussiana
% 2. Classificador Bayesiano utilizando a PDF estimada.
clear
close all
clc
dados = load ('glicose.txt');
% Pessoas sem diabetes pertencem a Classe 0 e com diabetes a classe 1
classe0 = dados(find(dados(:,2) == 0),1);
classe1 = dados(find(dados(:,2) == 1),1);
n = length(classe0);
h = round(sqrt(n));
dim = size(classe0,2);
janela = zeros(n,1);
pdf = janela;
u = janela;
gaussiana = janela;
x = [40:0.01:200];
for i = 1:length(x)
    for j = 1:length(classe0)
        u(j) = (x(i)-classe0(j))/h;
        gaussiana(j) = (1/sqrt(2*pi))*exp((-u(j)^2)/2);
        end
        pdf_classe0(i) = (1/n)*sum((1/h^dim)*gaussiana);
end
n = length(classe1);
h = round(sqrt(n));
janela = zeros(n,1);
pdf = janela;
u = janela;
gaussiana = janela;
for i = 1:length(x)
    for j = 1:length(classe1)
        u(j) = (x(i)-classe1(j))/h;
        gaussiana(j) = (1/sqrt(2*pi))*exp((-u(j)^2)/2);
        end
        pdf_classe1(i) = (1/n)*sum((1/h^dim)*gaussiana);
end
plot(x,pdf_classe0)
hold on
plot(x,pdf_classe1)
legend('Classe 0', 'Classe 1')
title('PDF Estimada das classes')
%--------------------------------------------------------------------------
%----------------Classificador Bayesiano-----------------------------------
%Defincao dos "a priori": Como na nossa base temos aproximadamente 2/3 para
%classe 0 e 1/3 para classe 1 usaremos essas valores como a probabilidade
%da classe.
p_classe0 = 2/3;
p_classe1 = 1/3;
classe_estimada = 2*ones(length(dados),1);
acertos = 0;
erros = 0;
for i = 1:length(dados)
    xi = dados(i);
    classe = dados(i,2);
    idc = find(x==xi);
    aux0 = pdf_classe0(idc)*p_classe0;
    aux1 = pdf_classe1(idc)*p_classe1;
    if aux0 > aux1
        classe_estimada(i) = 0;
    else
        classe_estimada(i) = 1;
    end
    if classe_estimada(i) == classe
        acertos = acertos + 1;
    else
        erros = erros + 1;
    end
end
disp(['Tx_Acerto: ', num2str(100*acertos/(acertos+erros)), '%'])
%-------------------------------------------------------------------------
%Classificador para uma entrada dada pelo usuário
entrada = input('Digite a glicose do paciente: ')
idc = find(x==entrada);
aux0 = pdf_classe0(idc)*p_classe0;
aux1 = pdf_classe1(idc)*p_classe1;
if aux0 > aux1
    classe_estimada2 = 0
else
    classe_estimada2 = 1
end

