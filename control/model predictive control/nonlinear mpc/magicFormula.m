function Fy = magicFormula(alpha, Fz, gamma)
    arguments
        alpha
        Fz = 2000
        gamma = 0
    end
    a1 = -22.1; a2 = 1011; a3 = 1078; a4 = 1.82; a5 = 0.208; a6 = 0.000;
    a7 = -0.354; a8 = 0.707; a9 = 0.028; a10 = 0.000; a11 = 14.8; a12 = 0.022;

    % IMPORTANT conversions (forces in `kN` and angles in `deg`)
    alphad = rad2deg(alpha); gammad = rad2deg(gamma); Fzk = Fz / 1e3;

    % Formula equations
    C = 1.3;
    D = a1 * Fzk ^ 2 + a2 * Fzk;
    B = a3 * sin(a4 * atan(a5 * Fzk)) / (C * D) * (1 - a12 * abs(gammad));
    E = a6 * Fzk ^ 2 + a7 * Fzk + a8;

    DSh = a9 * gammad;
    DSv = (a10 * Fzk ^ 2 + a11 * Fzk) * gammad;
    alphaDSh = alphad + DSh;
    phi = (1 - E) * alphaDSh + E / B * atan(B * alphaDSh);

    % Equation
    Fy = D * sin(C * atan(B * phi)) + DSv;
end