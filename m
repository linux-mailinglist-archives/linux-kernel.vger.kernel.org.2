Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C51360A98
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbhDONgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:36:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:30295 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhDONgr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:36:47 -0400
IronPort-SDR: ps3eTn9jAw5tEUXGNMXxNj7Ie61vCeVyNSryQDH3DYSVLyxwVzdVWvwpI/4JhQ+3ARMGQDaII1
 EGmM+03UNo8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="181976419"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="181976419"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:36:23 -0700
IronPort-SDR: Lf3dW9/B2M33M08dE48gG0BmC45xypo3WcA1eocXH2Kb2qExm1w0uEdvtBwM7naRFdWzQcemHW
 nyDAZ/+J96Zw==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="425179108"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.171.192]) ([10.249.171.192])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 06:36:19 -0700
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com> <YHgdixeqOu2NarkC@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <132fc848-7252-0d7f-4a5f-020e8f79012e@linux.intel.com>
Date:   Thu, 15 Apr 2021 21:36:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YHgdixeqOu2NarkC@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/15/2021 7:03 PM, Jiri Olsa wrote:
> On Mon, Mar 29, 2021 at 03:00:31PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> ---
>> v3:
>>   - Rename the patch:
>>     'perf parse-events: Support hardware events inside PMU' -->
>>     'perf parse-events: Support no alias assigned event inside hybrid PMU'
>>
>>   - Major code is moved to parse-events-hybrid.c.
>>   - Refine the code.
>>
>>   tools/perf/util/parse-events-hybrid.c | 18 +++++-
>>   tools/perf/util/parse-events-hybrid.h |  3 +-
>>   tools/perf/util/parse-events.c        | 80 +++++++++++++++++++++++++--
>>   tools/perf/util/parse-events.h        |  4 +-
>>   tools/perf/util/parse-events.y        |  9 ++-
>>   tools/perf/util/pmu.c                 |  4 +-
>>   tools/perf/util/pmu.h                 |  2 +-
>>   7 files changed, 108 insertions(+), 12 deletions(-)
> 
> please move the support to pass pmu_name and filter
> on it within hybrid code in to separate patch
> 

OK.

