clear all; clc;

disp(' ')
disp('            Practica 5')
disp(' ')
disp('***********************************')
disp(' ')
disp('Entrada de datos')
disp(' ')

p = [2 2.5 1; 0 -1 -2]
t = [1 1 -1]

disp('***********************************')
disp(' ')
disp('Entrada de pesos y ganancia')
disp(' ')

w = [-.7 .2]
b = 0.5
alfa = 0.5

disp('***********************************')
disp(' ')
disp('Proceso iterativo')
disp(' ')

e = 1;
iteracion = 0;
errores = 0;

%%%%%%%% documento

fid = fopen('Adaline_AND3.doc','w');
fprintf( fid,'Practica 6  "Adaline  AND"\n');
fprintf( fid,'\nAlfa %f\n',alfa);

while errores ~= size(p,2)
    iteracion = iteracion +1;
    errores = 0;
    
    fprintf( fid,'\nIteracion %i\n',iteracion);
    
    for i = 1: size(p,2)
        a = (w * p(:,i) + b);

        if a >= 0
            a = 1;
        else
            a = -1;
        end

        e = t(1,i) - a;
        paux = p(:,i);
        w = w + (2 * alfa * e * paux')
        b = b + (2 * alfa * e)

        if e == 0
            errores = errores + 1;
        end
        
        fprintf( fid,'\nPatron de entrada %i\n',i);
        fprintf( fid,'\nFuncion de activacion hardlim\n');
        fprintf( fid,'a = %3i\n',a);
        fprintf( fid,'\nError\n');
        fprintf( fid,'e = %10.3f\n',e);
        fprintf( fid,'\nPesos sinopticos\n');
        fprintf( fid,'w = [%10.3f %10.3f ]\n',w);
        fprintf( fid,'\nGanancia\n');
        fprintf( fid,'b = %10.3f\n',b);
        
    end
    
    disp('***********************************')
    disp(' ')
    disp('Recta solucion')
    disp(' ')

    x = -b/w(1,1)
    y = -b/w(1,2)

    %   Graficar usando la funcion plot

%     plot(p(1,1), p(2,1), 'or') % grafica con una "o" roja
%     hold on % mantener el grafico porque solo grafica el ultimo
%     grid on % para activar las etiquetas
%     plot(p(1,2), p(2,2), 'or')% grafica con una "o" azul
%     plot(p(1,3), p(2,3), 'or')
%     plot(p(1,4), p(2,4), 'ob')
%     axis([-5 5 -5 5]) % para darle un rango al plano cartesiano primero en x y en y
%     plot([x,0],[0,y])
    
    fprintf( fid,'\nRecta solucion %i\n',iteracion);
    fprintf( fid,'coordenada x = %10.3f\n',x);
    fprintf( fid,'coordenada y = %10.3f\n',y);
    
end
fclose(fid);
plot(p(1,1), p(2,1), 'or') % grafica con una "o" roja
    hold on % mantener el grafico porque solo grafica el ultimo
    grid on % para activar las etiquetas
    plot(p(1,2), p(2,2), 'or')% grafica con una "o" azul
    plot(p(1,3), p(2,3), 'ob')    
    %plot(p(1,4), p(2,4), 'ob')
    axis([-5 5 -5 5]) % para darle un rango al plano cartesiano primero en x y en y
    plot([x,0],[0,y])
    