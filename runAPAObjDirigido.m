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

%---ações do agente---
acoesAg = {'acima', 'abaixo', 'esquerda', 'direita', 'aspirar'};

%Variaveis de configuração
contador = 0;
%Vetor vazio
listaAcoes = int16([]);
inicio = 1;

%Localização sujeira
[sujeiraX,sujeiraY] = find(sala == 2)

%Concatena as matrizes
sujeiraTotal = [sujeiraX,sujeiraY];
%Ordena a matriz  em ordem crescente pela coluna 1
sujeiraTotalOrd = sortrows(sujeiraTotal,1);

%Adicionar no fim do array
%teste = [teste, 2]
%Remover primeiro do array
%teste = teste(2:end)

disp(['------------------------------------------------------------------']);
disp(['Sala:']);
disp(sala);
disp(['------------------------------------------------------------------']);
disp(['Acoes:']);
disp(['1 = Acima | 2 = Abaixo | 3 = Esquerda | 4 = Direita | 5 = Aspirtar']);
disp(['------------------------------------------------------------------']);
disp(['Movimentacoes:']);
disp(['']);
tempX = posicaoX;
tempY = posicaoY;

%verifica se a primeira posicao é suja, se sim seta o inicio como a segunda linha
if(sujeiraTotalOrd(1,1) == posicaoX && sujeiraTotalOrd(1,2) == posicaoY)
  listaAcoes = [listaAcoes, 5];
  inicio = 2;
end

%Cria um roteiro de acoes a serem executadas
for i = inicio:size(sujeiraX,1)
  %Diminui a posicao atual da posicao da sujeira, calculando o caminho pela ditancia Manhattan
  saldoX = (tempX - sujeiraTotalOrd(i,1));
  saldoY = (tempY - sujeiraTotalOrd(i,2));  
  %Verifica de o saldoX é negativo, se sim está abaixo, e adiciona a acao 2 X vezes
  if(saldoX < 0)
    %Transforma o valor negativo em positivo
    saldoX = abs(saldoX);
    for fX = 1:saldoX
      listaAcoes = [listaAcoes,2];
    end
  %Se o saldoX é positivo, a sujeira está acima, entao adiciona a acao 1 X vezes
  elseif(saldoX > 0)
    for fX = 1:saldoX
      listaAcoes = [listaAcoes,1];
    end
  end
  %Verifica se o saldoY é negativo a sujeira está a direita (2-5) = -3, entao adiciona a acao 4 X vezes;
  if(saldoY < 0)
    saldoY = abs(saldoY);
    for fY = 1:saldoY
      listaAcoes = [listaAcoes,4];
    end
  %Se o saldoY é positivo a sujeira está a esquerda (3-2) = 1, entao adiciona a acao 3 X vezes;
  elseif(saldoY > 0)
    for fY = 1:saldoY
      listaAcoes = [listaAcoes,3];
    end
  end
  listaAcoes = [listaAcoes,5];
  %Seta a coordenada para a proxima movimentacao como a ultima posicao da sujeira
  tempX = sujeiraTotalOrd(i,1);
  tempY = sujeiraTotalOrd(i,2);
end
  
for j = 1:length(listaAcoes)
  %executa as acoes estabelecidas anteriormente
  contador = contador+1;
  disp(['Movimentacao no: ', num2str(contador),' Acao executada: ', num2str(listaAcoes(j))]);
  [modSala, modX, modY] = atualizaAmbiente(sala, listaAcoes(j), posicaoX, posicaoY);
  sala = modSala;
  mostraAmbiente(sala);
  hold on;
  posicaoAspirador(modX, modY);
  hold off;
  pause(0.15);
  posicaoX = modX;
  posicaoY = modY;
end
contador = contador+1;
disp(['Movimentacao no: ', num2str(contador),' Acao executada: 6']);
disp(['']);
disp(['------------------------------------------------------------------']);
disp(['']);
disp(['Total de movimentacoes: ', num2str(contador - size(sujeiraX,1))]);
disp(['Total de lixo coletado: ', num2str(size(sujeiraX,1))]);
disp(['Total de acoes: ', num2str(contador)]);

%{
  Documentação utilizada:
  https://www.mathworks.com/matlabcentral/answers/122-how-do-i-comment-out-a-large-block-of-code-in-matlab
  https://www.mathworks.com/help/matlab/math/creating-and-concatenating-matrices.html
  https://www.mathworks.com/help/matlab/ref/sortrows.html
  https://www.mathworks.com/matlabcentral/answers/343993-how-do-i-convert-all-negative-elements-in-a-matrix-to-positive-elements-such-that-the-sum-of-he-val
  https://www.mathworks.com/help/matlab/ref/empty.html
  https://www.mathworks.com/help/matlab/ref/if.html
  https://www.mathworks.com/matlabcentral/answers/289860-remove-first-element-of-array-and-add-element-to-the-end-fifo-array
  https://www.mathworks.com/matlabcentral/answers/283821-add-single-element-to-array-or-vector
  https://www.mathworks.com/help/matlab/ref/disp.html
  https://www.mathworks.com/help/matlab/ref/find.html
  
  Renato Constancio Filho
%}
  
