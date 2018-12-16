%%read data from serial
clc;clear;
s=serial('com8');
fopen(s);

while(true)
    fprintf(fscanf(s))
end