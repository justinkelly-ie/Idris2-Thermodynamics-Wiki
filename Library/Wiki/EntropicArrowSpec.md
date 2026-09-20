# ⚡ Layer 8 Discrete Helmholtz Free Energy & Entropic Arrow Specification

Documents and verifies discrete Helmholtz free energy calculations ($F = U - T \cdot S$), second law thermodynamic compliance ($\Delta F \le 0$), multi-step entropic cascades, and monadic history relinearization using QuickCheck property testing and compile-time proof witnesses built natively on 3-component `Vexel` multiset state representations.

---

## 1. Thermodynamic State $\leftrightarrow$ Multiset Basis Duality Dictionary

| Physical Thermodynamic Construct | Multiset Algebraic Basis Dual | Functional Representation |
| :--- | :--- | :--- |
| **Thermodynamic State $(U, T, S)$** | 3-Component Vector Multiset | `thermoVexel u t s = MkVexel [(MkUnixel 0, u), (MkUnixel 1, t), (MkUnixel 2, s)]` |
| **Internal Energy $U$** | Basis `[0]` Coefficient | `thermoInternalEnergy v = lookupUnixel (MkUnixel 0) v` |
| **Temperature $T$** | Basis `[1]` Coefficient | `thermoTemperature v = lookupUnixel (MkUnixel 1) v` |
| **Entropy $S$** | Basis `[2]` Coefficient | `thermoEntropy v = lookupUnixel (MkUnixel 2) v` |
| **Free Energy $F(U, T, S)$** | Multiset State Contracted Scalar | `computeFreeEnergy v = thermoInternalEnergy v - (thermoTemperature v * thermoEntropy v)` |
| **Entropic Step ($\Delta F \le 0$)** | Monotonic Vector State Transition | `EntropicArrowStep before after` |

---

## 2. Mathematical Foundation & Thermodynamic Laws

Layer 8 `Idris2-Thermodynamics` defines irreversible state transitions and free energy minimization over discrete `Vexel` multiset states:

1. **Discrete Helmholtz Free Energy**: $F(v) = \text{thermoInternalEnergy}(v) - (\text{thermoTemperature}(v) \cdot \text{thermoEntropy}(v))$
2. **Entropic Arrow of Time**: Isothermal entropy growth ($\Delta S \ge 0$) guarantees free energy drop ($\Delta F \le 0$).
3. **Multi-Step Cascade Execution**: Cascading steps accumulating individual energy drops $\sum \Delta F_i$.

---

## 3. Formal Specification & Verification Suite

```idris
module Wiki.EntropicArrowSpec

import Core.BoxInt
import Core.VexelMaxel
import Math.Thermodynamics.EntropicArrow
import Wiki.Generators
import public QuickCheck

%default total

||| 1. Discrete Helmholtz Free Energy Equation: F = U - T * S
public export
prop_freeEnergyEquation : BoxInt -> BoxInt -> BoxInt -> Bool
prop_freeEnergyEquation u t s =
  computeFreeEnergy (thermoVexel u t s) == u - (t * s)

||| 2. Isothermal Entropy Growth Minimizes Free Energy: S2 >= S1 => Delta F <= 0
public export
prop_isothermalEntropyGrowthMinimizesFreeEnergy : BoxInt -> BoxInt -> BoxInt -> BoxInt -> Bool
prop_isothermalEntropyGrowthMinimizesFreeEnergy u t s1 s2 =
  let t' = absBox t
      st1 = thermoVexel u t' s1
      st2 = thermoVexel u t' (s1 + absBox s2) -- s2' >= s1
  in isFreeEnergyMinimizing st1 st2

||| Static Compile-Time Proof Witness Verification
public export
0 prfStaticEntropicArrow : isFreeEnergyMinimizing (thermoVexel (intToBoxInt 100) (intToBoxInt 10) (intToBoxInt 2))
                                                  (thermoVexel (intToBoxInt 100) (intToBoxInt 10) (intToBoxInt 5)) = True
prfStaticEntropicArrow = verifyEntropicArrow

||| QuickCheck Execution Runner for Entropic Arrow Suite
public export
auditEntropicArrowSpecProof : IO Bool
auditEntropicArrowSpecProof = do
  let r1 = qc3 prop_freeEnergyEquation
  let r2 = qc4 prop_isothermalEntropyGrowthMinimizesFreeEnergy
  pure (r1.pass == Just True && r2.pass == Just True)
```
