Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF80434AEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhCZTJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:09:18 -0400
Received: from mga03.intel.com ([134.134.136.65]:27803 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhCZTI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:08:56 -0400
IronPort-SDR: l10Rqr8PBlI+/TzkxsyieOWVw47WLO+XsReisUa+iyml0Rjd7Y+mGY96HsKS8Ggd+QkAL+Pt/4
 xMSxR0ejaz/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191234777"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191234777"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:08:55 -0700
IronPort-SDR: uLIXQh6zgtUsMrBJoBILfd4f3s2d1JlTx9+ggrtKN79Uh/CWJuk0gYcW4n1snkQdkJ4C3yoGSX
 nCkYFBUR7BYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="392321056"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2021 12:08:55 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 05/25] perf/x86: Hybrid PMU support for intel_ctrl
Date:   Fri, 26 Mar 2021 12:01:52 -0700
Message-Id: <1616785332-165261-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
References: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The intel_ctrl is the counter mask of a PMU. The PMU counter information
may be different among hybrid PMUs, each hybrid PMU should use its own
intel_ctrl to check and access the counters.

When handling a certain hybrid PMU, apply the intel_ctrl from the
corresponding hybrid PMU.

When checking the HW existence, apply the PMU and number of counters
from the corresponding hybrid PMU as well. Perf will check the HW
existence for each Hybrid PMU before registration. Expose the
check_hw_exists() for a later patch.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 14 +++++++-------
 arch/x86/events/intel/core.c | 14 +++++++++-----
 arch/x86/events/perf_event.h | 10 ++++++++--
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d3d3c6b..fc14697 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -230,7 +230,7 @@ static void release_pmc_hardware(void) {}
 
 #endif
 
-static bool check_hw_exists(void)
+bool check_hw_exists(struct pmu *pmu, int num_counters, int num_counters_fixed)
 {
 	u64 val, val_fail = -1, val_new= ~0;
 	int i, reg, reg_fail = -1, ret = 0;
@@ -241,7 +241,7 @@ static bool check_hw_exists(void)
 	 * Check to see if the BIOS enabled any of the counters, if so
 	 * complain and bail.
 	 */
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		reg = x86_pmu_config_addr(i);
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
@@ -255,13 +255,13 @@ static bool check_hw_exists(void)
 		}
 	}
 
-	if (x86_pmu.num_counters_fixed) {
+	if (num_counters_fixed) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		ret = rdmsrl_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
-		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
-			if (fixed_counter_disabled(i))
+		for (i = 0; i < num_counters_fixed; i++) {
+			if (fixed_counter_disabled(i, pmu))
 				continue;
 			if (val & (0x03 << i*4)) {
 				bios_fail = 1;
@@ -1547,7 +1547,7 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
-		if (fixed_counter_disabled(idx))
+		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
 
@@ -1992,7 +1992,7 @@ static int __init init_hw_perf_events(void)
 	pmu_check_apic();
 
 	/* sanity check that the hardware exists or is emulated */
-	if (!check_hw_exists())
+	if (!check_hw_exists(&pmu, x86_pmu.num_counters, x86_pmu.num_counters_fixed))
 		return 0;
 
 	pr_cont("%s PMU driver.\n", x86_pmu.name);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 494b9bc..7cc2c45 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2153,10 +2153,11 @@ static void intel_pmu_disable_all(void)
 static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	intel_pmu_lbr_enable_all(pmi);
 	wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL,
-			x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
+	       intel_ctrl & ~cpuc->intel_ctrl_guest_mask);
 
 	if (test_bit(INTEL_PMC_IDX_FIXED_BTS, cpuc->active_mask)) {
 		struct perf_event *event =
@@ -2709,6 +2710,7 @@ int intel_pmu_save_and_restart(struct perf_event *event)
 static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	unsigned long flags;
 	int idx;
 
@@ -2724,7 +2726,7 @@ static void intel_pmu_reset(void)
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
-		if (fixed_counter_disabled(idx))
+		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
 	}
@@ -2753,6 +2755,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
+	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	inc_irq_stat(apic_perf_irqs);
 
@@ -2798,7 +2801,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu.drain_pebs(regs, &data);
-		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
+		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3807,10 +3810,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
+	u64 intel_ctrl = hybrid(cpuc->pmu, intel_ctrl);
 
 	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
-	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
-	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
+	arr[0].host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
+	arr[0].guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
 		arr[0].guest &= ~cpuc->pebs_enabled;
 	else
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3306892..9b3b59c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -635,6 +635,7 @@ enum {
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	union perf_capabilities		intel_cap;
+	u64				intel_ctrl;
 };
 
 static __always_inline bool is_hybrid(void)
@@ -1001,6 +1002,9 @@ static inline int x86_pmu_rdpmc_index(int index)
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
 }
 
+bool check_hw_exists(struct pmu *pmu, int num_counters,
+		     int num_counters_fixed);
+
 int x86_add_exclusive(unsigned int what);
 
 void x86_del_exclusive(unsigned int what);
@@ -1105,9 +1109,11 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 
-static inline bool fixed_counter_disabled(int i)
+static inline bool fixed_counter_disabled(int i, struct pmu *pmu)
 {
-	return !(x86_pmu.intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
+	u64 intel_ctrl = hybrid(pmu, intel_ctrl);
+
+	return !(intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
-- 
2.7.4

