Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B509738926B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354704AbhESPV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:21:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:9762 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354570AbhESPVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:21:14 -0400
IronPort-SDR: 0Fo5sbEJBH5Mpz1GnwW8jup9F8zI6vEz/r7l8WD1Fy8PCnzoM1a8UVbPlWtshrcvDRj4Yv5Bd6
 b/RfAsW6RRfw==
X-IronPort-AV: E=McAfee;i="6200,9189,9989"; a="264916864"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="264916864"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 08:19:53 -0700
IronPort-SDR: dwamyHfbyLLHGPTjROrVOGxmT7Szj2tE1cy4BQd+YduqEZzt+VOyUtv8WEHqxY1O3969gALcap
 GcJ8DaywUS9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="411775943"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 May 2021 08:19:53 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, vitaly.slobodskoy@intel.com,
        namhyung@kernel.org, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 5/6] perf/x86: Remove swap_task_ctx()
Date:   Wed, 19 May 2021 08:06:05 -0700
Message-Id: <1621436766-112801-5-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
References: <1621436766-112801-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The pmu specific data is saved in task_struct now. It doesn't need to
swap between context.

Remove swap_task_ctx() support.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- Rebase on top of the 5.13-rc2

 arch/x86/events/core.c       |  9 ---------
 arch/x86/events/intel/core.c |  7 -------
 arch/x86/events/intel/lbr.c  | 23 -----------------------
 arch/x86/events/perf_event.h | 11 -----------
 4 files changed, 50 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8368cc7..d89a942 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -79,7 +79,6 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_commit_scheduling, *x86_pmu.commit_scheduling);
 DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
-DEFINE_STATIC_CALL_NULL(x86_pmu_swap_task_ctx, *x86_pmu.swap_task_ctx);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
@@ -2018,7 +2017,6 @@ static void x86_pmu_static_call_update(void)
 	static_call_update(x86_pmu_stop_scheduling, x86_pmu.stop_scheduling);
 
 	static_call_update(x86_pmu_sched_task, x86_pmu.sched_task);
-	static_call_update(x86_pmu_swap_task_ctx, x86_pmu.swap_task_ctx);
 
 	static_call_update(x86_pmu_drain_pebs, x86_pmu.drain_pebs);
 	static_call_update(x86_pmu_pebs_aliases, x86_pmu.pebs_aliases);
@@ -2609,12 +2607,6 @@ static void x86_pmu_sched_task(struct perf_event_context *ctx,
 	static_call_cond(x86_pmu_sched_task)(ctx, task, sched_in);
 }
 
-static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
-				  struct perf_event_context *next)
-{
-	static_call_cond(x86_pmu_swap_task_ctx)(prev, next);
-}
-
 void perf_check_microcode(void)
 {
 	if (x86_pmu.check_microcode)
@@ -2676,7 +2668,6 @@ static struct pmu pmu = {
 
 	.event_idx		= x86_pmu_event_idx,
 	.sched_task		= x86_pmu_sched_task,
-	.swap_task_ctx		= x86_pmu_swap_task_ctx,
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b7fc7c9..8c3c885 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4473,12 +4473,6 @@ static void intel_pmu_sched_task(struct perf_event_context *ctx,
 	intel_pmu_lbr_sched_task(ctx, task, sched_in);
 }
 
-static void intel_pmu_swap_task_ctx(struct perf_event_context *prev,
-				    struct perf_event_context *next)
-{
-	intel_pmu_lbr_swap_task_ctx(prev, next);
-}
-
 static int intel_pmu_check_period(struct perf_event *event, u64 value)
 {
 	return intel_pmu_has_bts_period(event, value) ? -EINVAL : 0;
@@ -4627,7 +4621,6 @@ static __initconst const struct x86_pmu intel_pmu = {
 
 	.guest_get_msrs		= intel_guest_get_msrs,
 	.sched_task		= intel_pmu_sched_task,
-	.swap_task_ctx		= intel_pmu_swap_task_ctx,
 
 	.check_period		= intel_pmu_check_period,
 
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bef40b9..84d0a80 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -602,29 +602,6 @@ static void __intel_pmu_lbr_save(void *ctx)
 	cpuc->last_log_id = ++task_context_opt(ctx)->log_id;
 }
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
-				 struct perf_event_context *next)
-{
-	void *prev_ctx_data, *next_ctx_data;
-
-	swap(prev->task_ctx_data, next->task_ctx_data);
-
-	/*
-	 * Architecture specific synchronization makes sense in
-	 * case both prev->task_ctx_data and next->task_ctx_data
-	 * pointers are allocated.
-	 */
-
-	prev_ctx_data = next->task_ctx_data;
-	next_ctx_data = prev->task_ctx_data;
-
-	if (!prev_ctx_data || !next_ctx_data)
-		return;
-
-	swap(task_context_opt(prev_ctx_data)->lbr_callstack_users,
-	     task_context_opt(next_ctx_data)->lbr_callstack_users);
-}
-
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 			      struct task_struct *task, bool sched_in)
 {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 208b859..abeb01c 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -854,14 +854,6 @@ struct x86_pmu {
 	int		(*set_topdown_event_period)(struct perf_event *event);
 
 	/*
-	 * perf task context (i.e. struct perf_event_context::task_ctx_data)
-	 * switch helper to bridge calls from perf/core to perf/x86.
-	 * See struct pmu::swap_task_ctx() usage for examples;
-	 */
-	void		(*swap_task_ctx)(struct perf_event_context *prev,
-					 struct perf_event_context *next);
-
-	/*
 	 * AMD bits
 	 */
 	unsigned int	amd_nb_constraints : 1;
@@ -1308,9 +1300,6 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
 void intel_ds_init(void);
 
-void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
-				 struct perf_event_context *next);
-
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx,
 			      struct task_struct *task, bool sched_in);
 
-- 
2.7.4

