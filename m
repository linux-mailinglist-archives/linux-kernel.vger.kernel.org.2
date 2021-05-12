Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4452137BF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhELOLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:11:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:16915 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhELOLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:11:10 -0400
IronPort-SDR: RZVmWhFVZgUaVGoR126Qb7HKmcIfglT/rUFLFodKYfSibp96YiGD+/+VLhnjHrCAcOb7icyHyd
 ntSDwzGiYwyA==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="199392373"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="199392373"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:10:02 -0700
IronPort-SDR: MwK393zN0NXsGH9v371DsExp1Duy8q4dd45lXpmIecRhhmWCN5FkdKFOFlybpNy9cooSAeIanX
 TBndhYy0A4jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="437218966"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2021 07:10:02 -0700
Received: from [10.209.99.183] (kliang2-MOBL.ccr.corp.intel.com [10.209.99.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 9C484580342;
        Wed, 12 May 2021 07:10:00 -0700 (PDT)
Subject: Re: [PATCH V6] perf: Reset the dirty counter to prevent the leak for
 an RDPMC task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Rob Herring <robh@kernel.org>, Ingo Molnar <mingo@redhat.com>,
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
 <YJuFW08p8dsKc/wN@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <03fff406-3050-57dc-1f17-0f5630e810af@linux.intel.com>
Date:   Wed, 12 May 2021 10:09:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YJuFW08p8dsKc/wN@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/2021 3:35 AM, Peter Zijlstra wrote:
> On Tue, May 11, 2021 at 05:42:54PM -0400, Liang, Kan wrote:
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 1574b70..8216acc 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -3851,7 +3851,7 @@ static void perf_event_context_sched_in(struct
>> perf_event_context *ctx,
>>   		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
>>   	perf_event_sched_in(cpuctx, ctx, task);
>>
>> -	if (cpuctx->sched_cb_usage && pmu->sched_task)
>> +	if (pmu->sched_task && (cpuctx->sched_cb_usage ||
>> atomic_read(&pmu->sched_cb_usages)))
>>   		pmu->sched_task(cpuctx->task_ctx, true);
> 
> Aside from the obvious whitespace issues; I think this should work.
> 

Thanks. The whitespace should be caused by the copy/paste. I will fix it 
in the V7.

I did more tests. For some cases, I can still observe the dirty counter 
for the first RDPMC read. I think we still have to clear the dirty 
counters in the x86_pmu_event_mapped() for the first RDPMC read.
I have to disable the the interrupts to prevent the preemption.


  static void x86_pmu_event_mapped(struct perf_event *event, struct 
mm_struct *mm)
  {
+	unsigned long flags;
+
  	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
  		return;

  	/*
+	 * Enable sched_task() for the RDPMC task,
+	 * and clear the existing dirty counters.
+	 */
+	if (x86_pmu.sched_task && event->hw.target) {
+		atomic_inc(&event->pmu->sched_cb_usages);
+		local_irq_save(flags);
+		x86_pmu_clear_dirty_counters();
+		local_irq_restore(flags);
+	}
+
+	/*
  	 * This function relies on not being called concurrently in two
  	 * tasks in the same mm.  Otherwise one task could observe
  	 * perf_rdpmc_allowed > 1 and return all the way back to

Thanks,
Kan
