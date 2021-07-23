Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52473D3108
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 02:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhGWAIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:08:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:50093 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbhGWAIk (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:08:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="198982410"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="198982410"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 17:49:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="470881832"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 17:49:03 -0700
Subject: Re: [PATCH v3 3/3] perf tools: Enable on a list of CPUs for hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210712071235.28533-1-yao.jin@linux.intel.com>
 <20210712071235.28533-4-yao.jin@linux.intel.com> <YPXUMTFbj2Tl3eBz@krava>
 <ecf0e815-616f-0a08-cefd-baac93c0e47d@linux.intel.com>
 <YPaUc3iodIASdYRY@krava>
 <598463ae-0bb0-7609-407b-4822112b2093@linux.intel.com>
 <YPlGPC3OkPihS91A@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <57a972ea-bbe3-2baa-ab8d-9fbfe2eb4d32@linux.intel.com>
Date:   Fri, 23 Jul 2021 08:49:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPlGPC3OkPihS91A@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 7/22/2021 6:19 PM, Jiri Olsa wrote:
> On Wed, Jul 21, 2021 at 12:30:11PM +0800, Jin, Yao wrote:
>> Hi Jiri,
>>
>> On 7/20/2021 5:16 PM, Jiri Olsa wrote:
>>> On Tue, Jul 20, 2021 at 03:07:02PM +0800, Jin, Yao wrote:
>>>
>>> SNIP
>>>
>>>>
>>>> OK, evlist__fix_cpus() is better, use this name in v4.
>>>>
>>>>>> +{
>>>>>> +	struct perf_cpu_map *cpus;
>>>>>> +	struct evsel *evsel, *tmp;
>>>>>> +	struct perf_pmu *pmu;
>>>>>> +	int ret, unmatched_count = 0, events_nr = 0;
>>>>>> +
>>>>>> +	if (!perf_pmu__has_hybrid() || !cpu_list)
>>>>>> +		return 0;
>>>>>> +
>>>>>> +	cpus = perf_cpu_map__new(cpu_list);
>>>>>> +	if (!cpus)
>>>>>> +		return -1;
>>>>>> +
>>>>>> +	evlist__for_each_entry_safe(evlist, tmp, evsel) {
>>>>>> +		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
>>>>>> +		char buf1[128], buf2[128];
>>>>>> +
>>>>>> +		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
>>>>>> +		if (!pmu)
>>>>>> +			continue;
>>>>>> +
>>>>>> +		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
>>>>>> +					   &unmatched_cpus);
>>>>>> +		if (ret)
>>>>>> +			goto out;
>>>>>> +
>>>>>> +		events_nr++;
>>>>>> +
>>>>>> +		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
>>>>>> +		    matched_cpus->nr < cpus->nr ||
>>>>>> +		    matched_cpus->nr < pmu->cpus->nr)) {
>>>>>> +			perf_cpu_map__put(evsel->core.cpus);
>>>>>> +			perf_cpu_map__put(evsel->core.own_cpus);
>>>>>> +			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
>>>>>> +			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
>>>>>
>>>>> I'm bit confused in here.. AFAIUI there's 2 evsel objects create
>>>>> for hybrid 'cycles' ... should they have already proper cpus set?
>>>>>
>>>>
>>>> For 'cycles', yes two evsels are created automatically. One is for atom CPU
>>>> (e.g. 8-11), the other is for core CPU (e.g. 0-7). In this example, these 2
>>>> evsels have already the cpus set.
>>>
>>> hum, so those evsels are created with pmu's cpus, right?
>>>
>>
>> Yes, that's right. But we also check and adjust the evsel->cpus by using
>> user's cpu list on hybrid (what the evlist__use_cpu_list() does).
>>
>>>>
>>>> While the 'cpus' here is just the user specified cpu list.
>>>> cpus = perf_cpu_map__new(cpu_list);
>>>
>>> then I think they will be changed by evlist__create_maps
>>> with whatever user wants?
>>>
>>
>> No, it will not be changed by evlist__create_maps.
>>
>> In evlist__create_maps(),
>> evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;
>>
>> It disables has_user_cpus for hybrid.
>>
>> So in __perf_evlist__propagate_maps, they will not be changed by evlist->cpus.
>>
>> if (!evsel->own_cpus || evlist->has_user_cpus) {
>> 	perf_cpu_map__put(evsel->cpus);
>> 	evsel->cpus = perf_cpu_map__get(evlist->cpus);
>> 	
>>> could we just change __perf_evlist__propagate_maps to follow
>>> pmu's cpus?
>>>
>>
>> In __perf_evlist__propagate_maps, it has already followed pmu's cpus because
>> the evlist->has_user_cpus is false for hybrid.
> 
> sorry for delay
> 

Never mind. :)

> ok, so we first fix the cpus on hybrid events and then
> propagate maps.. I guess it's ok, because it's in libperf
> and that has no notion of hybrid so far
> 

Yes. If we want the libperf to be hybrid aware, the interface has to be modified but actually we 
need to avoid modifying the libperf interface. So I finally decide to adjust the evsel->cpus first 
and then propatate maps.

> could you please rename that function so it's also obvious
> it's for hybrid only
> 
>    evlist__fix_hybrid_cpus ? not sure ;-)
> 

Sure, I will rename the funciton in v4.

> and add some comment with example to explain what the
> function is doing
> 

Got it!

Thanks
Jin Yao

> thanks,
> jirka
> 
