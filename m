Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 879253D07C3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 06:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbhGUDu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 23:50:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:11313 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhGUDtm (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 23:49:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="233162580"
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="233162580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 21:30:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,257,1620716400"; 
   d="scan'208";a="501139482"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 21:30:13 -0700
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
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <598463ae-0bb0-7609-407b-4822112b2093@linux.intel.com>
Date:   Wed, 21 Jul 2021 12:30:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPaUc3iodIASdYRY@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 7/20/2021 5:16 PM, Jiri Olsa wrote:
> On Tue, Jul 20, 2021 at 03:07:02PM +0800, Jin, Yao wrote:
> 
> SNIP
> 
>>
>> OK, evlist__fix_cpus() is better, use this name in v4.
>>
>>>> +{
>>>> +	struct perf_cpu_map *cpus;
>>>> +	struct evsel *evsel, *tmp;
>>>> +	struct perf_pmu *pmu;
>>>> +	int ret, unmatched_count = 0, events_nr = 0;
>>>> +
>>>> +	if (!perf_pmu__has_hybrid() || !cpu_list)
>>>> +		return 0;
>>>> +
>>>> +	cpus = perf_cpu_map__new(cpu_list);
>>>> +	if (!cpus)
>>>> +		return -1;
>>>> +
>>>> +	evlist__for_each_entry_safe(evlist, tmp, evsel) {
>>>> +		struct perf_cpu_map *matched_cpus, *unmatched_cpus;
>>>> +		char buf1[128], buf2[128];
>>>> +
>>>> +		pmu = perf_pmu__find_hybrid_pmu(evsel->pmu_name);
>>>> +		if (!pmu)
>>>> +			continue;
>>>> +
>>>> +		ret = perf_pmu__cpus_match(pmu, cpus, &matched_cpus,
>>>> +					   &unmatched_cpus);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +
>>>> +		events_nr++;
>>>> +
>>>> +		if (matched_cpus->nr > 0 && (unmatched_cpus->nr > 0 ||
>>>> +		    matched_cpus->nr < cpus->nr ||
>>>> +		    matched_cpus->nr < pmu->cpus->nr)) {
>>>> +			perf_cpu_map__put(evsel->core.cpus);
>>>> +			perf_cpu_map__put(evsel->core.own_cpus);
>>>> +			evsel->core.cpus = perf_cpu_map__get(matched_cpus);
>>>> +			evsel->core.own_cpus = perf_cpu_map__get(matched_cpus);
>>>
>>> I'm bit confused in here.. AFAIUI there's 2 evsel objects create
>>> for hybrid 'cycles' ... should they have already proper cpus set?
>>>
>>
>> For 'cycles', yes two evsels are created automatically. One is for atom CPU
>> (e.g. 8-11), the other is for core CPU (e.g. 0-7). In this example, these 2
>> evsels have already the cpus set.
> 
> hum, so those evsels are created with pmu's cpus, right?
> 

Yes, that's right. But we also check and adjust the evsel->cpus by using user's cpu list on hybrid 
(what the evlist__use_cpu_list() does).

>>
>> While the 'cpus' here is just the user specified cpu list.
>> cpus = perf_cpu_map__new(cpu_list);
> 
> then I think they will be changed by evlist__create_maps
> with whatever user wants?
> 

No, it will not be changed by evlist__create_maps.

In evlist__create_maps(),
evlist->core.has_user_cpus = !!target->cpu_list && !target->hybrid;

It disables has_user_cpus for hybrid.

So in __perf_evlist__propagate_maps, they will not be changed by evlist->cpus.

if (!evsel->own_cpus || evlist->has_user_cpus) {
	perf_cpu_map__put(evsel->cpus);
	evsel->cpus = perf_cpu_map__get(evlist->cpus);
	
> could we just change __perf_evlist__propagate_maps to follow
> pmu's cpus?
> 

In __perf_evlist__propagate_maps, it has already followed pmu's cpus because the 
evlist->has_user_cpus is false for hybrid.

Thanks
Jin Yao

> jirka
> 
>>
>> We need to check that the cpu in 'cpus' is available on hybrid pmu or not
>> and adjust the evsel->core.cpus according the matching results.
>>
>>>> +
>>>> +			if (unmatched_cpus->nr > 0) {
>>>> +				cpu_map__snprint(matched_cpus, buf1, sizeof(buf1));
>>>> +				pr_warning("WARNING: use %s in '%s' for '%s', skip other cpus in list.\n",
>>>> +					   buf1, pmu->name, evsel->name);
>>>> +			}
>>>> +		}
>>>> +
>>>> +		if (matched_cpus->nr == 0) {
>>>> +			evlist__remove(evlist, evsel);
>>>> +			evsel__delete(evsel);
>>>> +
>>>> +			cpu_map__snprint(cpus, buf1, sizeof(buf1));
>>>> +			cpu_map__snprint(pmu->cpus, buf2, sizeof(buf2));
>>>> +			pr_warning("WARNING: %s isn't a '%s', please use a CPU list in the '%s' range (%s)\n",
>>>> +				   buf1, pmu->name, pmu->name, buf2);
>>>> +			unmatched_count++;
>>>> +		}
>>>
>>> hum, should we rather fail in here?
>>>
>>
>> perf stat -e cpu_core/cycles/,cpu_atom/instructions/ -C11
>>
>> CPU11 is atom CPU so the evsel 'cpu_core/cycles/' is failed but cpu_atom/instructions/ is OK.
>>
>> Don't we report the partially successful event?
>>
>> Thanks
>> Jin Yao
>>
>>> jirka
>>>
>>
> 
