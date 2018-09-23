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
posicaoSuja = sala(posicaoX, posicaoY)==2;

%gera uma variável de estrutura para saber a posição e o estado de cada
%célula = struct('nome', valor) - veja a função struct
%percepcao = struct('x', posicaoX, 'y', posicaoY, 'estado', salaSuja);

%---ações do agente---
acoesAg = {'acima', 'abaixo', 'esquerda', 'direita', 'aspirar'};

contador = 0;
acao = 0;

funcaoMapear = [2 2 4;
                2 3 4;
                2 4 4;
                2 5 2;
                3 5 3;
                3 4 3;
                3 3 3;
                3 2 2;
                4 2 4;
                4 3 4;
                4 4 4;
                4 5 2;
                5 5 3;
                5 4 3;
                5 3 3];
%exibir = sprintf('Acao no: %d Acao executada: %s',num2str(contador),num2str(acao));
 
continuar = 1;

while (continuar);
  
  if(ismember(2,sala))
    if(sala(posicaoX,posicaoY) == 2)
      acao = 5;
      contador = contador+1;
      disp(['Movimentacao no: ', num2str(contador),' Acao executada: ', num2str(acao)]);
     else
      for i = 1:size(funcaoMapear, 1)
        if posicaoX == funcaoMapear(i, 1) && posicaoY == funcaoMapear(i, 2)
        acao = funcaoMapear(i, 3);
        end
      end
      contador = contador+1;
      disp(['Movimentacao no: ', num2str(contador),' Acao executada: ', num2str(acao)]);
    end
    [modSala, modX, modY] = atualizaAmbiente(sala, acao, posicaoX, posicaoY);
    sala = modSala;
    mostraAmbiente(sala);
    hold on;
    posicaoAspirador(modX, modY);
    hold off;
    pause(0.15);
    posicaoX = modX;
    posicaoY = modY;
  else
    continuar = 0;
    acao = 6;
    contador = contador+1;
  end

endwhile
disp(['Total de movimentacoes: ', num2str(contador)]);
