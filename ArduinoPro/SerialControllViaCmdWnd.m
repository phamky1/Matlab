x=serial('COM8','BAUD', 9600);


try
    fopen(x);
catch
    try
        
        %delete(instrfindall);
        fclose(instrfindall);
        fopen(x);
    catch
        fprintf('\n\ncan not open com8\n');
        fprintf('check that you plug your controller to com8\n')
        return
    end
end


go = true;
while go
    
    a= input('Press 1 to turn ON LED & 0 to turn OFF:','s');
    switch a
        case {'1','0'}
            fprintf(x,a);
        otherwise
            fprintf('undefind input close  program ...\n')
            go =false;
    end
    
    
end

fclose(x);
