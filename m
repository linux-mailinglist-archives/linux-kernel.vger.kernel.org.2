Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE432EC4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 14:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCENgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 08:36:47 -0500
Received: from mga01.intel.com ([192.55.52.88]:47529 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229563AbhCENgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 08:36:40 -0500
IronPort-SDR: Fa0HI0QutV6vByj1pd85qwClZJ9p3nKa3H2IUW/7zoouNzRdpcIVeZJsJEiqm8toluHXmAJXw2
 otrlTPD5c8mA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="207384215"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="207384215"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 05:36:39 -0800
IronPort-SDR: cgxSOhgEF+xYdebQ8gyNIGyu+FGObqXttEKf6HlPYpxebh/qYrX6sFjwaU9/O3muS16jQOCkWC
 wakEW9qUyknQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="401680449"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 05 Mar 2021 05:36:38 -0800
Received: from [10.254.90.138] (kliang2-MOBL.ccr.corp.intel.com [10.254.90.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 5E382580224;
        Fri,  5 Mar 2021 05:36:37 -0800 (PST)
Subject: Re: [PATCH 00/49] Add Alder Lake support for perf
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <0b447023-7c74-bc4f-5485-e03897d213da@linux.intel.com>
 <YEEdyMdzKdDKIvmp@hirez.programming.kicks-ass.net>
 <YEISfS9rDU1+FJ44@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <b6b05e33-d4c8-8a05-ff06-ec86a50d0e4a@linux.intel.com>
Date:   Fri, 5 Mar 2021 08:36:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YEISfS9rDU1+FJ44@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/5/2021 6:14 AM, Peter Zijlstra wrote:
> On Thu, Mar 04, 2021 at 06:50:00PM +0100, Peter Zijlstra wrote:
>> On Thu, Mar 04, 2021 at 10:50:45AM -0500, Liang, Kan wrote:
>>> Hi Peter,
>>>
>>> Could you please take a look at the perf kernel patches (3-25)?
>>>
>>> By now, we have got some comments regarding the generic hybrid feature
>>> enumeration code and perf tool patches. I would appreciate it very much if
>>> you could comment on the perf kernel patches.
>>>
>>
>> Yeah, I started staring at it yesterday.. I'll try and respond tomorrow.
> 
> OK, so STYLE IS HORRIBLE, please surrender your CAPS-LOCK key until
> further notice.
> 
> The below is a completely unfinished 'diff' against 3-20. It has various
> notes interspersed.
> 
> Please rework.


Thanks for the detailed comments. I will rework the code accordingly.

Thanks,
Kan

> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -44,11 +44,13 @@
>   
>   #include "perf_event.h"
>   
> +static struct pmu pmu;
> +
>   struct x86_pmu x86_pmu __read_mostly;
>   
>   DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = {
>   	.enabled = 1,
> -	.hybrid_pmu_idx = X86_NON_HYBRID_PMU,
> +	.pmu = &pmu;
>   };
>   
>   DEFINE_STATIC_KEY_FALSE(rdpmc_never_available_key);
> @@ -184,7 +186,7 @@ static inline int get_possible_num_count
>   {
>   	int bit, num_counters = 0;
>   
> -	if (!IS_X86_HYBRID)
> +	if (!is_hybrid())
>   		return x86_pmu.num_counters;
>   
>   	for_each_set_bit(bit, &x86_pmu.hybrid_pmu_bitmap, X86_HYBRID_PMU_MAX_INDEX)
> @@ -270,6 +272,9 @@ bool check_hw_exists(int num_counters, i
>   		if (ret)
>   			goto msr_fail;
>   		for (i = 0; i < num_counters_fixed; i++) {
> +			/*
> +			 * XXX comment that explains why/how NULL below works.
> +			 */
>   			if (fixed_counter_disabled(i, NULL))
>   				continue;
>   			if (val & (0x03 << i*4)) {
> @@ -352,7 +357,6 @@ set_ext_hw_attr(struct hw_perf_event *hw
>   {
>   	struct perf_event_attr *attr = &event->attr;
>   	unsigned int cache_type, cache_op, cache_result;
> -	struct x86_hybrid_pmu *pmu = IS_X86_HYBRID ? container_of(event->pmu, struct x86_hybrid_pmu, pmu) : NULL;
>   	u64 config, val;
>   
>   	config = attr->config;
> @@ -372,10 +376,7 @@ set_ext_hw_attr(struct hw_perf_event *hw
>   		return -EINVAL;
>   	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
>   
> -	if (pmu)
> -		val = pmu->hw_cache_event_ids[cache_type][cache_op][cache_result];
> -	else
> -		val = hw_cache_event_ids[cache_type][cache_op][cache_result];
> +	val = hybrid(event->pmu, hw_cache_event_ids)[cache_type][cache_op][cache_result];
>   
>   	if (val == 0)
>   		return -ENOENT;
> @@ -384,10 +385,7 @@ set_ext_hw_attr(struct hw_perf_event *hw
>   		return -EINVAL;
>   
>   	hwc->config |= val;
> -	if (pmu)
> -		attr->config1 = pmu->hw_cache_extra_regs[cache_type][cache_op][cache_result];
> -	else
> -		attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
> +	attr->config1 = hybrid(event->pmu, hw_cache_extra_regs)[cache_type][cache_op][cache_result];
>   	return x86_pmu_extra_regs(val, event);
>   }
>   
> @@ -742,13 +740,11 @@ void x86_pmu_enable_all(int added)
>   	}
>   }
>   
> -static struct pmu pmu;
> -
>   static inline int is_x86_event(struct perf_event *event)
>   {
>   	int bit;
>   
> -	if (!IS_X86_HYBRID)
> +	if (!is_hybrid())
>   		return event->pmu == &pmu;
>   
>   	for_each_set_bit(bit, &x86_pmu.hybrid_pmu_bitmap, X86_HYBRID_PMU_MAX_INDEX) {
> @@ -760,6 +756,7 @@ static inline int is_x86_event(struct pe
>   
>   struct pmu *x86_get_pmu(void)
>   {
> +	/* borken */
>   	return &pmu;
>   }
>   /*
> @@ -963,7 +960,7 @@ EXPORT_SYMBOL_GPL(perf_assign_events);
>   
>   int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
>   {
> -	int num_counters = X86_HYBRID_READ_FROM_CPUC(num_counters, cpuc);
> +	int num_counters = hybrid(cpuc->pmu, num_counters);
>   	struct event_constraint *c;
>   	struct perf_event *e;
>   	int n0, i, wmin, wmax, unsched = 0;
> @@ -1124,7 +1121,7 @@ static void del_nr_metric_event(struct c
>   static int collect_event(struct cpu_hw_events *cpuc, struct perf_event *event,
>   			 int max_count, int n)
>   {
> -	union perf_capabilities intel_cap = X86_HYBRID_READ_FROM_CPUC(intel_cap, cpuc);
> +	union perf_capabilities intel_cap = hybrid(cpuc->pmu, intel_cap);
>   
>   	if (intel_cap.perf_metrics && add_nr_metric_event(cpuc, event))
>   		return -EINVAL;
> @@ -1147,8 +1144,8 @@ static int collect_event(struct cpu_hw_e
>    */
>   static int collect_events(struct cpu_hw_events *cpuc, struct perf_event *leader, bool dogrp)
>   {
> -	int num_counters = X86_HYBRID_READ_FROM_CPUC(num_counters, cpuc);
> -	int num_counters_fixed = X86_HYBRID_READ_FROM_CPUC(num_counters_fixed, cpuc);
> +	int num_counters = hybrid(cpuc->pmu, num_counters);
> +	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
>   	struct perf_event *event;
>   	int n, max_count;
>   
> @@ -1522,9 +1519,9 @@ void perf_event_print_debug(void)
>   	u64 pebs, debugctl;
>   	int cpu = smp_processor_id();
>   	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
> -	int num_counters = X86_HYBRID_READ_FROM_CPUC(num_counters, cpuc);
> -	int num_counters_fixed = X86_HYBRID_READ_FROM_CPUC(num_counters_fixed, cpuc);
> -	struct event_constraint *pebs_constraints = X86_HYBRID_READ_FROM_CPUC(pebs_constraints, cpuc);
> +	int num_counters = hybrid(cpuc->pmu, num_counters);
> +	int num_counters_fixed = hybrid(cpuc->pmu, num_counters_fixed);
> +	struct event_constraint *pebs_constraints = hybrid(cpuc->pmu, pebs_constraints);
>   	unsigned long flags;
>   	int idx;
>   
> @@ -1605,7 +1602,7 @@ void x86_pmu_stop(struct perf_event *eve
>   static void x86_pmu_del(struct perf_event *event, int flags)
>   {
>   	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> -	union perf_capabilities intel_cap = X86_HYBRID_READ_FROM_CPUC(intel_cap, cpuc);
> +	union perf_capabilities intel_cap = hybrid(cpuc->pmu, intel_cap);
>   	int i;
>   
>   	/*
> @@ -2105,7 +2102,7 @@ static int __init init_hw_perf_events(vo
>   
>   	pmu.attr_update = x86_pmu.attr_update;
>   
> -	if (!IS_X86_HYBRID) {
> +	if (!is_hybrid()) {
>   		x86_pmu_show_pmu_cap(x86_pmu.num_counters,
>   				     x86_pmu.num_counters_fixed,
>   				     x86_pmu.intel_ctrl);
> @@ -2139,7 +2136,7 @@ static int __init init_hw_perf_events(vo
>   	if (err)
>   		goto out1;
>   
> -	if (!IS_X86_HYBRID) {
> +	if (!is_hybrid()) {
>   		err = perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
>   		if (err)
>   			goto out2;
> @@ -2303,7 +2300,11 @@ static struct cpu_hw_events *allocate_fa
>   		return ERR_PTR(-ENOMEM);
>   	cpuc->is_fake = 1;
>   
> -	if (IS_X86_HYBRID)
> +	/*
> +	 * Utterly broken, this selects a random pmu to validate on;
> +	 * it should match event->pmu.
> +	 */
> +	if (is_hybrid())
>   		cpuc->hybrid_pmu_idx = x86_hybrid_get_idx_from_cpu(cpu);
>   	else
>   		cpuc->hybrid_pmu_idx = X86_NON_HYBRID_PMU;
> @@ -2362,8 +2363,10 @@ static int validate_group(struct perf_ev
>   
>   	/*
>   	 * Reject events from different hybrid PMUs.
> +	 *
> +	 * This is just flat out buggered.
>   	 */
> -	if (IS_X86_HYBRID) {
> +	if (is_hybrid()) {
>   		struct perf_event *sibling;
>   		struct pmu *pmu = NULL;
>   
> @@ -2380,6 +2383,26 @@ static int validate_group(struct perf_ev
>   
>   		if (pmu && pmu != event->pmu)
>   			return ret;
> +
> +		/*
> +		 * Maybe something like so..
> +		 */
> +
> +		struct perf_event *sibling;
> +		struct pmu *pmu = NULL;
> +
> +		if (is_x86_event(leader))
> +			pmu = leader->pmu;
> +
> +		for_each_sibling_event(sibling, leader) {
> +			if (!is_x86_event(sibling))
> +				continue;
> +
> +			if (!pmu)
> +				pmu = sibling->pmu;
> +			else if (pmu != sibling->pmu)
> +				return ret;
> +		}
>   	}
>   
>   	fake_cpuc = allocate_fake_cpuc();
> @@ -2418,7 +2441,7 @@ static int x86_pmu_event_init(struct per
>   	    (event->attr.type != PERF_TYPE_HW_CACHE))
>   		return -ENOENT;
>   
> -	if (IS_X86_HYBRID && (event->cpu != -1)) {
> +	if (is_hybrid() && (event->cpu != -1)) {
>   		hybrid_pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
>   		if (!cpumask_test_cpu(event->cpu, &hybrid_pmu->supported_cpus))
>   			return -ENOENT;
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3168,7 +3168,7 @@ struct event_constraint *
>   x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
>   			  struct perf_event *event)
>   {
> -	struct event_constraint *event_constraints = X86_HYBRID_READ_FROM_CPUC(event_constraints, cpuc);
> +	struct event_constraint *event_constraints = hybrid(cpuc->pmu, event_constraints);
>   	struct event_constraint *c;
>   
>   	if (event_constraints) {
> @@ -3180,10 +3180,10 @@ x86_get_event_constraints(struct cpu_hw_
>   		}
>   	}
>   
> -	if (!HAS_VALID_HYBRID_PMU_IN_CPUC(cpuc))
> +	if (!is_hybrid() || !cpuc->pmu)
>   		return &unconstrained;
>   
> -	return &x86_pmu.hybrid_pmu[cpuc->hybrid_pmu_idx].unconstrained;
> +	return hybrid_pmu(cpuc->pmu)->unconstrained;
>   }
>   
>   static struct event_constraint *
> @@ -3691,7 +3691,7 @@ static inline bool intel_pmu_has_cap(str
>   {
>   	struct x86_hybrid_pmu *pmu;
>   
> -	if (!IS_X86_HYBRID)
> +	if (!is_hybrid())
>   		return test_bit(idx, (unsigned long *)&x86_pmu.intel_cap.capabilities);
>   
>   	pmu = container_of(event->pmu, struct x86_hybrid_pmu, pmu);
> @@ -4224,7 +4224,7 @@ int intel_cpuc_prepare(struct cpu_hw_eve
>   {
>   	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
>   
> -	if (IS_X86_HYBRID || x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
> +	if (is_hybrid() || x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
>   		cpuc->shared_regs = allocate_shared_regs(cpu);
>   		if (!cpuc->shared_regs)
>   			goto err;
> @@ -4377,8 +4377,8 @@ static void init_hybrid_pmu(int cpu)
>   	if (!test_bit(idx, &x86_pmu.hybrid_pmu_bitmap))
>   		return;
>   
> -	cpuc->hybrid_pmu_idx = idx;
>   	pmu = &x86_pmu.hybrid_pmu[idx];
> +	cpuc->pmu = &pmu.pmu;
>   
>   	/* Only register PMU for the first CPU */
>   	if (!cpumask_empty(&pmu->supported_cpus)) {
> @@ -4451,7 +4451,7 @@ static void intel_pmu_cpu_starting(int c
>   	int core_id = topology_core_id(cpu);
>   	int i;
>   
> -	if (IS_X86_HYBRID)
> +	if (is_hybrid())
>   		init_hybrid_pmu(cpu);
>   
>   	init_debug_store_on_cpu(cpu);
> @@ -4480,7 +4480,7 @@ static void intel_pmu_cpu_starting(int c
>   	 * feature for now. The corresponding bit should always be 0 on
>   	 * a hybrid platform, e.g., Alder Lake.
>   	 */
> -	if (!IS_X86_HYBRID && x86_pmu.intel_cap.perf_metrics) {
> +	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics) {
>   		union perf_capabilities perf_cap;
>   
>   		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
> @@ -4569,7 +4569,7 @@ static void intel_pmu_cpu_dead(int cpu)
>   {
>   	intel_cpuc_finish(&per_cpu(cpu_hw_events, cpu));
>   
> -	if (IS_X86_HYBRID) {
> +	if (is_hybrid()) {
>   		struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
>   		int idx = x86_hybrid_get_idx_from_cpu(cpu);
>   		struct x86_hybrid_pmu *hybrid_pmu;
> @@ -4579,7 +4579,7 @@ static void intel_pmu_cpu_dead(int cpu)
>   
>   		hybrid_pmu = &x86_pmu.hybrid_pmu[idx];
>   		cpumask_clear_cpu(cpu, &hybrid_pmu->supported_cpus);
> -		cpuc->hybrid_pmu_idx = X86_NON_HYBRID_PMU;
> +		cpuc->pmu = NULL;
>   		if (cpumask_empty(&hybrid_pmu->supported_cpus)) {
>   			perf_pmu_unregister(&hybrid_pmu->pmu);
>   			hybrid_pmu->pmu.type = -1;
> @@ -6217,7 +6217,7 @@ __init int intel_pmu_init(void)
>   
>   	snprintf(pmu_name_str, sizeof(pmu_name_str), "%s", name);
>   
> -	if (!IS_X86_HYBRID) {
> +	if (!is_hybrid()) {
>   		group_events_td.attrs  = td_attr;
>   		group_events_mem.attrs = mem_attr;
>   		group_events_tsx.attrs = tsx_attr;
> @@ -6273,7 +6273,7 @@ __init int intel_pmu_init(void)
>   		pr_cont("full-width counters, ");
>   	}
>   
> -	if (!IS_X86_HYBRID && x86_pmu.intel_cap.perf_metrics)
> +	if (!is_hybrid() && x86_pmu.intel_cap.perf_metrics)
>   		x86_pmu.intel_ctrl |= 1ULL << GLOBAL_CTRL_EN_PERF_METRICS;
>   
>   	return 0;
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2217,7 +2217,7 @@ void __init intel_ds_init(void)
>   			}
>   			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
>   
> -			if (!IS_X86_HYBRID && x86_pmu.intel_cap.pebs_output_pt_available) {
> +			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
>   				pr_cont("PEBS-via-PT, ");
>   				x86_get_pmu()->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
>   			}
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -331,7 +331,7 @@ struct cpu_hw_events {
>   	/*
>   	 * Hybrid PMU support
>   	 */
> -	int			        hybrid_pmu_idx;
> +	struct pmu			*pmu;
>   };
>   
>   #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
> @@ -671,21 +671,30 @@ struct x86_hybrid_pmu {
>   	struct extra_reg		*extra_regs;
>   };
>   
> -#define IS_X86_HYBRID			cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)
> -
> -#define HAS_VALID_HYBRID_PMU_IN_CPUC(_cpuc)				\
> -	(IS_X86_HYBRID &&						\
> -	 ((_cpuc)->hybrid_pmu_idx >= X86_HYBRID_PMU_ATOM_IDX) &&	\
> -	 ((_cpuc)->hybrid_pmu_idx < X86_HYBRID_PMU_MAX_INDEX))
> +static __always_inline bool is_hybrid(void)
> +{
> +	return unlikely(cpu_feature_enabled(X86_FEATURE_HYBRID_CPU));
> +}
>   
> -#define X86_HYBRID_READ_FROM_CPUC(_name, _cpuc)				\
> -	(_cpuc && HAS_VALID_HYBRID_PMU_IN_CPUC(_cpuc) ? x86_pmu.hybrid_pmu[(_cpuc)->hybrid_pmu_idx]._name : x86_pmu._name)
> +static __always_inline bool is_hybrid_idx(int idx)
> +{
> +	return (unsigned)idx < X86_HYBRID_PMU_MAX_INDEX;
> +}
>   
> -#define X86_HYBRID_READ_FROM_EVENT(_name, _event)			\
> -	(IS_X86_HYBRID ? ((struct x86_hybrid_pmu *)(_event->pmu))->_name : x86_pmu._name)
> +static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *)
> +{
> +	return container_of(pmu, struct x86_hybrid_pmu, pmu);
> +}
>   
> -#define IS_VALID_HYBRID_PMU_IDX(idx)					\
> -	(idx < X86_HYBRID_PMU_MAX_INDEX && idx > X86_NON_HYBRID_PMU)
> +#define hybrid(_pmu, _field)						\
> +({									\
> +	typeof(x86_pmu._field) __F = x86_pmu._field;			\
> +									\
> +	if (is_hybrid() && (_pmu))					\
> +		__F = hybrid_pmu(_pmu)->_field;				\
> +									\
> +	__F;								\
> +})
>   
>   static inline enum x86_hybrid_pmu_type_idx
>   x86_hybrid_get_idx_from_cpu(unsigned int cpu)
> @@ -898,9 +907,12 @@ struct x86_pmu {
>   	 * for all PMUs. The hybrid_pmu only includes the unique capabilities.
>   	 * The hybrid_pmu_bitmap is the bits map of the possible hybrid_pmu.
>   	 */
> +	int				(*filter_match)(struct perf_event *event);
>   	unsigned long			hybrid_pmu_bitmap;
> +	/*
> +	 * This thing is huge, use dynamic allocation!
> +	 */
>   	struct x86_hybrid_pmu		hybrid_pmu[X86_HYBRID_PMU_MAX_INDEX];
> -	int				(*filter_match)(struct perf_event *event);
>   };
>   
>   struct x86_perf_task_context_opt {
> 
