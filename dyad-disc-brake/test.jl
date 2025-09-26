using Pkg

Pkg.activate(".")
using Revise

using DifferentialEquations
using ModelingToolkit
using Plots
using Unitful

include("./src/DiscBrakeThermal.jl")

function simulate()
    @mtkbuild brake = DiscBrakeThermal()

    tspan = (0.0, 30.0)
    prob = ODEProblem(brake, [], tspan)
    sol = solve(prob)
    display(plot(sol, idxs=[brake.rotor.port.T, brake.pad.port.T],
        xlabel="time (s)", ylabel="temperature (K)",
        label=["Rotor" "Pad"]))
end

simulate()
