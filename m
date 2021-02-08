Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C88F313BBE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhBHR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:57:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:62838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233958AbhBHPca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:32:30 -0500
IronPort-SDR: FMkA9XVtdydHgxm0FKtKHii9UBdekDQPrBQPVrLenN+DemnaOCemc/AbC2ioLu90yU5bNm6mcB
 2GlX/jzL7wjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951899"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951899"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:01 -0800
IronPort-SDR: mNMc06eYntWlQftIvy7RK+H3TyPWCbf5kttYtXk9oegiwDPeFPAtw6kBCWqvKiz3YvBxNN38eJ
 wORL3FpW1FCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820506"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:01 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 04/49] perf/x86: Hybrid PMU support for intel_ctrl
Date:   Mon,  8 Feb 2021 07:25:01 -0800
Message-Id: <1612797946-18784-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The intel_ctrl is the event mask of a PMU. The PMU counter information
may be different among hybrid PMUs, each hybrid PMU should use its own
intel_ctrl.

When handling a certain hybrid PMU, apply the intel_ctrl from the
corresponding hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  4 ++--
 arch/x86/events/intel/core.c | 14 +++++++++-----
 arch/x86/events/perf_event.h |  7 +++++--
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 334553f..170acbf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -256,7 +256,7 @@ static bool check_hw_exists(void)
 		if (ret)
 			goto msr_fail;
 		for (i = 0; i < x86_pmu.num_counters_fixed; i++) {
-			if (fixed_counter_disabled(i))
+			if (fixed_counter_disabled(i, NULL))
 				continue;
 			if (val & (0x03 << i*4)) {
 				bios_fail = 1;
@@ -1535,7 +1535,7 @@ void perf_event_print_debug(void)
 			cpu, idx, prev_left);
 	}
 	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
-		if (fixed_counter_disabled(idx))
+		if (fixed_counter_disabled(idx, cpuc))
 			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4d026f6..1b9563c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2153,10 +2153,11 @@ static void intel_pmu_disable_all(void)
 static void __intel_pmu_enable_all(int added, bool pmi)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 intel_ctrl = X86_HYBRID_READ_FROM_CPUC(intel_ctrl, cpuc);
 
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
+		if (fixed_counter_disabled(idx, cpuc))
 			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
 	}
@@ -2753,6 +2755,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	int bit;
 	int handled = 0;
+	u64 intel_ctrl = X86_HYBRID_READ_FROM_CPUC(intel_ctrl, cpuc);
 
 	inc_irq_stat(apic_perf_irqs);
 
@@ -2798,7 +2801,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 		handled++;
 		x86_pmu.drain_pebs(regs, &data);
-		status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
+		status &= intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3808,10 +3811,11 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_guest_switch_msr *arr = cpuc->guest_switch_msrs;
+	u64 intel_ctrl = X86_HYBRID_READ_FROM_CPUC(intel_ctrl, cpuc);
 
 	arr[0].msr = MSR_CORE_PERF_GLOBAL_CTRL;
-	arr[0].host = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
-	arr[0].guest = x86_pmu.intel_ctrl & ~cpuc->intel_ctrl_host_mask;
+	arr[0].host = intel_ctrl & ~cpuc->intel_ctrl_guest_mask;
+	arr[0].guest = intel_ctrl & ~cpuc->intel_ctrl_host_mask;
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
 		arr[0].guest &= ~cpuc->pebs_enabled;
 	else
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a53d4dd..b939784 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -647,6 +647,7 @@ enum x86_hybrid_pmu_type_idx {
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	union perf_capabilities		intel_cap;
+	u64				intel_ctrl;
 };
 
 #define IS_X86_HYBRID			cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)
@@ -1106,9 +1107,11 @@ ssize_t events_sysfs_show(struct device *dev, struct device_attribute *attr,
 ssize_t events_ht_sysfs_show(struct device *dev, struct device_attribute *attr,
 			  char *page);
 
-static inline bool fixed_counter_disabled(int i)
+static inline bool fixed_counter_disabled(int i, struct cpu_hw_events *cpuc)
 {
-	return !(x86_pmu.intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
+	u64 intel_ctrl = X86_HYBRID_READ_FROM_CPUC(intel_ctrl, cpuc);
+
+	return !(intel_ctrl >> (i + INTEL_PMC_IDX_FIXED));
 }
 
 #ifdef CONFIG_CPU_SUP_AMD
-- 
2.7.4

