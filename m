Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE37E37FFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 00:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhEMWPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 18:15:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:52464 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhEMWPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 18:15:21 -0400
IronPort-SDR: +6R8VEg5TsOGgysHFjsf1ffMuZgCihyb4JS+gAcGjnO3f658ZJnQiYAr/XKEXaiLT62X9n4vji
 ZS6dMuZRlT5Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200121992"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="200121992"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 15:14:11 -0700
IronPort-SDR: 9vc5KYkLKoFxtepfQxprdlBdJpIJrfoYp/jaNtTojAEFRmxe/pwHWbubiXzNAmiSnwJEzOgvx1
 FhjWd6B3coTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="471807620"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 13 May 2021 15:14:11 -0700
Received: from [10.212.147.75] (kliang2-MOBL.ccr.corp.intel.com [10.212.147.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 02C5E5807DB;
        Thu, 13 May 2021 15:14:09 -0700 (PDT)
Subject: Re: [PATCH V7 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        ak@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
 <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
 <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
Date:   Thu, 13 May 2021 18:14:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2021 11:02 AM, Peter Zijlstra wrote:
> On Thu, May 13, 2021 at 07:23:02AM -0700, kan.liang@linux.intel.com wrote:
> 
>> +	if (x86_pmu.sched_task && event->hw.target) {
>> +		atomic_inc(&event->pmu->sched_cb_usage);
>> +		local_irq_save(flags);
>> +		x86_pmu_clear_dirty_counters();
>> +		local_irq_restore(flags);
>> +	}
> 
> So what happens if our mmap() happens after we've already created two
> (or more) threads in the process, all of who already have a counter (or
> more) on?
> 
> Shouldn't this be something like?

That's not enough.

I implemented a test case as below:
- The main thread A creates a new thread B.
- Bind the thread A to CPU 0. Then the thread A opens a event, mmap, 
enable the event, and sleep.
- Bind the thread B to CPU 1. Wait until the event in the thread A is 
enabled. Then RDPMC can read the counters on CPU 1.

In the x86_pmu_event_mapped(), we do on_each_cpu_mask(mm_cpumask(mm), 
cr4_update_pce, NULL, 1);
The RDPMC from thread B on CPU 1 is not forbidden.
Since the counter is not created in thread B, the sched_task() never 
gets a chance to be invoked. The dirty counter is not cleared.

To fix it, I think we have to move the cr4_update_pce() to the context 
switch, and update it only when the RDPMC task is scheduled. But it 
probably brings some overhead.

What do you think?

Thanks,
Kan

> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2474,7 +2474,7 @@ static int x86_pmu_event_init(struct per
>   	return err;
>   }
>   
> -static void x86_pmu_clear_dirty_counters(void)
> +static void x86_pmu_clear_dirty_counters(void *unused)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   	int i;
> @@ -2512,9 +2512,9 @@ static void x86_pmu_event_mapped(struct
>   	 */
>   	if (x86_pmu.sched_task && event->hw.target) {
>   		atomic_inc(&event->pmu->sched_cb_usage);
> -		local_irq_save(flags);
> -		x86_pmu_clear_dirty_counters();
> -		local_irq_restore(flags);
> +		on_each_cpu_mask(mm_cpumask(mm),
> +				 x86_pmu_clear_dirty_counters,
> +				 NULL, true);
>   	}
>   
>   	/*
> @@ -2653,7 +2653,7 @@ static void x86_pmu_sched_task(struct pe
>   	 */
>   	if (sched_in && ctx && READ_ONCE(x86_pmu.attr_rdpmc) &&
>   	    current->mm && atomic_read(&current->mm->context.perf_rdpmc_allowed))
> -		x86_pmu_clear_dirty_counters();
> +		x86_pmu_clear_dirty_counters(NULL);
>   }
>   
>   static void x86_pmu_swap_task_ctx(struct perf_event_context *prev,
> 
