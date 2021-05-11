Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4437AD7F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbhEKSA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:00:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:50588 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231439AbhEKSAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:00:53 -0400
IronPort-SDR: EyMkazqzFEygQSgXvZNdG7/necP0sLDDco9gGYSMyM51sP8TAroXF1DxG0wS7j45d6lgAOSse+
 +GHNyePQrYYg==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199187963"
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="199187963"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2021 10:59:44 -0700
IronPort-SDR: 1jdM+AqMw7Gm1DQTt+B+OP0V9JZILETW84rgGG/mp9oDlC3P9o29wjixOkJV7n0WOq69aB5Jeg
 7dAE03TSyvVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,291,1613462400"; 
   d="scan'208";a="537125718"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 11 May 2021 10:59:43 -0700
Received: from [10.252.131.4] (kliang2-MOBL.ccr.corp.intel.com [10.252.131.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 23CEF5807DB;
        Tue, 11 May 2021 10:59:41 -0700 (PDT)
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
To:     Rob Herring <robh@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <1619115952-155809-1-git-send-email-kan.liang@linux.intel.com>
 <20210510191811.GA21560@worktop.programming.kicks-ass.net>
 <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bbe76d64-f6ff-29eb-9f62-2d4f934463e3@linux.intel.com>
Date:   Tue, 11 May 2021 13:59:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKeVoBL6cn6CGUW17jnf8B+4aHKeyRdceaGCiKzsUsZwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/2021 4:29 PM, Rob Herring wrote:
> On Mon, May 10, 2021 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Apr 22, 2021 at 11:25:52AM -0700, kan.liang@linux.intel.com wrote:
>>
>>> - Add a new method check_leakage() to check and clear dirty counters
>>>    to prevent potential leakage.
>>
>> I really dislike adding spurious callbacks, also because indirect calls
>> are teh suck, but also because it pollutes the interface so.
>>
>> That said, I'm not sure I actually like the below any better :/
>>

Maybe we can add a atomic variable to track the number of 
event_mapped(). Only invoke sched_task() when the number > 0.

It looks like only X86 implements the event_mapped(). So it should not 
impact other ARCHs.

What do you think?

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c6fedd2..ae5b0e7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1636,6 +1636,8 @@ static void x86_pmu_del(struct perf_event *event, 
int flags)
  	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
  		goto do_del;

+	__set_bit(event->hw.idx, cpuc->dirty);
+
  	/*
  	 * Not a TXN, therefore cleanup properly.
  	 */
@@ -2484,6 +2486,31 @@ static int x86_pmu_event_init(struct perf_event 
*event)
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
  static void x86_pmu_event_mapped(struct perf_event *event, struct 
mm_struct *mm)
  {
  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
@@ -2507,7 +2534,6 @@ static void x86_pmu_event_mapped(struct perf_event 
*event, struct mm_struct *mm)

  static void x86_pmu_event_unmapped(struct perf_event *event, struct 
mm_struct *mm)
  {
-
  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
  		return;

@@ -2616,6 +2642,14 @@ static const struct attribute_group 
*x86_pmu_attr_groups[] = {
  static void x86_pmu_sched_task(struct perf_event_context *ctx, bool 
sched_in)
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
  }

  static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 10c8171..55bd891 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -229,6 +229,7 @@ struct cpu_hw_events {
  	 */
  	struct perf_event	*events[X86_PMC_IDX_MAX]; /* in counter order */
  	unsigned long		active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	unsigned long		dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
  	int			enabled;

  	int			n_events; /* the # of events in the below arrays */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1574b70..ef8f6f4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -384,6 +384,7 @@ DEFINE_STATIC_KEY_FALSE(perf_sched_events);
  static DECLARE_DELAYED_WORK(perf_sched_work, perf_sched_delayed);
  static DEFINE_MUTEX(perf_sched_mutex);
  static atomic_t perf_sched_count;
+static atomic_t perf_event_mmap_count;

  static DEFINE_PER_CPU(atomic_t, perf_cgroup_events);
  static DEFINE_PER_CPU(int, perf_sched_cb_usages);
@@ -3851,7 +3852,7 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,
  		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
  	perf_event_sched_in(cpuctx, ctx, task);

-	if (cpuctx->sched_cb_usage && pmu->sched_task)
+	if (pmu->sched_task && (cpuctx->sched_cb_usage || 
atomic_read(&perf_event_mmap_count)))
  		pmu->sched_task(cpuctx->task_ctx, true);

  	perf_pmu_enable(pmu);
@@ -5988,8 +5989,10 @@ static void perf_mmap_open(struct vm_area_struct 
*vma)
  	if (vma->vm_pgoff)
  		atomic_inc(&event->rb->aux_mmap_count);

-	if (event->pmu->event_mapped)
+	if (event->pmu->event_mapped) {
+		atomic_inc(&perf_event_mmap_count);
  		event->pmu->event_mapped(event, vma->vm_mm);
+	}
  }

  static void perf_pmu_output_stop(struct perf_event *event);
@@ -6011,8 +6014,10 @@ static void perf_mmap_close(struct vm_area_struct 
*vma)
  	unsigned long size = perf_data_size(rb);
  	bool detach_rest = false;

-	if (event->pmu->event_unmapped)
+	if (event->pmu->event_unmapped) {
+		atomic_dec(&perf_event_mmap_count);
  		event->pmu->event_unmapped(event, vma->vm_mm);
+	}

  	/*
  	 * rb->aux_mmap_count will always drop before rb->mmap_count and
@@ -6329,8 +6334,10 @@ static int perf_mmap(struct file *file, struct 
vm_area_struct *vma)
  	vma->vm_flags |= VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP;
  	vma->vm_ops = &perf_mmap_vmops;

-	if (event->pmu->event_mapped)
+	if (event->pmu->event_mapped) {
+		atomic_inc(&perf_event_mmap_count);
  		event->pmu->event_mapped(event, vma->vm_mm);
+	}

  	return ret;
  }


Thanks,
Kan
