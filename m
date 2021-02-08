Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48DC313CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhBHSO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:14:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:62780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhBHPmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:42:44 -0500
IronPort-SDR: rqoP8N/QHZ/3AfZcavYVF0JCVUNR/0484m21kxKPdHkFgaLRzfyD/GAMEVTCzR8ir/whEic0sG
 Xrwnqd1NQzlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951984"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:23 -0800
IronPort-SDR: XW4OH+xQP79CQH0St0IIvEwjiiUqFWbN15QCv4PgaQKv7TlM4fUt6HvJenkZfCH9Ffbpc7l8Ns
 t+c3jEPLBSFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820747"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:23 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 20/49] perf/x86/intel: Add Alder Lake Hybrid support
Date:   Mon,  8 Feb 2021 07:25:17 -0800
Message-Id: <1612797946-18784-21-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Alder Lake Hybrid system has two different types of core, Golden Cove
core and Gracemont core. The Golden Cove core is registered to
"cpu_core" PMU. The Gracemont core is registered to "cpu_atom" PMU.

The difference between the two PMUs include:
- Number of GP and fixed counters
- Events
- The "cpu_core" PMU supports Topdown metrics.
  The "cpu_atom" PMU supports PEBS-via-PT.

The "cpu_core" PMU is similar to the Sapphire Rapids PMU, but without
PMEM.
The "cpu_atom" PMU is similar to Tremont, but with different
event_constraints, extra_regs and number of counters.

Users may disable all CPUs of the same CPU type on the command line or
in the BIOS. For this case, perf still initializes a PMU for the CPU
type, but will not register the PMU. The PMU will only be registered
when any corresponding CPU is online.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 227 +++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   |   7 ++
 arch/x86/events/perf_event.h |   2 +
 3 files changed, 236 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ea2541b..fcbf72f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2076,6 +2076,14 @@ static struct extra_reg intel_tnt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
+	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
+	EVENT_EXTRA_END
+};
+
 #define KNL_OT_L2_HITE		BIT_ULL(19) /* Other Tile L2 Hit */
 #define KNL_OT_L2_HITF		BIT_ULL(20) /* Other Tile L2 Hit */
 #define KNL_MCDRAM_LOCAL	BIT_ULL(21)
@@ -2430,6 +2438,16 @@ static int icl_set_topdown_event_period(struct perf_event *event)
 	return 0;
 }
 
+static int adl_set_topdown_event_period(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
+
+	if (pmu->cpu_type != X86_HYBRID_CORE_CPU_TYPE)
+		return 0;
+
+	return icl_set_topdown_event_period(event);
+}
+
 static inline u64 icl_get_metrics_event_value(u64 metric, u64 slots, int idx)
 {
 	u32 val;
@@ -2570,6 +2588,17 @@ static u64 icl_update_topdown_event(struct perf_event *event)
 						 x86_pmu.num_topdown_events - 1);
 }
 
+static u64 adl_update_topdown_event(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
+
+	if (pmu->cpu_type != X86_HYBRID_CORE_CPU_TYPE)
+		return 0;
+
+	return icl_update_topdown_event(event);
+}
+
+
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -4063,6 +4092,32 @@ tfa_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 	return c;
 }
 
