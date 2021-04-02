Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303E435244F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhDBARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:22901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236361AbhDBARk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:40 -0400
IronPort-SDR: w24um4/qxV0NnTudU8U45Wl1WZAO5gs68j1EVkFi1T8zwthqX+7y0AlHQZtd3UlRTp5xyKiVW2
 ynJkr5EDA1yQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191837678"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="191837678"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:40 -0700
IronPort-SDR: NAGwN7kvjaKgW4L+zfpRtU86VJQyktTWSy0B07jj8KrsLl4J559OZpXVvHurodmobHLmQo2mDO
 BXhdHUXxKmzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399265"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:38 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 04/25] perf/x86/intel: Hybrid PMU support for perf capabilities
Date:   Thu,  1 Apr 2021 17:10:31 -0700
Message-Id: <1617322252-154215-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
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

Add is_hybrid() to distinguish a hybrid system. ADL may have an
alternative configuration. With that configuration, the
X86_FEATURE_HYBRID_CPU is not set. Perf cannot rely on the feature bit.
The number of hybrid PMUs implies whether it's a hybrid system. The
number will be assigned in the following "Add Alder Lake Hybrid support"
patch as well.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c           |  6 ++++--
 arch/x86/events/intel/core.c     | 27 ++++++++++++++++++++++-----
 arch/x86/events/intel/ds.c       |  2 +-
 arch/x86/events/perf_event.h     | 34 ++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/msr-index.h |  3 +++
 5 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e564e96..d3d3c6b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1105,8 +1105,9 @@ static void del_nr_metric_event(struct cpu_hw_events *cpuc,
 static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
 			 int max_count, int n)
 {
+	union perf_capabilities intel_cap = hybrid(cpuc->pmu, intel_cap);
 
-	if (x86_pmu.intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
+	if (intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
 		return -EINVAL;
 
 	if (n >= max_count + cpuc->n_metric)
@@ -1582,6 +1583,7 @@ void x86_pmu_stop(struct perf_event *event, int flags)
 static void x86_pmu_del(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union perf_capabilities intel_cap = hybrid(cpuc->pmu, intel_cap);
 	int i;
 
 	/*
@@ -1621,7 +1623,7 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	}
 	cpuc->event_constraint[i-1] = NULL;
 	--cpuc->n_events;
-	if (x86_pmu.intel_cap.perf_metrics)
+	if (intel_cap.perf_metrics)
 		del_nr_metric_event(cpuc, event);
 
 	perf_event_update_userpage(event);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f116c63..494b9bc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3646,6 +3646,15 @@ static inline bool is_mem_loads_aux_event(struct perf_event *event)
 	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0x03, .umask=0x82);
 }
 
+static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
+{
+	union perf_capabilities *intel_cap;
+
+	intel_cap = is_hybrid() ? &hybrid_pmu(event->pmu)->intel_cap :
+				  &x86_pmu.intel_cap;
+
+	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
+}
 
 static int intel_pmu_hw_config(struct perf_event *event)
 {
@@ -3712,7 +3721,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	 * with a slots event as group leader. When the slots event
 	 * is used in a metrics group, it too cannot support sampling.
 	 */
-	if (x86_pmu.intel_cap.perf_metrics && is_topdown_event(event)) {
+	if (intel_pmu_has_cap(event, PERF_CAP_METRICS_IDX) && is_topdown_event(event)) {
 		if (event->attr.config1 || event->attr.config2)
 			return -EINVAL;
 
@@ -4219,8 +4228,16 @@ static void intel_pmu_cpu_starting(int cpu)
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
+	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics) {
 		union perf_capabilities perf_cap;
 
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
@@ -4330,7 +4347,7 @@ static int intel_pmu_check_period(struct perf_event *event, u64 value)
 
 static int intel_pmu_aux_output_match(struct perf_event *event)
 {
-	if (!x86_pmu.intel_cap.pebs_output_pt_available)
+	if (!intel_pmu_has_cap(event, PERF_CAP_PT_IDX))
 		return 0;
 
 	return is_intel_pt_event(event);
@@ -5770,7 +5787,7 @@ __init int intel_pmu_init(void)
 		pr_cont("full-width counters, ");
 	}
 
-	if (x86_pmu.intel_cap.perf_metrics)
+	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
 		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
 
 	return 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1bfea8c..9328aa1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2205,7 +2205,7 @@ void __init intel_ds_init(void)
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
 
-			if (x86_pmu.intel_cap.pebs_output_pt_available) {
+			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3e19ca5..df65012d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -632,6 +632,29 @@ enum {
 	x86_lbr_exclusive_max,
 };
 
+struct x86_hybrid_pmu {
+	struct pmu			pmu;
+	union perf_capabilities		intel_cap;
+};
+
+static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
+{
+	return container_of(pmu, struct x86_hybrid_pmu, pmu);
+}
+
+/* The number of hybrid PMUs implies whether it's a hybrid system */
+#define is_hybrid()			(!!x86_pmu.num_hybrid_pmus)
+
+#define hybrid(_pmu, _field)				\
+({							\
+	typeof(x86_pmu._field) __F = x86_pmu._field;	\
+							\
+	if (is_hybrid() && (_pmu))			\
+		__F = hybrid_pmu(_pmu)->_field;		\
+							\
+	__F;						\
+})
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
@@ -818,6 +841,17 @@ struct x86_pmu {
 	int (*check_period) (struct perf_event *event, u64 period);
 
 	int (*aux_output_match) (struct perf_event *event);
+
+	/*
+	 * Hybrid support
+	 *
+	 * Most PMU capabilities are the same among different hybrid PMUs.
+	 * The global x86_pmu saves the architecture capabilities, which
+	 * are available for all PMUs. The hybrid_pmu only includes the
+	 * unique capabilities.
+	 */
+	int				num_hybrid_pmus;
+	struct x86_hybrid_pmu		*hybrid_pmu;
 };
 
 struct x86_perf_task_context_opt {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ec..163f5d2 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -185,6 +185,9 @@
 #define MSR_PEBS_DATA_CFG		0x000003f2
 #define MSR_IA32_DS_AREA		0x00000600
 #define MSR_IA32_PERF_CAPABILITIES	0x00000345
+#define PERF_CAP_METRICS_IDX		15
+#define PERF_CAP_PT_IDX			16
+
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
 
 #define MSR_IA32_RTIT_CTL		0x00000570
-- 
2.7.4

