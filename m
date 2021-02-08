Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F169313C1F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhBHSCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:02:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:62838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231960AbhBHPgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:36:05 -0500
IronPort-SDR: ekyCadWK6fiY8S3KVrtbUR+0lV31qovqIYUxgAa1VuzU9pBdixbScGFIk3L+a1iblOZjRYkqJQ
 Lo2WcmyZL30g==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951918"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951918"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:07 -0800
IronPort-SDR: kn1woTY2iaioexGN7Bm6ksRfPOhUFR2OHxhkEu3uY2eYTSUH20GkfMdIIO/BTo9yeQbaY2746L
 M3zHqNCU18RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820593"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:07 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 09/49] perf/x86: Hybrid PMU support for extra_regs
Date:   Mon,  8 Feb 2021 07:25:06 -0800
Message-Id: <1612797946-18784-10-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
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
index 2160142..6857934 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -148,15 +148,16 @@ u64 x86_perf_event_update(struct perf_event *event)
  */
 static int x86_pmu_extra_regs(u64 config, struct perf_event *event)
 {
+	struct extra_reg *extra_regs = X86_HYBRID_READ_FROM_EVENT(extra_regs, event);
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
index 9acfa82..582d191 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2966,8 +2966,10 @@ intel_vlbr_constraints(struct perf_event *event)
 	return NULL;
 }
 
-static int intel_alt_er(int idx, u64 config)
+static int intel_alt_er(struct cpu_hw_events *cpuc,
+			int idx, u64 config)
 {
+	struct extra_reg *extra_regs = X86_HYBRID_READ_FROM_CPUC(extra_regs, cpuc);
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
+	struct extra_reg *extra_regs = X86_HYBRID_READ_FROM_EVENT(extra_regs, event);
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
@@ -4162,7 +4165,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
 
-	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
+	if (IS_X86_HYBRID || x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
 		cpuc->shared_regs = allocate_shared_regs(cpu);
 		if (!cpuc->shared_regs)
 			goto err;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7a5d036..109139c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -663,6 +663,7 @@ struct x86_hybrid_pmu {
 					[PERF_COUNT_HW_CACHE_RESULT_MAX];
 	struct event_constraint		*event_constraints;
 	struct event_constraint		*pebs_constraints;
+	struct extra_reg		*extra_regs;
 };
 
 #define IS_X86_HYBRID			cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)
-- 
2.7.4

