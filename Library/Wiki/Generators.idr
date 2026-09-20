module Wiki.Generators

import public QuickCheck
import Core.BoxInt
import Core.VexelMaxel
import Math.Thermodynamics.EntropicArrow

%default total

public export
Arbitrary BoxInt where
  arbitrary = map (intToBoxInt . cast) (the (Gen Int) arbitrary)
  coarbitrary (MkBoxInt v) gen = coarbitrary (the Integer v) gen

public export
genThermoVexel : Gen Vexel
genThermoVexel = do
  u <- arbitrary
  t <- arbitrary
  s <- arbitrary
  pure (thermoVexel u t s)

public export
qc : (Arbitrary a, Show a, Testable prop) => (a -> prop) -> QCRes
qc f = quickCheck (MkFn f)

public export
qc2 : (Arbitrary a, Show a, Arbitrary b, Show b, Testable prop) => (a -> b -> prop) -> QCRes
qc2 f = quickCheck (MkFn (\x => MkFn (f x)))

public export
qc3 : (Arbitrary a, Show a, Arbitrary b, Show b, Arbitrary c, Show c, Testable prop) => (a -> b -> c -> prop) -> QCRes
qc3 f = quickCheck (MkFn (\x => MkFn (\y => MkFn (f x y))))

public export
qc4 : (Arbitrary a, Show a, Arbitrary b, Show b, Arbitrary c, Show c, Arbitrary d, Show d, Testable prop) => (a -> b -> c -> d -> prop) -> QCRes
qc4 f = quickCheck (MkFn (\x => MkFn (\y => MkFn (\z => MkFn (f x y z)))))
