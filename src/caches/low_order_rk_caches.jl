@cache struct EulerCache{uType,rateType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  tmp::uType
  k::rateType
  fsalfirst::rateType
end

@cache struct SplitEulerCache{uType,rateType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  tmp::uType
  k::rateType
  fsalfirst::rateType
end

function alg_cache(alg::SplitEuler,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  SplitEulerCache(u,uprev,similar(u),zero(rate_prototype),zero(rate_prototype))
end

struct SplitEulerConstantCache <: OrdinaryDiffEqConstantCache end

alg_cache(alg::SplitEuler,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = SplitEulerConstantCache()

function alg_cache(alg::Euler,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  EulerCache(u,uprev,similar(u),zero(rate_prototype),zero(rate_prototype))
end

struct EulerConstantCache <: OrdinaryDiffEqConstantCache end

alg_cache(alg::Euler,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = EulerConstantCache()

@cache struct HeunCache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  tmp::uType
  atmp::uNoUnitsType
  k::rateType
  fsalfirst::rateType
end

@cache struct RalstonCache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  tmp::uType
  atmp::uNoUnitsType
  k::rateType
  fsalfirst::rateType
end

function alg_cache(alg::Heun,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  HeunCache(u,uprev,similar(u),similar(u, uEltypeNoUnits),zero(rate_prototype),
            zero(rate_prototype))
end

function alg_cache(alg::Ralston,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  RalstonCache(u,uprev,similar(u),similar(u, uEltypeNoUnits),zero(rate_prototype),
               zero(rate_prototype))
end

struct HeunConstantCache <: OrdinaryDiffEqConstantCache end

alg_cache(alg::Heun,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = HeunConstantCache()

struct RalstonConstantCache <: OrdinaryDiffEqConstantCache end

alg_cache(alg::Ralston,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = RalstonConstantCache()

@cache struct MidpointCache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k::rateType
  tmp::uType
  atmp::uNoUnitsType
  fsalfirst::rateType
end

struct MidpointConstantCache <: OrdinaryDiffEqConstantCache end

function alg_cache(alg::Midpoint,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tmp = similar(u); atmp = similar(u, uEltypeNoUnits)
  k = zero(rate_prototype)
  fsalfirst = zero(rate_prototype)
  MidpointCache(u,uprev,k,tmp,atmp,fsalfirst)
end

alg_cache(alg::Midpoint,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = MidpointConstantCache()

@cache struct RK4Cache{uType,rateType,uNoUnitsType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  fsalfirst::rateType
  k₂::rateType
  k₃::rateType
  k₄::rateType
  k::rateType
  tmp::uType
  atmp::uNoUnitsType
end

struct RK4ConstantCache <: OrdinaryDiffEqConstantCache end

function alg_cache(alg::RK4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  k₁ = zero(rate_prototype)
  k₂ = zero(rate_prototype)
  k₃ = zero(rate_prototype)
  k₄ = zero(rate_prototype)
  k  = zero(rate_prototype)
  tmp = similar(u); atmp = similar(u, uEltypeNoUnits)
  RK4Cache(u,uprev,k₁,k₂,k₃,k₄,k,tmp,atmp)
end

alg_cache(alg::RK4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = RK4ConstantCache()

@cache struct BS3Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  fsalfirst::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::BS3,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = BS3ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  BS3Cache(u,uprev,k1,k2,k3,k4,utilde,tmp,atmp,tab)
end

alg_cache(alg::BS3,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = BS3ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))


@cache struct OwrenZen3Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::OwrenZen3,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = OwrenZen3ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  OwrenZen3Cache(u,uprev,k1,k2,k3,k4,utilde,tmp,atmp,tab)
end

alg_cache(alg::OwrenZen3,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = OwrenZen3ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct OwrenZen4Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::OwrenZen4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = OwrenZen4ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  OwrenZen4Cache(u,uprev,k1,k2,k3,k4,k5,k6,utilde,tmp,atmp,tab)
end

alg_cache(alg::OwrenZen4,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = OwrenZen4ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct OwrenZen5Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  k7::rateType
  k8::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::OwrenZen5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = OwrenZen5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = zero(rate_prototype)
  k7 = zero(rate_prototype)
  k8 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  OwrenZen5Cache(u,uprev,k1,k2,k3,k4,k5,k6,k7,k8,utilde,tmp,atmp,tab)
end

alg_cache(alg::OwrenZen5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = OwrenZen5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct BS5Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  k7::rateType
  k8::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::BS5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = BS5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = zero(rate_prototype)
  k7 = zero(rate_prototype)
  k8 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  BS5Cache(u,uprev,k1,k2,k3,k4,k5,k6,k7,k8,utilde,tmp,atmp,tab)
end

alg_cache(alg::BS5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = BS5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct Tsit5Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  k7::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

@cache struct RK46NLCache{uType,rateType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k::rateType
  tmp::uType
  fsalfirst::rateType
  tab::TabType
end

struct RK46NLConstantCache{T,T2} <: OrdinaryDiffEqConstantCache
  α2::T
  α3::T
  α4::T
  α5::T
  α6::T
  β1::T
  β2::T
  β3::T
  β4::T
  β5::T
  β6::T
  c2::T2
  c3::T2
  c4::T2
  c5::T2
  c6::T2

  function RK46NLConstantCache(::Type{T}, ::Type{T2}) where {T,T2}
    α2 = T(-0.737101392796)
    α3 = T(-1.634740794343)
    α4 = T(-0.744739003780)
    α5 = T(-1.469897351522)
    α6 = T(-2.813971388035)
    β1 = T(0.032918605146)
    β2 = T(0.823256998200)
    β3 = T(0.381530948900)
    β4 = T(0.200092213184)
    β5 = T(1.718581042715)
    β6 = T(0.27)
    c2 = T2(0.032918605146)
    c3 = T2(0.249351723343)
    c4 = T2(0.466911705055)
    c5 = T2(0.582030414044)
    c6 = T2(0.847252983783)
    new{T,T2}(α2, α3, α4, α5, α6, β1, β2, β3, β4, β5, β6, c2, c3, c4, c5, c6)
  end
end

function alg_cache(alg::RK46NL,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tmp = similar(u)
  k = zero(rate_prototype)
  fsalfirst = zero(rate_prototype)
  tab = RK46NLConstantCache(real(uBottomEltypeNoUnits), real(tTypeNoUnits))
  RK46NLCache(u,uprev,k,tmp,fsalfirst,tab)
end

function alg_cache(alg::RK46NL,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  RK46NLConstantCache(real(uBottomEltypeNoUnits), real(tTypeNoUnits))
end

function alg_cache(alg::Tsit5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = Tsit5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = zero(rate_prototype)
  k7 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  Tsit5Cache(u,uprev,k1,k2,k3,k4,k5,k6,k7,utilde,tmp,atmp,tab)
end

alg_cache(alg::Tsit5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = Tsit5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct DP5Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  k7::rateType
  dense_tmp3::rateType
  dense_tmp4::rateType
  update::rateType
  bspl::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::DP5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = k2
  k7 = zero(rate_prototype) # This is FSAL'd to k1
  dense_tmp3 = k2
  dense_tmp4 = k5
  bspl = k3

  tmp = similar(u) # has to be separate for FSAL
  utilde = tmp

  if eltype(u) != uEltypeNoUnits || calck
    update = zero(rate_prototype)
    atmp = similar(u,uEltypeNoUnits)
  else
    update = k7
    atmp = k3
  end

  tab = DP5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  cache = DP5Cache(u,uprev,k1,k2,k3,k4,k5,k6,k7,dense_tmp3,dense_tmp4,update,bspl,utilde,tmp,atmp,tab)
  cache
end

alg_cache(alg::DP5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = DP5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct DP5ThreadedCache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  k7::rateType
  dense_tmp3::rateType
  dense_tmp4::rateType
  update::rateType
  bspl::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::DP5Threaded,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = zero(rate_prototype)
  k7 = zero(rate_prototype)
  dense_tmp3 = zero(rate_prototype)
  dense_tmp4 = zero(rate_prototype)
  update = zero(rate_prototype)
  bspl = zero(rate_prototype)
  utilde = similar(u)
  tmp = similar(u); atmp = similar(u,uEltypeNoUnits)
  tab = DP5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  DP5ThreadedCache(u,uprev,k1,k2,k3,k4,k5,k6,k7,dense_tmp3,dense_tmp4,update,bspl,utilde,tmp,atmp,tab)
end

@cache struct Anas5Cache{uType,rateType,uNoUnitsType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k1::rateType
  k2::rateType
  k3::rateType
  k4::rateType
  k5::rateType
  k6::rateType
  k7::rateType
  utilde::uType
  tmp::uType
  atmp::uNoUnitsType
  tab::TabType
end

function alg_cache(alg::Anas5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tab = Anas5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))
  k1 = zero(rate_prototype)
  k2 = zero(rate_prototype)
  k3 = zero(rate_prototype)
  k4 = zero(rate_prototype)
  k5 = zero(rate_prototype)
  k6 = zero(rate_prototype)
  k7 = zero(rate_prototype)
  utilde = similar(u)
  atmp = similar(u,uEltypeNoUnits)
  tmp = similar(u)
  Anas5Cache(u,uprev,k1,k2,k3,k4,k5,k6,k7,utilde,tmp,atmp,tab)
end

alg_cache(alg::Anas5,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}}) = Anas5ConstantCache(real(uBottomEltypeNoUnits),real(tTypeNoUnits))

@cache struct CFRLDDRK64Cache{uType,rateType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k::rateType
  tmp::uType
  fsalfirst::rateType
  tab::TabType
end

struct CFRLDDRK64ConstantCache{T,T2} <: OrdinaryDiffEqConstantCache
  α1::T
  α2::T
  α3::T
  α4::T
  α5::T
  β1::T
  β2::T
  β3::T
  β4::T
  β5::T
  β6::T
  c2::T2
  c3::T2
  c4::T2
  c5::T2
  c6::T2

  function CFRLDDRK64ConstantCache(::Type{T}, ::Type{T2}) where {T,T2}
    α1 = T(0.17985400977138)
    α2 = T(0.14081893152111)
    α3 = T(0.08255631629428)
    α4 = T(0.65804425034331)
    α5 = T(0.31862993413251)
    β1 = T(0.10893125722541)
    β2 = T(0.13201701492152)
    β3 = T(0.38911623225517)
    β4 = T(-0.59203884581148)
    β5 = T(0.47385028714844)
    β6 = T(0.48812405426094)
    c2 = T2(0.28878526699679)
    c3 = T2(0.38176720366804)
    c4 = T2(0.71262082069639)
    c5 = T2(0.69606990893393)
    c6 = T2(0.83050587987157)
    new{T,T2}(α1, α2, α3, α4, α5, β1, β2, β3, β4, β5, β6, c2, c3, c4, c5, c6)
  end
end

function alg_cache(alg::CFRLDDRK64,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tmp = similar(u)
  k = zero(rate_prototype)
  fsalfirst = zero(rate_prototype)
  tab = CFRLDDRK64ConstantCache(real(uBottomEltypeNoUnits), real(tTypeNoUnits))
  CFRLDDRK64Cache(u,uprev,k,tmp,fsalfirst,tab)
end

function alg_cache(alg::CFRLDDRK64,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  CFRLDDRK64ConstantCache(real(uBottomEltypeNoUnits), real(tTypeNoUnits))
end

@cache struct TSLDDRK74Cache{uType,rateType,TabType} <: OrdinaryDiffEqMutableCache
  u::uType
  uprev::uType
  k::rateType
  tmp::uType
  fsalfirst::rateType
  tab::TabType
end

struct TSLDDRK74ConstantCache{T,T2} <: OrdinaryDiffEqConstantCache
  α1::T
  α2::T
  α3::T
  α4::T
  α5::T
  α6::T
  β1::T
  β2::T
  β3::T
  β4::T
  β5::T
  β6::T
  β7::T
  c2::T2
  c3::T2
  c4::T2
  c5::T2
  c6::T2
  c7::T2

  function TSLDDRK74ConstantCache(::Type{T}, ::Type{T2}) where {T,T2}
    α1 = T(0.241566650129646868)
    α2 = T(0.0423866513027719953)
    α3 = T(0.215602732678803776)
    α4 = T(0.232328007537583987)
    α5 = T(0.256223412574146438)
    α6 = T(0.0978694102142697230)
    β1 = T(0.0941840925477795334)
    β2 = T(0.149683694803496998)
    β3 = T(0.285204742060440058)
    β4 = T(-0.122201846148053668)
    β5 = T(0.0605151571191401122)
    β6 = T(0.345986987898399296)
    β7 = T(0.186627171718797670)
    c2 = T2(0.335750742677426401)
    c3 = T2(0.286254438654048527)
    c4 = T2(0.744675262090520366)
    c5 = T2(0.639198690801246909)
    c6 = T2(0.723609252956949472)
    c7 = T2(0.91124223849547205)
    new{T,T2}(α1, α2, α3, α4, α5, α6, β1, β2, β3, β4, β5, β6, β7, c2, c3, c4, c5, c6, c7)
  end
end

function alg_cache(alg::TSLDDRK74,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{true}})
  tmp = similar(u)
  k = zero(rate_prototype)
  fsalfirst = zero(rate_prototype)
  tab = TSLDDRK74ConstantCache(real(uBottomEltypeNoUnits), real(tTypeNoUnits))
  TSLDDRK74Cache(u,uprev,k,tmp,fsalfirst,tab)
end

function alg_cache(alg::TSLDDRK74,u,rate_prototype,uEltypeNoUnits,uBottomEltypeNoUnits,tTypeNoUnits,uprev,uprev2,f,t,dt,reltol,p,calck,::Type{Val{false}})
  TSLDDRK74ConstantCache(real(uBottomEltypeNoUnits), real(tTypeNoUnits))
end
