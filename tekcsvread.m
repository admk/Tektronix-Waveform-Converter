function [dat, type] = tekcsvread(file)
%tekcsvread Read a CSV file written by the TekTronix oscilloscope into a
%matrix
%
%   created by Xitong Gao (gxtfmx@gmail.com) on 9 Feb 2011.
%
%   usage
%       [dat, type] = tekcsvread('~/Desktop/TEK0001.CSV')
%
%   input arguments
%       file - the file path of your CSV file
%   output arguments
%       dat - the data matrix
%       type - the type of the source

% init
pos_ptr = 1;

% open the file
fid = fopen(file);

while ~feof(fid)

    % read the current line
    tline = fgetl(fid);

    % get all locations of comma in line
    comma_locs = findstr(',', tline);

    % read properties
    if pos_ptr < 20

        % get property value
        info_value = tline(comma_locs(1)+1:comma_locs(2)-1);

        switch pos_ptr
            case 1
                % get record length
                rec_length = str2double(info_value);
                % init dat
                dat = zeros(2, rec_length);
            case 7
                % get type
                type = info_value;
        end

    end

    % fill in data
    dat(1, pos_ptr) = str2double(tline(comma_locs(3)+1:comma_locs(4)-1));
    dat(2, pos_ptr) = str2double(tline(comma_locs(4)+1:end));

    % increment position pointer
    pos_ptr = pos_ptr + 1;

end

% done, close the file
fclose(fid);

% return value check
assert(pos_ptr - 1 == rec_length, 'Number of data read does not agree with file.');

end
