clear all; clc;
figure
disp('|Neurona Retropropagacion |')
disp('|Entradas y Salidas|')
%Abre el excel 
%puede comparar todas las columnas del archivo excel, pero en caso que solo
%quiera comparar uno por uno se hace de la siguiente manera [num(:,:1)]; ya
%dependiendo de la columan que quiera comparar en ambos como para p y t.
[num,txt,raw] = xlsread('Base_Datos_FallasElectricas.xlsx', 'Hoja1');
p = [num(:,:)];
[num1,txt1,raw1] = xlsread('Base_Datos_sinFallasElectricas.xlsx', 'Base_Datos_sinFallasElectricas');
t=[num1(:,:)];
%capa de salida
factorAprendizaje = 0.5;
ws = [0.1 0.3];     
bs = -0.5; 
%primera neurona
wn1 = [0.2 0.5];
bn1 = [0.7 -0.2];
%segunda neurona
wn2 = [0.2 0.5];
bn2 = [0.7 -0.2];
%Variables
E = 0;
aciertos = 0;
iteracion = 0;
EAnt = 0;
CondicionParo = 0.01;
deltaE = 1;
prompt='1.- logsig-logsig,  2.-tansig-tansig,  3.-logsig-tansig'
operacion = input(prompt);
while aciertos < size(p,2) 
    disp('////ALGORITMO/////');
    %contador
    iteracion = iteracion + 1
    for i = 1 : size(p,2)
        % Primera neurona
        a = wn1 * p (i) + bn1;
        aN1 = [(exp(a(1)) - exp(-a(1))) / (exp(a(1)) + exp(-a(1))) (exp(a(2)) - exp(-a(2))) / (exp(a(2)) + exp(-a(2)))]
        % Segunda neurona
        a = (wn2 * p(i) + bn2);
        aN2 = [1/(1 + exp(-a(1))) 1/(1+exp(-a(2)))]
        % Neurona de salida
        as = (ws * (aN1' + aN2') + bs);
        % Busca Error
        e = t(i) - as
        E(end + 1) = e
        %Derivadas
        % pureline
        fs = 1;
       switch(operacion) 
           case 1
                % Operacion logsig
                fn1 = [(aN1(1) * (1 - aN1(1)))  (aN1(2) * ( 1 - aN1(2)))]
                %Operacion logsig
                fn2 = [(aN2(1) * (1 - aN2(1)))  (aN2(2) * ( 1 - aN2(2)))]
                
            case 2
                %Operacion tansig
                fn1 = [(1 - aN1(1)^2)  (1 - aN1(2)^2)]
                %Operacion tansig
                fn2 = [(1 - aN2(1)^2)  (1 - aN2(2)^2)]

            case 3
              %Operacion tansig
              fn1 = [(1 - aN1(1)^2)  (1 - aN1(2)^2)]
              %Operecion logsig
              fn2 = [(aN2(1) * (1 - aN2(1)))  (aN2(2) * ( 1 - aN2(2)))] 
        end
        %Busqueda Sensitividad
        ss = -2 * fs * e
        sN1 = [fn1(1) * ws(1) * ss  fn1(2) * ws(2) * ss]
        sN2 = [fn2(1) * ws(1) * ss  fn2(2) * ws(2) * ss]
        %Operaciones de Ajustes
        ws = ws - factorAprendizaje * (ss * aN1 + ss * aN2)
        bs = bs - factorAprendizaje * ss
                
        wn1 = wn1 - factorAprendizaje * sN1 * p(i)
        bn1 = bn1 - factorAprendizaje * sN1
        
        wn2 = wn2 - factorAprendizaje * sN2 * p(i)
        bn2 = bn2 - factorAprendizaje * sN2      
    end
    if iteracion == 1        EAnt = E(end)  
    else
        deltaE= E(end) - EAnt;
        deltaE = abs(deltaE)
        EAnt = E(end);
    end
    aciertos = sum(deltaE == 0);
    if deltaE < CondicionParo
        break,
    end
%grafica Patrones 
for i = 1 : 3001
    subplot(2,2,1);
    title('Patrones');
    hold on;
        grid on;
        plot(p(i),t(i),"or");
        axis([-4 4 -4 4])% pone la grafica donde inicia xmin xmax ymin ymax
end
%grafica Errores
    subplot(2,2,2);
    title('Errores');
    plot(iteracion,deltaE, '*b')
    hold on
    axis([-0.3 (iteracion+1) -0.5 3])% pone la grafica donde inicia xmin xmax ymin ymax
end
%Operacion de la sepacion lineal
x1 = -bs / ws(1)
    y1 = -bs / ws(2)  
%grafica Separacion lienal
title('Separacion lineal');
for j = 1 : 3001
    subplot(2,2,3);
    plot(p(j),t(j),"ob");
    hold on;
    grid on;
     x = linspace(-3,3,50);
     y = sin(x * pi / 4);
     plot(x,y);
 end
