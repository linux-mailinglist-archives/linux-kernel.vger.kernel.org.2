Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452433CFB30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 15:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhGTNJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 09:09:00 -0400
Received: from mga05.intel.com ([192.55.52.43]:40460 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238933AbhGTNEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 09:04:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="296798398"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="296798398"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 06:42:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="657540777"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga006.fm.intel.com with ESMTP; 20 Jul 2021 06:42:18 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 6/6] perf: Clean up pmu specific data
Date:   Tue, 20 Jul 2021 06:40:20 -0700
Message-Id: <1626788420-121610-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626788420-121610-1-git-send-email-kan.liang@linux.intel.com>
References: <1626788420-121610-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pmu specific data is saved in task_struct now. Remove it from event
context structure.

Remove swap_task_ctx() as well.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

Changes since V3:
- Rebase on top of the 5.13-rc2

 include/linux/perf_event.h | 11 --------
 kernel/events/core.c       | 64 ++--------------------------------------------
 2 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e90de20..6e96839 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -436,16 +436,6 @@ struct pmu {
 	struct kmem_cache		*task_ctx_cache;
 
 	/*
-	 * PMU specific parts of task perf event context (i.e. ctx->task_ctx_data)
-	 * can be synchronized using this function. See Intel LBR callstack support
-	 * implementation and Perf core context switch handling callbacks for usage
-	 * examples.
-	 */
-	void (*swap_task_ctx)		(struct perf_event_context *prev,
-					 struct perf_event_context *next);
-					/* optional */
-
-	/*
 	 * Set up pmu-private data structures for an AUX area
 	 */
 	void *(*setup_aux)		(struct perf_event *event, void **pages,
@@ -847,7 +837,6 @@ struct perf_event_context {
 #ifdef CONFIG_CGROUP_PERF
 	int				nr_cgroups;	 /* cgroup evts */
 #endif
-	void				*task_ctx_data; /* pmu specific data */
 	struct rcu_head			rcu_head;
 };
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9b8bc01..cecbf25 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1241,26 +1241,11 @@ static void get_ctx(struct perf_event_context *ctx)
 	refcount_inc(&ctx->refcount);
 }
 
-static void *alloc_task_ctx_data(struct pmu *pmu)
-{
-	if (pmu->task_ctx_cache)
-		return kmem_cache_zalloc(pmu->task_ctx_cache, GFP_KERNEL);
-
-	return NULL;
-}
-
-static void free_task_ctx_data(struct pmu *pmu, void *task_ctx_data)
-{
-	if (pmu->task_ctx_cache && task_ctx_data)
-		kmem_cache_free(pmu->task_ctx_cache, task_ctx_data);
-}
-
 static void free_ctx(struct rcu_head *head)
 {
 	struct perf_event_context *ctx;
 
 	ctx = container_of(head, struct perf_event_context, rcu_head);
-	free_task_ctx_data(ctx->pmu, ctx->task_ctx_data);
 	kfree(ctx);
 }
 
@@ -3453,25 +3438,13 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 			if (cpuctx->sched_cb_usage && pmu->sched_task)
 				pmu->sched_task(ctx, task, false);
 
-			/*
-			 * PMU specific parts of task perf context can require
-			 * additional synchronization. As an example of such
-			 * synchronization see implementation details of Intel
-			 * LBR call stack data profiling;
-			 */
-			if (pmu->swap_task_ctx)
-				pmu->swap_task_ctx(ctx, next_ctx);
-			else
-				swap(ctx->task_ctx_data, next_ctx->task_ctx_data);
-
 			perf_pmu_enable(pmu);
 
 			/*
 			 * RCU_INIT_POINTER here is safe because we've not
 			 * modified the ctx and the above modification of
-			 * ctx->task and ctx->task_ctx_data are immaterial
-			 * since those values are always verified under
-			 * ctx->lock which we're now holding.
+			 * ctx->task is immaterial since this value is always
+			 * verified under ctx->lock which we're now holding.
 			 */
 			RCU_INIT_POINTER(task->perf_event_ctxp[ctxn], next_ctx);
 			RCU_INIT_POINTER(next->perf_event_ctxp[ctxn], ctx);
@@ -4605,7 +4578,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_cpu_context *cpuctx;
-	void *task_ctx_data = NULL;
 	unsigned long flags;
 	int ctxn, err;
 	int cpu = event->cpu;
@@ -4629,24 +4601,12 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 	if (ctxn < 0)
 		goto errout;
 
-	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
-		task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!task_ctx_data) {
-			err = -ENOMEM;
-			goto errout;
-		}
-	}
-
 retry:
 	ctx = perf_lock_task_context(task, ctxn, &flags);
 	if (ctx) {
 		clone_ctx = unclone_ctx(ctx);
 		++ctx->pin_count;
 
-		if (task_ctx_data && !ctx->task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
 		raw_spin_unlock_irqrestore(&ctx->lock, flags);
 
 		if (clone_ctx)
@@ -4657,11 +4617,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		if (!ctx)
 			goto errout;
 
-		if (task_ctx_data) {
-			ctx->task_ctx_data = task_ctx_data;
-			task_ctx_data = NULL;
-		}
-
 		err = 0;
 		mutex_lock(&task->perf_event_mutex);
 		/*
@@ -4688,11 +4643,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		}
 	}
 
-	free_task_ctx_data(pmu, task_ctx_data);
 	return ctx;
 
 errout:
-	free_task_ctx_data(pmu, task_ctx_data);
 	return ERR_PTR(err);
 }
 
@@ -13145,18 +13098,6 @@ inherit_event(struct perf_event *parent_event,
 	if (IS_ERR(child_event))
 		return child_event;
 
-
-	if ((child_event->attach_state & PERF_ATTACH_TASK_DATA) &&
-	    !child_ctx->task_ctx_data) {
-		struct pmu *pmu = child_event->pmu;
-
-		child_ctx->task_ctx_data = alloc_task_ctx_data(pmu);
-		if (!child_ctx->task_ctx_data) {
-			free_event(child_event);
-			return ERR_PTR(-ENOMEM);
-		}
-	}
-
 	/*
 	 * is_orphaned_event() and list_add_tail(&parent_event->child_list)
 	 * must be under the same lock in order to serialize against
@@ -13167,7 +13108,6 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		/* task_ctx_data is freed with child_ctx */
 		free_event(child_event);
 		return NULL;
 	}
-- 
2.7.4

