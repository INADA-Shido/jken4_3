clear;

% データの準備（例のデータ）
setSize = [4, 8, 16];

% 探索時間（行: 条件, 列: セットサイズ）
% [直線+あり; 直線+なし; 曲線+あり; 曲線+なし]

A = importdata('data1270292.txt', ',',   1);
data = A.data;

data = data(12:end, :);

data(data(:, 7) == 1, :) = [];

target_in_data = data(data(:, 4) == 1, :);
target_no_data = data(data(:, 4) == 2, :);

circle_data1 = target_in_data(target_in_data(:, 5) == 1, :);
circle_data2 = target_no_data(target_no_data(:, 5) == 1, :);

branch_data1 = target_in_data(target_in_data(:, 5) == 2, :);
branch_data2 = target_no_data(target_no_data(:, 5) == 2, :);

mean_circle_data1 = [mean(circle_data1(circle_data1(:, 6) == 4, 8)), ...
    mean(circle_data1(circle_data1(:, 6) == 8, 8)), ...
    mean(circle_data1(circle_data1(:, 6) == 16, 8))];
mean_circle_data2 = [mean(circle_data2(circle_data2(:, 6) == 4, 8)), ...
    mean(circle_data2(circle_data2(:, 6) == 8, 8)), ...
    mean(circle_data2(circle_data2(:, 6) == 16, 8))];

mean_branch_data1 = [mean(branch_data1(branch_data1(:, 6) == 4, 8)), ...
    mean(branch_data1(branch_data1(:, 6) == 8, 8)), ...
    mean(branch_data1(branch_data1(:, 6) == 16, 8))];
mean_branch_data2 = [mean(branch_data2(branch_data2(:, 6) == 4, 8)), ...
    mean(branch_data2(branch_data2(:, 6) == 8, 8)), ...
    mean(branch_data2(branch_data2(:, 6) == 16, 8))];

% プロット
figure(1);
hold on;

% 直線条件（破線）
plot(setSize, mean_circle_data1, 'k--^', 'LineWidth', 1.5, 'MarkerSize', 8); % △ 目標あり
plot(setSize, mean_circle_data2, 'k--o', 'LineWidth', 1.5, 'MarkerSize', 8); % ○ 目標なし

% 曲線条件（実線）
plot(setSize, mean_branch_data1, 'k-^', 'LineWidth', 1.5, 'MarkerSize', 8);  % △ 目標あり
plot(setSize, mean_branch_data2, 'k-o', 'LineWidth', 1.5, 'MarkerSize', 8);  % ○ 目標なし

% 軸ラベル
xlabel('セットサイズ');
ylabel('探索時間（ミリ秒）');

% 凡例
legend({'〇 目標刺激あり', '〇 目標刺激なし', ...
        '〇+| 目標刺激あり', '〇+| 目標刺激なし'}, ...
        'Location', 'northwest');

% 軸の範囲調整（任意）
ylim([500 1800]);
xlim([3 17]);
xticks([4 8 16]);

% グリッドを消す（必要に応じて）
grid off;

% フォントサイズなど整える
set(gca, 'FontSize', 12);