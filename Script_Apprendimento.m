%% Calcoliamo il vettore età

num_partecipanti=90;
min_eta=19;
max_eta=27;
eta_media=(min_eta+max_eta)/2;
dev_standard_eta=2;
eta=normrnd(eta_media,dev_standard_eta,num_partecipanti,1);
eta(eta<min_eta)=min_eta;
eta(eta>max_eta)=max_eta;
eta=round(eta);
histogram(eta);

%% Sesso 

v=randi([0,1], num_partecipanti,1); %vettore random formato da 0 e 1 (da convertire in F=0, M=1 con Excel)

%% UMANISTICO
% 1) Punteggio cartaceo umanistico=pcu
min_pcu=0;
max_pcu=10; 
media_pcu=5.5;
dev_standard_pcu=2;

punteggio_pcu=normrnd(media_pcu, dev_standard_pcu, num_partecipanti, 1);
punteggio_pcu(punteggio_pcu<min_pcu)=min_pcu;
punteggio_pcu(punteggio_pcu>max_pcu)=max_pcu;
punteggio_pcu=round(punteggio_pcu);
histogram(punteggio_pcu)

% 2) punteggio digitale umanistico=pdu
min_pdu=0;
max_pdu=10;
media_pdu=8;
dev_standard_pdu=2;

punteggio_pdu=normrnd(media_pdu, dev_standard_pdu, num_partecipanti, 1);
punteggio_pdu(punteggio_pdu<min_pcu)=min_pdu;
punteggio_pdu(punteggio_pdu>max_pcu)=max_pdu;
punteggio_pdu=round(punteggio_pdu);
histogram(punteggio_pdu)

%% STEM
% 3) Punteggio cartaceo STEM=pcs
min_pcs=0;
max_pcs=10;
media_pcs=4;
dev_standard_pcs=2;

punteggio_pcs=normrnd(media_pcs, dev_standard_pcs, num_partecipanti, 1);
punteggio_pcs(punteggio_pcs<min_pcs)=min_pcs;
punteggio_pcs(punteggio_pcs>max_pcs)=max_pcs;
punteggio_pcs=round(punteggio_pcs);
histogram(punteggio_pcs)

% 4) Punteggio digitale STEM=pds
min_pds=0;
max_pds=10;
media_pds=9;
dev_standard_pds=2;

punteggio_pds=normrnd(media_pds, dev_standard_pds, num_partecipanti, 1);
punteggio_pds(punteggio_pds<min_pds)=min_pds;
punteggio_pds(punteggio_pds>max_pds)=max_pds;
punteggio_pds=round(punteggio_pds);
histogram(punteggio_pds)

%% Punteggio al TPQS (tra 10 e 50)

min_tpqs=10;
max_tpqs=50;
media_tpqs=40;
dev_standard_tpqs=6;

punteggio_tpqs=normrnd(media_tpqs, dev_standard_tpqs, num_partecipanti, 1);
punteggio_tpqs(punteggio_tpqs<min_tpqs)=min_tpqs;
punteggio_tpqs(punteggio_tpqs>max_tpqs)=max_tpqs;
punteggio_tpqs=round(punteggio_tpqs);
histogram(punteggio_tpqs)

%% Normalizzazione dei punteggi (metodo min-max)

pcu_norm=round((punteggio_pcu-min(punteggio_pcu))/(max(punteggio_pcu)-min(punteggio_pcu)),3);
pdu_norm=round((punteggio_pdu-min(punteggio_pdu))/(max(punteggio_pdu)-min(punteggio_pdu)),3);
pcs_norm=round((punteggio_pcs-min(punteggio_pcs))/(max(punteggio_pcs)-min(punteggio_pcs)),3);
pds_norm=round((punteggio_pds-min(punteggio_pds))/(max(punteggio_pds)-min(punteggio_pds)),3);
tpqs_norm=round((punteggio_tpqs-min(punteggio_tpqs))/(max(punteggio_tpqs)-min(punteggio_tpqs)),3);

%% Correlazione tra Punteggio Digitale STEM e TPQS

corr_desiderata=0.70;

% vettore TPQS correlato al vettore PDS
tpqs2 = corr_desiderata * pds_norm + sqrt(1 - corr_desiderata^2) * tpqs_norm;
tpqs_norm2=round((tpqs2-min(tpqs2))/(max(tpqs2)-min(tpqs2)),3); % normalizziamo
c=corrcoef(pds_norm, tpqs_norm2); % ricalcoliamo il coefficiente di correlazione per vedere se può andare bene

%% Tabella da caricare in JASP

tabella_progetto=table(pcu_norm, pdu_norm, pcs_norm, pds_norm, tpqs_norm2, 'VariableNames', ... 
    {'Punteggio Cartaceo Umanistico','Punteggio Digitale Umanistico', ...
    'Punteggio Cartaceo STEM', 'Punteggio Digitale STEM', 'Punteggio al TPQS'});

filename='tabella_progetto.csv';
writetable(tabella_progetto, filename);









