Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CB73A25A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJHm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:42:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:8751 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhFJHm4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:42:56 -0400
IronPort-SDR: Dr9iZdMLm/5WOelBLCr6T90B4N6bE2ETL41JzbS5PtdS2pRgYXVJRbRQoE7xRK2onKVB9W/vlw
 OaiQcEsWQXXw==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="192357723"
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="192357723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 00:40:56 -0700
IronPort-SDR: geqIlTNE1j7yRc+bTR1MlpsjzXw78Uan+EBA8Lgm/sz6mB3q41enbOfUtDc9fk98G0CHZIrJ0t
 Sj54j+gOpSSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,263,1616482800"; 
   d="scan'208";a="552957771"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jun 2021 00:40:53 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v2] perf vendor events: Add metrics for Icelake Server
Date:   Thu, 10 Jun 2021 15:39:50 +0800
Message-Id: <20210610073950.31752-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for Icelake Server to perf.

Based on TMA metrics 4.21 at 01.org.
https://download.01.org/perfmon/

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v2:
 - Fix perf test 10 error.

   # ./perf test 10
   10: PMU events                                                      :
   10.1: PMU event table sanity                                        : Ok
   10.2: PMU event map aliases                                         : Ok
   10.3: Parsing of PMU event table metrics                            : Ok
   10.4: Parsing of PMU event table metrics with fake PMUs             : Ok

 - Remove cstate metrics because the kernel has not supported
   cstate_core and cstate_core for Icelake server.

 - Remove the topdown L1/L2 metrics.

 - The patch can be found at:
   https://github.com/yaoj/icx-events.git

   The top commit.
   
 .../arch/x86/icelakex/icx-metrics.json        | 291 ++++++++++++++++++
 1 file changed, 291 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json

diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
new file mode 100644
index 000000000000..70d833039a25
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
@@ -0,0 +1,291 @@
+[
+    {
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
+        "MetricGroup": "Summary",
+        "MetricName": "IPC"
+    },
+    {
+        "MetricExpr": "UOPS_RETIRED.SLOTS / INST_RETIRED.ANY",
+        "BriefDescription": "Uops Per Instruction",
+        "MetricGroup": "Pipeline;Retire",
+        "MetricName": "UPI"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Instruction per taken branch",
+        "MetricGroup": "Branches;FetchBW;PGO",
+        "MetricName": "IpTB"
+    },
+    {
+        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
+        "MetricGroup": "Pipeline",
+        "MetricName": "CPI"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
+        "MetricGroup": "Pipeline",
+        "MetricName": "CLKS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
+        "BriefDescription": "Instructions Per Cycle (per physical core)",
+        "MetricGroup": "SMT;TmaL1",
+        "MetricName": "CoreIPC"
+    },
+    {
+        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.DISTRIBUTED",
+        "BriefDescription": "Floating Point Operations Per Cycle",
+        "MetricGroup": "Flops",
+        "MetricName": "FLOPc"
+    },
+    {
+        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 )",
+        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
+        "MetricGroup": "Pipeline;PortsUtil",
+        "MetricName": "ILP"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricGroup": "BrMispredicts",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
+        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
+        "MetricGroup": "SMT",
+        "MetricName": "CORE_CLKS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
+        "BriefDescription": "Instructions per Load (lower number means higher occurrence rate)",
+        "MetricGroup": "InsType",
+        "MetricName": "IpLoad"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
+        "BriefDescription": "Instructions per Store (lower number means higher occurrence rate)",
+        "MetricGroup": "InsType",
+        "MetricName": "IpStore"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
+        "MetricGroup": "Branches;InsType",
+        "MetricName": "IpBranch"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
+        "BriefDescription": "Instructions per (near) call (lower number means higher occurrence rate)",
+        "MetricGroup": "Branches",
+        "MetricName": "IpCall"
+    },
+    {
+        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
+        "BriefDescription": "Branch instructions per taken branch. ",
+        "MetricGroup": "Branches;PGO",
+        "MetricName": "BpTkBranch"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
+        "BriefDescription": "Instructions per Floating Point (FP) Operation (lower number means higher occurrence rate)",
+        "MetricGroup": "Flops;FpArith;InsType",
+        "MetricName": "IpFLOP"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions, Sample with: INST_RETIRED.PREC_DIST",
+        "MetricGroup": "Summary;TmaL1",
+        "MetricName": "Instructions"
+    },
+    {
+        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop Stream Detector; aka Loop Cache)",
+        "MetricGroup": "LSD",
+        "MetricName": "LSD_Coverage"
+    },
+    {
+        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
+        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
+        "MetricGroup": "DSB;FetchBW",
+        "MetricName": "DSB_Coverage"
+    },
+    {
+        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
+        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
+        "MetricGroup": "MemoryBound;MemoryLat",
+        "MetricName": "Load_Miss_Real_Latency"
+    },
+    {
+        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
+        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
+        "MetricGroup": "MemoryBound;MemoryBW",
+        "MetricName": "MLP"
+    },
+    {
+        "MetricConstraint": "NO_NMI_WATCHDOG",
+        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTED )",
+        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
+        "MetricGroup": "MemoryTLB",
+        "MetricName": "Page_Walks_Utilization"
+    },
+    {
+        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
+        "MetricGroup": "MemoryBW",
+        "MetricName": "L1D_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
+        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
+        "MetricGroup": "MemoryBW",
+        "MetricName": "L2_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "MemoryBW",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
+        "BriefDescription": "Average per-core data access bandwidth to the L3 cache [GB / sec]",
+        "MetricGroup": "MemoryBW;Offcore",
+        "MetricName": "L3_Cache_Access_BW"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "CacheMisses",
+        "MetricName": "L1MPKI"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "CacheMisses",
+        "MetricName": "L2MPKI"
+    },
+    {
+        "MetricExpr": "1000 * ( ( OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUESTS.DEMAND_DATA_RD ) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS ) / INST_RETIRED.ANY",
+        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
+        "MetricGroup": "CacheMisses;Offcore",
+        "MetricName": "L2MPKI_All"
+    },
+    {
+        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
+        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
+        "MetricGroup": "CacheMisses",
+        "MetricName": "L3MPKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
+        "BriefDescription": "Rate of silent evictions from the L2 cache per Kilo instruction where the evicted lines are dropped (no writeback to L3 or memory)",
+        "MetricGroup": "L2Evicts;Server",
+        "MetricName": "L2_Evictions_Silent_PKI"
+    },
+    {
+        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
+        "BriefDescription": "Rate of non silent evictions from the L2 cache per Kilo instruction",
+        "MetricGroup": "L2Evicts;Server",
+        "MetricName": "L2_Evictions_NonSilent_PKI"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricGroup": "HPC;Summary",
+        "MetricName": "CPU_Utilization"
+    },
+    {
+        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 / duration_time",
+        "BriefDescription": "Measured Average Frequency for unhalted processors [GHz]",
+        "MetricGroup": "Summary;Power",
+        "MetricName": "Average_Frequency"
+    },
+    {
+        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Giga Floating Point Operations Per Second",
+        "MetricGroup": "Flops;HPC",
+        "MetricName": "GFLOPs"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricGroup": "Power",
+        "MetricName": "Turbo_Utilization"
+    },
+    {
+        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_DISTRIBUTED",
+        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
+        "MetricGroup": "SMT",
+        "MetricName": "SMT_2T_Utilization"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THREAD",
+        "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
+        "MetricGroup": "OS",
+        "MetricName": "Kernel_Utilization"
+    },
+    {
+        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
+        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
+        "MetricGroup": "HPC;MemoryBW;SoC",
+        "MetricName": "DRAM_BW_Use"
+    },
+    {
+        "MetricExpr": "1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "MemoryLat;SoC",
+        "MetricName": "MEM_Read_Latency"
+    },
+    {
+        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@event\\=0x36\\,umask\\=0xC817FE01\\,thresh\\=1@",
+        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
+        "MetricGroup": "MemoryBW;SoC",
+        "MetricName": "MEM_Parallel_Reads"
+    },
+    {
+        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / cha_0@event\\=0x0@ )",
+        "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
+        "MetricGroup": "MemoryLat;SoC;Server",
+        "MetricName": "MEM_PMM_Read_Latency"
+    },
+    {
+        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
+        "MetricGroup": "MemoryBW;SoC;Server",
+        "MetricName": "PMM_Read_BW"
+    },
+    {
+        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
+        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
+        "MetricGroup": "MemoryBW;SoC;Server",
+        "MetricName": "PMM_Write_BW"
+    },
+    {
+        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000 / duration_time",
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Writes [GB / sec]",
+        "MetricGroup": "IoBW;SoC;Server",
+        "MetricName": "IO_Write_BW"
+    },
+    {
+        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR ) * 64 / 1000000000 / duration_time",
+        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Reads [GB / sec]",
+        "MetricGroup": "IoBW;SoC;Server",
+        "MetricName": "IO_Read_BW"
+    },
+    {
+        "MetricExpr": "cha_0@event\\=0x0@",
+        "BriefDescription": "Socket actual clocks when any core is active on that socket",
+        "MetricGroup": "SoC",
+        "MetricName": "Socket_CLKS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
+        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
+        "MetricGroup": "Branches;OS",
+        "MetricName": "IpFarBranch"
+    }
+]
-- 
2.17.1

