Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A494313CDF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbhBHSLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:11:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:62778 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234021AbhBHPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:40:15 -0500
IronPort-SDR: U/hGEWZpvyBxNlRkpNDgcA0LfUDlPTMNCxxKMC+7i/v3he5si+xJ4qnPIqYeKVEV7vwAmIRNu1
 eAYTMJTzF4Vg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951967"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951967"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:19 -0800
IronPort-SDR: nyhDXeDCN0I9vCKt1W/SpZB79Cx1UgziUrfgo4Mhw9KpIXMZ2oraSPhAHyfPz5rTQWIC74L3Vo
 YELjOA8T4zQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820680"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:17 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 16/49] perf/x86: Register hybrid PMUs
Date:   Mon,  8 Feb 2021 07:25:13 -0800
Message-Id: <1612797946-18784-17-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Different hybrid PMUs have different PMU capabilities and events. Perf
should registers a dedicated PMU for each of them.

To check the X86 event, perf has to go through all possible hybrid pmus.

Only the PMU for the boot CPU is registered in init_hw_perf_events()
because the boot CPU is the only online CPU at that moment.
The init_hybrid_pmu() is introduced to register and initialize the other
type of PMUs when the new type of CPU is online.

All hybrid PMUs have capability PERF_PMU_CAP_HETEROGENEOUS_CPUS.
The PMU name for hybrid PMUs will be "cpu_XXX", which will be assigned
later in a separated patch.

The PMU type id for the core PMU is still PERF_TYPE_RAW. For the other
hybrid PMUs, the PMU type id is not hard code.

The event->cpu must be compatitable with the supported CPUs of the PMU.
Add a check in the x86_pmu_event_init().

The events in a group must be from the same type of hybrid PMU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  98 +++++++++++++++++++++++++++++++++-------
 arch/x86/events/intel/core.c | 105 ++++++++++++++++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  24 ++++++++++
 3 files changed, 211 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bbd87b7..44ad8dc 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -480,7 +480,7 @@ int x86_setup_perfctr(struct perf_event *event)
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
-	if (attr->type == PERF_TYPE_RAW)
+	if (attr->type == event->pmu->type)
 		return x86_pmu_extra_regs(event->attr.config, event);
 
 	if (attr->type == PERF_TYPE_HW_CACHE)
@@ -615,7 +615,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_OS;
 
-	if (event->attr.type == PERF_TYPE_RAW)
+	if (event->attr.type == event->pmu->type)
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
@@ -746,7 +746,16 @@ static struct pmu pmu;
 
 static inline int is_x86_event(struct perf_event *event)
 {
-	return event->pmu == &pmu;
+	int bit;
+
+	if (!IS_X86_HYBRID)
+		return event->pmu == &pmu;
+
+	for_each_set_bit(bit, &x86_pmu.hybrid_pmu_bitmap, X86_HYBRID_PMU_MAX_INDEX) {
+		if (event->pmu == &x86_pmu.hybrid_pmu[bit].pmu)
+			return true;
+	}
+	return false;
 }
 
 struct pmu *x86_get_pmu(void)
@@ -2053,8 +2062,11 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	x86_pmu_show_pmu_cap(x86_pmu.num_counters, x86_pmu.num_counters_fixed,
-			     x86_pmu.intel_ctrl);
+	if (!IS_X86_HYBRID) {
+		x86_pmu_show_pmu_cap(x86_pmu.num_counters,
+				     x86_pmu.num_counters_fixed,
+				     x86_pmu.intel_ctrl);
+	}
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
@@ -2084,9 +2096,36 @@ static int __init init_hw_perf_events(void)
 	if (err)
 		goto out1;
 
-	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
-	if (err)
-		goto out2;
+	if (!IS_X86_HYBRID) {
+		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+		if (err)
+			goto out2;
+	} else {
+		struct x86_hybrid_pmu *hybrid_pmu;
+		int bit;
+
+		for_each_set_bit(bit, &x86_pmu.hybrid_pmu_bitmap, X86_HYBRID_PMU_MAX_INDEX) {
+			hybrid_pmu = &x86_pmu.hybrid_pmu[bit];
+
+			hybrid_pmu->pmu = pmu;
+			hybrid_pmu->pmu.type = -1;
+			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
+			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
+
+			/* Only register the PMU for the boot CPU */
+			if (bit != x86_hybrid_get_idx_from_cpu(smp_processor_id()))
+				continue;
+
+			if (X86_HYBRID_PMU_CORE_IDX == bit)
+				err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name, PERF_TYPE_RAW);
+			else
+				err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name, -1);
+			if (err)
+				clear_bit(bit, &x86_pmu.hybrid_pmu_bitmap);
+		}
+		if (!x86_pmu.hybrid_pmu_bitmap)
+			goto out2;
+	}
 
 	return 0;
 
