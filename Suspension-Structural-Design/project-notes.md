# 🧱 Double Wishbone Suspension & Structural Design Project

**Coursework Project:** Loughborough University – Structural Design  
**Duration:** Oct 2023 – Jan 2024  
**Tools Used:** Siemens NX, Material Selection Charts, Simulation, CAD

## 💡 Objective
To design a complete double wishbone suspension assembly and analyse key components under structural loads. The project aimed to simulate real-world loading conditions in racing and performance vehicle applications.

---

## 🛠️ Project Breakdown

### 🔧 Design Highlights
- Created full CAD assembly of a double wishbone suspension: including knuckle, upper/lower arms, damper, pins, and spring
- Used mirror, extrusion, subtract, fillet and sweep tools to accurately model components
- Simulated mechanical constraints and physical fit between suspension components

### 📊 Structural Analyses
- **Bending Stress (Upper Arm):**
  - Estimated load from vehicle weight (1400 kg sprung mass)
  - Simulated beam bending using NX
  - Max normal stress: **65 MPa**
- **Shear Stress (Upper Arm):**
  - NX showed peak at knuckle joints: **39.86 MPa**
  - Hand calcs overestimated shear (~275 MPa) due to idealisation
- **Buckling (Damper Pin):**
  - Simulated compressive load: **919 N**
  - NX critical buckling mode closely matched hand estimate: **~21.57 N**
- **Torsion (Spring):**
  - Spring wire (Ø4.5mm) simulated for angular twist
  - Calculated twist: **15 rad**, Torque: **36.8 Nm**

### 🪶 Materials & Environmental Factors
- Conducted material selection using stiffness and strength indices
- Evaluated environmental impact (CO₂ & energy)
- Materials considered: CFRP, Boron Carbide, Silicon Nitride
- **Best Technical Fit:** CFRP (common in motorsport)
- **Best Sustainable Fit:** Boron Carbide

---

## 📈 Front Wing Box Beam Simulation
- Simulated simplified Formula 1 front wing using hollow cantilever model
- Materials tested for deflection under 920 N downforce
- NX Simulations:
  - CFRP (37.5mm wall): Best stiffness
  - Boron Carbide (19mm wall): Best eco-efficiency
- Comparison across weight, energy, CO₂ emissions

---

## 📁 Report & Visuals
- Full PDF Report: [Report.pdf](./Report.pdf)
- Includes: Methodology, NX images, hand calculations, material index tables, simulation results

---

## 📸 Suggested Visual Uploads
> - Screenshots of NX assemblies  
> - Simulated stress plots (bending, shear, torsion, buckling)  
> - Material charts or graphs  
> - CAD renderings (ray traced images)

---

## ✅ Outcome
Delivered a functional, manufacturable suspension design with a complete analytical breakdown of mechanical stresses and sustainability factors. Gained deep understanding of FEA principles, automotive component loading, and environmentally aware engineering.

