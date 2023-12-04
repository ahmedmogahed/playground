nx = 5;
ny = 2;
nu = 2;
nlobj = nlmpc(nx,ny,nu);

%% Prediction and control horizon and sampling time
Ts = 0.1;
p = 20;
c = 1;
nlobj.Ts = Ts;
nlobj.PredictionHorizon = p;
nlobj.ControlHorizon = c;

%% State and output equation
nlobj.Model.StateFcn = "singleTrackStateDT0";
nlobj.Model.IsContinuousTime = false;
nlobj.Model.OutputFcn = @(x,u,Ts) [x(4); x(5)];
nlobj.Model.NumberOfParameters = 1;

%% Weights
nlobj.Weights.OutputVariables = [30 90];
nlobj.Weights.ManipulatedVariablesRate = [40,80];

%% sample time
nloptions = nlmpcmoveopt;
nloptions.Parameters = {Ts};

%% reference trajectory
yref=csvread("position.csv");

%% initial conditions
x0 = [0; 0; 0; yref(1,1); yref(1,2)];
u0 = zeros(nu,1); 
validateFcns(nlobj,x0,u0,[], {Ts});

x = x0;
y = [x(4);x(5)];
mv = u0;

%% simulation
Duration = 10;
xHistory = x;
index = 1;
for ct = 1:(Duration/Ts)
    % Ignoring the estimation of hidden states
    [mv,nloptions] = nlmpcmove(nlobj,x,mv,yref(index,:),[],nloptions);
    % Implement first optimal control move
    x = singleTrackStateDT0(x,mv,Ts);
    % Save plant states
    xHistory = [xHistory x];
    index = index+1;
end


%% plotting
timespan = 0:Ts:Duration;
tiledlayout(2,1)

nexttile
plot(timespan,xHistory(4,:),timespan,yref(:,1))
title('Pos x')

nexttile
plot(timespan,xHistory(5,:),timespan,yref(:,2))
title('Pos y')