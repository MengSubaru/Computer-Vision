%ʹ�ô˽ű�֮ǰ����յڶ��еĸ�ʽ����vlfeat��������Ϣ��ȷ�������ҵ���غ���
%run('../vlfeat-0.9.21/toolbox/vl_setup.m');

imga = imread('uttower1.jpg');% tree1.png
imgb = imread('uttower2.jpg');% tree2.png

img1 = single(rgb2gray(imga));
img2 = single(rgb2gray(imgb));

[f1, d1] = vl_sift(img1);
[f2, d2] = vl_sift(img2);
matches= vl_ubcmatch(d1, d2, 10.0);% ����RANSAC�㷨�뽫�˴���10.0����Ϊ4.0
%����������THRESH��ѡ���Ӱ��Ч�ʺͽ����THRESHԽ��Խ�죬ѡ��Ķ�Ӧ��Խ�٣�THRESHԽСԽ����ѡ��Ķ�Ӧ��Խ�൫�Ǵ���ƥ��ĵ��Ҳ������

points_a = zeros(size(matches, 2), 2);
points_a(:, 1) = f1(1, matches(1, :));
points_a(:, 2) = f1(2, matches(1, :));

points_b = zeros(size(matches, 2), 2);
points_b(:, 1) = f2(1, matches(2, :));
points_b(:, 2) = f2(2, matches(2, :));

% ѡ��RANSACɸ����������ѡ��ʹ��RANSAC���㵥Ӧ�Ծ��󣬷��������homography_matrix���㵥Ӧ�Ծ���
%H = RANSAC(points_a, points_b);
H = homography_matrix(points_a, points_b);

[outputImage, x, y] = Warping(H, imga);

mergedImage = output_mosaic(imgb, outputImage, x, y);

figure;
imshow(mergedImage);