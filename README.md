# 📘 Idris2-Thermodynamics-Wiki (Layer 8 Specification & Verification)

This repository contains the executable wiki specifications, QuickCheck property suites, and formal proof witnesses for **Layer 8** (`Idris2-Thermodynamics`).

---

## 📚 Literate Specifications & Property Suites

- **[`PreorderedMonoidSpec.md`](Library/Wiki/PreorderedMonoidSpec.md):** 
  - Verifies bounded pre-ordered poset reflexivity ($\forall b,\, b \le b$).
  - Verifies monoid addition monotonicity ($a \le b \implies a + c \le b + c$).
  - Includes static proof witness `prfStaticReflexivity`.

- **[`EntropicArrowSpec.md`](Library/Wiki/EntropicArrowSpec.md):** 
  - Verifies discrete Helmholtz free energy equation ($F = U - T \cdot S$).
  - Verifies second law thermodynamic compliance ($\Delta F \le 0$) under isothermal entropy growth ($T \ge 0, \Delta S \ge 0$).
  - Includes static proof witness `prfStaticEntropicArrow`.

---

## ⚡ Running Verification Executable

To build and run the complete Layer 8 test suite inside `fedora-toolbox-44`:

```bash
toolbox run -c fedora-toolbox-44 bash -c "cd /var/home/justin/Projects/Idris2-Thermodynamics && idris2 --install Idris2-Thermodynamics.ipkg && cd /var/home/justin/Projects/Idris2-Thermodynamics-Wiki && idris2 --build Idris2-Thermodynamics-Wiki.ipkg && ./build/exec/thermodynamics-wiki"
```
