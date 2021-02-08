Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EB313BC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhBHR6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 12:58:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:62811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhBHPcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:32:12 -0500
IronPort-SDR: U6N9LeTF3v/+e9oYQeoZ5sKR5uOOrPYNdzXEtT4bhRluf9V5s8u7yMc/FwioK1AqAGSguGUll6
 q2tUzuZsZcRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951896"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951896"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:00 -0800
IronPort-SDR: x+c1Lmw0JaMblfhlaOMDcMQ55P8BdlI5I+V9FMy8fK1XVQ5F5dTCIOg+Q8U6RVRSjrFNVHlqqN
 T39xnZBfPeGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820498"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:00 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 03/49] perf/x86/intel: Hybrid PMU support for perf capabilities
Date:   Mon,  8 Feb 2021 07:25:00 -0800
Message-Id: <1612797946-18784-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Some platforms, e.g. Alder Lake, have hybrid architecture. Although most
PMU capabilities are the same, there are still some unique PMU
capabilities for different hybrid PMUs. Perf should register a dedicated
pmu for each hybrid PMU.

Add a new struct x86_hybrid_pmu, which saves the dedicated pmu and
capabilities for each hybrid PMU.

The 'hybrid_pmu_idx' is introduced in the per-CPU struct cpu_hw_events
to indicate the index of the hybrid PMU for this CPU.

The architecture MSR, MSR_IA32_PERF_CAPABILITIES, only indicates the
architecture features which are available on all hybrid PMUs. The
architecture features are stored in the global x86_pmu.intel_cap.

For Alder Lake, the model-specific features are perf metrics and
PEBS-via-PT. The corresponding bits of the global x86_pmu.intel_cap
should be 0 for these two features. Perf should not use the global
intel_cap to check the features on a hybrid system.
Add a dedicated intel_cap in the x86_hybrid_pmu to store the
model-specific capabilities. Use the dedicated intel_cap to replace
the global intel_cap for thse two features. The dedicated intel_cap
will be set in the following "Add Alder Lake Hybrid support" patch.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c           |  7 +++++--
 arch/x86/events/intel/core.c     | 31 ++++++++++++++++++++++++++-----
 arch/x86/events/intel/ds.c       |  2 +-
 arch/x86/events/perf_event.h     | 38 ++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/msr-index.h |  2 ++
 5 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 6ddeed3..334553f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -48,6 +48,7 @@ struct x86_pmu x86_pmu __read_mostly;
 
 DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
 	.enabled = 1,
+	.hybrid_pmu_idx = X86_NON_HYBRID_PMU,
 };
 
 DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
