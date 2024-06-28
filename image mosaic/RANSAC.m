function H = RANSAC (points_a, points_b)
    %points_a,bΪ�����㷨��ʼѡ����ƥ��㼯�����д���������

    H = []; %��Ϊ����ĵ�Ӧ�Ծ���
    matches_points = 0; %�ڵ����ĵ�Ӧ�Ծ����������ڵ���Ŀ

    num = size(points_a, 1);

    src_points = ones(3, num);
    src_points(1, :) = points_a(:, 1);
    src_points(2, :) = points_a(:, 2);

    idx = randperm(num, 25); %��ʼ���ѡȡ���ɸ��ڵ�

    a = points_a(idx, :);
    b = points_b(idx, :);

    for i = 1 : 10 %������������Ҫ�������ѡ��

        tmp_H = homography_matrix(a, b); %�ɵ�ǰ�ڵ�������H

        tar_points = tmp_H * src_points;
        tar_points = permute(tar_points(1:2, :), [2, 1]);

        res = tar_points - points_b;
        res = res .* res;
        dis = sqrt(res(:, 1) + res(:, 2));

        logical_vector = dis < 30; %���ڽ綨�ڵ��threshold

        a = points_a(logical_vector, :);
        b = points_b(logical_vector, :);

        if size(a, 1) > matches_points
            H = tmp_H;
            matches_points = size(a, 1);
        end

    end
    
end