@@ -2221,6 +2260,11 @@ static struct cpu_hw_events *allocate_fake_cpuc(void)
 		return ERR_PTR(-ENOMEM);
 	cpuc->is_fake = 1;
 
+	if (IS_X86_HYBRID)
+		cpuc->hybrid_pmu_idx = x86_hybrid_get_idx_from_cpu(cpu);
+	else
+		cpuc->hybrid_pmu_idx = X86_NON_HYBRID_PMU;
+
 	if (intel_cpuc_prepare(cpuc, cpu))
 		goto error;
 
@@ -2273,6 +2317,28 @@ static int validate_group(struct perf_event *event)
 	struct cpu_hw_events *fake_cpuc;
 	int ret = -EINVAL, n;
 
+	/*
+	 * Reject events from different hybrid PMUs.
+	 */
+	if (IS_X86_HYBRID) {
+		struct perf_event *sibling;
+		struct pmu *pmu = NULL;
+
+		if (leader->pmu->task_ctx_nr == perf_hw_context)
+			pmu = leader->pmu;
+		else {
+			for_each_sibling_event(sibling, leader) {
+				if (sibling->pmu->task_ctx_nr == perf_hw_context) {
+					pmu = sibling->pmu;
+					break;
+				}
+			}
+		}
+
+		if (pmu && pmu != event->pmu)
+			return ret;
+	}
+
 	fake_cpuc = allocate_fake_cpuc();
 	if (IS_ERR(fake_cpuc))
 		return PTR_ERR(fake_cpuc);
@@ -2301,16 +2367,18 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
+	struct x86_hybrid_pmu *hybrid_pmu = NULL;
 	int err;
 
