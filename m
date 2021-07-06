Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF23BC640
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhGFGFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 02:05:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:15370 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhGFGFL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 02:05:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="270181204"
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; 
   d="scan'208";a="270181204"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 23:02:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; 
   d="scan'208";a="460565723"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jul 2021 23:02:14 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH 2/2] perf vendor events intel: Add basic metrics for Elkhartlake
Date:   Tue,  6 Jul 2021 14:00:53 +0800
Message-Id: <20210706060053.23591-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210706060053.23591-1-yao.jin@linux.intel.com>
References: <20210706060053.23591-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for Elkhartlake to perf.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 .../arch/x86/elkhartlake/ehl-metrics.json     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json

diff --git a/tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json b/tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
new file mode 100644
index 000000000000..b6f7126be1fd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
@@ -0,0 +1,57 @@
+[
+    {
+        "MetricExpr": "INST_RETIRED.ANY / cycles",
+        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
+        "MetricName": "IPC"
+    },
+    {
+        "MetricExpr": "1 / IPC",
+        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
+        "MetricName": "CPI"
+    },
+    {
+        "MetricExpr": "cycles",
+        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
+        "MetricName": "CLKS"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
+        "MetricName": "IpMispredict"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
+        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
+        "MetricName": "IpBranch"
+    },
+    {
+        "MetricExpr": "INST_RETIRED.ANY",
+        "BriefDescription": "Total number of retired Instructions",
+        "MetricName": "Instructions"
+    },
+    {
+        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 ",
+        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
+        "MetricName": "L3_Cache_Fill_BW"
+    },
+    {
+        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
+        "BriefDescription": "Average CPU Utilization",
+        "MetricName": "CPU_Utilization"
+    },
+    {
+        "MetricExpr": "(cycles / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 ",
+        "BriefDescription": "Measured Average Frequency for unhalted processors [GHz]",
+        "MetricName": "Average_Frequency"
+    },
+    {
+        "MetricExpr": "cycles / CPU_CLK_UNHALTED.REF_TSC",
+        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
+        "MetricName": "Turbo_Utilization"
+    },
+    {
+        "MetricExpr": "cycles:k / cycles",
+        "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
+        "MetricName": "Kernel_Utilization"
+    }
+]
-- 
2.17.1

