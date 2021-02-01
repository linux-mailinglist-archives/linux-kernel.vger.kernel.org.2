Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E3930AC66
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 17:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhBAQOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 11:14:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:32389 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229607AbhBAQOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 11:14:46 -0500
IronPort-SDR: gS0b/tNUM2oP9fPqb0eVzh0QtU5G7alXN8PFztQSVn7/aFv4E+ZAquC6bua0em3ZFqGZGItPcV
 ND9JTm2OLwbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160474722"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="160474722"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 08:13:00 -0800
IronPort-SDR: 6oPmBHFebm/gP6zjcJxQPupqgsk2fO02WQEF2NnDoUIUuqOs5vCe9L6XOvx4iq2iN357Qwhmdi
 H3/I9hoK33Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="506895242"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 01 Feb 2021 08:12:58 -0800
Received: from [10.255.230.26] (kliang2-MOBL.ccr.corp.intel.com [10.255.230.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 291B858045A;
        Mon,  1 Feb 2021 08:12:57 -0800 (PST)
Subject: Re: [PATCH V3 0/5] perf core PMU support for Sapphire Rapids (Kernel)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
References: <1611873611-156687-1-git-send-email-kan.liang@linux.intel.com>
 <YBgQoWRxpyoHDsmp@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <08df0d66-ae21-6e52-cef6-c003db0b75b2@linux.intel.com>
Date:   Mon, 1 Feb 2021 11:12:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YBgQoWRxpyoHDsmp@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/2021 9:30 AM, Peter Zijlstra wrote:
> 
> I made the below changes, does that work?

Yes, it works well.

Thanks,
Kan

> 
> ---
> 
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3627,6 +3627,15 @@ static int core_pmu_hw_config(struct per
>   	return intel_pmu_bts_config(event);
>   }
>   
> +#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
> +					 ((x86_pmu.num_topdown_events - 1) << 8))
> +
> +static bool is_available_metric_event(struct perf_event *event)
> +{
> +	return is_metric_event(event) &&
> +		event->attr.config <= INTEL_TD_METRIC_AVAILABLE_MAX;
> +}
> +
>   static inline bool is_mem_loads_event(struct perf_event *event)
>   {
>   	return (event->attr.config & INTEL_ARCH_EVENT_MASK) == X86_CONFIG(.event=0xcd, .umask=0x01);
> @@ -3711,7 +3720,7 @@ static int intel_pmu_hw_config(struct pe
>   		if (event->attr.config & X86_ALL_EVENT_FLAGS)
>   			return -EINVAL;
>   
> -		if (is_metric_event(event)) {
> +		if (is_available_metric_event(event)) {
>   			struct perf_event *leader = event->group_leader;
>   
>   			/* The metric events don't support sampling. */
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -87,7 +87,14 @@ static inline bool is_topdown_count(stru
>   	return event->hw.flags & PERF_X86_EVENT_TOPDOWN;
>   }
>   
> -static inline bool is_metric_event(struct perf_event *event);
> +static inline bool is_metric_event(struct perf_event *event)
> +{
> +	u64 config = event->attr.config;
> +
> +	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
> +		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
> +		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_MAX);
> +}
>   
>   static inline bool is_slots_event(struct perf_event *event)
>   {
> @@ -901,18 +908,6 @@ static struct perf_pmu_events_ht_attr ev
>   struct pmu *x86_get_pmu(void);
>   extern struct x86_pmu x86_pmu __read_mostly;
>   
> -#define INTEL_TD_METRIC_AVAILABLE_MAX	(INTEL_TD_METRIC_RETIRING + \
> -					 ((x86_pmu.num_topdown_events - 1) << 8))
> -
> -static inline bool is_metric_event(struct perf_event *event)
> -{
> -	u64 config = event->attr.config;
> -
> -	return ((config & ARCH_PERFMON_EVENTSEL_EVENT) == 0) &&
> -		((config & INTEL_ARCH_EVENT_MASK) >= INTEL_TD_METRIC_RETIRING)  &&
> -		((config & INTEL_ARCH_EVENT_MASK) <= INTEL_TD_METRIC_AVAILABLE_MAX);
> -}
> -
>   static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
>   {
>   	if (static_cpu_has(X86_FEATURE_ARCH_LBR))
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -284,10 +284,12 @@ struct x86_pmu_capability {
>   #define INTEL_TD_METRIC_BAD_SPEC		0x8100	/* Bad speculation metric */
>   #define INTEL_TD_METRIC_FE_BOUND		0x8200	/* FE bound metric */
>   #define INTEL_TD_METRIC_BE_BOUND		0x8300	/* BE bound metric */
> -#define INTEL_TD_METRIC_HEAVY_OPS		0x8400	/* Heavy Operations metric */
> -#define INTEL_TD_METRIC_BR_MISPREDICT		0x8500	/* Branch Mispredict metric */
> -#define INTEL_TD_METRIC_FETCH_LAT		0x8600	/* Fetch Latency metric */
> -#define INTEL_TD_METRIC_MEM_BOUND		0x8700	/* Memory bound metric */
> +/* Level 2 metrics */
> +#define INTEL_TD_METRIC_HEAVY_OPS		0x8400  /* Heavy Operations metric */
> +#define INTEL_TD_METRIC_BR_MISPREDICT		0x8500  /* Branch Mispredict metric */
> +#define INTEL_TD_METRIC_FETCH_LAT		0x8600  /* Fetch Latency metric */
> +#define INTEL_TD_METRIC_MEM_BOUND		0x8700  /* Memory bound metric */
> +
>   #define INTEL_TD_METRIC_MAX			INTEL_TD_METRIC_MEM_BOUND
>   #define INTEL_TD_METRIC_NUM			8
>   
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -908,7 +908,6 @@ enum perf_event_type {
>   	 *			u32	var1_dw;
>   	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
>   	 *	#endif
> -	 *
>   	 *	 }
>   	 *	}
>   	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
> @@ -1276,29 +1275,23 @@ struct perf_branch_entry {
>   		reserved:40;
>   };
>   
> -#if defined(__LITTLE_ENDIAN_BITFIELD)
>   union perf_sample_weight {
>   	__u64		full;
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
>   	struct {
>   		__u32	var1_dw;
>   		__u16	var2_w;
>   		__u16	var3_w;
>   	};
> -};
> -
>   #elif defined(__BIG_ENDIAN_BITFIELD)
> -
> -union perf_sample_weight {
> -	__u64		full;
>   	struct {
>   		__u16	var3_w;
>   		__u16	var2_w;
>   		__u32	var1_dw;
>   	};
> -};
> -
>   #else
>   #error "Unknown endianness"
>   #endif
> +};
>   
>   #endif /* _UAPI_LINUX_PERF_EVENT_H */
> 
