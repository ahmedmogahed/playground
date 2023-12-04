function xk1 = singleTrackStateDT0(xk, uk, Ts)

M = 10;
delta = Ts/M;
xk1 = xk;
for ct=1:M
    xk1 = xk1 + delta*singleTrackStateFnc(xk1,uk);
end