>>
>> diff --git a/tools/perf/util/parse-events-hybrid.c b/tools/perf/util/parse-events-hybrid.c
>> index 8a630cbab8f3..5bf176b55573 100644
>> --- a/tools/perf/util/parse-events-hybrid.c
>> +++ b/tools/perf/util/parse-events-hybrid.c
>> @@ -64,6 +64,11 @@ static int add_hw_hybrid(struct parse_events_state *parse_state,
>>   	int ret;
>>   
>>   	perf_pmu__for_each_hybrid_pmu(pmu) {
>> +		if (parse_state->pmu_name &&
>> +		    strcmp(parse_state->pmu_name, pmu->name)) {
>> +			continue;
> 
> please add this check to separate function
> 
> 	if (pmu_cmp(parse_stat))
> 		continue;
> 

OK.

> SNIP
> 
>> +	if (!parse_state->fake_pmu && head_config && !found &&
>> +	    perf_pmu__is_hybrid(name)) {
>> +		struct parse_events_term *term;
>> +		int ret;
>> +
>> +		list_for_each_entry(term, head_config, list) {
>> +			if (!term->config)
>> +				continue;
>> +
>> +			ret = parse_events__with_hybrid_pmu(parse_state,
>> +							    term->config,
>> +							    name, &found,
>> +							    list);
>> +			if (found)
>> +				return ret;
> 
> what if there are more terms in head_config?
> should we make sure there's just one term and fail if there's more?
> 

Yes, it should have only one term in head_config.

Now I change the code to:

+       if (!parse_state->fake_pmu && head_config && !found &&
+           perf_pmu__is_hybrid(name)) {
+               struct parse_events_term *term;
+
+               term = list_first_entry(head_config, struct parse_events_term,
+                                       list);
+               if (term->config) {
+                       return parse_events__with_hybrid_pmu(parse_state,
+                                                            term->config,
+                                                            name, list);
+               }
+       }

> also we already know the perf_pmu__is_hybrid(name) is true,
> so can't we just call:
> 
>    return parse_events__with_hybrid_pmu(....)
> 
> 

Yes, we can direct return parse_events__with_hybrid_pmu().

>> +		}
>> +	}
>>   
>>   	if (verbose > 1) {
>>   		fprintf(stderr, "After aliases, add event pmu '%s' with '",
>> @@ -1605,6 +1630,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>>   	struct perf_pmu *pmu = NULL;
>>   	int ok = 0;
>>   
>> +	if (parse_state->pmu_name) {
>> +		list = malloc(sizeof(struct list_head));
>> +		if (!list)
>> +			return -1;
>> +		INIT_LIST_HEAD(list);
>> +		*listp = list;
>> +		return 0;
>> +	}
> 
> hum, why is this needed?
>

Hmm, it's not necessary in new code, sorry about that.

>> +
>>   	*listp = NULL;
>>   	/* Add it for all PMUs that support the alias */
>>   	list = malloc(sizeof(struct list_head));
>> @@ -2176,6 +2210,44 @@ int parse_events_terms(struct list_head *terms, const char *str)
>>   	return ret;
>>   }
>>   
>> +static int list_entries_nr(struct list_head *list)
>> +{
>> +	struct list_head *pos;
>> +	int n = 0;
>> +
>> +	list_for_each(pos, list)
>> +		n++;
>> +
>> +	return n;
>> +}
>> +
>> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>> +					 const char *str, char *pmu_name,
>> +					 bool *found, struct list_head *list)
>> +{
>> +	struct parse_events_state ps = {
>> +		.list           = LIST_HEAD_INIT(ps.list),
>> +		.stoken         = PE_START_EVENTS,
>> +		.pmu_name       = pmu_name,
>> +		.idx            = parse_state->idx,
>> +	};
> 
> could we add this pmu_name directly to __parse_events?
> 

Do you suggest we directly call __parse_events()?

int __parse_events(struct evlist *evlist, const char *str,
		   struct parse_events_error *err, struct perf_pmu *fake_pmu)

	struct parse_events_state parse_state = {
		.list	  = LIST_HEAD_INIT(parse_state.list),
		.idx	  = evlist->core.nr_entries,
		.error	  = err,
		.evlist	  = evlist,
		.stoken	  = PE_START_EVENTS,
		.fake_pmu = fake_pmu,
	};

But for parse_events__with_hybrid_pmu, we don't have valid evlist. So if we switch to 
__parse_events, evlist processing may be a problem.

So could we still keep current parse_events__with_hybrid_pmu()?

> it duplicates the code plus there are some extra checks
> you don't do in here and which might be needed, like
> last->cmdline_group_boundary setup
> 
>> +	int ret;
>> +
>> +	*found = false;
>> +	ret = parse_events__scanner(str, &ps);
>> +	perf_pmu__parse_cleanup();
>> +
>> +	if (!ret) {
>> +		if (!list_empty(&ps.list)) {
>> +			*found = true;
>> +			list_splice(&ps.list, list);
>> +			parse_state->idx = list_entries_nr(list);
> 
> could you just use ps.idx instead of list_entries_nr ?
> 

Yes, the code will be changed to:

+
+       if (!ret) {
+               if (!list_empty(&ps.list)) {
+                       list_splice(&ps.list, list);
+                       parse_state->idx = ps.idx;
+               }
+       }

>> +		}
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   int __parse_events(struct evlist *evlist, const char *str,
>>   		   struct parse_events_error *err, struct perf_pmu *fake_pmu)
>>   {
>> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
>> index c4f2f96304ce..f9d8e8e41c38 100644
>> --- a/tools/perf/util/parse-events.h
>> +++ b/tools/perf/util/parse-events.h
>> @@ -138,6 +138,7 @@ struct parse_events_state {
>>   	struct list_head	  *terms;
>>   	int			   stoken;
>>   	struct perf_pmu		  *fake_pmu;
>> +	char			  *pmu_name;
> 
> so it's hybrid specific, we should name it like hybrid_pmu_name or such
>

OK, I will use hybrid_pmu_name in next version.

Thanks
Jin Yao

> thanks,
> jirka
> 