-	switch (event->attr.type) {
-	case PERF_TYPE_RAW:
-	case PERF_TYPE_HARDWARE:
-	case PERF_TYPE_HW_CACHE:
-		break;
-
-	default:
+	if ((event->attr.type != event->pmu->type) &&
+	    (event->attr.type != PERF_TYPE_HARDWARE) &&
+	    (event->attr.type != PERF_TYPE_HW_CACHE))
 		return -ENOENT;
+
+	if (IS_X86_HYBRID && (event->cpu != -1)) {
+		hybrid_pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
+		if (!cpumask_test_cpu(event->cpu, &hybrid_pmu->supported_cpus))
+			return -ENOENT;
 	}
 
 	err = __x86_pmu_event_init(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 559b4e9..d2de342 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3721,7 +3721,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
-	if (event->attr.type != PERF_TYPE_RAW)
+	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
+	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
 
 	/*
@@ -4304,12 +4305,97 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
 	}
 }
 
+static void init_hybrid_pmu(int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	int idx = x86_hybrid_get_idx_from_cpu(cpu);
+	struct x86_hybrid_pmu *pmu;
+	struct perf_cpu_context *cpuctx;
+	unsigned int fixed_mask, unused_eax, unused_ebx, unused_edx;
+
+	if (WARN_ON(!IS_VALID_HYBRID_PMU_IDX(idx)))
+		return;
+
+	if (!test_bit(idx, &x86_pmu.hybrid_pmu_bitmap))
+		return;
+
+	cpuc->hybrid_pmu_idx = idx;
+	pmu = &x86_pmu.hybrid_pmu[idx];
+
+	/* Only register PMU for the first CPU */
+	if (!cpumask_empty(&pmu->supported_cpus)) {
+		cpumask_set_cpu(cpu, &pmu->supported_cpus);
+
+		/*
+		 * The cpuctx of all CPUs are allocated when registering the
+		 * boot CPU's PMU. At that time, the PMU for other hybrid CPUs
+		 * is not registered yet. The boot CPU's PMU was
+		 * unconditionally assigned to each cpuctx->ctx.pmu.
+		 * Update the cpuctx->ctx.pmu when the PMU for other hybrid
+		 * CPUs is known.
+		 */
+		cpuctx = per_cpu_ptr(pmu->pmu.pmu_cpu_context, cpu);
+		cpuctx->ctx.pmu = &pmu->pmu;
+		return;
+	}
+
+	if ((pmu->pmu.type == -1) &&
+	    perf_pmu_register(&pmu->pmu, pmu->name,
+			      (idx == X86_HYBRID_PMU_CORE_IDX) ? PERF_TYPE_RAW : -1))
+		return;
+
+	cpuctx = per_cpu_ptr(pmu->pmu.pmu_cpu_context, cpu);
+	cpuctx->ctx.pmu = &pmu->pmu;
+
+	/*
+	 * Except for ECX, other fields have been stored in the x86 struct
+	 * at boot time.
+	 */
+	cpuid(10, &unused_eax, &unused_ebx, &fixed_mask, &unused_edx);
+
+	intel_pmu_check_num_counters(&pmu->num_counters,
+				     &pmu->num_counters_fixed,
+				     &pmu->intel_ctrl,
+				     (u64)fixed_mask);
+
+	pr_info("%s PMU driver: ", pmu->name);
+
+	if (pmu->intel_cap.perf_metrics) {
+		pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+		pmu->intel_ctrl |= INTEL_PMC_MSK_FIXED_SLOTS;
+	}
+
+	if (pmu->intel_cap.pebs_output_pt_available) {
+		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
+		pr_cont("PEBS-via-PT ");
+	}
+
+	intel_pmu_check_event_constraints(pmu->event_constraints,
+					  pmu->num_counters,
+					  pmu->num_counters_fixed,
+					  pmu->intel_ctrl);
+
+	intel_pmu_check_extra_regs(pmu->extra_regs);
+
+	pr_cont("\n");
+
+	x86_pmu_show_pmu_cap(pmu->num_counters, pmu->num_counters_fixed,
+			     pmu->intel_ctrl);
+
+	cpumask_set_cpu(cpu, &pmu->supported_cpus);
+
+	return;
+}
+
 static void intel_pmu_cpu_starting(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int core_id = topology_core_id(cpu);
 	int i;
 
+	if (IS_X86_HYBRID)
+		init_hybrid_pmu(cpu);
+
 	init_debug_store_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up.
@@ -4424,6 +4510,23 @@ void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 static void intel_pmu_cpu_dead(int cpu)
 {
 	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
+
+	if (IS_X86_HYBRID) {
+		struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+		int idx = x86_hybrid_get_idx_from_cpu(cpu);
+		struct x86_hybrid_pmu *hybrid_pmu;
+
+		if (WARN_ON(!IS_VALID_HYBRID_PMU_IDX(idx)))
+			return;
+
+		hybrid_pmu = &x86_pmu.hybrid_pmu[idx];
+		cpumask_clear_cpu(cpu, &hybrid_pmu->supported_cpus);
+		cpuc->hybrid_pmu_idx = X86_NON_HYBRID_PMU;
+		if (cpumask_empty(&hybrid_pmu->supported_cpus)) {
+			perf_pmu_unregister(&hybrid_pmu->pmu);
+			hybrid_pmu->pmu.type = -1;
+		}
+	}
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d5fcc15..740ba48 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -643,9 +643,14 @@ enum x86_hybrid_pmu_type_idx {
 	X86_HYBRID_PMU_MAX_INDEX
 };
 
+#define X86_HYBRID_ATOM_CPU_TYPE	0x20
+#define X86_HYBRID_CORE_CPU_TYPE	0x40
 
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
+	const char			*name;
+	u32				cpu_type;
+	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	int				max_pebs_events;
@@ -679,6 +684,25 @@ struct x86_hybrid_pmu {
 #define X86_HYBRID_READ_FROM_EVENT(_name, _event)			\
 	(IS_X86_HYBRID ? ((struct x86_hybrid_pmu *)(_event->pmu))->_name : x86_pmu._name)
 
+#define IS_VALID_HYBRID_PMU_IDX(idx)					\
+	(idx < X86_HYBRID_PMU_MAX_INDEX && idx > X86_NON_HYBRID_PMU)
+
+static inline enum x86_hybrid_pmu_type_idx
+x86_hybrid_get_idx_from_cpu(unsigned int cpu)
+{
+	unsigned int cpu_type = cpu_data(cpu).x86_cpu_type >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
+
+	switch (cpu_type) {
+	case X86_HYBRID_ATOM_CPU_TYPE:
+		return X86_HYBRID_PMU_ATOM_IDX;
+	case X86_HYBRID_CORE_CPU_TYPE:
+		return X86_HYBRID_PMU_CORE_IDX;
+	default:
+		pr_warn("CPU %u: invalid cpu type %u\n", cpu, cpu_type);
+	}
+	return X86_NON_HYBRID_PMU;
+}
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
-- 
2.7.4

