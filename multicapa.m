clear all;
clc;
figure
disp('---------------------------------------')
disp('|          Programa de prueba         |')
disp('---------------------------------------')
disp('| Entrena una neurona tipo Multicapa |')
disp('---------------------------------------')
disp('|         Entrada logica XOR           |')
disp('---------------------------------------')
p1=[0 0 1 1; 0 1 0 1]
p2=[0 0 0 1; 0 1 1 1]
disp('--------------------------------------')
disp('|     datos de pesos y ganancia       |')
disp('--------------------------------------')
w=[-0.7 0.2]
b=0.5
disp('---------------------------------------')
disp('|       datos de estados finales      |')
disp('---------------------------------------')
tAND=[ 0 0 0 1]
tOR=[ 0 1 1 1 ]
tXOR=[ 0 1 1 0]
disp('---------------------------------------')
wAND=w;
bAND=b;
wOR=w;
bOR=b;
i=1;
aciertosAND=0;
aciertosOR=0;
aciertosXOR=0

%grafica 1
subplot(2,2,1);
title('Patrones');
plot(p1(1,1),p1(2,1), 'ob')
hold on %mantenerse en la grafica 
plot(p1(1,2),p1(2,2), '*r')
%hold on
plot(p1(1,3),p1(2,3), '*r')
%hold on 
plot(p1(1,4),p1(2,4), 'ob')
%hold on
axis([-0.5 1.5 -.5 1.5]) % pone la grafica donde inicia xmin xmax ymin ymax


while aciertosAND < length(p1)
    i=i+1;
    for j=1:length(p1)
        % ALGORITMO
        a=(wAND*p1(:,j)) + bAND
        if a>=0
            a=1
        else 
            a=0
        end
        %CALCULANDO ERROR

        eAND(j)=tAND(j)-a;

        if eAND(j)~=0
            aciertosAND=0
    
            % AJUSTE DE PESO Y GANANCIA
            wAND=wAND+(eAND(j)*p1(:,j)');
            bAND=bAND+eAND(j);

        else 
            aciertosAND=aciertosAND+1;
        end
        disp(i);

    end
    
end
 i2=0;
while aciertosOR < length(p1)
    i2=i2+1;
    for j=1:length(p1)
        % ALGORITMO
        a=(wOR*p1(:,j)) + bOR;
        if a>=0
            a=1;
        else 
            a=0;
        end
        %CALCULANDO ERROR

        eOR(j)=tOR(j)-a;

        if eOR(j)~=0
            aciertosOR=0
    
            % AJUSTE DE PESO Y GANANCIA
            wOR=wOR+(eOR(j)*p1(:,j)');
            bOR=bOR+eOR(j);

        else 
            aciertosOR=aciertosOR+1;
        end
        disp(i2);

    end
    
end

wXOR=(wAND + wOR)/2;
bXOR=(bAND + bOR)/2;
iF=0;

while aciertosXOR < length(p2)
    iF=iF+1;
    for j=1:length(p2)
        % ALGORITMO
        a=(wXOR*p2(:,j)) + bXOR;
        if a>=0
            a=1;
        else 
            a=0;
        end
        %CALCULANDO ERROR

        eXOR(j)=tXOR(j)-a;

        if eXOR(j)~=0
            aciertosXOR=0;
    
            % AJUSTE DE PESO Y GANANCIA
            wXOR=wXOR+(eXOR(j)*p2(:,j)')
            bXOR=bXOR+eXOR(j)

        else 
            aciertosXOR=aciertosXOR+1;
        end
        disp(iF);

    end
    %grafica 2
    subplot(2,2,2);
    plot(iF,eXOR(4), 'ob')
    hold on
    axis([-0.3 (iF+1) -0.5 1.2])
    title('funcion seno del doble ');
end


%grafica 3
subplot(2,2,3);
plot(p1(1,1),p1(2,1), 'ob')
hold on %mantenerse en la grafica 
plot(p1(1,2),p1(2,2), '*r')
%hold on
plot(p1(1,3),p1(2,3), '*r')
%hold on 
plot(p1(1,4),p1(2,4), 'ob')
%hold on
axis([-0.5 1.5 -.5 1.5]) % pone la grafica donde inicia xmin xmax ymin ymax

x1=((-bAND)/wAND(1,1));
y1=((-bAND)/wAND(1,2));
line([x1,0],[0,y1]);

x2=((-bOR)/wOR(1,1));
y2=((-bOR)/wOR(1,2));
line([x2,0],[0,y2]);


