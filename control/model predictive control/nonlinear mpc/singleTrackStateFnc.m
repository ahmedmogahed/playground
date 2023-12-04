function dxdt = singleTrackStateFnc(x,u)
    % vy: x(1), psi: x(2), psid: x(3), px: x(4), py: x(5)
    m = 1555; % mass of the vehicle
    theta = 2491; % Inertia of the vehicle
    lf = 1.354; % length from front tyre to c.g.
    lr = 1.372; % length from rear tyre to c.g.

    vxft = u(2) * cos(u(1)) + sin(u(1)) * (x(1) + lf * x(3));
    vyft = -u(2) * sin(u(1)) + cos(u(1)) * (x(1) + lf * x(3));
    alphaf = -atan2(vyft, vxft);
    alphar = -atan2(x(1) - lr * x(3), u(2));

    dxdt = zeros(5,1);
    dxdt(1) = (-m * u(2) * x(3) + magicFormula(alphaf) * cos(u(1)) + magicFormula(alphar)) / m;
    dxdt(2) = x(3);
    dxdt(3) = (lf * magicFormula(alphaf) * cos(u(1)) - lr * magicFormula(alphar)) / theta;
    dxdt(4) = u(2) * cos(x(2)) - x(1) * sin(x(2));
    dxdt(5) = x(1) * cos(x(2)) + u(2) * sin(x(2));
end