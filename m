Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A49F37CA22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbhELQ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:26:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:15653 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236273AbhELPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:37:28 -0400
IronPort-SDR: ydGkHPBFsxSzhQZND0IjPwXajD7frdxAPOrJMn0VTM70BYzlFDOlASH5LbIep1kCURwnuthpAI
 JIbtd5OPQYuw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="196641577"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="196641577"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 08:36:17 -0700
IronPort-SDR: 3Wz6ALEHL+dXqLYGuZAUrcLfaPxHT6DXjQj1QyYEBdHmKFFZxdJ3lrdaRC9xsmeFp1xtS9H/O0
 PAh59tVWSGGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="391896614"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 12 May 2021 08:36:17 -0700
Received: from [10.209.99.183] (kliang2-MOBL.ccr.corp.intel.com [10.209.99.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B4A8C5807FC;
        Wed, 12 May 2021 08:36:15 -0700 (PDT)
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
 <bbe76d64-f6ff-29eb-9f62-2d4f934463e3@linux.intel.com>
 <CAL_JsqJrrqbHbMXEpy++nGzZ5JD=mm4O2xPgL8g1MUXAQGk=Jw@mail.gmail.com>
 <f390aa11-e475-9d9d-9384-959a7ed32fd6@linux.intel.com>
 <CAL_JsqKN4YcCpL9uiOqea4CcqRWgU7Af=V8JNMjypivaVHq4sQ@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <e91d1c50-7785-46f9-5440-bc4e8fcbc926@linux.intel.com>
Date:   Wed, 12 May 2021 11:36:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKN4YcCpL9uiOqea4CcqRWgU7Af=V8JNMjypivaVHq4sQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2021 10:54 AM, Rob Herring wrote:
>> How about this one?
> Would you mind splitting this to core and x86 parts.
> 

Sure, I will split the patch.

>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index c6fedd2..9052578 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -1636,6 +1636,8 @@ static void x86_pmu_del(struct perf_event *event,
>> int flags)
>>          if (cpuc->txn_flags & PERF_PMU_TXN_ADD)
>>                  goto do_del;
>>
>> +       __set_bit(event->hw.idx, cpuc->dirty);
>> +
>>          /*
>>           * Not a TXN, therefore cleanup properly.
>>           */
>> @@ -2484,12 +2486,43 @@ static int x86_pmu_event_init(struct perf_event
>> *event)
>>          return err;
>>    }
>>
>> +static void x86_pmu_clear_dirty_counters(void)
>> +{
>> +       struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +       int i;
>> +
>> +        /* Don't need to clear the assigned counter. */
>> +       for (i = 0; i < cpuc->n_events; i++)
>> +               __clear_bit(cpuc->assign[i], cpuc->dirty);
>> +
>> +       if (bitmap_empty(cpuc->dirty, X86_PMC_IDX_MAX))
>> +               return;
>> +
>> +       for_each_set_bit(i, cpuc->dirty, X86_PMC_IDX_MAX) {
>> +               /* Metrics and fake events don't have corresponding HW counters. */
>> +               if (is_metric_idx(i) || (i == INTEL_PMC_IDX_FIXED_VLBR))
>> +                       continue;
>> +               else if (i >= INTEL_PMC_IDX_FIXED)
>> +                       wrmsrl(MSR_ARCH_PERFMON_FIXED_CTR0 + (i - INTEL_PMC_IDX_FIXED), 0);
>> +               else
>> +                       wrmsrl(x86_pmu_event_addr(i), 0);
>> +       }
>> +
>> +       bitmap_zero(cpuc->dirty, X86_PMC_IDX_MAX);
>> +}
>> +
>>    static void x86_pmu_event_mapped(struct perf_event *event, struct
>> mm_struct *mm)
>>    {
>>          if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>                  return;
>>
>>          /*
>> +        * Enable sched_task() for the RDPMC task.
>> +        */
>> +       if (x86_pmu.sched_task && event->hw.target)
>> +               atomic_inc(&event->pmu->sched_cb_usages);
>> +
>> +       /*
>>           * This function relies on not being called concurrently in two
>>           * tasks in the same mm.  Otherwise one task could observe
>>           * perf_rdpmc_allowed > 1 and return all the way back to
>> @@ -2507,10 +2540,12 @@ static void x86_pmu_event_mapped(struct
>> perf_event *event, struct mm_struct *mm)
>>
>>    static void x86_pmu_event_unmapped(struct perf_event *event, struct
>> mm_struct *mm)
>>    {
>> -
>>          if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
>>                  return;
>>
>> +       if (x86_pmu.sched_task && event->hw.target)
>> +               atomic_dec(&event->pmu->sched_cb_usages);
>> +
>>          if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
>>                  on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
>>    }
>> @@ -2616,6 +2651,14 @@ static const struct attribute_group
>> *x86_pmu_attr_groups[] = {
>>    static void x86_pmu_sched_task(struct perf_event_context *ctx, bool
>> sched_in)
>>    {
>>          static_call_cond(x86_pmu_sched_task)(ctx, sched_in);
>> +
>> +       /*
>> +        * If a new task has the RDPMC enabled, clear the dirty counters
>> +        * to prevent the potential leak.
>> +        */
>> +       if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
>> +           current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
>> +               x86_pmu_clear_dirty_counters();
>>    }
>>
>>    static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> index 10c8171..55bd891 100644
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -229,6 +229,7 @@ struct cpu_hw_events {
>>           */
>>          struct perf_event       *events[X86_PMC_IDX_MAX]; /* in counter order */
>>          unsigned long           active_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>> +       unsigned long           dirty[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
>>          int                     enabled;
>>
>>          int                     n_events; /* the # of events in the below arrays */
>> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
>> index c8a3388..3a85dbe 100644
>> --- a/include/linux/perf_event.h
>> +++ b/include/linux/perf_event.h
>> @@ -301,6 +301,9 @@ struct pmu {
>>          /* number of address filters this PMU can do */
>>          unsigned int                    nr_addr_filters;
>>
>> +       /* Track the per PMU sched_task() callback users */
>> +       atomic_t                        sched_cb_usages;
> To align with the per cpu one: s/usages/usage/
> 

OK

> I think we should be able to use refcount_t here instead?

I think they are the same for this case. Is there a particular reason 
for the change? Are they different in ARM?

> 
>> +
>>          /*
>>           * Fully disable/enable this PMU, can be used to protect from the PMI
>>           * as well as for lazy/batch writing of the MSRs.
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 1574b70..8216acc 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3851,7 +3851,7 @@ static void perf_event_context_sched_in(struct
>> perf_event_context *ctx,
>>                  cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>          perf_event_sched_in(cpuctx, ctx, task);
>>
>> -       if (cpuctx->sched_cb_usage && pmu->sched_task)
>> +       if (pmu->sched_task && (cpuctx->sched_cb_usage ||
>> atomic_read(&pmu->sched_cb_usages)))
> For completeness, shouldn't this condition be added everywhere
> ->sched_task() can be called perhaps with the exception of
> __perf_pmu_sched_task() which is only called when the task context
> doesn't change.

In theory, it's harmless to add it in the other places, because we also 
check it in the X86 specific code. But the other checks can bring some 
overhead. I'd like to avoid the overhead in a context switch.

Since X86 is the only user for sched_task() for now, I prefer to only 
add the check here. I will add some comments to explain the reason.

If ARM needs it in the other places later, please feel free to add it.

Thanks,
Kan
