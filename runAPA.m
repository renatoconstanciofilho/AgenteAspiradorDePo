%Para chamar as fun��es do aspirador de p� automatico (APA) baseado em um agente
%reativo simples
clear all;clc; close all;


%---Ambiente---
sala = geraAmbiente(); %Gerar o ambiente
mostraAmbiente(sala); %Mostrar o ambiente
%Coordernadas de in�cio do agente aspirador de p�
posicaoX = 2;
posicaoY = 2;

%pesquise para ver para que servem as fun��es (hold on, hold off e pause)
hold on; %mant�m est�tico o ambiente feito anteriormente para posicionar o limpador
posicaoAspirador(posicaoX, posicaoY); %posicionar o APA nas posi��es estabelecidas anteriormente
hold off;
pause(1);

%se a c�lula estiver suja ent�o retornar� 1, caso contr�rio, 0
salaSuja = sala(posicaoX, posicaoY)==2;

%gera uma vari�vel de estrutura para saber a posi��o e o estado de cada
%c�lula = struct('nome', valor) - veja a fun��o struct
percepcao = struct('x', posicaoX, 'y', posicaoY, 'estado', salaSuja);

%---a��es do agente---
acoesAg = {'acima', 'abaixo', 'esquerda', 'direita', 'aspirar'};

contador = 0;

while 1
    
    
    %escolhe a a��o de acordo com a percep��o - chama fun��o agenteReativoSimples
    acao = agenteReativoSimples(percepcao);
    
    %chama a fun��o atualizaAmbiente para atualizar a a��o realizada
    [sala, modX, modY] = atualizaAmbiente(sala, acao, percepcao.x, percepcao.y);
    
    %Mostra na tela as a��es escolhidas e percep��es (veja as fun��es 'disp' e 'num2str')
    %disp{(['Estado da percepcao -> ' num2str(percepcao.estado) '| Acao escolhida: ' acoesAg(acao)])}
    
    %mostra o ambiente atualizado
    mostraAmbiente(sala);
    
    %posiciona o aspirador no ambiente atualizado
    hold on;
    posicaoAspirador(modX, modY);
    hold off;
    pause(0.15);
    
    %atualiza a percep��o e o estado depois de concluir a a��o
    percepcao.x = modX;
    percepcao.y = modY;
    
    percepcao.estado = sala(modX, modY)==2;
    
end

disp(contador);

