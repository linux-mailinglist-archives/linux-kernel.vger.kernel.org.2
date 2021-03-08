Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498D2330BD1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhCHKyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:54:14 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49]:62174 "EHLO
        esa3.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231272AbhCHKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:53:52 -0500
IronPort-SDR: pG7SqrES6y18NfUDYen3CLAjuHVrQt/P1iKGyq0AByh0bQQaHVlOqH6x0HaBm0nyieSHaspipV
 WmT+LEzG73L9DeEvMeVy5+XXqH0A5XjG44TyMOxeCkse76lHx+0O58I9gHanN6AiJpSwVMPaIl
 F9ZSHXuMNPzFmS6AL/tM+U2KfOVUMzHA7n3ys6r/rD/OJjCFQ24kxOnJ1gjU3arxTy9LnUB1W9
 ygQ6B30z1WEFUFb/2UC/OnZmtcIMWi4bpVtG8WTsORzOVcfUdx/vm9aSR9SabkVbNndSXY6vfJ
 Ko8=
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="22144093"
X-IronPort-AV: E=Sophos;i="5.81,232,1610377200"; 
   d="scan'208";a="22144093"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP; 08 Mar 2021 19:53:50 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 279104E2C00
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:53:49 +0900 (JST)
Received: from yto-om3.fujitsu.com (yto-om3.o.css.fujitsu.com [10.128.89.164])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D82D4520AB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:53:48 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by yto-om3.fujitsu.com (Postfix) with ESMTP id 0096E4005E9C0;
        Mon,  8 Mar 2021 19:53:48 +0900 (JST)
From:   Shunsuke Nakamura <nakamura.shun@fujitsu.com>
To:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] perf vendor events arm64: Add Fujitsu A64FX pmu event
Date:   Mon,  8 Mar 2021 19:53:41 +0900
Message-Id: <20210308105342.746940-3-nakamura.shun@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308105342.746940-1-nakamura.shun@fujitsu.com>
References: <20210308105342.746940-1-nakamura.shun@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pmu events for A64FX.

Documentation source:
https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_PMU_Events_v1.2.pdf

Signed-off-by: Shunsuke Nakamura <nakamura.shun@fujitsu.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 .../arch/arm64/fujitsu/a64fx/branch.json      |   8 +
 .../arch/arm64/fujitsu/a64fx/bus.json         |  62 ++++++
 .../arch/arm64/fujitsu/a64fx/cache.json       | 128 ++++++++++++
 .../arch/arm64/fujitsu/a64fx/cycle.json       |   5 +
 .../arch/arm64/fujitsu/a64fx/exception.json   |  29 +++
 .../arch/arm64/fujitsu/a64fx/instruction.json | 131 ++++++++++++
 .../arch/arm64/fujitsu/a64fx/memory.json      |   8 +
 .../arch/arm64/fujitsu/a64fx/other.json       | 188 +++++++++++++++++
 .../arch/arm64/fujitsu/a64fx/pipeline.json    | 194 ++++++++++++++++++
 .../arch/arm64/fujitsu/a64fx/sve.json         | 110 ++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 11 files changed, 864 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json

diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
new file mode 100644
index 000000000000..b011af11bf94
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
@@ -0,0 +1,8 @@
+[
+  {
+    "ArchStdEvent": "BR_MIS_PRED"
+  },
+  {
+    "ArchStdEvent": "BR_PRED"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
new file mode 100644
index 000000000000..084e88d7df73
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
@@ -0,0 +1,62 @@
+[
+  {
+    "PublicDescription": "This event counts read transactions from tofu controller to measured CMG.",
+    "EventCode": "0x314",
+    "EventName": "BUS_READ_TOTAL_TOFU",
+    "BriefDescription": "This event counts read transactions from tofu controller to measured CMG."
+  },
+  {
+    "PublicDescription": "This event counts read transactions from PCI controller to measured CMG.",
+    "EventCode": "0x315",
+    "EventName": "BUS_READ_TOTAL_PCI",
+    "BriefDescription": "This event counts read transactions from PCI controller to measured CMG."
+  },
+  {
+    "PublicDescription": "This event counts read transactions from measured CMG local memory to measured CMG.",
+    "EventCode": "0x316",
+    "EventName": "BUS_READ_TOTAL_MEM",
+    "BriefDescription": "This event counts read transactions from measured CMG local memory to measured CMG."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG0, if measured CMG is not CMG0.",
+    "EventCode": "0x318",
+    "EventName": "BUS_WRITE_TOTAL_CMG0",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG0, if measured CMG is not CMG0."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG1, if measured CMG is not CMG1.",
+    "EventCode": "0x319",
+    "EventName": "BUS_WRITE_TOTAL_CMG1",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG1, if measured CMG is not CMG1."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG2, if measured CMG is not CMG2.",
+    "EventCode": "0x31A",
+    "EventName": "BUS_WRITE_TOTAL_CMG2",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG2, if measured CMG is not CMG2."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to CMG3, if measured CMG is not CMG3.",
+    "EventCode": "0x31B",
+    "EventName": "BUS_WRITE_TOTAL_CMG3",
+    "BriefDescription": "This event counts write transactions from measured CMG to CMG3, if measured CMG is not CMG3."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to tofu controller.",
+    "EventCode": "0x31C",
+    "EventName": "BUS_WRITE_TOTAL_TOFU",
+    "BriefDescription": "This event counts write transactions from measured CMG to tofu controller."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to PCI controller.",
+    "EventCode": "0x31D",
+    "EventName": "BUS_WRITE_TOTAL_PCI",
+    "BriefDescription": "This event counts write transactions from measured CMG to PCI controller."
+  },
+  {
+    "PublicDescription": "This event counts write transactions from measured CMG to measured CMG local memory.",
+    "EventCode": "0x31E",
+    "EventName": "BUS_WRITE_TOTAL_MEM",
+    "BriefDescription": "This event counts write transactions from measured CMG to measured CMG local memory."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
new file mode 100644
index 000000000000..2e341a951a10
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
@@ -0,0 +1,128 @@
+[
+  {
+    "ArchStdEvent": "L1I_CACHE_REFILL"
+  },
+  {
+    "ArchStdEvent": "L1I_TLB_REFILL"
+  },
+  {
+    "ArchStdEvent": "L1D_CACHE_REFILL"
+  },
+  {
+    "ArchStdEvent": "L1D_CACHE"
+  },
+  {
+    "ArchStdEvent": "L1D_TLB_REFILL"
+  },
+  {
+    "ArchStdEvent": "L1I_CACHE"
+  },
+  {
+    "ArchStdEvent": "L1D_CACHE_WB"
+  },
+  {
+    "ArchStdEvent": "L2D_CACHE"
+  },
+  {
+    "ArchStdEvent": "L2D_CACHE_REFILL"
+  },
+  {
+    "ArchStdEvent": "L2D_CACHE_WB"
+  },
+  {
+    "ArchStdEvent": "L2D_TLB_REFILL"
+  },
+  {
+    "ArchStdEvent": "L2I_TLB_REFILL"
+  },
+  {
+    "ArchStdEvent": "L2D_TLB"
+  },
+  {
+    "ArchStdEvent": "L2I_TLB"
+  },
+  {
+    "PublicDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch.",
+    "EventCode": "0x49",
+    "EventName": "L1D_CACHE_REFILL_PRF",
+    "BriefDescription": "This event counts L1D_CACHE_REFILL caused by software or hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch.",
+    "EventCode": "0x59",
+    "EventName": "L2D_CACHE_REFILL_PRF",
+    "BriefDescription": "This event counts L2D_CACHE_REFILL caused by software or hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts L1D_CACHE_REFILL caused by demand access.",
+    "EventCode": "0x200",
+    "EventName": "L1D_CACHE_REFILL_DM",
+    "BriefDescription": "This event counts L1D_CACHE_REFILL caused by demand access."
+  },
+  {
+    "PublicDescription": "This event counts L1D_CACHE_REFILL caused by hardware prefetch.",
+    "EventCode": "0x202",
+    "EventName": "L1D_CACHE_REFILL_HWPRF",
+    "BriefDescription": "This event counts L1D_CACHE_REFILL caused by hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts outstanding L1D cache miss requests per cycle.",
+    "EventCode": "0x208",
+    "EventName": "L1_MISS_WAIT",
+    "BriefDescription": "This event counts outstanding L1D cache miss requests per cycle."
+  },
+  {
+    "PublicDescription": "This event counts outstanding L1I cache miss requests per cycle.",
+    "EventCode": "0x209",
+    "EventName": "L1I_MISS_WAIT",
+    "BriefDescription": "This event counts outstanding L1I cache miss requests per cycle."
+  },
+  {
+    "PublicDescription": "This event counts L2D_CACHE_REFILL caused by demand access.",
+    "EventCode": "0x300",
+    "EventName": "L2D_CACHE_REFILL_DM",
+    "BriefDescription": "This event counts L2D_CACHE_REFILL caused by demand access."
+  },
+  {
+    "PublicDescription": "This event counts L2D_CACHE_REFILL caused by hardware prefetch.",
+    "EventCode": "0x302",
+    "EventName": "L2D_CACHE_REFILL_HWPRF",
+    "BriefDescription": "This event counts L2D_CACHE_REFILL caused by hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts outstanding L2 cache miss requests per cycle.",
+    "EventCode": "0x308",
+    "EventName": "L2_MISS_WAIT",
+    "BriefDescription": "This event counts outstanding L2 cache miss requests per cycle."
+  },
+  {
+    "PublicDescription": "This event counts the number of times of L2 cache miss.",
+    "EventCode": "0x309",
+    "EventName": "L2_MISS_COUNT",
+    "BriefDescription": "This event counts the number of times of L2 cache miss."
+  },
+  {
+    "PublicDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch.",
+    "EventCode": "0x325",
+    "EventName": "L2D_SWAP_DM",
+    "BriefDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access.",
+    "EventCode": "0x326",
+    "EventName": "L2D_CACHE_MIBMCH_PRF",
+    "BriefDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access."
+  },
+  {
+    "PublicDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch.",
+    "EventCode": "0x396",
+    "EventName": "L2D_CACHE_SWAP_LOCAL",
+    "BriefDescription": "This event counts operations where demand access hits an L2 cache refill buffer allocated by software or hardware prefetch."
+  },
+  {
+    "PublicDescription": "This event counts energy consumption per cycle of L2 cache.",
+    "EventCode": "0x3E0",
+    "EventName": "EA_L2",
+    "BriefDescription": "This event counts energy consumption per cycle of L2 cache."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
new file mode 100644
index 000000000000..b16484628290
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
@@ -0,0 +1,5 @@
+[
+  {
+    "ArchStdEvent": "CPU_CYCLES"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
new file mode 100644
index 000000000000..348749c154c0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
@@ -0,0 +1,29 @@
+[
+  {
+    "ArchStdEvent": "EXC_TAKEN"
+  },
+  {
+    "ArchStdEvent": "EXC_UNDEF"
+  },
+  {
+    "ArchStdEvent": "EXC_SVC"
+  },
+  {
+    "ArchStdEvent": "EXC_PABORT"
+  },
+  {
+    "ArchStdEvent": "EXC_DABORT"
+  },
+  {
+    "ArchStdEvent": "EXC_IRQ"
+  },
+  {
+    "ArchStdEvent": "EXC_FIQ"
+  },
+  {
+    "ArchStdEvent": "EXC_SMC"
+  },
+  {
+    "ArchStdEvent": "EXC_HVC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
new file mode 100644
index 000000000000..6d258b1080cf
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
@@ -0,0 +1,131 @@
+[
+  {
+    "ArchStdEvent": "SW_INCR"
+  },
+  {
+    "ArchStdEvent": "INST_RETIRED"
+  },
+  {
+    "ArchStdEvent": "EXC_RETURN"
+  },
+  {
+    "ArchStdEvent": "CID_WRITE_RETIRED"
+  },
+  {
+    "ArchStdEvent": "INST_SPEC"
+  },
+  {
+    "ArchStdEvent": "LDREX_SPEC"
+  },
+  {
+    "ArchStdEvent": "STREX_SPEC"
+  },
+  {
+    "ArchStdEvent": "LD_SPEC"
+  },
+  {
+    "ArchStdEvent": "ST_SPEC"
+  },
+  {
+    "ArchStdEvent": "LDST_SPEC"
+  },
+  {
+    "ArchStdEvent": "DP_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SPEC"
+  },
+  {
+    "ArchStdEvent": "VFP_SPEC"
+  },
+  {
+    "ArchStdEvent": "PC_WRITE_SPEC"
+  },
+  {
+    "ArchStdEvent": "CRYPTO_SPEC"
+  },
+  {
+    "ArchStdEvent": "BR_IMMED_SPEC"
+  },
+  {
+    "ArchStdEvent": "BR_RETURN_SPEC"
+  },
+  {
+    "ArchStdEvent": "BR_INDIRECT_SPEC"
+  },
+  {
+    "ArchStdEvent": "ISB_SPEC"
+  },
+  {
+    "ArchStdEvent": "DSB_SPEC"
+  },
+  {
+    "ArchStdEvent": "DMB_SPEC"
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction.",
+    "EventCode": "0x9F",
+    "EventName": "DCZVA_SPEC",
+    "BriefDescription": "This event counts architecturally executed zero blocking operations due to the 'DC ZVA' instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed floating-point move operations.",
+    "EventCode": "0x105",
+    "EventName": "FP_MV_SPEC",
+    "BriefDescription": "This event counts architecturally executed floating-point move operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that using predicate register.",
+    "EventCode": "0x108",
+    "EventName": "PRD_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that using predicate register."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed inter-element manipulation operations.",
+    "EventCode": "0x109",
+    "EventName": "IEL_SPEC",
+    "BriefDescription": "This event counts architecturally executed inter-element manipulation operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed inter-register manipulation operations.",
+    "EventCode": "0x10A",
+    "EventName": "IREG_SPEC",
+    "BriefDescription": "This event counts architecturally executed inter-register manipulation operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed NOSIMD load operations that using SIMD&FP registers.",
+    "EventCode": "0x112",
+    "EventName": "FP_LD_SPEC",
+    "BriefDescription": "This event counts architecturally executed NOSIMD load operations that using SIMD&FP registers."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed NOSIMD store operations that using SIMD&FP registers.",
+    "EventCode": "0x113",
+    "EventName": "FP_ST_SPEC",
+    "BriefDescription": "This event counts architecturally executed NOSIMD store operations that using SIMD&FP registers."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed SIMD broadcast floating-point load operations.",
+    "EventCode": "0x11A",
+    "EventName": "BC_LD_SPEC",
+    "BriefDescription": "This event counts architecturally executed SIMD broadcast floating-point load operations."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed instructions, excluding the MOVPRFX instruction.",
+    "EventCode": "0x121",
+    "EventName": "EFFECTIVE_INST_SPEC",
+    "BriefDescription": "This event counts architecturally executed instructions, excluding the MOVPRFX instruction."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that uses 'pre-index' as its addressing mode.",
+    "EventCode": "0x123",
+    "EventName": "PRE_INDEX_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that uses 'pre-index' as its addressing mode."
+  },
+  {
+    "PublicDescription": "This event counts architecturally executed operations that uses 'post-index' as its addressing mode.",
+    "EventCode": "0x124",
+    "EventName": "POST_INDEX_SPEC",
+    "BriefDescription": "This event counts architecturally executed operations that uses 'post-index' as its addressing mode."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
new file mode 100644
index 000000000000..c1f6479e92b4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
@@ -0,0 +1,8 @@
+[
+  {
+    "PublicDescription": "This event counts energy consumption per cycle of CMG local memory.",
+    "EventCode": "0x3E8",
+    "EventName": "EA_MEMORY",
+    "BriefDescription": "This event counts energy consumption per cycle of CMG local memory."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
new file mode 100644
index 000000000000..10c823ac26cc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
@@ -0,0 +1,188 @@
+[
+  {
+    "PublicDescription": "This event counts the occurrence count of the micro-operation split.",
+    "EventCode": "0x139",
+    "EventName": "UOP_SPLIT",
+    "BriefDescription": "This event counts the occurrence count of the micro-operation split."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no operation was committed because the oldest and uncommitted load/store/prefetch operation waits for memory access.",
+    "EventCode": "0x180",
+    "EventName": "LD_COMP_WAIT_L2_MISS",
+    "BriefDescription": "This event counts every cycle that no operation was committed because the oldest and uncommitted load/store/prefetch operation waits for memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for memory access.",
+    "EventCode": "0x181",
+    "EventName": "LD_COMP_WAIT_L2_MISS_EX",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L2 cache access.",
+    "EventCode": "0x182",
+    "EventName": "LD_COMP_WAIT_L1_MISS",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L2 cache access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L2 cache access.",
+    "EventCode": "0x183",
+    "EventName": "LD_COMP_WAIT_L1_MISS_EX",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L2 cache access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L1D cache, L2 cache and memory access.",
+    "EventCode": "0x184",
+    "EventName": "LD_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted load/store/prefetch operation waits for L1D cache, L2 cache and memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L1D cache, L2 cache and memory access.",
+    "EventCode": "0x185",
+    "EventName": "LD_COMP_WAIT_EX",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the oldest and uncommitted integer load operation waits for L1D cache, L2 cache and memory access."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed due to the lack of an available prefetch port.",
+    "EventCode": "0x186",
+    "EventName": "LD_COMP_WAIT_PFP_BUSY",
+    "BriefDescription": "This event counts every cycle that no instruction was committed due to the lack of an available prefetch port."
+  },
+  {
+    "PublicDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by an integer load operation.",
+    "EventCode": "0x187",
+    "EventName": "LD_COMP_WAIT_PFP_BUSY_EX",
+    "BriefDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by an integer load operation."
+  },
+  {
+    "PublicDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by a software prefetch instruction.",
+    "EventCode": "0x188",
+    "EventName": "LD_COMP_WAIT_PFP_BUSY_SWPF",
+    "BriefDescription": "This event counts the LD_COMP_WAIT_PFP_BUSY caused by a software prefetch instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is an integer or floating-point/SIMD instruction.",
+    "EventCode": "0x189",
+    "EventName": "EU_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is an integer or floating-point/SIMD instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a floating-point/SIMD instruction.",
+    "EventCode": "0x18A",
+    "EventName": "FL_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a floating-point/SIMD instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a branch instruction.",
+    "EventCode": "0x18B",
+    "EventName": "BR_COMP_WAIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed and the oldest and uncommitted instruction is a branch instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the CSE is empty.",
+    "EventCode": "0x18C",
+    "EventName": "ROB_EMPTY",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the CSE is empty."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed because the CSE is empty and the store port (SP) is full.",
+    "EventCode": "0x18D",
+    "EventName": "ROB_EMPTY_STQ_BUSY",
+    "BriefDescription": "This event counts every cycle that no instruction was committed because the CSE is empty and the store port (SP) is full."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that the instruction unit is halted by the WFE/WFI instruction.",
+    "EventCode": "0x18E",
+    "EventName": "WFE_WFI_CYCLE",
+    "BriefDescription": "This event counts every cycle that the instruction unit is halted by the WFE/WFI instruction."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only.",
+    "EventCode": "0x190",
+    "EventName": "_0INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that no instruction was committed, but counts at the time when commits MOVPRFX only."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that one instruction is committed.",
+    "EventCode": "0x191",
+    "EventName": "_1INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that one instruction is committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that two instructions are committed.",
+    "EventCode": "0x192",
+    "EventName": "_2INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that two instructions are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that three instructions are committed.",
+    "EventCode": "0x193",
+    "EventName": "_3INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that three instructions are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that four instructions are committed.",
+    "EventCode": "0x194",
+    "EventName": "_4INST_COMMIT",
+    "BriefDescription": "This event counts every cycle that four instructions are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that only any micro-operations are committed.",
+    "EventCode": "0x198",
+    "EventName": "UOP_ONLY_COMMIT",
+    "BriefDescription": "This event counts every cycle that only any micro-operations are committed."
+  },
+  {
+    "PublicDescription": "This event counts every cycle that only the MOVPRFX instruction is committed.",
+    "EventCode": "0x199",
+    "EventName": "SINGLE_MOVPRFX_COMMIT",
+    "BriefDescription": "This event counts every cycle that only the MOVPRFX instruction is committed."
+  },
+  {
+    "PublicDescription": "This event counts energy consumption per cycle of core.",
+    "EventCode": "0x1E0",
+    "EventName": "EA_CORE",
+    "BriefDescription": "This event counts energy consumption per cycle of core."
+  },
+  {
+    "PublicDescription": "This event counts streaming prefetch requests to L1D cache generated by hardware prefetcher.",
+    "EventCode": "0x230",
+    "EventName": "L1HWPF_STREAM_PF",
+    "BriefDescription": "This event counts streaming prefetch requests to L1D cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts allocation type prefetch injection requests to L1D cache generated by hardware prefetcher.",
+    "EventCode": "0x231",
+    "EventName": "L1HWPF_INJ_ALLOC_PF",
+    "BriefDescription": "This event counts allocation type prefetch injection requests to L1D cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts non-allocation type prefetch injection requests to L1D cache generated by hardware prefetcher.",
+    "EventCode": "0x232",
+    "EventName": "L1HWPF_INJ_NOALLOC_PF",
+    "BriefDescription": "This event counts non-allocation type prefetch injection requests to L1D cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher.",
+    "EventCode": "0x233",
+    "EventName": "L2HWPF_STREAM_PF",
+    "BriefDescription": "This event counts streaming prefetch requests to L2 cache generated by hardware prefecher."
+  },
+  {
+    "PublicDescription": "This event counts allocation type prefetch injection requests to L2 cache generated by hardware prefetcher.",
+    "EventCode": "0x234",
+    "EventName": "L2HWPF_INJ_ALLOC_PF",
+    "BriefDescription": "This event counts allocation type prefetch injection requests to L2 cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts non-allocation type prefetch injection requests to L2 cache generated by hardware prefetcher.",
+    "EventCode": "0x235",
+    "EventName": "L2HWPF_INJ_NOALLOC_PF",
+    "BriefDescription": "This event counts non-allocation type prefetch injection requests to L2 cache generated by hardware prefetcher."
+  },
+  {
+    "PublicDescription": "This event counts prefetch requests to L2 cache generated by the other causes.",
+    "EventCode": "0x236",
+    "EventName": "L2HWPF_OTHER",
+    "BriefDescription": "This event counts prefetch requests to L2 cache generated by the other causes."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
new file mode 100644
index 000000000000..dd7c97a9972b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
@@ -0,0 +1,194 @@
+[
+  {
+    "ArchStdEvent": "STALL_FRONTEND"
+  },
+  {
+    "ArchStdEvent": "STALL_BACKEND"
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EAGA pipeline.",
+    "EventCode": "0x1A0",
+    "EventName": "EAGA_VAL",
+    "BriefDescription": "This event counts valid cycles of EAGA pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EAGB pipeline.",
+    "EventCode": "0x1A1",
+    "EventName": "EAGB_VAL",
+    "BriefDescription": "This event counts valid cycles of EAGB pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EXA pipeline.",
+    "EventCode": "0x1A2",
+    "EventName": "EXA_VAL",
+    "BriefDescription": "This event counts valid cycles of EXA pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of EXB pipeline.",
+    "EventCode": "0x1A3",
+    "EventName": "EXB_VAL",
+    "BriefDescription": "This event counts valid cycles of EXB pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of FLA pipeline.",
+    "EventCode": "0x1A4",
+    "EventName": "FLA_VAL",
+    "BriefDescription": "This event counts valid cycles of FLA pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of FLB pipeline.",
+    "EventCode": "0x1A5",
+    "EventName": "FLB_VAL",
+    "BriefDescription": "This event counts valid cycles of FLB pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of PRX pipeline.",
+    "EventCode": "0x1A6",
+    "EventName": "PRX_VAL",
+    "BriefDescription": "This event counts valid cycles of PRX pipeline."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in FLA pipeline, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x1B4",
+    "EventName": "FLA_VAL_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in FLA pipeline, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in FLB pipeline, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x1B5",
+    "EventName": "FLB_VAL_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in FLB pipeline, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L1D cache pipeline#0.",
+    "EventCode": "0x240",
+    "EventName": "L1_PIPE0_VAL",
+    "BriefDescription": "This event counts valid cycles of L1D cache pipeline#0."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L1D cache pipeline#1.",
+    "EventCode": "0x241",
+    "EventName": "L1_PIPE1_VAL",
+    "BriefDescription": "This event counts valid cycles of L1D cache pipeline#1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#0 that its sce bit of tagged address is 1.",
+    "EventCode": "0x250",
+    "EventName": "L1_PIPE0_VAL_IU_TAG_ADRS_SCE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#0 that its sce bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#0 that its pfe bit of tagged address is 1.",
+    "EventCode": "0x251",
+    "EventName": "L1_PIPE0_VAL_IU_TAG_ADRS_PFE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#0 that its pfe bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#1 that its sce bit of tagged address is 1.",
+    "EventCode": "0x252",
+    "EventName": "L1_PIPE1_VAL_IU_TAG_ADRS_SCE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#1 that its sce bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#1 that its pfe bit of tagged address is 1.",
+    "EventCode": "0x253",
+    "EventName": "L1_PIPE1_VAL_IU_TAG_ADRS_PFE",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#1 that its pfe bit of tagged address is 1."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L1D cache pipeline#0.",
+    "EventCode": "0x260",
+    "EventName": "L1_PIPE0_COMP",
+    "BriefDescription": "This event counts completed requests in L1D cache pipeline#0."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L1D cache pipeline#1.",
+    "EventCode": "0x261",
+    "EventName": "L1_PIPE1_COMP",
+    "BriefDescription": "This event counts completed requests in L1D cache pipeline#1."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L1I cache pipeline.",
+    "EventCode": "0x268",
+    "EventName": "L1I_PIPE_COMP",
+    "BriefDescription": "This event counts completed requests in L1I cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L1I cache pipeline.",
+    "EventCode": "0x269",
+    "EventName": "L1I_PIPE_VAL",
+    "BriefDescription": "This event counts valid cycles of L1I cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts aborted requests in L1D pipelines that due to store-load interlock.",
+    "EventCode": "0x274",
+    "EventName": "L1_PIPE_ABORT_STLD_INTLK",
+    "BriefDescription": "This event counts aborted requests in L1D pipelines that due to store-load interlock."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#0 that its sector cache ID is not 0.",
+    "EventCode": "0x2A0",
+    "EventName": "L1_PIPE0_VAL_IU_NOT_SEC0",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#0 that its sector cache ID is not 0."
+  },
+  {
+    "PublicDescription": "This event counts requests in L1D cache pipeline#1 that its sector cache ID is not 0.",
+    "EventCode": "0x2A1",
+    "EventName": "L1_PIPE1_VAL_IU_NOT_SEC0",
+    "BriefDescription": "This event counts requests in L1D cache pipeline#1 that its sector cache ID is not 0."
+  },
+  {
+    "PublicDescription": "This event counts the number of times where 2 elements of the gather instructions became 2 flows because 2 elements could not be combined.",
+    "EventCode": "0x2B0",
+    "EventName": "L1_PIPE_COMP_GATHER_2FLOW",
+    "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 2 flows because 2 elements could not be combined."
+  },
+  {
+    "PublicDescription": "This event counts the number of times where 2 elements of the gather instructions became 1 flow because 2 elements could be combined.",
+    "EventCode": "0x2B1",
+    "EventName": "L1_PIPE_COMP_GATHER_1FLOW",
+    "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 1 flow because 2 elements could be combined."
+  },
+  {
+    "PublicDescription": "This event counts the number of times where 2 elements of the gather instructions became 0 flow because both predicate values are 0.",
+    "EventCode": "0x2B2",
+    "EventName": "L1_PIPE_COMP_GATHER_0FLOW",
+    "BriefDescription": "This event counts the number of times where 2 elements of the gather instructions became 0 flow because both predicate values are 0."
+  },
+  {
+    "PublicDescription": "This event counts the number of flows of the scatter instructions.",
+    "EventCode": "0x2B3",
+    "EventName": "L1_PIPE_COMP_SCATTER_1FLOW",
+    "BriefDescription": "This event counts the number of flows of the scatter instructions."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#0, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x2B8",
+    "EventName": "L1_PIPE0_COMP_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#0, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#1, where it is corrected so that it becomes 16 when all bits are 1.",
+    "EventCode": "0x2B9",
+    "EventName": "L1_PIPE1_COMP_PRD_CNT",
+    "BriefDescription": "This event counts the number of 1's in the predicate bits of request in L1D cache pipeline#1, where it is corrected so that it becomes 16 when all bits are 1."
+  },
+  {
+    "PublicDescription": "This event counts valid cycles of L2 cache pipeline.",
+    "EventCode": "0x330",
+    "EventName": "L2_PIPE_VAL",
+    "BriefDescription": "This event counts valid cycles of L2 cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts completed requests in L2 cache pipeline.",
+    "EventCode": "0x350",
+    "EventName": "L2_PIPE_COMP_ALL",
+    "BriefDescription": "This event counts completed requests in L2 cache pipeline."
+  },
+  {
+    "PublicDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access.",
+    "EventCode": "0x370",
+    "EventName": "L2_PIPE_COMP_PF_L2MIB_MCH",
+    "BriefDescription": "This event counts operations where software or hardware prefetch hits an L2 cache refill buffer allocated by demand access."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
new file mode 100644
index 000000000000..dc1b95e42c32
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
@@ -0,0 +1,110 @@
+[
+  {
+    "ArchStdEvent": "SIMD_INST_RETIRED"
+  },
+  {
+    "ArchStdEvent": "SVE_INST_RETIRED"
+  },
+  {
+    "ArchStdEvent": "UOP_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_MATH_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_FMA_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_RECPE_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_CVT_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SVE_INT_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_PRED_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_MOVPRFX_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_MOVPRFX_U_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SVE_LD_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SVE_ST_SPEC"
+  },
+  {
+    "ArchStdEvent": "PRF_SPEC"
+  },
+  {
+    "ArchStdEvent": "BASE_LD_REG_SPEC"
+  },
+  {
+    "ArchStdEvent": "BASE_ST_REG_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_LDR_REG_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_STR_REG_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_LDR_PREG_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_STR_PREG_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_PRF_CONTIG_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SVE_LD_MULTI_SPEC"
+  },
+  {
+    "ArchStdEvent": "ASE_SVE_ST_MULTI_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_LD_GATHER_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_ST_SCATTER_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_PRF_GATHER_SPEC"
+  },
+  {
+    "ArchStdEvent": "SVE_LDFF_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_SCALE_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_FIXED_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_HP_SCALE_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_HP_FIXED_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_SP_SCALE_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_SP_FIXED_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_DP_SCALE_OPS_SPEC"
+  },
+  {
+    "ArchStdEvent": "FP_DP_FIXED_OPS_SPEC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 0d609149b82a..c43591d831b8 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -20,5 +20,6 @@
 0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
+0x00000000460f0010,v1,fujitsu/a64fx,core
 0x00000000480fd010,v1,hisilicon/hip08,core
 0x00000000500f0000,v1,ampere/emag,core
-- 
2.25.1

