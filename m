Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C02F35C8F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242489AbhDLOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:39:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:29202 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242387AbhDLOim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:38:42 -0400
IronPort-SDR: WtEAdesCg7tDt4bqf2VaDWYBLV35CKtr8DIBSlAwRHtLopAmB4sSl+2/mvIc0KHUFu0paYagsL
 7SzWrVCumHJw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194317967"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194317967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:38:24 -0700
IronPort-SDR: bmu3oF8Cu4+5oplXxLCPPOnq0R55omxBWR0oog9h/40Gc+1VePbsCAGsnZagasZBFTN3QTwXsj
 RqQqjx+R/xsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398392787"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 07:38:24 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 10/25] perf/x86: Hybrid PMU support for extra_regs
Date:   Mon, 12 Apr 2021 07:30:50 -0700
Message-Id: <1618237865-33448-11-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Different hybrid PMU may have different extra registers, e.g. Core PMU
may have offcore registers, frontend register and ldlat register. Atom
core may only have offcore registers and ldlat register. Each hybrid PMU
should use its own extra_regs.

An Intel Hybrid system should always have extra registers.
Unconditionally allocate shared_regs for Intel Hybrid system.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       |  5 +++--
 arch/x86/events/intel/core.c | 15 +++++++++------
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f3e6fb0..4dcf0de 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -154,15 +154,16 @@ u64 x86_perf_event_update(struct perf_event *event)
  */
 static int x86_pmu_extra_regs(u64 config, struct perf_event *event)
 {
+	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
 	struct hw_perf_event_extra *reg;
 	struct extra_reg *er;
 
 	reg = &event->hw.extra_reg;
 
-	if (!x86_pmu.extra_regs)
+	if (!extra_regs)
 		return 0;
 
-	for (er = x86_pmu.extra_regs; er->msr; er++) {
+	for (er = extra_regs; er->msr; er++) {
 		if (er->event != (config & er->config_mask))
 			continue;
 		if (event->attr.config1 & ~er->valid_mask)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 447a80f..f727aa5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2966,8 +2966,10 @@ intel_vlbr_constraints(struct perf_event *event)
 	return NULL;
 }
 
-static int intel_alt_er(int idx, u64 config)
+static int intel_alt_er(struct cpu_hw_events *cpuc,
+			int idx, u64 config)
 {
+	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
 	int alt_idx = idx;
 
 	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
@@ -2979,7 +2981,7 @@ static int intel_alt_er(int idx, u64 config)
 	if (idx == EXTRA_REG_RSP_1)
 		alt_idx = EXTRA_REG_RSP_0;
 
-	if (config & ~x86_pmu.extra_regs[alt_idx].valid_mask)
+	if (config & ~extra_regs[alt_idx].valid_mask)
 		return idx;
 
 	return alt_idx;
@@ -2987,15 +2989,16 @@ static int intel_alt_er(int idx, u64 config)
 
 static void intel_fixup_er(struct perf_event *event, int idx)
 {
+	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
 	event->hw.extra_reg.idx = idx;
 
 	if (idx == EXTRA_REG_RSP_0) {
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |= x86_pmu.extra_regs[EXTRA_REG_RSP_0].event;
+		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
 	} else if (idx == EXTRA_REG_RSP_1) {
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |= x86_pmu.extra_regs[EXTRA_REG_RSP_1].event;
+		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
 	}
 }
@@ -3071,7 +3074,7 @@ __intel_shared_reg_get_constraints(struct cpu_hw_events *cpuc,
 		 */
 		c = NULL;
 	} else {
-		idx = intel_alt_er(idx, reg->config);
+		idx = intel_alt_er(cpuc, idx, reg->config);
 		if (idx != reg->idx) {
 			raw_spin_unlock_irqrestore(&era->lock, flags);
 			goto again;
@@ -4155,7 +4158,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
 
-	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
+	if (is_hybrid() || x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
 		cpuc->shared_regs = allocate_shared_regs(cpu);
 		if (!cpuc->shared_regs)
 			goto err;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a38c5b6..f04be6b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -651,6 +651,7 @@ struct x86_hybrid_pmu {
 					[PERF_COUNT_HW_CACHE_RESULT_MAX];
 	struct event_constraint		*event_constraints;
 	struct event_constraint		*pebs_constraints;
+	struct extra_reg		*extra_regs;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
-- 
2.7.4

