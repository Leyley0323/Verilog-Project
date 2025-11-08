# FIFO (First-In First-Out) Buffer

## Overview
This Verilog module implements a **32-word FIFO buffer** with configurable width and status indicators.  
The design allows synchronous read and write operations and includes logic for detecting **full**, **empty**, **almost full**, and **almost empty** states.

---

## Features
- **Parameterizable depth and width**
- **Full and empty status detection**
- **Almost full and almost empty thresholds**
- **Synchronous read and write**
- **Asynchronous active-low reset (`rst_n`)**

---
Perfect — here’s your **Signal Descriptions** section written in that same Markdown table style so you can copy and paste it directly into your README:

---

## Signal Descriptions

| **Signal**       | **Direction** | **Width** | **Description**                |
| ---------------- | ------------- | --------- | ------------------------------ |
| **clk**          | Input         | 1         | Clock signal                   |
| **rst_n**        | Input         | 1         | Active-low reset               |
| **wr_en**        | Input         | 1         | Write enable signal            |
| **rd_en**        | Input         | 1         | Read enable signal             |
| **data_in**      | Input         | 32        | Data input to FIFO             |
| **data_out**     | Output        | 32        | Data output from FIFO          |
| **full**         | Output        | 1         | High when FIFO is full         |
| **empty**        | Output        | 1         | High when FIFO is empty        |
| **almost_full**  | Output        | 1         | High when FIFO is nearly full  |
| **almost_empty** | Output        | 1         | High when FIFO is nearly empty |

---

## Usage Notes

* Operates on the **positive edge** of the clock (`clk`).
* Both **read** and **write** operations are synchronous.
* **Reset (`rst_n`)** must be held low during initialization to clear all pointers and counters.
* Avoid asserting both **`wr_en`** and **`rd_en`** simultaneously unless the design is synchronized to handle concurrent access.
* Use the **`full`** and **`empty`** flags to control data flow and prevent overflow or underflow.
* **`almost_full`** and **`almost_empty`** provide early warning thresholds for flow control.

---
