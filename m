Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29138926C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354705AbhESPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:21:30 -0400
Received: from mga07.intel.com ([134.134.136.100]:9763 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354573AbhESPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:21:14 -0400
IronPort-SDR: yT06ayuj1gxGYo9CW0DnPJ3FRaS0XrtmJ0+aHCgiB/iBNqWKaCJAxGaIulj1Obf5/OzpVt1rOU
 eA/QRJ1PGzaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264916866"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264916866"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:19:54 -0700
IronPort-SDR: Bmx2MIkjYllld0UVI6qvXIaZAHO0WFYK1kYg65cx0QW4fJOL0QA28Pu+jQ0jIwGstqKUJSlR1j
 WIzPAgkQ/Q6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411775947"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 08:19:53 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, vitaly.slobodskoy@intel.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 6/6] perf: Clean up pmu specific data
Date:   Wed, 19 May 2021 08:06:06 -0700
Message-Id: <1621436766-112801-6-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
References: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
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

Changes since V3:
- Rebase on top of the 5.13-rc2

 include/linux/perf_event.h | 11 --------
 kernel/events/core.c       | 64 ++--------------------------------------------
 2 files changed, 2 insertions(+), 73 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0085b97..5624792 100644
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
index a83284b..ddebbdb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1273,26 +1273,11 @@ static void get_ctx(struct perf_event_context *ctx)
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
 
@@ -3485,25 +3470,13 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
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
@@ -4630,7 +4603,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 {
 	struct perf_event_context *ctx, *clone_ctx = NULL;
 	struct perf_cpu_context *cpuctx;
-	void *task_ctx_data = NULL;
 	unsigned long flags;
 	int ctxn, err;
 	int cpu = event->cpu;
@@ -4654,24 +4626,12 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
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
@@ -4682,11 +4642,6 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
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
@@ -4713,11 +4668,9 @@ find_get_context(struct pmu *pmu, struct task_struct *task,
 		}
 	}
 
-	free_task_ctx_data(pmu, task_ctx_data);
 	return ctx;
 
 errout:
-	free_task_ctx_data(pmu, task_ctx_data);
 	return ERR_PTR(err);
 }
 
@@ -13230,18 +13183,6 @@ inherit_event(struct perf_event *parent_event,
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
@@ -13252,7 +13193,6 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		/* task_ctx_data is freed with child_ctx */
 		free_event(child_event);
 		return NULL;
 	}
-- 
2.7.4

