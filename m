Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEED35245A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbhDBASJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236561AbhDBARw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:52 -0400
IronPort-SDR: 0+uzXfvVFfsLcostglwWinXu6NVtGGFvexhS+nttyKL9ovGx130lO+0B0JpEBW9tmDen2L2yeP
 1BYN+q6nkEDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775046"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775046"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:50 -0700
IronPort-SDR: ureG5v09SMDPTYx8aZCs1kvGi7JNxIbwJr/GzosXklrplg2KZuUOzB2WVAs7chzVWVDmVdYokg
 mPMXaS8cujmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399366"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:50 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 16/25] perf/x86: Register hybrid PMUs
Date:   Thu,  1 Apr 2021 17:10:43 -0700
Message-Id: <1617322252-154215-17-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Different hybrid PMUs have different PMU capabilities and events. Perf
should registers a dedicated PMU for each of them.

To check the X86 event, perf has to go through all possible hybrid pmus.

All the hybrid PMUs are registered at boot time. Before the
registration, add intel_pmu_check_hybrid_pmus() to check and update the
counters information, the event constraints, the extra registers and the
unique capabilities for each hybrid PMUs.

Postpone the display of the PMU information and HW check to
CPU_STARTING, because the boot CPU is the only online CPU in the
init_hw_perf_events(). Perf doesn't know the availability of the other
PMUs. Perf should display the PMU information only if the counters of
the PMU are available.

One type of CPUs may be all offline. For this case, users can still
observe the PMU in /sys/devices, but its CPU mask is 0.

All hybrid PMUs have capability PERF_PMU_CAP_HETEROGENEOUS_CPUS.
The PMU name for hybrid PMUs will be "cpu_XXX", which will be assigned
later in a separated patch.

The PMU type id for the core PMU is still PERF_TYPE_RAW. For the other
hybrid PMUs, the PMU type id is not hard code.

The event->cpu must be compatitable with the supported CPUs of the PMU.
Add a check in the x86_pmu_event_init().

The events in a group must be from the same type of hybrid PMU.
The fake cpuc used in the validation must be from the supported CPU of
the event->pmu.

Perf may not retrieve a valid core type from get_this_hybrid_cpu_type().
For example, ADL may have an alternative configuration. With that
configuration, Perf cannot retrieve the core type from the CPUID leaf
0x1a. Add a platform specific get_hybrid_cpu_type(). If the generic way
fails, invoke the platform specific get_hybrid_cpu_type().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 138 +++++++++++++++++++++++++++++++++++++------
 arch/x86/events/intel/core.c |  93 ++++++++++++++++++++++++++++-
 arch/x86/events/perf_event.h |  14 +++++
 3 files changed, 224 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f9d299b..e15b177 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -485,7 +485,7 @@ int x86_setup_perfctr(struct perf_event *event)
 		local64_set(&hwc->period_left, hwc->sample_period);
 	}
 
-	if (attr->type == PERF_TYPE_RAW)
+	if (attr->type == event->pmu->type)
 		return x86_pmu_extra_regs(event->attr.config, event);
 
 	if (attr->type == PERF_TYPE_HW_CACHE)
@@ -620,7 +620,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		event->hw.config |= ARCH_PERFMON_EVENTSEL_OS;
 
-	if (event->attr.type == PERF_TYPE_RAW)
+	if (event->attr.type == event->pmu->type)
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
@@ -749,7 +749,17 @@ void x86_pmu_enable_all(int added)
 
 static inline int is_x86_event(struct perf_event *event)
 {
-	return event->pmu == &pmu;
+	int i;
+
+	if (!is_hybrid())
+		return event->pmu == &pmu;
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		if (event->pmu == &x86_pmu.hybrid_pmu[i].pmu)
+			return true;
+	}
+
+	return false;
 }
 
 struct pmu *x86_get_pmu(unsigned int cpu)
@@ -1998,6 +2008,23 @@ void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 	pr_info("... event mask:             %016Lx\n", intel_ctrl);
 }
 
