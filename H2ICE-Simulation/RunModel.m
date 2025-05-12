engine_speed = 1500;
    stepsize = (60/engine_speed)/1000;
    sim_time = stepsize * (2*1000 - 1);
sim('HydICengine');
