Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54336AA2A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 02:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhDZA5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 20:57:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:28421 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231247AbhDZA5n (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 20:57:43 -0400
IronPort-SDR: 7Kv9RIKl0yErwGX8AdFF9AvXHOaETu/2W9p8FYONt+yroODm4Ws66WAa+k9Xc/j8Woi9dGwb6e
 PqkG4xgB0GfA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="193078524"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="193078524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 17:56:35 -0700
IronPort-SDR: DApHfgI2vBV3XxI0T//MsIT74B93vJ/xMO9jWLh18N0TyuTywLRjvZw6VBSm9waR3bWlOlMorR
 mTpONFwDWQ/A==
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422410123"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 17:56:30 -0700
Subject: Re: [PATCH v5 12/26] perf parse-events: Support event inside hybrid
 pmu
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
 <20210423053541.12521-13-yao.jin@linux.intel.com> <YIWWISXCQl7fPUFo@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cea88d03-f3bf-d9cd-57be-ad3f45d82eb1@linux.intel.com>
Date:   Mon, 26 Apr 2021 08:56:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIWWISXCQl7fPUFo@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/26/2021 12:17 AM, Jiri Olsa wrote:
> On Fri, Apr 23, 2021 at 01:35:27PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +static int parse_events__inside_hybrid_pmu(struct parse_events_state *parse_state,
>> +					   struct list_head *list, char *name,
>> +					   struct list_head *head_config)
>> +{
>> +	struct parse_events_term *term;
>> +	int ret = -1;
>> +
>> +	if (parse_state->fake_pmu || !head_config || list_empty(head_config) ||
>> +	    !perf_pmu__is_hybrid(name)) {
>> +		return -1;
>> +	}
>> +
>> +	/*
>> +	 * More than one term in list.
>> +	 */
>> +	if (head_config->next && head_config->next->next != head_config)
>> +		return -1;
>> +
>> +	term = list_first_entry(head_config, struct parse_events_term, list);
>> +	if (term && term->config && strcmp(term->config, "event")) {
> 
> so 'event' is set only for HW events, I don't see it being for other
> types.. also should the check be !strcmp ?
> 

For some HW events, such as branch-instructions, branch-misses and other HW events which are defined 
under /sys/devices/cpu_core/events, the term->config is "event". For these events, we don't need to 
do the second parsing. So I just use 'strcmp(term->config, "event")' to avoid the second parsing.

If we check with !strcmp, the second parsing will be executed but the result after parsing should be 
empty.

> also please add some tests for cache events with pmu syntax
> 

OK, I will add new test case for that.

Thanks
Jin Yao

> jirka
> 
>> +		ret = parse_events__with_hybrid_pmu(parse_state, term->config,
>> +						    name, list);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   int parse_events_add_pmu(struct parse_events_state *parse_state,
>>   			 struct list_head *list, char *name,
>>   			 struct list_head *head_config,
>> @@ -1567,6 +1598,11 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>>   	if (pmu->default_config && get_config_chgs(pmu, head_config, &config_terms))
>>   		return -ENOMEM;
>>   
>> +	if (!parse_events__inside_hybrid_pmu(parse_state, list, name,
>> +					     head_config)) {
>> +		return 0;
>> +	}
>> +
>>   	if (!parse_state->fake_pmu && perf_pmu__config(pmu, &attr, head_config, parse_state->error)) {
>>   		struct evsel_config_term *pos, *tmp;
>>   
>> @@ -2183,6 +2219,33 @@ int parse_events_terms(struct list_head *terms, const char *str)
>>   	return ret;
>>   }
>>   
>> +static int parse_events__with_hybrid_pmu(struct parse_events_state *parse_state,
>> +					 const char *str, char *pmu_name,
>> +					 struct list_head *list)
>> +{
>> +	struct parse_events_state ps = {
>> +		.list            = LIST_HEAD_INIT(ps.list),
>> +		.stoken          = PE_START_EVENTS,
>> +		.hybrid_pmu_name = pmu_name,
>> +		.idx             = parse_state->idx,
>> +	};
>> +	int ret;
>> +
>> +	ret = parse_events__scanner(str, &ps);
>> +	perf_pmu__parse_cleanup();
>> +
>> +	if (!ret) {
>> +		if (!list_empty(&ps.list)) {
>> +			list_splice(&ps.list, list);
>> +			parse_state->idx = ps.idx;
>> +			return 0;
>> +		} else
>> +			return -1;
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
