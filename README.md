# Collector-Log for Windows
Se trata de um coletor de log full para analise futura, o qual exporta os logs para .CSV ou .EVTX.
A proposta e realizar a coleta de logs na máquina o qual possa estar passando por uma análise forense para evitar ao máximo contato com a máquina.

    1-Ao executar o script deve se verificar se possui permissão de ADMIN e se possui permissão para executar script.
    2-O comando para permissão de execução de script é esse "Set-ExecutionPolicy RemoteSigned"

Ao executar o script o mesmo irá criar uma pasta local e irá criar arquivos contendo os dados dos logs da máquina.
![image](https://github.com/geovanidps/Collector-log/assets/68928130/970e71df-2b7b-4cec-bc14-2bf4fc26a9ac)

Após a execução e finalização da coleta será possível ver os arquivos criados e um arquivo em .zip contendo todos os logs coletados.
O que facilita para análise futura ou em outro servidor.

![Capturar](https://github.com/geovanidps/Collector-log/assets/68928130/269977f7-640a-46cd-9212-89561d1d32aa)
