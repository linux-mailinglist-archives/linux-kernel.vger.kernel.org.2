Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC05D3BE2C7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 07:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGGFq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 01:46:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:14139 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230160AbhGGFq6 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 01:46:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209199421"
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="209199421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 22:44:17 -0700
X-IronPort-AV: E=Sophos;i="5.83,331,1616482800"; 
   d="scan'208";a="497618791"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 22:44:15 -0700
Subject: Re: [PATCH] perf stat: Merge uncore events by default for hybrid
 platform
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210616063004.2824-1-yao.jin@linux.intel.com>
 <ac00637c-af58-6dba-67b7-95887bae3b99@linux.intel.com>
 <YOS0K0f+cAKdCHe+@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c3c1b7db-0986-0030-5d12-8e1ffe62fa37@linux.intel.com>
Date:   Wed, 7 Jul 2021 13:44:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOS0K0f+cAKdCHe+@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 7/7/2021 3:51 AM, Jiri Olsa wrote:
> On Tue, Jul 06, 2021 at 10:32:57AM +0800, Jin, Yao wrote:
>> Hi,
>>
>> On 6/16/2021 2:30 PM, Jin Yao wrote:
>>> On hybrid platform, by default stat aggregates and reports the event counts
>>> per pmu. For example,
>>>
>>>     # perf stat -e cycles -a true
>>>
>>>      Performance counter stats for 'system wide':
>>>
>>>              1,400,445      cpu_core/cycles/
>>>                680,881      cpu_atom/cycles/
>>>
>>>            0.001770773 seconds time elapsed
>>>
>>> While for uncore events, that's not a suitable method. Uncore has nothing
>>> to do with hybrid. So for uncore events, we aggregate event counts from all
>>> PMUs and report the counts without PMUs.
>>>
>>> Before:
>>>
>>>     # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true
>>>
>>>      Performance counter stats for 'system wide':
>>>
>>>                  2,058      uncore_arb_0/event=0x81,umask=0x1/
>>>                  2,028      uncore_arb_1/event=0x81,umask=0x1/
>>>                      0      uncore_arb_0/event=0x84,umask=0x1/
>>>                      0      uncore_arb_1/event=0x84,umask=0x1/
>>>
>>>            0.000614498 seconds time elapsed
>>>
>>> After:
>>>
>>>     # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ -a true
>>>
>>>      Performance counter stats for 'system wide':
>>>
>>>                  3,996      arb/event=0x81,umask=0x1/
>>>                      0      arb/event=0x84,umask=0x1/
>>>
>>>            0.000630046 seconds time elapsed
>>>
>>> Of course, we also keep the '--no-merge' still works for uncore events.
>>>
>>>     # perf stat -e arb/event=0x81,umask=0x1/,arb/event=0x84,umask=0x1/ --no-merge true
>>>
>>>      Performance counter stats for 'system wide':
>>>
>>>                  1,952      uncore_arb_0/event=0x81,umask=0x1/
>>>                  1,921      uncore_arb_1/event=0x81,umask=0x1/
>>>                      0      uncore_arb_0/event=0x84,umask=0x1/
>>>                      0      uncore_arb_1/event=0x84,umask=0x1/
>>>
>>>            0.000575536 seconds time elapsed
>>>
>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>> ---
>>>    tools/perf/builtin-stat.c      |  3 ---
>>>    tools/perf/util/stat-display.c | 29 +++++++++++++++++++++++++----
>>>    2 files changed, 25 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>>> index f9f74a514315..b67a44982b61 100644
>>> --- a/tools/perf/builtin-stat.c
>>> +++ b/tools/perf/builtin-stat.c
>>> @@ -2442,9 +2442,6 @@ int cmd_stat(int argc, const char **argv)
>>>    	evlist__check_cpu_maps(evsel_list);
>>> -	if (perf_pmu__has_hybrid())
>>> -		stat_config.no_merge = true;
>>> -
>>>    	/*
>>>    	 * Initialize thread_map with comm names,
>>>    	 * so we could print it out on output.
>>> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
>>> index b759dfd633b4..c6070f4684ca 100644
>>> --- a/tools/perf/util/stat-display.c
>>> +++ b/tools/perf/util/stat-display.c
>>> @@ -595,6 +595,19 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
>>>    	}
>>>    }
>>> +static bool is_uncore(struct evsel *evsel)
>>> +{
>>> +	struct perf_pmu *pmu;
>>> +
>>> +	if (evsel->pmu_name) {
>>> +		pmu = perf_pmu__find(evsel->pmu_name);
> 
> evsel__find_pmu might be one line shorter? ;-)
> 

Yes, this is a better method, thanks!

> 
>>> +		if (pmu)
>>> +			return pmu->is_uncore;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>>    static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>>>    			    void (*cb)(struct perf_stat_config *config, struct evsel *counter, void *data,
>>>    				       bool first),
>>> @@ -603,10 +616,18 @@ static bool collect_data(struct perf_stat_config *config, struct evsel *counter,
>>>    	if (counter->merged_stat)
>>>    		return false;
>>>    	cb(config, counter, data, true);
>>> -	if (config->no_merge)
>>> -		uniquify_event_name(counter);
>>> -	else if (counter->auto_merge_stats)
>>> -		collect_all_aliases(config, counter, cb, data);
>>> +	if (perf_pmu__has_hybrid()) {
>>> +		if (config->no_merge || !is_uncore(counter))
> 
> hum, this is all the same except for the !is_uncore condition, right?
> 
> could we just add 'config->no_merge || hybrid_uniquify(count)'
> 
> that would cover both perf_pmu__has_hybrid and !is_uncore conditions?
> 

Yes, I will create a new function 'hybrid_uniquify' to check if uniquify event name for hybrid.

Thanks
Jin Yao

> jirka
> 
>>> +			uniquify_event_name(counter);
>>> +		else if (counter->auto_merge_stats)
>>> +			collect_all_aliases(config, counter, cb, data);
>>> +	} else {
>>> +		if (config->no_merge)
>>> +			uniquify_event_name(counter);
>>> +		else if (counter->auto_merge_stats)
>>> +			collect_all_aliases(config, counter, cb, data);
>>> +	}
>>> +
>>>    	return true;
>>>    }
>>>
>>
>> Any comments for this patch? :)
>>
>> Thanks
>> Jin Yao
>>
> 
