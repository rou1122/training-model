[name, label]=textread('train.txt','%s%d');
[row, col]=size(label);
multilabel=zeros(row, 100);
for i = 1:row
     multilabel(i, label(i,1))=1;
end
filename = 'name.txt';
dlmwrite(filename, 1);
xlswrite(filename, name);
[file, num]=textread('name.txt','%d%s','delimiter','/');
filename = 'name.txt';
dlmwrite(filename, 1);
xlswrite(filename, num);
[num, type]=textread('name.txt','%d%s','delimiter','.');
multifood = dlmread('multifood.txt', ' ');
for j = 1:1174
idx = find( ismember( num, multifood(j,1)  , 'rows' ) );
[row_idx,col_idx]=size(idx);
    for k = 1:row_idx
        for l = 2:14
            if multifood(j,l)~=0
                multilabel(idx(k),multifood(j,l))=1;
            end
        end
    end
end
file_out= fopen('train1.txt','w');
for r = 1:row
    fprintf(file_out,'%.0f/%.0f.jpg ',file(r,1),num(r,1));
    for s = 1:100
        fprintf(file_out,' %.0f ',multilabel(r,s));
    end
    fprintf(file_out,'\n');
end
fclose(file_out);