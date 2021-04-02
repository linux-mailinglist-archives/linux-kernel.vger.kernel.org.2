Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CD352450
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhDBARn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236379AbhDBARl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:41 -0400
IronPort-SDR: OG08FiyfG2vXYjvoSzJ2nwL13T/7XFge8DigvpZX4RbxhsW+463TXO/5G7w/1wL1Ua0nS2mCQg
 Srf+QBru68FQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775018"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775018"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:41 -0700
IronPort-SDR: hxh38T2TxjfBzS02mHik65ufCddvdmlY4Eg0gvhu1MFHgizMlyu4QBIg7KSNp08DFCl+ct2L2H
 ymfGiEq/pLnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399279"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:40 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 06/25] perf/x86: Hybrid PMU support for counters
Date:   Thu,  1 Apr 2021 17:10:33 -0700
Message-Id: <1617322252-154215-7-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The number of GP and fixed counters are different among hybrid PMUs.
Each hybrid PMU should use its own counter related information.

When handling a certain hybrid PMU, apply the number of counters from
the corresponding hybrid PMU.

When reserving the counters in the initialization of a new event,
reserve all possible counters.

The number of counter recored in the global x86_pmu is for the
architecture counters which are available for all hybrid PMUs. KVM
doesn't support the hybrid PMU yet. Return the number of the
architecture counters for now.

For the functions only available for the old platforms, e.g.,
intel_pmu_drain_pebs_nhm(), nothing is changed.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 55 ++++++++++++++++++++++++++++++--------------
 arch/x86/events/intel/core.c |  8 ++++---
 arch/x86/events/intel/ds.c   | 14 +++++++----
 arch/x86/events/perf_event.h |  3 +++
 4 files changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index fc14697..0bd9554 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -184,16 +184,29 @@ static DEFINE_MUTEX(pmc_reserve_mutex);
 
 #ifdef CONFIG_X86_LOCAL_APIC
 
+static inline int get_possible_num_counters(void)
+{
+	int i, num_counters = x86_pmu.num_counters;
+
+	if (!is_hybrid())
+		return num_counters;
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++)
+		num_counters = max_t(int, num_counters, x86_pmu.hybrid_pmu[i].num_counters);
+
+	return num_counters;
+}
+
 static bool reserve_pmc_hardware(void)
 {
-	int i;
+	int i, num_counters = get_possible_num_counters();
 
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		if (!reserve_perfctr_nmi(x86_pmu_event_addr(i)))
 			goto perfctr_fail;
 	}
 
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		if (!reserve_evntsel_nmi(x86_pmu_config_addr(i)))
 			goto eventsel_fail;
 	}
@@ -204,7 +217,7 @@ static bool reserve_pmc_hardware(void)
 	for (i--; i >= 0; i--)
 		release_evntsel_nmi(x86_pmu_config_addr(i));
 
-	i = x86_pmu.num_counters;
+	i = num_counters;
 
 perfctr_fail:
 	for (i--; i >= 0; i--)
