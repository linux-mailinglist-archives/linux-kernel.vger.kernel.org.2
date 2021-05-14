Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E4380AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhENNuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:50:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:59457 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231540AbhENNuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:50:12 -0400
IronPort-SDR: idS9z2+L3i412uzcT5i9Ye3rmfOFgD7HtXJfQHru1ZIM7PWMxhnsIIJtKGVuwhPy58il3ITuLc
 iIO0elab9PqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="187299459"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="187299459"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 06:48:53 -0700
IronPort-SDR: ojowpmgtANLjVZdwOGWDfl8NxHZGxSuzcwjqFf61n6bw7t/XPxn+iafJ7l4iC/vzc+6VWu7tCS
 JBIX4Y9wVjWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="627152695"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 14 May 2021 06:48:52 -0700
Received: from [10.209.84.224] (kliang2-MOBL.ccr.corp.intel.com [10.209.84.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 10AF3580960;
        Fri, 14 May 2021 06:48:50 -0700 (PDT)
Subject: Re: [PATCH V7 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
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
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
 <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
 <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net>
 <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
 <CAL_JsqJ8WtTykBPiN6tm=oDPeypChnsSQr-2BpDjXGfmuKXnrg@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ff0eab70-a34a-c82c-5490-0280bb75ce94@linux.intel.com>
Date:   Fri, 14 May 2021 09:48:49 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJ8WtTykBPiN6tm=oDPeypChnsSQr-2BpDjXGfmuKXnrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2021 11:50 PM, Rob Herring wrote:
> On Thu, May 13, 2021 at 5:14 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 5/13/2021 11:02 AM, Peter Zijlstra wrote:
>>> On Thu, May 13, 2021 at 07:23:02AM -0700, kan.liang@linux.intel.com wrote:
>>>
>>>> +    if (x86_pmu.sched_task && event->hw.target) {
>>>> +            atomic_inc(&event->pmu->sched_cb_usage);
>>>> +            local_irq_save(flags);
>>>> +            x86_pmu_clear_dirty_counters();
>>>> +            local_irq_restore(flags);
>>>> +    }
>>>
>>> So what happens if our mmap() happens after we've already created two
>>> (or more) threads in the process, all of who already have a counter (or
>>> more) on?
>>>
>>> Shouldn't this be something like?
>>
>> That's not enough.
>>
>> I implemented a test case as below:
>> - The main thread A creates a new thread B.
>> - Bind the thread A to CPU 0. Then the thread A opens a event, mmap,
>> enable the event, and sleep.
>> - Bind the thread B to CPU 1. Wait until the event in the thread A is
>> enabled. Then RDPMC can read the counters on CPU 1.
>>
>> In the x86_pmu_event_mapped(), we do on_each_cpu_mask(mm_cpumask(mm),
>> cr4_update_pce, NULL, 1);
>> The RDPMC from thread B on CPU 1 is not forbidden.
> 
> You want RDPMC disabled since the counters are not cleared? If you had
> a cpu bound event for CPU1, then you'd want RDPMC enabled, right?
>

Since we are trying to use a lazy way to clear the counters, I think the 
RDPMC should be enabled only for a user who owns the counters.

For the above case, we only perf_event_open(pid = 0, cpu = -1) an event 
in the thread A. Perf should only monitor the thread A. The RDPMC should 
be enabled only when the thread A is scheduled in.
The thread B doesn't open any events. The RDPMC should be disabled for 
the thread B. Otherwise, it can read any counters on the CPU, including 
other task-bound events, which is what the patchset intends to prevent.


>> Since the counter is not created in thread B, the sched_task() never
>> gets a chance to be invoked. The dirty counter is not cleared.
>>
>> To fix it, I think we have to move the cr4_update_pce() to the context
>> switch, and update it only when the RDPMC task is scheduled. But it
>> probably brings some overhead.
> 
> I'm trying to do a similar approach (if I understand what you mean)
> using sched_task() without a switch_mm hook or IPIs. The current
> branch is here[1]. I have things working for task bound events, but I
> don't think cpu bound events are handled for similar reasons as above.
> I'm not too sure that enabling user access for cpu bound events is
> really all that useful? Maybe for Arm we should just keep user access
> for cpu bound events disabled.
> 
> Note for now I'm not doing lazy clearing of counters for simplicity.

If we don't use the lazy way, I think we can clear the counters when a 
task is scheduled out. I don't think we need to worry about the above case.

Thanks,
Kan
