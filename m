Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9F35B8BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 04:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhDLCvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 22:51:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:54346 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235857AbhDLCvg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 22:51:36 -0400
IronPort-SDR: DjR71hettRPXoM57B1cOffCUNZ4nfqc/EPGbs4efi+Y4SevNI6AVI8D7M0TU0PPh/u4Etfl6rU
 H10/iiyfJjbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="174190754"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="174190754"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 19:51:19 -0700
IronPort-SDR: GRFJcbk+aJAEyDZy2iIe5wijQ2p8mXtxLTEXRoriaYAJdsEAsikUG8sRKvs6sxjLKoQOhk5FOn
 e97tNrJKF4Ag==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="451243351"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 19:51:16 -0700
Subject: Re: [PATCH v3 12/27] perf parse-events: Support no alias assigned
 event inside hybrid PMU
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-13-yao.jin@linux.intel.com> <YHBa15BWne4zgv/A@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6a7ba97c-29e7-bc4d-57aa-18bc92af9738@linux.intel.com>
Date:   Mon, 12 Apr 2021 10:51:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHBa15BWne4zgv/A@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/9/2021 9:47 PM, Jiri Olsa wrote:
> On Mon, Mar 29, 2021 at 03:00:31PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +			   struct parse_events_state *parse_state)
>>   {
>>   	struct perf_event_attr attr;
>>   	LIST_HEAD(config_terms);
>> @@ -521,7 +526,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>>   
>>   	i = parse_events__add_cache_hybrid(list, idx, &attr,
>>   					   config_name ? : name, &config_terms,
>> -					   &hybrid);
>> +					   &hybrid, parse_state);
>>   	if (hybrid)
>>   		return i;
>>   
>> @@ -1481,7 +1486,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>>   	struct perf_pmu *pmu;
>>   	struct evsel *evsel;
>>   	struct parse_events_error *err = parse_state->error;
>> -	bool use_uncore_alias;
>> +	bool use_uncore_alias, found = false;
>>   	LIST_HEAD(config_terms);
>>   
>>   	if (verbose > 1) {
>> @@ -1530,8 +1535,28 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>>   		}
>>   	}
>>   
>> -	if (!parse_state->fake_pmu && perf_pmu__check_alias(pmu, head_config, &info))
>> +	if (!parse_state->fake_pmu &&
>> +	    perf_pmu__check_alias(pmu, head_config, &info, &found)) {
>>   		return -EINVAL;
>> +	}
>> +
> 
> ok, let's not polute surronding functions and make strict check
> on what we want in here.. we are after following events:
> 
> 	cpu_xxx/L1-dcache/
> 	cpu_xxx/l1-d|/
>          ...
> right?
> 

Yes, we only focus on the cache events now.

> so we are after events with single term in head_config that has name in:
> 
> 	L1-dcache|l1-d|l1d|L1-data              |
> 	L1-icache|l1-i|l1i|L1-instruction       |
> 	LLC|L2                                  |
> 	dTLB|d-tlb|Data-TLB                     |
> 	iTLB|i-tlb|Instruction-TLB              |
> 	branch|branches|bpu|btb|bpc             |
> 	node
> 
> I think that with such direct check the code will be more straight
> forward, also let's move it to parse-events-hybrid
> 

Do you suggest we just use string comparison for doing the direct check?

e.g.

if (strstr(term->config, "L1-dcache"))
	...

Of course, we can define a string array first and use a loop for string comparison.

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
> 
> do we need to call the parsing again? could we just call
> parse_events__add_cache_hybrid?
> 
> jirka
> 
> 

If we do the direct check for cache events, I think we don't need the parsing again.

As I mentioned above, we need to define a string array and compare with term->config one by one.

I'm OK for this solution. :)

Thanks
Jin Yao

>> +			if (found)
>> +				return ret;
>> +		}
>> +	}
>>   
>>   	if (verbose > 1) {
>>   		fprintf(stderr, "After aliases, add event pmu '%s' with '",
>> @@ -1605,6 +1630,15 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>>   	struct perf_pmu *pmu = NULL;
>>   	int ok = 0;
>>   
> 
> SNIP
> 