+/*
+ * The generic code is not hybrid friendly. The hybrid_pmu->pmu
+ * of the first registered PMU is unconditionally assigned to
+ * each possible cpuctx->ctx.pmu.
+ * Update the correct hybrid PMU to the cpuctx->ctx.pmu.
+ */
+void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu)
+{
+	struct perf_cpu_context *cpuctx;
+
+	if (!pmu->pmu_cpu_context)
+		return;
+
+	cpuctx = per_cpu_ptr(pmu->pmu_cpu_context, cpu);
+	cpuctx->ctx.pmu = pmu;
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2058,8 +2085,11 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	x86_pmu_show_pmu_cap(x86_pmu.num_counters, x86_pmu.num_counters_fixed,
-			     x86_pmu.intel_ctrl);
+	if (!is_hybrid()) {
+		x86_pmu_show_pmu_cap(x86_pmu.num_counters,
+				     x86_pmu.num_counters_fixed,
+				     x86_pmu.intel_ctrl);
+	}
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
@@ -2089,9 +2119,46 @@ static int __init init_hw_perf_events(void)
 	if (err)
 		goto out1;
 
-	err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
-	if (err)
-		goto out2;
+	if (!is_hybrid()) {
+		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
+		if (err)
+			goto out2;
+	} else {
+		u8 cpu_type = get_this_hybrid_cpu_type();
+		struct x86_hybrid_pmu *hybrid_pmu;
+		bool registered = false;
+		int i;
+
+		if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
+			cpu_type = x86_pmu.get_hybrid_cpu_type();
+
+		for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+			hybrid_pmu = &x86_pmu.hybrid_pmu[i];
+
+			hybrid_pmu->pmu = pmu;
+			hybrid_pmu->pmu.type = -1;
+			hybrid_pmu->pmu.attr_update = x86_pmu.attr_update;
+			hybrid_pmu->pmu.capabilities |= PERF_PMU_CAP_HETEROGENEOUS_CPUS;
+
+			err = perf_pmu_register(&hybrid_pmu->pmu, hybrid_pmu->name,
+						(hybrid_pmu->cpu_type == hybrid_big) ? PERF_TYPE_RAW : -1);
+			if (err)
+				continue;
+
+			if (cpu_type == hybrid_pmu->cpu_type)
+				x86_pmu_update_cpu_context(&hybrid_pmu->pmu, raw_smp_processor_id());
+
+			registered = true;
+		}
+
+		if (!registered) {
+			pr_warn("Failed to register hybrid PMUs\n");
+			kfree(x86_pmu.hybrid_pmu);
+			x86_pmu.hybrid_pmu = NULL;
+			x86_pmu.num_hybrid_pmus = 0;
+			goto out2;
+		}
+	}
 
 	return 0;
 
@@ -2216,16 +2283,27 @@ static void free_fake_cpuc(struct cpu_hw_events *cpuc)
 	kfree(cpuc);
 }
 
-static struct cpu_hw_events *allocate_fake_cpuc(void)
+static struct cpu_hw_events *allocate_fake_cpuc(struct pmu *event_pmu)
 {
 	struct cpu_hw_events *cpuc;
-	int cpu = raw_smp_processor_id();
+	int cpu;
 
 	cpuc = kzalloc(sizeof(*cpuc), GFP_KERNEL);
 	if (!cpuc)
 		return ERR_PTR(-ENOMEM);
 	cpuc->is_fake = 1;
 
+	if (is_hybrid()) {
+		struct x86_hybrid_pmu *h_pmu;
+
+		h_pmu = hybrid_pmu(event_pmu);
+		if (cpumask_empty(&h_pmu->supported_cpus))
+			return ERR_PTR(-ENODEV);
+		cpu = cpumask_first(&h_pmu->supported_cpus);
+	} else
+		cpu = raw_smp_processor_id();
+	cpuc->pmu = event_pmu;
+
 	if (intel_cpuc_prepare(cpuc, cpu))
 		goto error;
 
@@ -2244,7 +2322,7 @@ static int validate_event(struct perf_event *event)
 	struct event_constraint *c;
 	int ret = 0;
 
-	fake_cpuc = allocate_fake_cpuc();
+	fake_cpuc = allocate_fake_cpuc(event->pmu);
 	if (IS_ERR(fake_cpuc))
 		return PTR_ERR(fake_cpuc);
 
@@ -2278,7 +2356,27 @@ static int validate_group(struct perf_event *event)
 	struct cpu_hw_events *fake_cpuc;
 	int ret = -EINVAL, n;
 
-	fake_cpuc = allocate_fake_cpuc();
+	/*
+	 * Reject events from different hybrid PMUs.
+	 */
+	if (is_hybrid()) {
+		struct perf_event *sibling;
+		struct pmu *pmu = NULL;
+
+		if (is_x86_event(leader))
+			pmu = leader->pmu;
+
+		for_each_sibling_event(sibling, leader) {
+			if (!is_x86_event(sibling))
+				continue;
+			if (!pmu)
+				pmu = sibling->pmu;
+			else if (pmu != sibling->pmu)
+				return ret;
+		}
+	}
+
+	fake_cpuc = allocate_fake_cpuc(event->pmu);
 	if (IS_ERR(fake_cpuc))
 		return PTR_ERR(fake_cpuc);
 	/*
@@ -2306,16 +2404,18 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
+	struct x86_hybrid_pmu *pmu = NULL;
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
+	if (is_hybrid() && (event->cpu != -1)) {
+		pmu = hybrid_pmu(event->pmu);
+		if (!cpumask_test_cpu(event->cpu, &pmu->supported_cpus))
+			return -ENOENT;
 	}
 
 	err = __x86_pmu_event_init(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d1a13e0..27919ae 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3720,7 +3720,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
-	if (event->attr.type != PERF_TYPE_RAW)
+	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
+	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
 
 	/*
@@ -4218,12 +4219,62 @@ static void flip_smm_bit(void *data)
 	}
 }
 
+static bool init_hybrid_pmu(int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	u8 cpu_type = get_this_hybrid_cpu_type();
+	struct x86_hybrid_pmu *pmu = NULL;
+	int i;
+
+	if (!cpu_type && x86_pmu.get_hybrid_cpu_type)
+		cpu_type = x86_pmu.get_hybrid_cpu_type();
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		if (x86_pmu.hybrid_pmu[i].cpu_type == cpu_type) {
+			pmu = &x86_pmu.hybrid_pmu[i];
+			break;
+		}
+	}
+	if (WARN_ON_ONCE(!pmu || (pmu->pmu.type == -1))) {
+		cpuc->pmu = NULL;
+		return false;
+	}
+
+	/* Only check and dump the PMU information for the first CPU */
+	if (!cpumask_empty(&pmu->supported_cpus))
+		goto end;
+
+	if (!check_hw_exists(&pmu->pmu, pmu->num_counters, pmu->num_counters_fixed))
+		return false;
+
+	pr_info("%s PMU driver: ", pmu->name);
+
+	if (pmu->intel_cap.pebs_output_pt_available)
+		pr_cont("PEBS-via-PT ");
+
+	pr_cont("\n");
+
+	x86_pmu_show_pmu_cap(pmu->num_counters, pmu->num_counters_fixed,
+			     pmu->intel_ctrl);
+
+end:
+	cpumask_set_cpu(cpu, &pmu->supported_cpus);
+	cpuc->pmu = &pmu->pmu;
+
+	x86_pmu_update_cpu_context(&pmu->pmu, cpu);
+
+	return true;
+}
+
 static void intel_pmu_cpu_starting(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int core_id = topology_core_id(cpu);
 	int i;
 
+	if (is_hybrid() && !init_hybrid_pmu(cpu))
+		return;
+
 	init_debug_store_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up.
@@ -4337,7 +4388,12 @@ void intel_cpuc_finish(struct cpu_hw_events *cpuc)
 
 static void intel_pmu_cpu_dead(int cpu)
 {
-	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+
+	intel_cpuc_finish(cpuc);
+
+	if (is_hybrid() && cpuc->pmu)
+		cpumask_clear_cpu(cpu, &hybrid_pmu(cpuc->pmu)->supported_cpus);
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
@@ -5153,6 +5209,36 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
 	}
 }
 
