Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4286A379786
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbhEJTTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhEJTTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:19:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B80BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 12:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uj4T461Q6i15FffkobP1bXgUv4vtpvercuMlehVfQn0=; b=ALam15ctQ28+Lq3xKot952LWR3
        VQD+0e31x3fXKdYUIScFe/yfByQDoFAKpvOCOHfsXPrf4grAfEJEe4XjMby69XlV5Bq5c40vK7/PU
        iKYjoSOgmfxUzt7YlsX5xG8TmuckQkaVLvuiq6VWzLzs2TfibPKgA3ZRMa+zjTMRe7NF046Ch8z4F
        hoRA2m/4blSNf5NQif9IfWsfooSYLrUCUkOs0jKUjqIbtt4UwgGMeNN0gdE95gmRk/tnvN9kPApRs
        hvn9G6a64cz30SIfQbx1ZuVkRtr/0wYsMdbaO/I4JWfKF3qVa8ZdfykbVvn8oLNHVfCaSY/6jMjzt
        kZOAd3dQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgBPw-00FWvj-29; Mon, 10 May 2021 19:18:12 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A9029871B5; Mon, 10 May 2021 21:18:11 +0200 (CEST)
Date:   Mon, 10 May 2021 21:18:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com, luto@amacapital.net,
        eranian@google.com, namhyung@kernel.org, robh@kernel.org
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
Message-ID: <20210510191811.GA21560@worktop.programming.kicks-ass.net>
References: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 11:25:52AM -0700, kan.liang@linux.intel.com wrote:

> - Add a new method check_leakage() to check and clear dirty counters
>   to prevent potential leakage.

I really dislike adding spurious callbacks, also because indirect calls
are teh suck, but also because it pollutes the interface so.

That said, I'm not sure I actually like the below any better :/

---

 arch/x86/events/core.c       | 58 +++++++++++++++++++++++++++++++++++++++++---
 arch/x86/events/perf_event.h |  1 +
 include/linux/perf_event.h   |  2 ++
 kernel/events/core.c         |  7 +++++-
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8e509325c2c3..e650c4ab603a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -740,21 +740,26 @@ void x86_pmu_enable_all(int added)
 	}
 }
 
-static inline int is_x86_event(struct perf_event *event)
+static inline bool is_x86_pmu(struct pmu *_pmu)
 {
 	int i;
 
 	if (!is_hybrid())
-		return event->pmu == &pmu;
+		return _pmu == &pmu;
 
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
-		if (event->pmu == &x86_pmu.hybrid_pmu[i].pmu)
+		if (_pmu == &x86_pmu.hybrid_pmu[i].pmu)
 			return true;
 	}
 
 	return false;
 }
 
+static inline int is_x86_event(struct perf_event *event)
+{
+	return is_x86_pmu(event->pmu);
+}
+
 struct pmu *x86_get_pmu(unsigned int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -1624,6 +1629,8 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
 		goto do_del;
 
+	__set_bit(event->hw.idx, cpuc->dirty);
+
 	/*
 	 * Not a TXN, therefore cleanup properly.
 	 */
@@ -2472,6 +2479,31 @@ static int x86_pmu_event_init(struct perf_event *event)
 	return err;
 }
 
+static void x86_pmu_clear_dirty_counters(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	int i;
+
+	 /* Don't need to clear the assigned counter. */
+	for (i = 0; i < cpuc->n_events; i++)
+		__clear_bit(cpuc->assign[i], cpuc->dirty);
+
+	if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
+		return;
+
+	for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
+		/* Metrics and fake events don't have corresponding HW counters. */
+		if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
+			continue;
+		else if (i >= INTEL_PMC_IDX_FIXED)
+			wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
+		else
+			wrmsrl(x86_pmu_event_addr(i), 0);
+	}
+
+	bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
+}
+
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
@@ -2495,7 +2527,6 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
 {
-
 	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
 		return;
 
@@ -2604,6 +2635,25 @@ static const struct attribute_group *x86_pmu_attr_groups[] = {
 static void x86_pmu_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
+
+	/*
+	 * If a new task has the RDPMC enabled, clear the dirty counters
+	 * to prevent the potential leak.
+	 */
+	if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
+	    current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
+		x86_pmu_clear_dirty_counters();
+}
+
+bool arch_perf_needs_sched_in(struct pmu *pmu)
+{
+	if (!READ_ONCE(x86_pmu.attr_rdpmc))
+		return false;
+
+	if (!is_x86_pmu(pmu))
+		return  false;
+
+	return current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed);
 }
 
 static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27fa85e7d4fd..d6003e08b055 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -229,6 +229,7 @@ struct cpu_hw_events {
 	 */
 	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
 	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	int			enabled;
 
 	int			n_events; /* the # of events in the below arrays */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f5a6a2f069ed..8b5a88e93e3c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1597,6 +1597,8 @@ int perf_event_exit_cpu(unsigned int cpu);
 #define perf_event_exit_cpu	NULL
 #endif
 
+extern bool __weak arch_perf_needs_sched_in(struct pmu *_pmu);
+
 extern void __weak arch_perf_update_userpage(struct perf_event *event,
 					     struct perf_event_mmap_page *userpg,
 					     u64 now);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8c3abccaa612..9ae292c09cb0 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3817,6 +3817,11 @@ static void cpu_ctx_sched_in(struct perf_cpu_context *cpuctx,
 	ctx_sched_in(ctx, cpuctx, event_type, task);
 }
 
+bool __weak arch_perf_needs_sched_in(struct pmu *pmu)
+{
+	return false;
+}
+
 static void perf_event_context_sched_in(struct perf_event_context *ctx,
 					struct task_struct *task)
 {
@@ -3851,7 +3856,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
+	if (pmu->sched_task && (cpuctx->sched_cb_usage || arch_perf_needs_sched_in(pmu)))
 		pmu->sched_task(cpuctx->task_ctx, true);
 
 	perf_pmu_enable(pmu);
