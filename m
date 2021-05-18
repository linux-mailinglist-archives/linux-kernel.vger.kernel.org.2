Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048F33878DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245490AbhERMf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:35:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:20816 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243361AbhERMf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:35:57 -0400
IronPort-SDR: bxPziKL9AWDhvj42vcublUp5AC8URGhshO+91OMt7sfXk2EwFa14UQAmll2wBczapTQeiTBQiG
 wt4FYWbtZWOA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286231330"
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="286231330"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 05:34:39 -0700
IronPort-SDR: aCOnWlsZltYXpUzBpXiEfv+O7duSefmK7gdRkR3kM62ouyNsniHa1VI6mvKJ4k1saolwzytieL
 Cjf5LeKtb2qw==
X-IronPort-AV: E=Sophos;i="5.82,310,1613462400"; 
   d="scan'208";a="472930047"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.255.30.127]) ([10.255.30.127])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 05:34:36 -0700
Subject: Re: [PATCH v2 2/2] perf/x86/lbr: Move cpuc->lbr_xsave allocation out
 of sleeping region
To:     Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        seanjc@google.com, x86@kernel.org
References: <20210430052247.3079672-1-like.xu@linux.intel.com>
 <20210430052247.3079672-2-like.xu@linux.intel.com>
 <YKOQqT+Ktc4C2kQp@hirez.programming.kicks-ass.net>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <a9032de6-e55d-bfff-e6b5-4c79dcab30f3@linux.intel.com>
Date:   Tue, 18 May 2021 20:34:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKOQqT+Ktc4C2kQp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/18 18:02, Peter Zijlstra wrote:
> On Fri, Apr 30, 2021 at 01:22:47PM +0800, Like Xu wrote:
>> If the kernel is compiled with the CONFIG_LOCKDEP option, the conditional
>> might_sleep_if() deep in kmem_cache_alloc() will generate the following
>> trace, and potentially cause a deadlock when another LBR event is added:
> 
> ...
> 
>> One of the solution is to use GFP_ATOMIC, but it will make the code less
>> reliable under memory pressue. Let's move the memory allocation out of
>> the sleeping region and put it into the intel_pmu_hw_config(). The LBR
>> xsave buffer is a per-CPU buffer, not a per-event buffer. This buffer is
>> allocated once when initializing the LBR event.
>>
>> The disadvantage of this fix is that the cpuc->lbr_xsave memory
>> will be allocated for each cpu like the legacy ds_buffer.
>>
>> Fixes: c085fb8774 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
>> Tested-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Like Xu <like.xu@linux.intel.com>
>> ---
>> v1->v2 Changelog:
>> - Frob reserve_lbr_buffers() in intel_pmu_hw_config().
>>
>>   arch/x86/events/intel/core.c |  2 ++
>>   arch/x86/events/intel/lbr.c  | 25 +++++++++++++++++++------
>>   arch/x86/events/perf_event.h |  6 ++++++
>>   3 files changed, 27 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 456aa6ffd9a1..19027aa01f82 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3745,6 +3745,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>   
>>   			event->destroy = hw_perf_lbr_event_destroy;
>>   		}
>> +
>> +		reserve_lbr_buffers(event);
> 
> Ok, so this would actually work..
> 
>>   	}
>>   
>>   	if (event->attr.aux_output) {
> 
>> @@ -722,6 +716,25 @@ void release_lbr_buffers(void)
>>   	}
>>   }
>>   
>> +void reserve_lbr_buffers(struct perf_event *event)
>> +{
>> +	struct kmem_cache *kmem_cache;
>> +	struct cpu_hw_events *cpuc;
>> +	int cpu;
>> +
>> +	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
>> +		return;
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
>> +		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
>> +		if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
>> +			cpuc->lbr_xsave =
>> +				kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
>> +						      cpu_to_node(cpu));
> 
> (coding style fail)
> 
> But then I looked at this function, and srlsy that !precise_ip is the
> only thing you need @event for? Why do we care?

Kan once commented, we only need to alloc the buffer for the non-PEBS
event. It seems the check "(cpuc->lbr_users != cpuc->lbr_pebs_users)"
is implicitly removed.

I think we still need to check !precision_ip, right ?

> 
>> +	}
>> +}
> 
> 
> Without that silly @event dependency you can go back to the original
> form, which makes much more sense since now reserve and release are
> symmetric.
> 
> ---
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -396,10 +396,12 @@ int x86_reserve_hardware(void)
>   	if (!atomic_inc_not_zero(&pmc_refcount)) {
>   		mutex_lock(&pmc_reserve_mutex);
>   		if (atomic_read(&pmc_refcount) == 0) {
> -			if (!reserve_pmc_hardware())
> +			if (!reserve_pmc_hardware()) {
>   				err = -EBUSY;
> -			else
> +			} else {
>   				reserve_ds_buffers();
> +				reserve_lbr_buffers();
> +			}
>   		}
>   		if (!err)
>   			atomic_inc(&pmc_refcount);
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -658,7 +658,6 @@ static inline bool branch_user_callstack
>   
>   void intel_pmu_lbr_add(struct perf_event *event)
>   {
> -	struct kmem_cache *kmem_cache = event->pmu->task_ctx_cache;
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>   
>   	if (!x86_pmu.lbr_nr)
> @@ -696,11 +695,6 @@ void intel_pmu_lbr_add(struct perf_event
>   	perf_sched_cb_inc(event->ctx->pmu);
>   	if (!cpuc->lbr_users++ && !event->total_time_running)
>   		intel_pmu_lbr_reset();
> -
> -	if (static_cpu_has(X86_FEATURE_ARCH_LBR) &&
> -	    kmem_cache && !cpuc->lbr_xsave &&
> -	    (cpuc->lbr_users != cpuc->lbr_pebs_users))
> -		cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
>   }
>   
>   void release_lbr_buffers(void)
> @@ -722,6 +716,26 @@ void release_lbr_buffers(void)
>   	}
>   }
>   
> +void reserve_lbr_buffers(void)
> +{
> +	struct kmem_cache *kmem_cache;
> +	struct cpu_hw_events *cpuc;
> +	int cpu;
> +
> +	if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
> +		return;
> +
> +	for_each_possible_cpu(cpu) {
> +		cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
> +		kmem_cache = x86_get_pmu(cpu)->task_ctx_cache;
> +		if (!kmem_cache || cpuc->lbr_xsave)
> +			continue;
> +
> +		cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
> +							cpu_to_node(cpu));
> +	}
> +}
> +
>   void intel_pmu_lbr_del(struct perf_event *event)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1244,6 +1244,8 @@ void reserve_ds_buffers(void);
>   
>   void release_lbr_buffers(void);
>   
> +void reserve_lbr_buffers(void);
> +
>   extern struct event_constraint bts_constraint;
>   extern struct event_constraint vlbr_constraint;
>   
> @@ -1393,6 +1395,10 @@ static inline void release_lbr_buffers(v
>   {
>   }
>   
> +static inline void reserve_lbr_buffers(void)
> +{
> +}
> +
>   static inline int intel_pmu_init(void)
>   {
>   	return 0;
> 

