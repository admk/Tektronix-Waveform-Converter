function fig = tekfigure(file, varargin)
%tekfigure Return the figure handle that plots the data from the CSV file
%generated from the Tektronix oscilloscope
%
%   created by Xitong Gao (gxtfmx@gmail.com) on 9 Feb 2011.
%
%   usage
%       fig = tekfigure(file,visible)
%
%   input arguments
%       file - the file path of your CSV file
%       visible - should the figure be visible
%   output arguments
%       fig - the figure handle of the plot


visible = parseArguments(varargin);

% reads the data
[dat, type] = tekcsvread(file);

% figure
fig = figure('visible', visible);
set(fig, 'Position', [1 1 768 512]);

% plot
plot(dat(1,:), dat(2,:), 'Color', [0.6 0.2 0]);

% ranges
x_min = min(dat(1,:));
x_max = max(dat(1,:));
y_min = min(dat(2,:));
y_max = max(dat(2,:));
axis([x_min x_max y_min y_max]);

% style
box off;

% labels
switch type

    case 'MATH'
        xlabel('Frequency (Hz)');
        ylabel('Magnitude (dB)');

    case {'CH1', 'CH2'}
        xlabel('Time (s)');
        ylabel('Amplitude (V)');

end

end


function [visible] = parseArguments(arg)
%parseArguments

visible = 'off';

if ~isempty(arg)
    % visible
    if ~isempty(arg{1})
        if arg{1}
            visible = 'on';
        end
    end
end

end