+static struct event_constraint *
+adl_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
+			  struct perf_event *event)
+{
+	if (cpuc->hybrid_pmu_idx == X86_HYBRID_PMU_CORE_IDX)
+		return spr_get_event_constraints(cpuc, idx, event);
+	else if (cpuc->hybrid_pmu_idx == X86_HYBRID_PMU_ATOM_IDX)
+		return tnt_get_event_constraints(cpuc, idx, event);
+
+	WARN_ON(1);
+	return &emptyconstraint;
+}
+
+static int adl_hw_config(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
+
+	if (pmu->cpu_type == X86_HYBRID_CORE_CPU_TYPE)
+		return hsw_hw_config(event);
+	else if (pmu->cpu_type == X86_HYBRID_ATOM_CPU_TYPE)
+		return intel_pmu_hw_config(event);
+
+	WARN_ON(1);
+	return -EOPNOTSUPP;
+}
+
 /*
  * Broadwell:
  *
@@ -4555,6 +4610,14 @@ static int intel_pmu_aux_output_match(struct perf_event *event)
 	return is_intel_pt_event(event);
 }
 
+static int intel_pmu_filter_match(struct perf_event *event)
+{
+	struct x86_hybrid_pmu *pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
+	unsigned int cpu = smp_processor_id();
+
+	return cpumask_test_cpu(cpu, &pmu->supported_cpus);
+}
+
 PMU_FORMAT_ATTR(offcore_rsp, "config1:0-63");
 
 PMU_FORMAT_ATTR(ldlat, "config1:0-15");
@@ -5254,6 +5317,84 @@ static const struct attribute_group *attr_update[] = {
 	NULL,
 };
 
+EVENT_ATTR_STR_HYBRID(slots,			slots_hybrid,			"event=0x00,umask=0x4", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-retiring,		td_retiring_hybrid,		"event=0xc2,umask=0x0;event=0x00,umask=0x80", X86_HYBRID_ATOM_CPU_TYPE | X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-bad-spec,		td_bad_spec_hybrid,		"event=0x73,umask=0x0;event=0x00,umask=0x81", X86_HYBRID_ATOM_CPU_TYPE | X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-fe-bound,		td_fe_bound_hybrid,		"event=0x71,umask=0x0;event=0x00,umask=0x82", X86_HYBRID_ATOM_CPU_TYPE | X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-be-bound,		td_be_bound_hybrid,		"event=0x74,umask=0x0;event=0x00,umask=0x83", X86_HYBRID_ATOM_CPU_TYPE | X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-heavy-ops,	td_heavy_ops_hybrid,		"event=0x00,umask=0x84", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-br-mispredict,	td_br_mispredict_hybrid,	"event=0x00,umask=0x85", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-fetch-lat,	td_fetch_lat_hybrid,		"event=0x00,umask=0x86", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(topdown-mem-bound,	td_mem_bound_hybrid,		"event=0x00,umask=0x87", X86_HYBRID_CORE_CPU_TYPE);
+
+static struct attribute *adl_hybrid_events_attrs[] = {
+	EVENT_PTR(slots_hybrid),
+	EVENT_PTR(td_retiring_hybrid),
+	EVENT_PTR(td_bad_spec_hybrid),
+	EVENT_PTR(td_fe_bound_hybrid),
+	EVENT_PTR(td_be_bound_hybrid),
+	EVENT_PTR(td_heavy_ops_hybrid),
+	EVENT_PTR(td_br_mispredict_hybrid),
+	EVENT_PTR(td_fetch_lat_hybrid),
+	EVENT_PTR(td_mem_bound_hybrid),
+	NULL,
+};
+
+/* Must be in IDX order */
+EVENT_ATTR_STR_HYBRID(mem-loads, mem_ld_adl_hybrid, "event=0xd0,umask=0x5,ldlat=3;event=0xcd,umask=0x1,ldlat=3", X86_HYBRID_ATOM_CPU_TYPE | X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(mem-stores, mem_st_adl_hybrid, "event=0xd0,umask=0x6;event=0xcd,umask=0x2", X86_HYBRID_ATOM_CPU_TYPE | X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(mem-loads-aux, mem_ld_aux_hybrid, "event=0x03,umask=0x82", X86_HYBRID_CORE_CPU_TYPE);
+
+static struct attribute *adl_hybrid_mem_attrs[] = {
+	EVENT_PTR(mem_ld_adl_hybrid),
+	EVENT_PTR(mem_st_adl_hybrid),
+	EVENT_PTR(mem_ld_aux_hybrid),
+	NULL,
+};
+
+EVENT_ATTR_STR_HYBRID(tx-start, tx_start_adl_hybrid, "event=0xc9,umask=0x1", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(tx-commit, tx_commit_adl_hybrid, "event=0xc9,umask=0x2", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(tx-abort, tx_abort_adl_hybrid, "event=0xc9,umask=0x4", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(tx-conflict, tx_conflict_adl_hybrid, "event=0x54,umask=0x1", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(cycles-t, cycles_t_adl_hybrid, "event=0x3c,in_tx=1", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(cycles-ct, cycles_ct_adl_hybrid, "event=0x3c,in_tx=1,in_tx_cp=1", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(tx-capacity-read, tx_capacity_read_adl_hybrid, "event=0x54,umask=0x80", X86_HYBRID_CORE_CPU_TYPE);
+EVENT_ATTR_STR_HYBRID(tx-capacity-write, tx_capacity_write_adl_hybrid, "event=0x54,umask=0x2", X86_HYBRID_CORE_CPU_TYPE);
+
+static struct attribute *adl_hybrid_tsx_attrs[] = {
+	EVENT_PTR(tx_start_adl_hybrid),
+	EVENT_PTR(tx_abort_adl_hybrid),
+	EVENT_PTR(tx_commit_adl_hybrid),
+	EVENT_PTR(tx_capacity_read_adl_hybrid),
+	EVENT_PTR(tx_capacity_write_adl_hybrid),
+	EVENT_PTR(tx_conflict_adl_hybrid),
+	EVENT_PTR(cycles_t_adl_hybrid),
+	EVENT_PTR(cycles_ct_adl_hybrid),
+	NULL,
+};
+
+FORMAT_ATTR_HYBRID(in_tx, X86_HYBRID_CORE_CPU_TYPE);
+FORMAT_ATTR_HYBRID(in_tx_cp, X86_HYBRID_CORE_CPU_TYPE);
+FORMAT_ATTR_HYBRID(offcore_rsp, X86_HYBRID_CORE_CPU_TYPE | X86_HYBRID_ATOM_CPU_TYPE);
+FORMAT_ATTR_HYBRID(ldlat, X86_HYBRID_CORE_CPU_TYPE | X86_HYBRID_ATOM_CPU_TYPE);
+FORMAT_ATTR_HYBRID(frontend, X86_HYBRID_CORE_CPU_TYPE);
+
+static struct attribute *adl_hybrid_extra_attr_rtm[] = {
+	FORMAT_HYBRID_PTR(in_tx),
+	FORMAT_HYBRID_PTR(in_tx_cp),
+	FORMAT_HYBRID_PTR(offcore_rsp),
+	FORMAT_HYBRID_PTR(ldlat),
+	FORMAT_HYBRID_PTR(frontend),
+	NULL,
+};
+
+static struct attribute *adl_hybrid_extra_attr[] = {
+	FORMAT_HYBRID_PTR(offcore_rsp),
+	FORMAT_HYBRID_PTR(ldlat),
+	FORMAT_HYBRID_PTR(frontend),
+	NULL,
+};
+
 static bool is_attr_for_this_pmu(struct kobject *kobj, struct attribute *attr)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -5370,6 +5511,7 @@ __init int intel_pmu_init(void)
 	bool pmem = false;
 	int version, i;
 	char *name;
+	struct x86_hybrid_pmu *pmu;
 
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
 		switch (boot_cpu_data.x86) {
@@ -5964,6 +6106,91 @@ __init int intel_pmu_init(void)
 		name = "sapphire_rapids";
 		break;
 
+	case INTEL_FAM6_ALDERLAKE:
+	case INTEL_FAM6_ALDERLAKE_L:
+		/*
+		 * Alder Lake has 2 types of CPU, core and atom.
+		 *
+		 * Initialize the common PerfMon capabilities here.
+		 */
+		x86_pmu.late_ack = true;
+		x86_pmu.pebs_aliases = NULL;
+		x86_pmu.pebs_prec_dist = true;
+		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
+		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
+		x86_pmu.flags |= PMU_FL_PEBS_ALL;
+		x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
+		x86_pmu.flags |= PMU_FL_MEM_LOADS_AUX;
+		x86_pmu.lbr_pt_coexist = true;
+		intel_pmu_pebs_data_source_skl(false);
+		x86_pmu.num_topdown_events = 8;
+		x86_pmu.update_topdown_event = adl_update_topdown_event;
+		x86_pmu.set_topdown_event_period = adl_set_topdown_event_period;
+
+		x86_pmu.filter_match = intel_pmu_filter_match;
+		x86_pmu.get_event_constraints = adl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+		x86_pmu.limit_period = spr_limit_period;
+		/*
+		 * The rtm_abort_event is used to check whether to enable GPRs
+		 * for the RTM abort event. Atom doesn't have the RTM abort
+		 * event. There is no harmful to set it in the common
+		 * x86_pmu.rtm_abort_event.
+		 */
+		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xc9, .umask=0x04);
+
+		td_attr = adl_hybrid_events_attrs;
+		mem_attr = adl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			adl_hybrid_extra_attr_rtm : adl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		set_bit(X86_HYBRID_PMU_CORE_IDX, &x86_pmu.hybrid_pmu_bitmap);
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		pmu->name = "cpu_core";
+		pmu->cpu_type = X86_HYBRID_CORE_CPU_TYPE;
+		pmu->num_counters = x86_pmu.num_counters + 2;
+		pmu->num_counters_fixed = x86_pmu.num_counters_fixed + 1;
+		pmu->max_pebs_events = min_t(unsigned, MAX_PEBS_EVENTS, pmu->num_counters);
+		pmu->unconstrained = (struct event_constraint)
+					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+							   0, pmu->num_counters, 0, 0);
+		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
+		pmu->intel_cap.perf_metrics = 1;
+		pmu->intel_cap.pebs_output_pt_available = 0;
+
+		memcpy(pmu->hw_cache_event_ids, spr_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
+		memcpy(pmu->hw_cache_extra_regs, spr_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
+		pmu->event_constraints = intel_spr_event_constraints;
+		pmu->pebs_constraints = intel_spr_pebs_event_constraints;
+		pmu->extra_regs = intel_spr_extra_regs;
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		set_bit(X86_HYBRID_PMU_ATOM_IDX, &x86_pmu.hybrid_pmu_bitmap);
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		pmu->name = "cpu_atom";
+		pmu->cpu_type = X86_HYBRID_ATOM_CPU_TYPE;
+		pmu->num_counters = x86_pmu.num_counters;
+		pmu->num_counters_fixed = x86_pmu.num_counters_fixed;
+		pmu->max_pebs_events = x86_pmu.max_pebs_events;
+		pmu->unconstrained = (struct event_constraint)
+					__EVENT_CONSTRAINT(0, (1ULL << pmu->num_counters) - 1,
+							   0, pmu->num_counters, 0, 0);
+		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
+		pmu->intel_cap.perf_metrics = 0;
+		pmu->intel_cap.pebs_output_pt_available = 1;
+
+		memcpy(pmu->hw_cache_event_ids, glp_hw_cache_event_ids, sizeof(pmu->hw_cache_event_ids));
+		memcpy(pmu->hw_cache_extra_regs, tnt_hw_cache_extra_regs, sizeof(pmu->hw_cache_extra_regs));
+		pmu->hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
+		pmu->event_constraints = intel_slm_event_constraints;
+		pmu->pebs_constraints = intel_grt_pebs_event_constraints;
+		pmu->extra_regs = intel_grt_extra_regs;
+		pr_cont("Alderlake Hybrid events, ");
+		name = "alderlake_hybrid";
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba651d9..1783fcf 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -779,6 +779,13 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_grt_pebs_event_constraints[] = {
+	/* Allow all events as PEBS with no flags */
+	INTEL_PLD_CONSTRAINT(0x5d0, 0xf),
+	INTEL_PSD_CONSTRAINT(0x6d0, 0xf),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5759f96..de193e6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1265,6 +1265,8 @@ extern struct event_constraint intel_glm_pebs_event_constraints[];
 
 extern struct event_constraint intel_glp_pebs_event_constraints[];
 
+extern struct event_constraint intel_grt_pebs_event_constraints[];
+
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
 
 extern struct event_constraint intel_westmere_pebs_event_constraints[];
-- 
2.7.4

