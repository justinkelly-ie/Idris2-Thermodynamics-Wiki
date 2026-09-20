# 🗂️ Thermodynamic Fluctuation Stream & Jarzynski Equality Specification

Documents and verifies discrete **Work/Heat Fluctuation Streams**, zero-allocation Jarzynski equality linear bounds $\langle e^{-\beta W} \rangle$, and total stream hylomorphisms.

## 1. Specification

```idris
module Wiki.FluctuationStreamSpec

import Math.Thermodynamics.FluctuationStream
import Core.BoxInt
import Data.Fuel

%default total

||| Property 1: Work Fluctuation Stream Total Work Hylomorphism Equivalence
public export covering
prop_totalWorkHylomorphismEquivalence : Bool
prop_totalWorkHylomorphismEquivalence =
  let works = [intToBoxInt 10, intToBoxInt 20, intToBoxInt 30]
      totW = fusedTotalWork (limit 100) works
  in unwrapBox totW == 60

||| Property 2: Jarzynski Linear Bound Monotonicity
public export covering
prop_jarzynskiBoundMonotonicity : Bool
prop_jarzynskiBoundMonotonicity =
  let works = [intToBoxInt 1, intToBoxInt 2, intToBoxInt 3]
      jBound1 = fusedJarzynskiLinearBound (limit 100) (intToBoxInt 1) works
      jBound2 = fusedJarzynskiLinearBound (limit 100) (intToBoxInt 2) works
  in unwrapBox jBound1 == -3 && unwrapBox jBound2 == -9

||| Direct Suite Execution for Fluctuation Stream Specification
public export covering
auditFluctuationStreamSpecProof : IO Bool
auditFluctuationStreamSpecProof = do
  let p1 = prop_totalWorkHylomorphismEquivalence
  let p2 = prop_jarzynskiBoundMonotonicity
  pure (p1 && p2)
```
