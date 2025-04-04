%% Aula_02_ECM307 - Analogia entre vetores e sinais
% Felipe Fazio da Costa; RA: 23.00055-4
%% Boas práticas

%%% Limpando todo sistema para início dos calculos
clear;
close all;
clc;
%% Sinal equação 3
% 

syms t  %%% Inicialização das variáveis a serem utilizadas.

%%% Numericamente o primeiro período:
t = 0 : 1e-3 : 1;
g = 1 - exp(-2*t);

%%% Numericamente 3 períodos:
t = 0 : 1e-3 : 3;
plot(t, [g g(2:end) g(2:end)]);
%% Calculando an:
% 

syms n t %%% Inicialização de variáveis.

%%% Cálculo do numerador da integral de an:
num_an = int((1 - exp(-2*t)) * cos(n * t), t, 0, 1)
%%% Cálculo do denominador da integral de an:
den_an = int(cos(n * t)^2, t, 0, 1)
%% Calculando bn:

syms n t %%% Inicialização de variáveis.

%%% Cálculo do numerador da integral de bn:
num_bn = int((1 - exp(-2*t)) * sin(n * t), t, 0, 1)

%%% Cálculo do denominador da integral de bn:
den_bn = int(sin(n * t)^2, t, 0, 1)
%% Substituindo os valores an:

%%% definição de n para parte numérica:
N  = 36;
n  = 1:1:N;

Num_numerico_an = eval(num_an);
Den_numerico_an = eval(den_an);

%%% Resultado numérico:
an = Num_numerico_an./Den_numerico_an
%% substituindo valores bn:

%%% definição de n para parte numérica:
N  = 36;
n  = 1:1:N;

Num_numerico_bn = eval(num_bn);
Den_numerico_bn = eval(den_bn);

%%% Resultado numérico:
bn = Num_numerico_bn./Den_numerico_bn
%% Concatenando os valores de an e bn
% 

g_aprox = 0;

tempo = [0 : 1e-3 : 3];

for k = 1:N

    g_aprox  =  g_aprox + an(k)*cos(n(k)*tempo) + + bn(k)*sin(n(k)*tempo);

end

plot(tempo,g_aprox)
%% Correção sobre a curva prévia

%%% Limpar variáveis:

clear;
close all;
clc;

%%% Inicializações de variáveis:
syms t n;
w = 2 * pi;
%% Calculando an(2.0):

num_an = int((1-exp(-2*t))*cos(n*w*t),t,0,1);                         
den_an = int((cos(n*w*t))^2,t,0,1);                    

num_numerico_an = eval(num_an);                           
den_numerico_an = eval(den_an);                           

an = num_numerico_an ./ den_numerico_an
%% Calculando bn(2.0):

num_bn = int((1-exp(-2*t))*sin(n*w*t),t,0,1);           
den_bn = int((sin(n*w*t))^2,t,0,1);                     

num_numerico_bn = eval(num_bn);                                       
den_numerico_bn = eval(den_bn);                           

bn = num_numerico_bn ./ den_numerico_bn
%% Parte Numérica:

% Declarando variáveis para o plot
g(t)=1-exp(-2*t);

% cálculo de a0 para o ajuste de amplitude do sinal sintetizado, e iniciando a soma com ele
aux = (int(g(t),t,0,1))/1;                   
tempo = 0:1e-3:3;
t1 = 0:1e-3:1;                                    
t2 = 1:1e-3:2;                                    
t3 = 2:1e-3:3;                                    

% Declarando o número de Harmônicas:
N = 15;
n = 1:1:N;

% Preparando an e bn para o plot considerando o número de harmônicas definido
num_numerico_an_plot = eval(num_an);                                            
den_numerico_an_plot = eval(den_an);                                            

an_plot = num_numerico_an_plot ./ den_numerico_an_plot;                         

num_numerico_bn_plot = eval(num_bn);                                            
den_numerico_bn_plot = eval(den_bn);                                            

bn_plot = num_numerico_bn_plot ./ den_numerico_bn_plot;                       

% Obtenção do sinal sintetizado
for k = 1:N

    aux  =  aux + an_plot(k)*cos(n(k)*w*tempo) + bn_plot(k)*sin(n(k)*w*tempo);

end

gt0_sintetizado = aux;                              

g1 = 1-exp(-2*(t1));                                                   
g2 = 1-exp(-2*(t2-1));                                                 
g3 = 1-exp(-2*(t3-2));

% Fazendo os plots
plot(tempo,gt0_sintetizado,'LineWidth',1,'Color',"b");hold
plot(t1,g1,'LineWidth',1,'Color',"k","LineStyle","--");               
plot(t2,g2,'LineWidth',1,'Color',"k","LineStyle","--");               
plot(t3,g3,'LineWidth',1,'Color',"k","LineStyle","--"); 
%% Potência do sinal:
% 

% cálculo da potência em watts
P = 1/1 * int(((1-exp(-2*t))^2),t,0,1) 
%% Conclusão
% Inicialmente, observa-se que o sinal sintetizado difere do sinal original 
% em amplitude e frequência. Essas discrepâncias são causadas por dois problemas 
% no modelo matemático, que, uma vez corrigidos, permitem que o sinal sintetizado 
% se aproxime significativamente do original.
%% 
% # *Ajuste da frequência fundamental*:O sinal original possui período _T_=1 
% segundo, o que implica em uma frequência _f_=1 Hz. No entanto, a frequência 
% fundamental das funções trigonométricas não foi corretamente ajustada nas equações 
% (2) e (3), resultando em um número incorreto de ciclos no intervalo de 1 a 3 
% segundos. Ao corrigir a frequência fundamental para _ω_=2_π rad/s_, o número 
% de ciclos é ajustado, alinhando o sinal sintetizado ao original.
% # *Correção da amplitude*:A amplitude do sinal sintetizado também apresentou 
% diferenças em relação ao sinal original. Isso ocorre porque o valor médio do 
% sinal original não é zero, enquanto a soma de senos e cossenos tem valor médio 
% nulo. Para resolver isso, calculou-se o valor médio do sinal original usando 
% a fórmula $a_0=\frac{1}{T_0} \displaystyle \int_{T_0}  g_{T_0}(t)dt$. Ao adicionar 
% a0 à somatória das componentes harmônicas, a amplitude do sinal sintetizado 
% foi corrigida, resultando em uma aproximação mais fiel ao sinal original.
%% 
% Com essas correções, o sinal sintetizado passou a apresentar características 
% de amplitude e frequência consistentes com o sinal original, demonstrando a 
% importância de ajustes precisos no modelo matemático para uma representação 
% adequada de sinais periódicos.