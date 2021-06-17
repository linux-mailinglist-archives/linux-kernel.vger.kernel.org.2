Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11003AB58E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFQOMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:12:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:53106 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhFQOMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:12:48 -0400
IronPort-SDR: kO+L9xwhs8edk87ylEp0sham0dHzj6L3XeYxQRe4h0JCfxqVgf/eVjviL7KjNeKtuYNiL3rn9j
 bOKRHnEbu8Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="203351117"
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="203351117"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 07:10:40 -0700
IronPort-SDR: qa0ct736u3CBtXZhy/CS/dkj7KpmyKejvgyZOgd37JpSRXwZdJyFf8O1UrdLkJBJ6li9tjDM0d
 NXH5Uvkv0SFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,280,1616482800"; 
   d="scan'208";a="404654939"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Jun 2021 07:10:40 -0700
Received: from [10.212.234.139] (kliang2-MOBL.ccr.corp.intel.com [10.212.234.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 22C175808A3;
        Thu, 17 Jun 2021 07:10:39 -0700 (PDT)
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
Message-ID: <3d4b9377-30b0-a945-7b11-b412dcc4c51a@linux.intel.com>
Date:   Thu, 17 Jun 2021 10:10:37 -0400
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
>> when you started this whole hybrid crud

Yes, to work around the hybrid, I updated the PMU for the CPU context 
accordingly, but not the task context. :( This issue is found in a 
stress test that was not ready at that time. Sorry for that.

>>, and I think that's still the
>> correct thing to do.
>> >> Still, let me consider if there's a workable short-term cludge I hate
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
> +	 * different PMU, don't bother gating this.
> +	 */
> +	pmu = ctx->pmu = cpuctx->ctx.pmu;
> +

I think all the perf_sw_context PMUs share the same pmu_cpu_context. so 
the cpuctx->ctx.pmu should be always the first registered 
perf_sw_context PMU which is perf_swevent. The ctx->pmu could be another 
software PMU.

In theory, the perf_sw_context PMUs should have a similar issue. If the 
events are from different perf_sw_context PMUs, we should 
perf_pmu_disable() all of the PMUs before schedule them, but the 
ctx->pmu only tracks the first one.

I don't have a good way to fix the perf_sw_context PMUs. I think we have 
to go through the event list and find all PMUs. But I don't think it's 
worth doing.

Maybe we should only apply the change for the hybrid PMUs, and leave 
other PMUs as is.

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6fee4a7..df9cce6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3821,9 +3821,19 @@ static void perf_event_context_sched_in(struct 
perf_event_context *ctx,
  					struct task_struct *task)
  {
  	struct perf_cpu_context *cpuctx;
-	struct pmu *pmu = ctx->pmu;
+	struct pmu *pmu;

  	cpuctx = __get_cpu_context(ctx);
+
+	if (ctx->pmu->capabilities & PERF_PMU_CAP_HETEROGENEOUS_CPUS) {
+		/*
+		 * HACK; for HETEROGENOUS the task context might have switched to a
+		 * different PMU, don't bother gating this.
+		 */
+		pmu = ctx->pmu = cpuctx->ctx.pmu;
+	} else
+		pmu = ctx->pmu;
+
  	if (cpuctx->task_ctx == ctx) {
  		if (cpuctx->sched_cb_usage)
  			__perf_pmu_sched_task(cpuctx, true);



Thanks,
Kan
