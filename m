Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D482389269
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354665AbhESPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:21:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:9762 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354566AbhESPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:21:14 -0400
IronPort-SDR: YvvJXyI0raET7g0e03x1K3xPxNVkzfXMl01xvMCefQZ9cAPOkQ4s+k2QEsoFT8bCam/bqplsd8
 bnyHaz9hjlFQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264916857"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264916857"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:19:51 -0700
IronPort-SDR: 0tdTUQWBN6EsE+fvyj9opAXKDn6eo9dxFpFvoSqoV7RX3uBQ0xRPyxc47qKXPYI3UK+s20K6dd
 yVz6sI1xM3lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411775935"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 08:19:51 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, vitaly.slobodskoy@intel.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 3/6] perf: Supply task information to sched_task()
Date:   Wed, 19 May 2021 08:06:03 -0700
Message-Id: <1621436766-112801-3-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
References: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To save/restore LBR call stack data in system-wide mode, the task_struct
information is required.

Extend the parameters of sched_task() to supply task_struct information.

When schedule in, the LBR call stack data for new task will be restored.
When schedule out, the LBR call stack data for old task will be saved.
Only need to pass the required task_struct information.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Rebase on top of the 5.13-rc2

 arch/powerpc/perf/core-book3s.c |  8 ++++++--
 arch/x86/events/core.c          |  5 +++--
 arch/x86/events/intel/core.c    |  4 ++--
 arch/x86/events/intel/lbr.c     |  3 ++-
 arch/x86/events/perf_event.h    |  5 +++--
 include/linux/perf_event.h      |  2 +-
 kernel/events/core.c            | 15 ++++++++-------
 7 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 16d4d1b..5c2cc4c 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -131,7 +131,10 @@ static unsigned long ebb_switch_in(bool ebb, struct cpu_hw_events *cpuhw)
 
 static inline void power_pmu_bhrb_enable(struct perf_event *event) {}
 static inline void power_pmu_bhrb_disable(struct perf_event *event) {}
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in) {}
+static void power_pmu_sched_task(struct perf_event_context *ctx,
+				 struct task_struct *task, bool sched_in)
+{
+}
 static inline void power_pmu_bhrb_read(struct perf_event *event, struct cpu_hw_events *cpuhw) {}
 static void pmao_restore_workaround(bool ebb) { }
 #endif /* CONFIG_PPC32 */
@@ -441,7 +444,8 @@ static void power_pmu_bhrb_disable(struct perf_event *event)
 /* Called from ctxsw to prevent one process's branch entries to
  * mingle with the other process's entries during context switch.
  */
-static void power_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void power_pmu_sched_task(struct perf_event_context *ctx,
+				 struct task_struct *task, bool sched_in)
 {
 	if (!ppmu->bhrb_nr)
 		return;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f71dd7..8368cc7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2603,9 +2603,10 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 	NULL,
 };
 
-static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
+static void x86_pmu_sched_task(struct perf_event_context *ctx,
+			       struct task_struct *task, bool sched_in)
 {
-	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+	static_call_cond(x86_pmu_sched_task)(ctx, task, sched_in);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e288922..b7fc7c9 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4467,10 +4467,10 @@ static void intel_pmu_cpu_dead(int cpu)
 }
 
 static void intel_pmu_sched_task(struct perf_event_context *ctx,
-				 bool sched_in)
+				 struct task_struct *task, bool sched_in)
 {
 	intel_pmu_pebs_sched_task(ctx, sched_in);
-	intel_pmu_lbr_sched_task(ctx, sched_in);
+	intel_pmu_lbr_sched_task(ctx, task, sched_in);
 }
 
 static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4409d2c..7914f40 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -619,7 +619,8 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
+void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
+			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	void *task_ctx;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ad87cb3..29f8df7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -777,7 +777,7 @@ struct x86_pmu {
 
 	void		(*check_microcode)(void);
 	void		(*sched_task)(struct perf_event_context *ctx,
-				      bool sched_in);
+				      struct task_struct *task, bool sched_in);
 
 	/*
 	 * Intel Arch Perfmon v2+
@@ -1310,7 +1310,8 @@ void intel_ds_init(void);
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 				 struct perf_event_context *next);
 
-void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in);
+void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
+			      struct task_struct *task, bool sched_in);
 
 u64 lbr_from_signext_quirk_wr(u64 val);
 
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d46b7e1..0085b97 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -428,7 +428,7 @@ struct pmu {
 	 * context-switches callback
 	 */
 	void (*sched_task)		(struct perf_event_context *ctx,
-					bool sched_in);
+					 struct task_struct *task, bool sched_in);
 
 	/*
 	 * Kmem cache of PMU specific data
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bb1b27e..a83284b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3483,7 +3483,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 			perf_pmu_disable(pmu);
 
 			if (cpuctx->sched_cb_usage && pmu->sched_task)
-				pmu->sched_task(ctx, false);
+				pmu->sched_task(ctx, task, false);
 
 			/*
 			 * PMU specific parts of task perf context can require
@@ -3523,7 +3523,7 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		perf_pmu_disable(pmu);
 
 		if (cpuctx->sched_cb_usage && pmu->sched_task)
-			pmu->sched_task(ctx, false);
+			pmu->sched_task(ctx, task, false);
 		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
 
 		perf_pmu_enable(pmu);
@@ -3562,7 +3562,8 @@ void perf_sched_cb_inc(struct pmu *pmu)
  * PEBS requires this to provide PID/TID information. This requires we flush
  * all queued PEBS records before we context switch to a new task.
  */
-static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in)
+static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx,
+				  struct task_struct *task, bool sched_in)
 {
 	struct pmu *pmu;
 
@@ -3574,7 +3575,7 @@ static void __perf_pmu_sched_task(struct perf_cpu_context *cpuctx, bool sched_in
 	perf_ctx_lock(cpuctx, cpuctx->task_ctx);
 	perf_pmu_disable(pmu);
 
-	pmu->sched_task(cpuctx->task_ctx, sched_in);
+	pmu->sched_task(cpuctx->task_ctx, task, sched_in);
 
 	perf_pmu_enable(pmu);
 	perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
@@ -3594,7 +3595,7 @@ static void perf_pmu_sched_task(struct task_struct *prev,
 		if (cpuctx->task_ctx)
 			continue;
 
-		__perf_pmu_sched_task(cpuctx, sched_in);
+		__perf_pmu_sched_task(cpuctx, sched_in ? next : prev, sched_in);
 	}
 }
 
@@ -3860,7 +3861,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	cpuctx = __get_cpu_context(ctx);
 	if (cpuctx->task_ctx == ctx) {
 		if (cpuctx->sched_cb_usage)
-			__perf_pmu_sched_task(cpuctx, true);
+			__perf_pmu_sched_task(cpuctx, task, true);
 		return;
 	}
 
@@ -3886,7 +3887,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 	perf_event_sched_in(cpuctx, ctx, task);
 
 	if (cpuctx->sched_cb_usage && pmu->sched_task)
-		pmu->sched_task(cpuctx->task_ctx, true);
+		pmu->sched_task(cpuctx->task_ctx, task, true);
 
 	perf_pmu_enable(pmu);
 
-- 
2.7.4

