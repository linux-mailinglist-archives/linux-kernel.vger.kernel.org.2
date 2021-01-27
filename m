Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68BE30602A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbhA0Psv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:48:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:12380 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236558AbhA0PrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:47:08 -0500
IronPort-SDR: XLrJX9o2th2gw5EAU41IHEDV0U2Xw3zfhyscmtoCMIsXt3U96BU8N7dNYGIXYYGd0nXzntRfSm
 5Enduehn+jYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159861143"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="159861143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 07:42:20 -0800
IronPort-SDR: 2D/G+4xlIt7WHp6sPitxHcyIZiPFLWNc+KMVMOXCTh3EgGoUhXo8CG67D0pj28ooKF8Y6Gk+t8
 s28qhaRNNtUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="369514653"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2021 07:42:20 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 5/5] perf/x86/intel: Support CPUID 10.ECX to disable fixed counters
Date:   Wed, 27 Jan 2021 07:38:45 -0800
Message-Id: <1611761925-159055-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
References: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
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
index 31e9aec..cd4d542 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2750,8 +2750,11 @@ static void intel_pmu_reset(void)
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
@@ -5206,7 +5209,7 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	struct event_constraint *c;
-	unsigned int unused;
+	unsigned int fixed_mask;
 	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
@@ -5228,7 +5231,7 @@ __init int intel_pmu_init(void)
 	 * Check whether the Architectural PerfMon supports
 	 * Branch Misses Retired hw_event or not.
 	 */
-	cpuid(10, &eax.full, &ebx.full, &unused, &edx.full);
+	cpuid(10, &eax.full, &ebx.full, &fixed_mask, &edx.full);
 	if (eax.split.mask_length < ARCH_PERFMON_EVENTS_COUNT)
 		return -ENODEV;
 
@@ -5252,12 +5255,15 @@ __init int intel_pmu_init(void)
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
@@ -5847,8 +5853,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
 	}
 
-	x86_pmu.intel_ctrl |=
-		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
+	x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
@@ -5865,13 +5870,22 @@ __init int intel_pmu_init(void)
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
index 767dbf8..15977d0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1068,6 +1068,11 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
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

