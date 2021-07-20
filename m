Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BF13CFB27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239115AbhGTNII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:08:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:40456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238928AbhGTNEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:04:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="296798395"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="296798395"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 06:42:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="657540773"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2021 06:42:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 4/6] perf/x86/lbr: Fix shorter LBRs call stacks for the system-wide mode
Date:   Tue, 20 Jul 2021 06:40:18 -0700
Message-Id: <1626788420-121610-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626788420-121610-1-git-send-email-kan.liang@linux.intel.com>
References: <1626788420-121610-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

In the system-wide mode, LBR callstacks are shorter in comparison to
the per-process mode.

LBR MSRs are reset during a context switch in the system-wide mode. For
the LBR call stack, the LBRs should be always saved/restored during a
context switch.

Use the space in task_struct to save/restore the LBR call stack data.

For a system-wide event, it's unnecessagy to update the
lbr_callstack_users for each threads. Add a variable in x86_pmu to
indicate whether the system-wide event is active.

Fixes: 76cb2c617f12 ("perf/x86/intel: Save/restore LBR stack during context switch")
Reported-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Debugged-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

Changes since V3:
- Rebase on top of the 5.13-rc2

 arch/x86/events/intel/lbr.c  | 49 ++++++++++++++++++++++++++++++++++++--------
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index da3a91a..8248ae1 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -502,11 +502,17 @@ static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
 	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos, NULL);
 }
 
+static inline bool has_lbr_callstack_users(void *ctx)
+{
+	return task_context_opt(ctx)->lbr_callstack_users ||
+	       x86_pmu.lbr_callstack_users;
+}
+
 static void __intel_pmu_lbr_restore(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_context_opt(ctx)->lbr_callstack_users == 0 ||
+	if (!has_lbr_callstack_users(ctx) ||
 	    task_context_opt(ctx)->lbr_stack_state == LBR_NONE) {
 		intel_pmu_lbr_reset();
 		return;
@@ -583,7 +589,7 @@ static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_context_opt(ctx)->lbr_callstack_users == 0) {
+	if (!has_lbr_callstack_users(ctx)) {
 		task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 		return;
 	}
@@ -623,6 +629,7 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 			      struct task_struct *task, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_ctx_data *ctx_data;
 	void *task_ctx;
 
 	if (!cpuc->lbr_users)
@@ -633,15 +640,18 @@ void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 	 * the task was scheduled out, restore the stack. Otherwise flush
 	 * the LBR stack.
 	 */
-	task_ctx = ctx ? ctx->task_ctx_data : NULL;
+	rcu_read_lock();
+	ctx_data = rcu_dereference(task->perf_ctx_data);
+	task_ctx = ctx_data ? ctx_data->data : NULL;
 	if (task_ctx) {
 		if (sched_in)
 			__intel_pmu_lbr_restore(task_ctx);
 		else
 			__intel_pmu_lbr_save(task_ctx);
+		rcu_read_unlock();
 		return;
 	}
-
+	rcu_read_unlock();
 	/*
 	 * Since a context switch can flip the address space and LBR entries
 	 * are not tagged with an identifier, we need to wipe the LBR, even for
@@ -670,8 +680,19 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data)
-		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users++;
+	if (branch_user_callstack(cpuc->br_sel)) {
+		if (event->attach_state & PERF_ATTACH_TASK) {
+			struct task_struct *task = event->hw.target;
+			struct perf_ctx_data *ctx_data;
+
+			rcu_read_lock();
+			ctx_data = rcu_dereference(task->perf_ctx_data);
+			if (ctx_data)
+				task_context_opt(ctx_data->data)->lbr_callstack_users++;
+			rcu_read_unlock();
+		} else
+			x86_pmu.lbr_callstack_users++;
+	}
 
 	/*
 	 * Request pmu::sched_task() callback, which will fire inside the
@@ -730,9 +751,19 @@ void intel_pmu_lbr_del(struct perf_event *event)
 	if (!x86_pmu.lbr_nr)
 		return;
 
-	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->ctx->task_ctx_data)
-		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users--;
+	if (branch_user_callstack(cpuc->br_sel)) {
+		if (event->attach_state & PERF_ATTACH_TASK) {
+			struct task_struct *task = event->hw.target;
+			struct perf_ctx_data *ctx_data;
+
+			rcu_read_lock();
+			ctx_data = rcu_dereference(task->perf_ctx_data);
+			if (ctx_data)
+				task_context_opt(ctx_data->data)->lbr_callstack_users--;
+			rcu_read_unlock();
+		} else
+			x86_pmu.lbr_callstack_users--;
+	}
 
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8489f50..583c08d38 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -820,6 +820,7 @@ struct x86_pmu {
 		const int	*lbr_sel_map;	   /* lbr_select mappings */
 		int		*lbr_ctl_map;	   /* LBR_CTL mappings */
 	};
+	u64		lbr_callstack_users;	   /* lbr callstack system wide users */
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
-- 
2.7.4

