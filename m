Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8B313C25
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhBHSDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:03:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:62811 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233972AbhBHPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:35:32 -0500
IronPort-SDR: qFYWj7bys3rRnb6Bhgp146wVh1CCudxin5+P4vF9TrXM98Ir0dt1r55mKbK1dPB+F/icMQK7eX
 quMeZ5lofPJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951915"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951915"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:06 -0800
IronPort-SDR: QA4ll6lGF5GRbV7RMimhUxD0tRYVdoJM5djjgL0Eug4bnS0fPk+5cmzAiQAA3K9yKgzpigHMrE
 BYy+fri3Ckng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820575"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:06 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/49] perf/x86: Hybrid PMU support for event constraints
Date:   Mon,  8 Feb 2021 07:25:05 -0800
Message-Id: <1612797946-18784-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The events are different among hybrid PMUs. Each hybrid PMU should use
its own event constraints.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 3 ++-
 arch/x86/events/intel/core.c | 5 +++--
 arch/x86/events/intel/ds.c   | 5 +++--
 arch/x86/events/perf_event.h | 5 +++++
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 27c87a7..2160142 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1514,6 +1514,7 @@ void perf_event_print_debug(void)
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int num_counters = X86_HYBRID_READ_FROM_CPUC(num_counters, cpuc);
 	int num_counters_fixed = X86_HYBRID_READ_FROM_CPUC(num_counters_fixed, cpuc);
+	struct event_constraint *pebs_constraints = X86_HYBRID_READ_FROM_CPUC(pebs_constraints, cpuc);
 	unsigned long flags;
 	int idx;
 
@@ -1533,7 +1534,7 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
 		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
-		if (x86_pmu.pebs_constraints) {
+		if (pebs_constraints) {
 			rdmsrl(MSR_IA32_PEBS_ENABLE, pebs);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9baa6b6..9acfa82 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3136,10 +3136,11 @@ struct event_constraint *
 x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
+	struct event_constraint *event_constraints = X86_HYBRID_READ_FROM_CPUC(event_constraints, cpuc);
 	struct event_constraint *c;
 
-	if (x86_pmu.event_constraints) {
-		for_each_event_constraint(c, x86_pmu.event_constraints) {
+	if (event_constraints) {
+		for_each_event_constraint(c, event_constraints) {
 			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a528966..ba651d9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -959,13 +959,14 @@ struct event_constraint intel_spr_pebs_event_constraints[] = {
 
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
+	struct event_constraint *pebs_constraints = X86_HYBRID_READ_FROM_EVENT(pebs_constraints, event);
 	struct event_constraint *c;
 
 	if (!event->attr.precise_ip)
 		return NULL;
 
-	if (x86_pmu.pebs_constraints) {
-		for_each_event_constraint(c, x86_pmu.pebs_constraints) {
+	if (pebs_constraints) {
+		for_each_event_constraint(c, pebs_constraints) {
 			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 00fcd92..7a5d036 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -661,6 +661,8 @@ struct x86_hybrid_pmu {
 					[PERF_COUNT_HW_CACHE_MAX]
 					[PERF_COUNT_HW_CACHE_OP_MAX]
 					[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	struct event_constraint		*event_constraints;
+	struct event_constraint		*pebs_constraints;
 };
 
 #define IS_X86_HYBRID			cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)
@@ -673,6 +675,9 @@ struct x86_hybrid_pmu {
 #define X86_HYBRID_READ_FROM_CPUC(_name, _cpuc)				\
 	(_cpuc && HAS_VALID_HYBRID_PMU_IN_CPUC(_cpuc) ? x86_pmu.hybrid_pmu[(_cpuc)->hybrid_pmu_idx]._name : x86_pmu._name)
 
+#define X86_HYBRID_READ_FROM_EVENT(_name, _event)			\
+	(IS_X86_HYBRID ? ((struct x86_hybrid_pmu *)(_event->pmu))->_name : x86_pmu._name)
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
-- 
2.7.4