@@ -215,9 +228,9 @@ static bool reserve_pmc_hardware(void)
 
 static void release_pmc_hardware(void)
 {
-	int i;
+	int i, num_counters = get_possible_num_counters();
 
-	for (i = 0; i < x86_pmu.num_counters; i++) {
+	for (i = 0; i < num_counters; i++) {
 		release_perfctr_nmi(x86_pmu_event_addr(i));
 		release_evntsel_nmi(x86_pmu_config_addr(i));
 	}
@@ -945,6 +958,7 @@ EXPORT_SYMBOL_GPL(perf_assign_events);
 
 int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 {
+	int num_counters = hybrid(cpuc->pmu, num_counters);
 	struct event_constraint *c;
 	struct perf_event *e;
 	int n0, i, wmin, wmax, unsched = 0;
@@ -1020,7 +1034,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 
 	/* slow path */
 	if (i != n) {
-		int gpmax = x86_pmu.num_counters;
+		int gpmax = num_counters;
 
 		/*
 		 * Do not allow scheduling of more than half the available
@@ -1041,7 +1055,7 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 		 * the extra Merge events needed by large increment events.
 		 */
 		if (x86_pmu.flags & PMU_FL_PAIR) {
-			gpmax = x86_pmu.num_counters - cpuc->n_pair;
+			gpmax = num_counters - cpuc->n_pair;
 			WARN_ON(gpmax <= 0);
 		}
 
@@ -1128,10 +1142,12 @@ static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
  */
 static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader, bool dogrp)
 {
+	int num_counters = hybrid(cpuc->pmu, num_counters);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct perf_event *event;
 	int n, max_count;
 
-	max_count = x86_pmu.num_counters + x86_pmu.num_counters_fixed;
+	max_count = num_counters + num_counters_fixed;
 
 	/* current number of events already accepted */
 	n = cpuc->n_events;
@@ -1499,18 +1515,18 @@ void perf_event_print_debug(void)
 {
 	u64 ctrl, status, overflow, pmc_ctrl, pmc_count, prev_left, fixed;
 	u64 pebs, debugctl;
-	struct cpu_hw_events *cpuc;
+	int cpu = smp_processor_id();
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	int num_counters = hybrid(cpuc->pmu, num_counters);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	unsigned long flags;
-	int cpu, idx;
+	int idx;
 
-	if (!x86_pmu.num_counters)
+	if (!num_counters)
 		return;
 
 	local_irq_save(flags);
 
-	cpu = smp_processor_id();
-	cpuc = &per_cpu(cpu_hw_events, cpu);
-
 	if (x86_pmu.version >= 2) {
 		rdmsrl(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
 		rdmsrl(MSR_CORE_PERF_GLOBAL_STATUS, status);
@@ -1533,7 +1549,7 @@ void perf_event_print_debug(void)
 	}
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for (idx = 0; idx < num_counters; idx++) {
 		rdmsrl(x86_pmu_config_addr(idx), pmc_ctrl);
 		rdmsrl(x86_pmu_event_addr(idx), pmc_count);
 
@@ -1546,7 +1562,7 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d:   gen-PMC%d left:  %016llx\n",
 			cpu, idx, prev_left);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+	for (idx = 0; idx < num_counters_fixed; idx++) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		rdmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, pmc_count);
@@ -2781,6 +2797,11 @@ unsigned long perf_misc_flags(struct pt_regs *regs)
 void perf_get_x86_pmu_capability(struct x86_pmu_capability *cap)
 {
 	cap->version		= x86_pmu.version;
+	/*
+	 * KVM doesn't support the hybrid PMU yet.
+	 * Return the common value in global x86_pmu,
+	 * which available for all cores.
+	 */
 	cap->num_counters_gp	= x86_pmu.num_counters;
 	cap->num_counters_fixed	= x86_pmu.num_counters_fixed;
 	cap->bit_width_gp	= x86_pmu.cntval_bits;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7cc2c45..33d26ed 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2711,21 +2711,23 @@ static void intel_pmu_reset(void)
 {
 	struct debug_store *ds = __this_cpu_read(cpu_hw_events.ds);
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
+	int num_counters = hybrid(cpuc->pmu, num_counters);
 	unsigned long flags;
 	int idx;
 
-	if (!x86_pmu.num_counters)
+	if (!num_counters)
 		return;
 
 	local_irq_save(flags);
 
 	pr_info("clearing PMU state on CPU#%d\n", smp_processor_id());
 
-	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
+	for (idx = 0; idx < num_counters; idx++) {
 		wrmsrl_safe(x86_pmu_config_addr(idx), 0ull);
 		wrmsrl_safe(x86_pmu_event_addr(idx),  0ull);
 	}
-	for (idx = 0; idx < x86_pmu.num_counters_fixed; idx++) {
+	for (idx = 0; idx < num_counters_fixed; idx++) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
 		wrmsrl_safe(MSR_ARCH_PERFMON_FIXED_CTR0 + idx, 0ull);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9328aa1..312bf3b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1007,6 +1007,8 @@ void intel_pmu_pebs_sched_task(struct perf_event_context *ctx, bool sched_in)
 static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 {
 	struct debug_store *ds = cpuc->ds;
+	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	u64 threshold;
 	int reserved;
 
@@ -1014,9 +1016,9 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 		return;
 
 	if (x86_pmu.flags & PMU_FL_PEBS_ALL)
-		reserved = x86_pmu.max_pebs_events + x86_pmu.num_counters_fixed;
+		reserved = max_pebs_events + num_counters_fixed;
 	else
-		reserved = x86_pmu.max_pebs_events;
+		reserved = max_pebs_events;
 
 	if (cpuc->n_pebs == cpuc->n_large_pebs) {
 		threshold = ds->pebs_absolute_maximum -
@@ -2072,6 +2074,8 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int max_pebs_events = hybrid(cpuc->pmu, max_pebs_events);
+	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
 	void *base, *at, *top;
@@ -2086,9 +2090,9 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = ((1ULL << x86_pmu.max_pebs_events) - 1) |
-	       (((1ULL << x86_pmu.num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
-	size = INTEL_PMC_IDX_FIXED + x86_pmu.num_counters_fixed;
+	mask = ((1ULL << max_pebs_events) - 1) |
+	       (((1ULL << num_counters_fixed) - 1) << INTEL_PMC_IDX_FIXED);
+	size = INTEL_PMC_IDX_FIXED + num_counters_fixed;
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, size);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f9b1eee..993f0de 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -636,6 +636,9 @@ struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
+	int				max_pebs_events;
+	int				num_counters;
+	int				num_counters_fixed;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
-- 
2.7.4

