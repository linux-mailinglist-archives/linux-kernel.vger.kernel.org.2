Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CF935E6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348007AbhDMTFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:05:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:15553 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344040AbhDMTFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:05:10 -0400
IronPort-SDR: oQCbsVV5rprk2+hsn0YD+K19Co+M0uXNjpxxurmXRhJeBhyRzHK8ioDEIme9DEYUlr62u2lsNe
 iwCLcbju+JMA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194593797"
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="194593797"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 12:04:44 -0700
IronPort-SDR: zyT73CzWZ6qJWl1NtEyST3KjUjvE+NCFqz0blSDIiwr0jKNDtPmKzaU/VA7/Rx/p0IHA4yLy1r
 Io4dTJ2MqWwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,220,1613462400"; 
   d="scan'208";a="417975222"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2021 12:04:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, ak@linux.intel.com, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 1/2] perf/x86: Move cpuc->running into P4 specific code
Date:   Tue, 13 Apr 2021 11:57:29 -0700
Message-Id: <1618340250-29027-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The 'running' variable is only used in the P4 PMU. Current perf sets the
variable in the critical function x86_pmu_start(), which wastes cycles
for everybody not running on P4.

Move cpuc->running into the P4 specific p4_pmu_enable_event().

Add a static per-CPU 'p4_running' variable to replace the 'running'
variable in the struct cpu_hw_events. Saves space for the generic
structure.

The p4_pmu_enable_all() also invokes the p4_pmu_enable_event(), but it
should not set cpuc->running. Factor out __p4_pmu_enable_event() for
p4_pmu_enable_all().

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch for V3
- Address the suggestion from Peter.
https://lore.kernel.org/lkml/20200908155840.GC35926@hirez.programming.kicks-ass.net/

 arch/x86/events/core.c       |  1 -
 arch/x86/events/intel/p4.c   | 16 +++++++++++++---
 arch/x86/events/perf_event.h |  1 -
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 18df171..dd9f3c2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1480,7 +1480,6 @@ static void x86_pmu_start(struct perf_event *event, int flags)
 
 	cpuc->events[idx] = event;
 	__set_bit(idx, cpuc->active_mask);
-	__set_bit(idx, cpuc->running);
 	static_call(x86_pmu_enable)(event);
 	perf_event_update_userpage(event);
 }
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index a4cc660..9c10cbb 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -947,7 +947,7 @@ static void p4_pmu_enable_pebs(u64 config)
 	(void)wrmsrl_safe(MSR_P4_PEBS_MATRIX_VERT,	(u64)bind->metric_vert);
 }
 
-static void p4_pmu_enable_event(struct perf_event *event)
+static void __p4_pmu_enable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 	int thread = p4_ht_config_thread(hwc->config);
@@ -983,6 +983,16 @@ static void p4_pmu_enable_event(struct perf_event *event)
 				(cccr & ~P4_CCCR_RESERVED) | P4_CCCR_ENABLE);
 }
 
+static DEFINE_PER_CPU(unsigned long [BITS_TO_LONGS(X86_PMC_IDX_MAX)], p4_running);
+
+static void p4_pmu_enable_event(struct perf_event *event)
+{
+	int idx = event->hw.idx;
+
+	__set_bit(idx, per_cpu(p4_running, smp_processor_id()));
+	__p4_pmu_enable_event(event);
+}
+
 static void p4_pmu_enable_all(int added)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -992,7 +1002,7 @@ static void p4_pmu_enable_all(int added)
 		struct perf_event *event = cpuc->events[idx];
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		p4_pmu_enable_event(event);
+		__p4_pmu_enable_event(event);
 	}
 }
 
@@ -1012,7 +1022,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 
 		if (!test_bit(idx, cpuc->active_mask)) {
 			/* catch in-flight IRQs */
-			if (__test_and_clear_bit(idx, cpuc->running))
+			if (__test_and_clear_bit(idx, per_cpu(p4_running, smp_processor_id())))
 				handled++;
 			continue;
 		}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 53b2b5f..54a340e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -228,7 +228,6 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
-	unsigned long		running[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
-- 
2.7.4

