%Para chamar as funções do aspirador de pó automatico (APA) baseado em um agente
%reativo simples
clear all;clc; close all;


%---Ambiente---
sala = geraAmbiente(); %Gerar o ambiente
mostraAmbiente(sala); %Mostrar o ambiente
%Coordernadas de início do agente aspirador de pó
posicaoX = 2;
posicaoY = 2;

%pesquise para ver para que servem as funções (hold on, hold off e pause)
hold on; %mantém estático o ambiente feito anteriormente para posicionar o limpador
posicaoAspirador(posicaoX, posicaoY); %posicionar o APA nas posições estabelecidas anteriormente
hold off;
pause(1);

%se a célula estiver suja então retornará 1, caso contrário, 0
salaSuja = sala(posicaoX, posicaoY)==2;

%gera uma variável de estrutura para saber a posição e o estado de cada
%célula = struct('nome', valor) - veja a função struct
percepcao = struct('x', posicaoX, 'y', posicaoY, 'estado', salaSuja);

%---ações do agente---
acoesAg = {'acima', 'abaixo', 'esquerda', 'direita', 'aspirar'};

contador = 0;

while 1
    
    
    %escolhe a ação de acordo com a percepção - chama função agenteReativoSimples
    acao = agenteReativoSimples(percepcao);
    
    %chama a função atualizaAmbiente para atualizar a ação realizada
    [sala, modX, modY] = atualizaAmbiente(sala, acao, percepcao.x, percepcao.y);
    
    %Mostra na tela as ações escolhidas e percepções (veja as funções 'disp' e 'num2str')
    %disp{(['Estado da percepcao -> ' num2str(percepcao.estado) '| Acao escolhida: ' acoesAg(acao)])}
    
    %mostra o ambiente atualizado
    mostraAmbiente(sala);
    
    %posiciona o aspirador no ambiente atualizado
    hold on;
    posicaoAspirador(modX, modY);
    hold off;
    pause(0.15);
    
    %atualiza a percepção e o estado depois de concluir a ação
    percepcao.x = modX;
    percepcao.y = modY;
    
    percepcao.estado = sala(modX, modY)==2;
    
end

disp(contador);

