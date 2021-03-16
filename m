Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DBD33CD45
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhCPF0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:26:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:57480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230372AbhCPFZe (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:25:34 -0400
IronPort-SDR: JZ7CJrH9gvmDJEKdNiTEgber5lOTJwo/Owx9nqPEbYGrHe/VJUN51VNWfJKCg8wu+lTD7Ug997
 MPDyheI54EsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="188563281"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="188563281"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 22:25:34 -0700
IronPort-SDR: v8xBohP9mDGjV+74qFjjTxJ1z2Z57FhcjKhlXXRpH5ujzi0p2s6eFvVuGHM72EE+cdLgFKXHsi
 mJhP8dH7/Hxw==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449602912"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 22:25:31 -0700
Subject: Re: [PATCH v2 16/27] perf evlist: Warn as events from different
 hybrid PMUs in a group
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-17-yao.jin@linux.intel.com> <YE/n2BW1ifH42/o6@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <020eaabf-abdb-4458-a883-2abbd4bbfbbd@linux.intel.com>
Date:   Tue, 16 Mar 2021 13:25:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE/n2BW1ifH42/o6@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/16/2021 7:03 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:31PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>>   				goto try_again;
>>   			}
>> +
>> +			if (errno == EINVAL && perf_pmu__hybrid_exist())
>> +				evlist__warn_hybrid_group(evlist);
>>   			rc = -errno;
>>   			evsel__open_strerror(pos, &opts->target, errno, msg, sizeof(msg));
>>   			ui__error("%s\n", msg);
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 7a732508b2b4..6f780a039db0 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -239,6 +239,9 @@ static void evlist__check_cpu_maps(struct evlist *evlist)
>>   	struct evsel *evsel, *pos, *leader;
>>   	char buf[1024];
>>   
>> +	if (evlist__hybrid_exist(evlist))
>> +		return;
> 
> this should be in separate patch and explained
> 

Now I have another idea. If a group consists of atom events and core events, we still follow current 
disabling group solution?

I mean removing following code:

if (evlist__hybrid_exist(evlist))
	return;

evlist__check_cpu_maps then continues running and disabling the group. But also report with a 
warning that says "WARNING: Group has events from different hybrid PMUs".

Do you like this way?

>> +
>>   	evlist__for_each_entry(evlist, evsel) {
>>   		leader = evsel->leader;
>>   
>> @@ -726,6 +729,10 @@ enum counter_recovery {
>>   static enum counter_recovery stat_handle_error(struct evsel *counter)
>>   {
>>   	char msg[BUFSIZ];
>> +
>> +	if (perf_pmu__hybrid_exist() && errno == EINVAL)
>> +		evlist__warn_hybrid_group(evsel_list);
>> +
>>   	/*
>>   	 * PPC returns ENXIO for HW counters until 2.6.37
>>   	 * (behavior changed with commit b0a873e).
>> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
>> index f139151b9433..5ec891418cdd 100644
>> --- a/tools/perf/util/evlist.c
>> +++ b/tools/perf/util/evlist.c
>> @@ -2224,3 +2224,47 @@ void evlist__invalidate_all_cpus(struct evlist *evlist)
>>   	perf_cpu_map__put(evlist->core.all_cpus);
>>   	evlist->core.all_cpus = perf_cpu_map__empty_new(1);
>>   }
>> +
>> +static bool group_hybrid_conflict(struct evsel *leader)
>> +{
>> +	struct evsel *pos, *prev = NULL;
>> +
>> +	for_each_group_evsel(pos, leader) {
>> +		if (!pos->pmu_name || !perf_pmu__is_hybrid(pos->pmu_name))
>> +			continue;
>> +
>> +		if (prev && strcmp(prev->pmu_name, pos->pmu_name))
>> +			return true;
>> +
>> +		prev = pos;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +void evlist__warn_hybrid_group(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		if (evsel__is_group_leader(evsel) &&
>> +		    evsel->core.nr_members > 1 &&
> 
> hm, could we just iterate all the members and make sure the first found
> hybrid event's pmu matches the pmu of the rest hybrid events in the list?
> 

'{cpu_core/event1/,cpu_core/event2/}','{cpu_atom/event3/,cpu_atom/event4/}'

Two or more groups need to be supported. We get the first hybrid event's pmu (cpu_core in this 
example) but it doesn't match the cpu_atom/event3/ and cpu_atom/event4/. But actually this case 
should be supported, right?

>> +		    group_hybrid_conflict(evsel)) {
>> +			WARN_ONCE(1, "WARNING: Group has events from "
>> +				     "different hybrid PMUs\n");
>> +			return;
>> +		}
>> +	}
>> +}
>> +
>> +bool evlist__hybrid_exist(struct evlist *evlist)
> 
> evlist__has_hybrid seems better
> 

Yes, agree.

Thanks
Jin Yao

> 
> jirka
> 
