Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD62C34AEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhCZTJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:09:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:27820 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230170AbhCZTI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:08:58 -0400
IronPort-SDR: Gh9bBCui8mHRpoy3TFqrGQVhGghx48Vf6x6fj6TZaABDH4qRFaq1wlu5Tzq94LcBw2lkWB4MOY
 JgUHUIF8Nvkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191234788"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191234788"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:08:58 -0700
IronPort-SDR: /AOOQnHUMxmQ0ZUAqvrN8yZ6wC/RNddmOR8VMUXD2ajZHIS3k3OZdDViK6/BdhN2fJwDhfz8jR
 8eldeXbbDQIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="392321090"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2021 12:08:58 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 09/25] perf/x86: Hybrid PMU support for event constraints
Date:   Fri, 26 Mar 2021 12:01:56 -0700
Message-Id: <1616785332-165261-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
References: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
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
 arch/x86/events/perf_event.h | 2 ++
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d71ca69..b866867 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1526,6 +1526,7 @@ void perf_event_print_debug(void)
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
 	int num_counters = hybrid(cpuc->pmu, num_counters);
 	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
+	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
 	unsigned long flags;
 	int idx;
 
@@ -1545,7 +1546,7 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: status:     %016llx\n", cpu, status);
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
 		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
-		if (x86_pmu.pebs_constraints) {
+		if (pebs_constraints) {
 			rdmsrl(MSR_IA32_PEBS_ENABLE, pebs);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
 		}
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 39f57ae..d304ba3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3136,10 +3136,11 @@ struct event_constraint *
 x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 			  struct perf_event *event)
 {
+	struct event_constraint *event_constraints = hybrid(cpuc->pmu, event_constraints);
 	struct event_constraint *c;
 
-	if (x86_pmu.event_constraints) {
-		for_each_event_constraint(c, x86_pmu.event_constraints) {
+	if (event_constraints) {
+		for_each_event_constraint(c, event_constraints) {
 			if (constraint_match(c, event->hw.config)) {
 				event->hw.flags |= c->flags;
 				return c;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 312bf3b..f1402bc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -959,13 +959,14 @@ struct event_constraint intel_spr_pebs_event_constraints[] = {
 
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
+	struct event_constraint *pebs_constraints = hybrid(event->pmu, pebs_constraints);
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
index c9974d0..53e8a0f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -649,6 +649,8 @@ struct x86_hybrid_pmu {
 					[PERF_COUNT_HW_CACHE_MAX]
 					[PERF_COUNT_HW_CACHE_OP_MAX]
 					[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	struct event_constraint		*event_constraints;
+	struct event_constraint		*pebs_constraints;
 };
 
 static __always_inline bool is_hybrid(void)
-- 
2.7.4

