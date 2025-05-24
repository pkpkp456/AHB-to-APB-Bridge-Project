# 🚀 AHB to APB Bridge – RTL Design with STA & Power Analysis

This project showcases the complete design and analysis of a custom **AHB to APB Bridge** in **Verilog HDL**, implemented and analyzed using **Xilinx Vivado 2023.2**. It highlights the critical aspects of digital hardware design—**RTL implementation**, **timing closure**, and **power optimization**.

---

## 🔧 Project Overview

In AMBA-based SoCs, the **Advanced High-performance Bus (AHB)** connects high-speed components, while the **Advanced Peripheral Bus (APB)** serves low-power peripherals. A bridge is required to ensure reliable communication between them.

This design implements such a bridge, taking care of:
- Protocol translation between AHB and APB
- Transfer control and address decoding
- Timing synchronization and latching

---

## 📊 Static Timing Analysis (STA) Summary

Performed using Vivado Timing Constraints (`.xdc`):

| Metric                   | Value     |
|--------------------------|-----------|
| 🕒 **Worst Negative Slack (WNS)** | +3.487 ns |
| ⏱️ **Worst Hold Slack (WHS)**    | +0.231 ns |
| 🚫 Timing Violations    | 0         |
| ✅ Status               | Timing Met |

All paths are timing-clean and meet the specified clock period.

---

## 🔋 Power Analysis Summary

| Parameter        | Value     |
|------------------|-----------|
| ⚡ **Total On-Chip Power**  | 0.097 W   |
| 🔒 Static Power   | 0.091 W (94%) |
| 🔄 Dynamic Power | 0.006 W (6%)  |
| 🌡️ Junction Temp | 25.4°C     |

✅ No thermal concerns, power consumption is within safe bounds.

---


---

## 🛠️ Tools Used

- 🧠 **Verilog HDL**
- 🛠️ **Xilinx Vivado 2023.2**
- 📉 **Vivado Power Estimator**
- 📐 **Vivado Timing Analyzer**
- 🧪 **Simulation Testbench**

---

## 🧠 What I Learned

- Crafting **clean RTL design** for bus protocols
- Applying **timing constraints** and resolving violations
- Understanding **clock-domain behavior** and logic delays
- Estimating power usage and optimizing dynamic/static power
- The significance of **timing closure and design robustness**

---

## 💬 Message to Future Engineers

> 💡 _“Designing logic is easy. Designing logic that meets timing, power, and scalability demands is the real challenge.”_

If you’re getting started in **VLSI**, don’t stop at making your design functionally correct—**analyze its performance, timing, and power**. That's what takes your RTL from lab to chip.

---

## 🔗 Connect With Me

Feel free to reach out or discuss the project via [LinkedIn](www.linkedin.com/in/praveen-kumar-podalakur-78b628287) or open an issue.

---

## 🏷️ Tags

`#VLSI` `#AHB` `#APB` `#RTLDesign` `#Vivado` `#STA` `#PowerAnalysis` `#Verilog` `#DigitalDesign` `#SoC`
