Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3B35F667
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351857AbhDNOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:45:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:53050 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhDNOou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:44:50 -0400
IronPort-SDR: euMvV4k8glNU2pVxGDFGrFmuGmYj4ZXrdgwQ36/kfN77z9CxozKE/NA3TjMIBsLCgY7r6KgTXW
 adtRKEdg4Kcw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="181775085"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="181775085"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 07:44:21 -0700
IronPort-SDR: CEeTghF2VvxGwUmw8Emx4l5Tdj98ytTVgkpT9jzTwNtl+9Vt02yoX0vhxPE5hvDz/lrP+e4kX8
 geKMbr7Ja7mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="452478785"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2021 07:44:20 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, ak@linux.intel.com, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 1/2] perf/x86: Move cpuc->running into P4 specific code
Date:   Wed, 14 Apr 2021 07:36:29 -0700
Message-Id: <1618410990-21383-1-git-send-email-kan.liang@linux.intel.com>
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
No changes since V3

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

