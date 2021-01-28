Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056F7308171
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 23:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhA1WvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 17:51:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:61322 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231657AbhA1WuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:50:17 -0500
IronPort-SDR: WT9QLCdFKWGgxotfYCyNx0h6aTltF9ufAyp9HpWMTDknAI5nGU7CkuUdz5iLSL98VEkeTx1fw3
 itNOCP4kHdMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="244413009"
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="244413009"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 14:45:45 -0800
IronPort-SDR: BszV148KXBWZ0emsYqQmEJbecvkHTFEAV0b8b+LUghnBEW1XoXb2YCd3UCHNblUlPdGPgL6pP1
 93UuXjiDsApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,383,1602572400"; 
   d="scan'208";a="389034627"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2021 14:45:45 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 5/5] perf/x86/intel: Support CPUID 10.ECX to disable fixed counters
Date:   Thu, 28 Jan 2021 14:40:11 -0800
Message-Id: <1611873611-156687-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

With Architectural Performance Monitoring Version 5, CPUID 10.ECX cpu
leaf indicates the fixed counter enumeration. This extends the previous
count to a bitmap which allows disabling even lower fixed counters.
It could be used by a Hypervisor.

The existing intel_ctrl variable is used to remember the bitmask of the
counters. All code that reads all counters is fixed to check this extra
bitmask.

Originally-by: Andi Kleen <ak@linux.intel.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  8 +++++++-
 arch/x86/events/intel/core.c | 34 ++++++++++++++++++++++++----------
 arch/x86/events/perf_event.h |  5 +++++
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e37de29..3d6fdcf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -253,6 +253,8 @@ static bool check_hw_exists(void)
 		if (ret)
 			goto msr_fail;
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
+			if (fixed_counter_disabled(i))
+				continue;
 			if (val & (0x03 << i*4)) {
 				bios_fail = 1;
 				val_fail = val;
@@ -1523,6 +1525,8 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+		if (fixed_counter_disabled(idx))
+			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
@@ -1995,7 +1999,9 @@ static int __init init_hw_perf_events(void)
 	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
 	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
 	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %d\n",     x86_pmu.num_counters_fixed);
+	pr_info("... fixed-purpose events:   %lu\n",
+			hweight64((((1ULL << x86_pmu.num_counters_fixed) - 1)
+					<< INTEL_PMC_IDX_FIXED) & x86_pmu.intel_ctrl));
 	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
 
 	if (!x86_pmu.read)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 99391e44..0d0826c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2735,8 +2735,11 @@ static void intel_pmu_reset(void)
 		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++)
+	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+		if (fixed_counter_disabled(idx))
+			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
+	}
 
 	if (ds)
 		ds->bts_index = ds->bts_buffer_base;
@@ -5193,7 +5196,7 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	struct event_constraint *c;
-	unsigned int unused;
+	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
@@ -5215,7 +5218,7 @@ __init int intel_pmu_init(void)
 	 * Check whether the Architectural PerfMon supports
 	 * Branch Misses Retired hw_event or not.
 	 */
-	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
 	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
 		return -ENODEV;
 
@@ -5239,12 +5242,15 @@ __init int intel_pmu_init(void)
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
 	 * assume at least 3 events, when not running in a hypervisor:
 	 */
-	if (version > 1) {
+	if (version > 1 && version < 5) {
 		int assume = 3 * !boot_cpu_has(X86_FEATURE_HYPERVISOR);
 
 		x86_pmu.num_counters_fixed =
 			max((int)edx.split.num_counters_fixed, assume);
-	}
+
+		fixed_mask = (1L << x86_pmu.num_counters_fixed) - 1;
+	} else if (version >= 5)
+		x86_pmu.num_counters_fixed = fls(fixed_mask);
 
 	if (version >= 4)
 		x86_pmu.counter_freezing = !disable_counter_freezing;
@@ -5836,8 +5842,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
 	}
 
-	x86_pmu.intel_ctrl |=
-		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+	x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
@@ -5854,13 +5859,22 @@ __init int intel_pmu_init(void)
 			 * events to the generic counters.
 			 */
 			if (c->idxmsk64 & INTEL_PMC_MSK_TOPDOWN) {
+				/*
+				 * Disable topdown slots and metrics events,
+				 * if slots event is not in CPUID.
+				 */
+				if (!(INTEL_PMC_MSK_FIXED_SLOTS & x86_pmu.intel_ctrl))
+					c->idxmsk64 = 0;
 				c->weight = hweight64(c->idxmsk64);
 				continue;
 			}
 
-			if (c->cmask == FIXED_EVENT_FLAGS
-			    && c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES) {
-				c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
+			if (c->cmask == FIXED_EVENT_FLAGS) {
+				/* Disabled fixed counters which are not in CPUID */
+				c->idxmsk64 &= x86_pmu.intel_ctrl;
+
+				if (c->idxmsk64 != INTEL_PMC_MSK_FIXED_REF_CYCLES)
+					c->idxmsk64 |= (1ULL << x86_pmu.num_counters) - 1;
 			}
 			c->idxmsk64 &=
 				~(~0ULL << (INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed));
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9f05807..6d2302f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1074,6 +1074,11 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 
+static inline bool fixed_counter_disabled(int i)
+{
+	return !(x86_pmu.intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
+}
+
 #ifdef CONFIG_CPU_SUP_AMD
 
 int amd_pmu_init(void);
-- 
2.7.4

