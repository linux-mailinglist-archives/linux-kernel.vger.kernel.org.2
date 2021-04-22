Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE83676EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhDVBpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 21:45:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:62597 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhDVBpB (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 21:45:01 -0400
IronPort-SDR: cfVMGwM4nc4aKF9UhInQk1IcGrN3WgS4vpDvuwbK5StqdsDt+P3/Ai0RQT2PQX1TSRxeQ3pL+L
 Mfn6jGG5xCAA==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="182940448"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="182940448"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 18:44:15 -0700
IronPort-SDR: bvbdtRftvl8OC51s90191WP3AuJtB49iN0Wg0usrjFG73NZagShNH5VVYUoOgKzZ46b/jFN11r
 T8aKFJ3qspFA==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="463778709"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 18:44:11 -0700
Subject: Re: [PATCH v4 12/25] perf parse-events: Support event inside hybrid
 pmu
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-13-yao.jin@linux.intel.com> <YIBvB8J6uJhIPBXz@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e258112b-0f1f-9b04-8eea-4c1da8d21953@linux.intel.com>
Date:   Thu, 22 Apr 2021 09:44:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBvB8J6uJhIPBXz@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:04PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> ---
>> v4:
>>   - New in v4.
>>
>>   tools/perf/util/parse-events.c | 55 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 55 insertions(+)
>>
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index f69475a158bb..bd3fd722b4ac 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -38,6 +38,7 @@
>>   #include "util/event.h"
>>   #include "util/pfm.h"
>>   #include "util/parse-events-hybrid.h"
>> +#include "util/pmu-hybrid.h"
>>   #include "perf.h"
>>   
>>   #define MAX_NAME_LEN 100
>> @@ -48,6 +49,9 @@ extern int parse_events_debug;
>>   int parse_events_parse(void *parse_state, void *scanner);
>>   static int get_config_terms(struct list_head *head_config,
>>   			    struct list_head *head_terms __maybe_unused);
>> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>> +					 const char *str, char *pmu_name,
>> +					 struct list_head *list, bool *parsed);
>>   
>>   static struct perf_pmu_event_symbol *perf_pmu_events_list;
>>   /*
>> @@ -1567,6 +1571,27 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>>   	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
>>   		return -ENOMEM;
>>   
>> +	if (!parse_state->fake_pmu && head_config &&
>> +	    perf_pmu__is_hybrid(name)) {
>> +		struct parse_events_term *term;
>> +		bool parsed;
>> +		int ret;
>> +
>> +		term = list_first_entry(head_config, struct parse_events_term,
>> +					list);
> 
> you need to test that there's something in the head_config first,
> and I thought you wanted to check that there's just 1 term, right?
> (you could check the next pointer == head_config)
> 

Yes, agree, we need to check the head_config has only one term first. Otherwise we don't need to do 
the second parsing.

> also please move this to separated function
>

OK.

>> +		if (term && term->config && strcmp(term->config, "event")) {
>> +			ret = parse_events__with_hybrid_pmu(parse_state,
>> +							    term->config, name,
>> +							    list, &parsed);
>> +			/*
>> +			 * If the string inside the pmu can't be parsed,
>> +			 * don't return, try next steps.
>> +			 */
>> +			if (parsed)
>> +				return ret;
> 
> so if the function fails we ignore the return value,
> because parsed is set only for ret == 0, so I think we
> don't need 'parsed' param and we could make parse_events__with_hybrid_pmu
> return 0 when we found some event and let it go through otherwise
> 

That makes sense. We let the parse_events__with_hybrid_pmu just returns 0 when we can find some 
events in second parsing. If there are no events parsed or something error occurs, 
parse_events__with_hybrid_pmu returns error value then we can go through other cases.

> 
>> +		}
>> +	}
>> +
>>   	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
>>   		struct evsel_config_term *pos, *tmp;
>>   
>> @@ -1585,6 +1610,9 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>>   	if (!evsel)
>>   		return -ENOMEM;
>>   
>> +	if (evsel->name)
>> +		evsel->use_config_name = true;
> 
> should this go to:
>   perf stat: Uniquify hybrid event name
> ?
> 

OK, I will move this to patch "perf stat: Uniquify hybrid event name".

> thanks,
> jirka
>

Thanks
Jin Yao

>> +
>>   	evsel->pmu_name = name ? strdup(name) : NULL;
>>   	evsel->use_uncore_alias = use_uncore_alias;
>>   	evsel->percore = config_term_percore(&evsel->config_terms);
>> @@ -2180,6 +2208,33 @@ int parse_events_terms(struct list_head *terms, const char *str)
>>   	return ret;
>>   }
>>   
>> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>> +					 const char *str, char *pmu_name,
>> +					 struct list_head *list, bool *parsed)
>> +{
>> +	struct parse_events_state ps = {
>> +		.list            = LIST_HEAD_INIT(ps.list),
>> +		.stoken          = PE_START_EVENTS,
>> +		.hybrid_pmu_name = pmu_name,
>> +		.idx             = parse_state->idx,
>> +	};
>> +	int ret;
>> +
>> +	*parsed = false;
>> +	ret = parse_events__scanner(str, &ps);
>> +	perf_pmu__parse_cleanup();
>> +
>> +	if (!ret) {
>> +		if (!list_empty(&ps.list)) {
>> +			*parsed = true;
>> +			list_splice(&ps.list, list);
>> +			parse_state->idx = ps.idx;
>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   int __parse_events(struct evlist *evlist, const char *str,
>>   		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
>>   {
>> -- 
>> 2.17.1
>>
> 
