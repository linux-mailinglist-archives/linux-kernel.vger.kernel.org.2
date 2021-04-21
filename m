Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD1D366EDC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhDUPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:12:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:40256 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236626AbhDUPMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:12:45 -0400
IronPort-SDR: 20V0UwkH8GsdxVB3uCgocFRH/X6uNJpB309perHoqeWuhx8zu7TVO4DRF7/YQK1DECPzYMp29Z
 owThjgHzIbEg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="175822881"
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="175822881"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 08:12:09 -0700
IronPort-SDR: 2AJSyPeHklbv64FG0nC1kSTrr5ejTj+yt4yloRg86YVPyzGRvt0nOv6mLSN5wM6N1TYWUKBubW
 w/9rbIkoo55Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,240,1613462400"; 
   d="scan'208";a="385803595"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 21 Apr 2021 08:12:08 -0700
Received: from [10.212.233.108] (kliang2-MOBL.ccr.corp.intel.com [10.212.233.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C5B975808CA;
        Wed, 21 Apr 2021 08:12:07 -0700 (PDT)
Subject: Re: [PATCH V5] perf/x86: Reset the dirty counter to prevent the leak
 for an RDPMC task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com, luto@amacapital.net,
        eranian@google.com, namhyung@kernel.org
References: <1618957842-103858-1-git-send-email-kan.liang@linux.intel.com>
 <YH/eF4YWg73Lkcrr@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c683d70f-ae07-765d-1278-5771d1061cc0@linux.intel.com>
Date:   Wed, 21 Apr 2021 11:12:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YH/eF4YWg73Lkcrr@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2021 4:11 AM, Peter Zijlstra wrote:
>> @@ -2327,10 +2367,17 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
>>   
>>   static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
>>   {
>> +	unsigned long flags;
>>   
>>   	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>   		return;
>>   
>> +	if (x86_pmu.sched_task && event->hw.target) {
>> +		local_irq_save(flags);
>> +		perf_sched_cb_dec(event->ctx->pmu);
>> +		local_irq_restore(flags);
>> +	}
>> +
>>   	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>>   		on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>>   }
> I don't understand how this can possibly be correct. Both
> perf_sched_cb_{inc,dec} modify strict per-cpu state, but the mapped
> functions happen on whatever random CPU of the moment whenever the task
> memory map changes.
> 
> Suppose we mmap() on CPU0 and then exit on CPU1. Suppose the task does
> mmap() on CPU0 but then creates threads and runs on CPU1-4 concurrently
> before existing on CPU5.
> 
> Could be I'm not seeing it due to having a snot-brain, please explain.

You are right.
I implemented a new test case which mmap() on CPU 3, run and exit on CPU 
0. It can still read the counter values from other tasks on CPU 0.

Actually, I don't think we need perf_sched_cb_{inc,dec} and sched_task().

The mm->context.perf_rdpmc_allowed will tell us if it's a RDPMC task.
I think a clean way should be to add a new check_leakage() method. When 
perf schedules in a RDPMC task, we invoke the method and clear the dirty 
counters.
(I use a generic name check_leakage for the method so it can be reused 
by other ARCHs if possible.)

The patch is as below. The new and old test cases are all passed. I will 
do more tests.

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c7fcc8d..229dd48 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1624,6 +1624,8 @@ static void x86_pmu_del(struct perf_event *event, 
int flags)
  	if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
  		goto do_del;

+	__set_bit(event->hw.idx, cpuc->dirty);
+
  	/*
  	 * Not a TXN, therefore cleanup properly.
  	 */
@@ -2631,6 +2633,37 @@ static int x86_pmu_check_period(struct perf_event 
*event, u64 value)
  	return 0;
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
+static void x86_pmu_check_leakage(void)
+{
+	if (READ_ONCE(x86_pmu.attr_rdpmc))
+		x86_pmu_clear_dirty_counters();
+}
+
  static int x86_pmu_aux_output_match(struct perf_event *event)
  {
  	if (!(pmu.capabilities & PERF_PMU_CAP_AUX_OUTPUT))
@@ -2675,6 +2708,7 @@ static struct pmu pmu = {
  	.sched_task		= x86_pmu_sched_task,
  	.swap_task_ctx		= x86_pmu_swap_task_ctx,
  	.check_period		= x86_pmu_check_period,
+	.check_leakage		= x86_pmu_check_leakage,

  	.aux_output_match	= x86_pmu_aux_output_match,

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 27fa85e..d6003e0 100644
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
index a763928..bcf3964 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -514,6 +514,11 @@ struct pmu {
  	 * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
  	 */
  	int (*check_period)		(struct perf_event *event, u64 value); /* 
optional */
+
+	/*
+	 * Check and clear dirty counters to prevent potential leakage
+	 */
+	void (*check_leakage)		(void); /* optional */
  };

  enum perf_addr_filter_action_t {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 928b166..b496113 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3822,6 +3822,12 @@ static void cpu_ctx_sched_in(struct 
perf_cpu_context *cpuctx,
  	ctx_sched_in(ctx, cpuctx, event_type, task);
  }

+static bool has_check_leakage(struct pmu *pmu)
+{
+	return pmu->check_leakage && current->mm &&
+	       atomic_read(&current->mm->context.perf_rdpmc_allowed);
+}
+
  static void perf_event_context_sched_in(struct perf_event_context *ctx,
  					struct task_struct *task)
  {
@@ -3832,6 +3838,8 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,
  	if (cpuctx->task_ctx == ctx) {
  		if (cpuctx->sched_cb_usage)
  			__perf_pmu_sched_task(cpuctx, true);
+		if (has_check_leakage(pmu))
+			pmu->check_leakage();
  		return;
  	}

@@ -3858,6 +3866,8 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,

  	if (cpuctx->sched_cb_usage && pmu->sched_task)
  		pmu->sched_task(cpuctx->task_ctx, true);
+	if (has_check_leakage(pmu))
+		pmu->check_leakage();

  	perf_pmu_enable(pmu);


Thanks,
Kan