@@ -1092,8 +1093,9 @@ static void del_nr_metric_event(struct cpu_hw_events *cpuc,
 static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
 			 int max_count, int n)
 {
+	union perf_capabilities intel_cap = X86_HYBRID_READ_FROM_CPUC(intel_cap, cpuc);
 
-	if (x86_pmu.intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
+	if (intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
 		return -EINVAL;
 
 	if (n >= max_count + cpuc->n_metric)
@@ -1569,6 +1571,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 static void x86_pmu_del(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union perf_capabilities intel_cap = X86_HYBRID_READ_FROM_CPUC(intel_cap, cpuc);
 	int i;
 
 	/*
@@ -1608,7 +1611,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
-	if (x86_pmu.intel_cap.perf_metrics)
+	if (intel_cap.perf_metrics)
 		del_nr_metric_event(cpuc, event);
 
 	perf_event_update_userpage(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 67a7246..4d026f6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3646,6 +3646,19 @@ static inline bool is_mem_loads_aux_event(struct perf_event *event)
 	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0x03, .umask=0x82);
 }
 
+static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
+{
+	struct x86_hybrid_pmu *pmu;
+
+	if (!IS_X86_HYBRID)
+		return test_bit(idx, (unsigned long *)&x86_pmu.intel_cap.capabilities);
+
+	pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
+	if (test_bit(idx, (unsigned long *)&pmu->intel_cap.capabilities))
+		return true;
+
+	return false;
+}
 
 static int intel_pmu_hw_config(struct perf_event *event)
 {
@@ -3709,7 +3722,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * with a slots event as group leader. When the slots event
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
-	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
+	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
 		if (event->attr.config1 || event->attr.config2)
 			return -EINVAL;
 
@@ -4216,8 +4229,16 @@ static void intel_pmu_cpu_starting(int cpu)
 	if (x86_pmu.version > 1)
 		flip_smm_bit(&x86_pmu.attr_freeze_on_smi);
 
-	/* Disable perf metrics if any added CPU doesn't support it. */
-	if (x86_pmu.intel_cap.perf_metrics) {
+	/*
+	 * Disable perf metrics if any added CPU doesn't support it.
+	 *
+	 * Turn off the check for a hybrid architecture, because the
+	 * architecture MSR, MSR_IA32_PERF_CAPABILITIES, only indicate
+	 * the architecture features. The perf metrics is a model-specific
+	 * feature for now. The corresponding bit should always be 0 on
+	 * a hybrid platform, e.g., Alder Lake.
+	 */
+	if (!IS_X86_HYBRID && x86_pmu.intel_cap.perf_metrics) {
 		union perf_capabilities perf_cap;
 
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
@@ -4327,7 +4348,7 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
 
 static int intel_pmu_aux_output_match(struct perf_event *event)
 {
-	if (!x86_pmu.intel_cap.pebs_output_pt_available)
+	if (!intel_pmu_has_cap(event, PERF_CAP_PT_IDX))
 		return 0;
 
 	return is_intel_pt_event(event);
@@ -5764,7 +5785,7 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
-	if (x86_pmu.intel_cap.perf_metrics)
+	if (!IS_X86_HYBRID && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
 	return 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7ebae18..ba7cf05 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2205,7 +2205,7 @@ void __init intel_ds_init(void)
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
 
-			if (x86_pmu.intel_cap.pebs_output_pt_available) {
+			if (!IS_X86_HYBRID && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
 				x86_get_pmu()->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 53b2b5f..a53d4dd 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -327,6 +327,11 @@ struct cpu_hw_events {
 	int				n_pair; /* Large increment events */
 
 	void				*kfree_on_online[X86_PERF_KFREE_MAX];
+
+	/*
+	 * Hybrid PMU support
+	 */
+	int			        hybrid_pmu_idx;
 };
 
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
@@ -630,6 +635,30 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
+enum x86_hybrid_pmu_type_idx {
+	X86_NON_HYBRID_PMU		= -1,
+	X86_HYBRID_PMU_ATOM_IDX		= 0,
+	X86_HYBRID_PMU_CORE_IDX,
+
+	X86_HYBRID_PMU_MAX_INDEX
+};
+
+
+struct x86_hybrid_pmu {
+	struct pmu			pmu;
+	union perf_capabilities		intel_cap;
+};
+
+#define IS_X86_HYBRID			cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)
+
+#define HAS_VALID_HYBRID_PMU_IN_CPUC(_cpuc)				\
+	(IS_X86_HYBRID &&						\
+	 ((_cpuc)->hybrid_pmu_idx >= X86_HYBRID_PMU_ATOM_IDX) &&	\
+	 ((_cpuc)->hybrid_pmu_idx < X86_HYBRID_PMU_MAX_INDEX))
+
+#define X86_HYBRID_READ_FROM_CPUC(_name, _cpuc)				\
+	(_cpuc && HAS_VALID_HYBRID_PMU_IN_CPUC(_cpuc) ? x86_pmu.hybrid_pmu[(_cpuc)->hybrid_pmu_idx]._name : x86_pmu._name)
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -816,6 +845,15 @@ struct x86_pmu {
 	int (*check_period) (struct perf_event *event, u64 period);
 
 	int (*aux_output_match) (struct perf_event *event);
+
+	/*
+	 * Hybrid support
+	 *
+	 * Most PMU capabilities are the same among different hybrid PMUs. The
+	 * global x86_pmu saves the architecture capabilities, which are available
+	 * for all PMUs. The hybrid_pmu only includes the unique capabilities.
+	 */
+	struct x86_hybrid_pmu		hybrid_pmu[X86_HYBRID_PMU_MAX_INDEX];
 };
 
 struct x86_perf_task_context_opt {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ec..c6d7247 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -185,6 +185,8 @@
 #define MSR_PEBS_DATA_CFG		0x000003f2
 #define MSR_IA32_DS_AREA		0x00000600
 #define MSR_IA32_PERF_CAPABILITIES	0x00000345
+#define PERF_CAP_METRICS_IDX		15
+#define PERF_CAP_PT_IDX			16
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
 
 #define MSR_IA32_RTIT_CTL		0x00000570
-- 
2.7.4