+static void intel_pmu_check_hybrid_pmus(u64 fixed_mask)
+{
+	struct x86_hybrid_pmu *pmu;
+	int i;
+
+	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
+		pmu = &x86_pmu.hybrid_pmu[i];
+
+		intel_pmu_check_num_counters(&pmu->num_counters,
+					     &pmu->num_counters_fixed,
+					     &pmu->intel_ctrl,
+					     fixed_mask);
+
+		if (pmu->intel_cap.perf_metrics) {
+			pmu->intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
+			pmu->intel_ctrl |= INTEL_PMC_MSK_FIXED_SLOTS;
+		}
+
+		if (pmu->intel_cap.pebs_output_pt_available)
+			pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
+
+		intel_pmu_check_event_constraints(pmu->event_constraints,
+						  pmu->num_counters,
+						  pmu->num_counters_fixed,
+						  pmu->intel_ctrl);
+
+		intel_pmu_check_extra_regs(pmu->extra_regs);
+	}
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5832,6 +5918,9 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
+	if (is_hybrid())
+		intel_pmu_check_hybrid_pmus((u64)fixed_mask);
+
 	return 0;
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1da91b7..35510a9 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -15,6 +15,7 @@
 #include <linux/perf_event.h>
 
 #include <asm/intel_ds.h>
+#include <asm/cpu.h>
 
 /* To enable MSR tracing please use the generic trace points. */
 
@@ -634,6 +635,9 @@ enum {
 
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
+	const char			*name;
+	u8				cpu_type;
+	cpumask_t			supported_cpus;
 	union perf_capabilities		intel_cap;
 	u64				intel_ctrl;
 	int				max_pebs_events;
@@ -672,6 +676,13 @@ static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
 	__F;						\
 })
 
+enum hybrid_pmu_type {
+	hybrid_big		= 0x40,
+	hybrid_small		= 0x20,
+
+	hybrid_big_small	= hybrid_big | hybrid_small,
+};
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -869,6 +880,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
+	u8 (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
@@ -1086,6 +1098,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
 			  u64 intel_ctrl);
 
+void x86_pmu_update_cpu_context(struct pmu *pmu, int cpu);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
-- 
2.7.4

