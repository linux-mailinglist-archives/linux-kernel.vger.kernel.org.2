Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D180380D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 17:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbhENPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 11:32:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:55751 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbhENPb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 11:31:59 -0400
IronPort-SDR: 1BVTW46DI76c81OB3FOTAu4a3LGheRjD6BCpk1AO7ipOaOkYNy+8hWJDgd/x6daVOd18AIDnS8
 0wDzJnSr5yZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="179791404"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="179791404"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 08:30:16 -0700
IronPort-SDR: Ec/DXsaPG5vYMTAvo6i9rZMyMwegNCBzmlkFESVAPkcCkIAko7I+IDCfGCZjtP1ajzOnw4Dyga
 cSsQ9p/8LZXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="471948779"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 14 May 2021 08:30:14 -0700
Received: from [10.209.84.224] (kliang2-MOBL.ccr.corp.intel.com [10.209.84.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id C3798580960;
        Fri, 14 May 2021 08:30:13 -0700 (PDT)
Subject: Re: [PATCH V7 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, robh@kernel.org,
        ak@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        luto@amacapital.net, eranian@google.com, namhyung@kernel.org
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
 <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
 <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net>
 <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
 <YJ6MvvtovR6adufW@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a0bfdcfa-4b1e-7bf5-e90b-8e46ed79c0c1@linux.intel.com>
Date:   Fri, 14 May 2021 11:30:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJ6MvvtovR6adufW@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2021 10:44 AM, Peter Zijlstra wrote:
> On Thu, May 13, 2021 at 06:14:08PM -0400, Liang, Kan wrote:
>> On 5/13/2021 11:02 AM, Peter Zijlstra wrote:
>>> On Thu, May 13, 2021 at 07:23:02AM -0700, kan.liang@linux.intel.com wrote:
>>>
>>>> +	if (x86_pmu.sched_task && event->hw.target) {
>>>> +		atomic_inc(&event->pmu->sched_cb_usage);
>>>> +		local_irq_save(flags);
>>>> +		x86_pmu_clear_dirty_counters();
>>>> +		local_irq_restore(flags);
>>>> +	}
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
>> - Bind the thread A to CPU 0. Then the thread A opens a event, mmap, enable
>> the event, and sleep.
>> - Bind the thread B to CPU 1. Wait until the event in the thread A is
>> enabled. Then RDPMC can read the counters on CPU 1.
> 
> This?

Yes

> 
> 	A				B
> 
> 	clone(CLONE_THREAD) --->	
> 	set_affine(0)
> 					set_affine(1)
> 					while (!event-enabled)
> 						;
> 	event = perf_event_open()
> 	mmap(event)
> 	ioctl(event, IOC_ENABLE); --->
> 					RDPMC
> 
> 	sleep(n)
> 	  schedule(INTERRUPTIBLE)
> 	  /* idle */
> 
> 
>> In the x86_pmu_event_mapped(), we do on_each_cpu_mask(mm_cpumask(mm),
>> cr4_update_pce, NULL, 1);
>> The RDPMC from thread B on CPU 1 is not forbidden.
>> Since the counter is not created in thread B, the sched_task() never gets a
>> chance to be invoked. The dirty counter is not cleared.
> 
> Per-task counters from CPU1 that ran before B ran?

Yes

> 
>> To fix it, I think we have to move the cr4_update_pce() to the context
>> switch, and update it only when the RDPMC task is scheduled. But it probably
>> brings some overhead.
> 
> We have CR4:PCE updates in the context switch path, see
> switch_mm_irqs_off() -> cr4_update_pce_mm().
> 
> Doing the clear there might actually make sense and avoids this frobbing
> of ->sched_task(). When we call cr4_update_pce_mm(), and @mm has rdpmc
> on, clear dirty or something like that.
> 
> Worth a try.
> 
> 

Looks like a good place. Will try.

Thanks,
Kan
