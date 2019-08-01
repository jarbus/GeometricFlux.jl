using Flux: Dense

in_channel = 3
out_channel = 5
N = 4
adj = [0. 1. 0. 1.;
       1. 0. 1. 0.;
       0. 1. 0. 1.;
       1. 0. 1. 0.]

@testset "Test InnerProductDecoder layer" begin
   ipd = InnerProductDecoder(identity)
   Y = ipd(rand(N))
   @test size(Y) == (N, N)

   Y = ipd(rand(N, in_channel))
   @test size(Y) == (N, N)
end

@testset "Test VariationalEncoder layer" begin
    z_dim = 2
    gc = GCNConv(adj, in_channel=>out_channel)
    ve = VariationalEncoder(gc, out_channel, z_dim)
    X = rand(N, in_channel)
    Z = ve(X)
    @test size(Z) == (N, z_dim)
end

@testset "Test GAE model" begin
    gc = GCNConv(adj, in_channel=>out_channel)
    gae = GAE(gc)
    X = rand(N, in_channel)
    Y = gae(X)
    @test size(Y) == (N, N)
end

@testset "Test VGAE model" begin
    z_dim = 2
    gc = GCNConv(adj, in_channel=>out_channel)
    vgae = VGAE(gc, out_channel, z_dim)
    X = rand(N, in_channel)
    Y = vgae(X)
    @test size(Y) == (N, N)
end
