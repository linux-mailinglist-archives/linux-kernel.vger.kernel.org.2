Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFDA3ACCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbhFRN4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:56:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:28917 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234036AbhFRN43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:56:29 -0400
IronPort-SDR: TfPt9vxsPnt3Fc+9RYhkb330r3IXU35zu1Xjf4t6LtkO7PU28T6zwuyrwiw9hdgP+yEJ6dMhog
 jvgcNcD6eZfw==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="186933578"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="186933578"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 06:54:20 -0700
IronPort-SDR: xeV4kgl1fdbaJH0QbvXvh6YmRn+1tTKk4kDVsAA+JiNwSr3tenwFfIHpR6uHNLSVRkSZGS7ZZA
 V+eUEWB8yitQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485693789"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 18 Jun 2021 06:54:20 -0700
Received: from [10.255.230.63] (kliang2-MOBL.ccr.corp.intel.com [10.255.230.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 566C95806E9;
        Fri, 18 Jun 2021 06:54:19 -0700 (PDT)
Subject: Re: [PATCH 0/4] perf: Fix the ctx->pmu for a hybrid system
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
        mark.rutland@arm.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com
References: <1623869734-133974-1-git-send-email-kan.liang@linux.intel.com>
 <YMsiiuUsjsrh8ZAC@hirez.programming.kicks-ass.net>
 <YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c878d084-f8a3-4bb6-715a-ba7fef6a7278@linux.intel.com>
Date:   Fri, 18 Jun 2021 09:54:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMsy7BuGT8nBTspT@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2021 7:33 AM, Peter Zijlstra wrote:
> On Thu, Jun 17, 2021 at 12:23:06PM +0200, Peter Zijlstra wrote:
>> On Wed, Jun 16, 2021 at 11:55:30AM -0700, kan.liang@linux.intel.com wrote:
>>
>>> To fix the issue, the generic perf codes have to understand the
>>> supported CPU mask of a specific hybrid PMU. So it can update the
>>> ctx->pmu accordingly, when a task is scheduled on a CPU which has
>>> a different type of PMU from the previous CPU. The supported_cpus
>>> has to be moved to the struct pmu.
>>
>> Urghh.. I so hate this :-/
>>
>> I *did* point you to:
>>
>>    https://lore.kernel.org/lkml/20181010104559.GO5728@hirez.programming.kicks-ass.net/
>>
>> when you started this whole hybrid crud, and I think that's still the
>> correct thing to do.
>>
>> Still, let me consider if there's a workable short-term cludge I hate
>> less.
> 
> How's this? We already have x86_pmu_update_cpu_context() setting the
> 'correct' pmu in the cpuctx, so we can simply fold that back into the
> task context.
> 
> For normal use this is a no-op.
> 
> Now I need to go audit all ctx->pmu usage :-(
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index db4604c4c502..6a496c29ef00 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3822,9 +3822,16 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
>   					struct task_struct *task)
>   {
>   	struct perf_cpu_context *cpuctx;
> -	struct pmu *pmu = ctx->pmu;
> +	struct pmu *pmu;
>   
>   	cpuctx = __get_cpu_context(ctx);
> +
> +	/*
> +	 * HACK; for HETEROGENOUS the task context might have switched to a

%s/HETEROGENOUS/HETEROGENEOUS/

> +	 * different PMU, don't bother gating this.
> +	 */
> +	pmu = ctx->pmu = cpuctx->ctx.pmu;
> +
>   	if (cpuctx->task_ctx == ctx) {
>   		if (cpuctx->sched_cb_usage)
>   			__perf_pmu_sched_task(cpuctx, true);
> 

With the patch, the issue has gone.
We've also run a full test on ADL and SPR. There is no other issues 
found with the patch.

Tested-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
