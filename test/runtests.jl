using GeometricFlux
using GeometricFlux.Datasets
using CUDA
using Flux
using Flux: @functor
using FillArrays
using GraphSignals
using Graphs: SimpleGraph, SimpleDiGraph, add_edge!, nv, ne
using LinearAlgebra
using NNlib
using SparseArrays: SparseMatrixCSC
using Statistics: mean
using Zygote
using Test

cuda_tests = [
    # "cuda/conv",
    # "cuda/msgpass",
]

tests = [
    "layers/gn",
    "layers/msgpass",
    "layers/conv",
    "layers/pool",
    "layers/misc",
    "models",
]

if CUDA.functional()
    using Flux: gpu
    using NNlibCUDA
    append!(tests, cuda_tests)
else
    @warn "CUDA unavailable, not testing GPU support"
end

@testset "GeometricFlux" begin
    for t in tests
        include("$(t).jl")
    end
end
