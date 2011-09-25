function tekfiguresave(varargin)
%tekfiguresave A UI front-end to recursively find and save plots from CSV waveform files.
%By default it saves eps files. The file type can be customised in the
%input argument of this function. For example
%       tekfiguresave('pdf')
%
%   created by Xitong Gao (gxtfmx@gmail.com) on 9 Feb 2011.
%
%   usage
%       tekfiguresave(fileformat, replace)
%
%   input arguments
%       fileformat - the file format of the generated image file, supports
%       EPS, PDF, PNG, JPEG, TIFF, BMP and more.
%       replace - should the file to be exported happened to have the same
%       file name be replaced?
%


[f_type, replace] = parseArguments(varargin);

% prompt for file directory
path = uigetdir('', 'Choose a path to load files');

if ~path
    return
end

save_cnt = 0;
[~,~, files] = dirr(path,'name','\.csv$');

for fileIndex = 1:numel(files)

    % current file path
    cfile = files{fileIndex};
    ofile = strcat(cfile(1:end-4),'.', f_type);

    fprintf('reading \n\t%s\n', cfile);

    % don't do anything if file exists
    if ~replace
        if exist(ofile, 'file')
            fprintf('\tfile already exists: %s\n', ofile);
            continue
        end
    end

    try
        % open csv and plot
        fig = tekfigure(cfile);

        % save figure
        saveas(fig, ofile, f_type);
        save_cnt = save_cnt + 1;

        % close figure
        close(fig);
    catch e
        fprintf('\tincompatible csv file.\n');
    end
end

fprintf('saved %d %s files.\n', save_cnt, f_type);

end


function [f_type, replace] = parseArguments(arg)
%parseArguments

% file type
f_type = 'eps';
% should replace old exported file
replace = false;

if ~isempty(arg)
    if ~isempty(arg{1})
        f_type = arg{1};
    end
end

if length(arg) > 1
    if ~isempty(arg{2})
        replace = arg{2};
    end
end

end
