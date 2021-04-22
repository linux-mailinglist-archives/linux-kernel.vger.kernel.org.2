Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995AF367745
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbhDVCNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 22:13:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:5900 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhDVCNl (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 22:13:41 -0400
IronPort-SDR: wNA4ATyRRg6im9G731KfQR9JkZRUu2KtJAt49w+1Uyn2PRoalPTgCkjEDvRufQH5tlF9ylElmb
 d/jKuKHFSwtg==
X-IronPort-AV: E=McAfee;i="6200,9189,9961"; a="192624509"
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="192624509"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 19:12:55 -0700
IronPort-SDR: LlSu5dkz4GBFUscexfF7wvE8xtRcea8gJA2lkEviyLQMex/M4h+Olg97ml9uzpsSzO+58hUtMl
 wQKu38Mi7BNQ==
X-IronPort-AV: E=Sophos;i="5.82,241,1613462400"; 
   d="scan'208";a="463785805"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 19:12:52 -0700
Subject: Re: [PATCH v4 14/25] perf stat: Add default hybrid events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
 <20210416140517.18206-15-yao.jin@linux.intel.com> <YIBvGk7qZiqMHxkt@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <59ded117-6f3c-f11f-8fe3-6b0e8f68c823@linux.intel.com>
Date:   Thu, 22 Apr 2021 10:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YIBvGk7qZiqMHxkt@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/22/2021 2:29 AM, Jiri Olsa wrote:
> On Fri, Apr 16, 2021 at 10:05:06PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
>> index 1255af4751c2..0351b99d17a7 100644
>> --- a/tools/perf/builtin-stat.c
>> +++ b/tools/perf/builtin-stat.c
>> @@ -1145,6 +1145,13 @@ static int parse_stat_cgroups(const struct option *opt,
>>   	return parse_cgroups(opt, str, unset);
>>   }
>>   
>> +static int add_default_hybrid_events(struct evlist *evlist)
>> +{
>> +	struct parse_events_error err;
>> +
>> +	return parse_events(evlist, "cycles,instructions,branches,branch-misses", &err);
>> +}
>> +
>>   static struct option stat_options[] = {
>>   	OPT_BOOLEAN('T', "transaction", &transaction_run,
>>   		    "hardware transaction statistics"),
>> @@ -1626,6 +1633,12 @@ static int add_default_attributes(void)
>>     { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_INSTRUCTIONS	},
>>     { .type = PERF_TYPE_HARDWARE, .config = PERF_COUNT_HW_BRANCH_MISSES		},
>>   
>> +};
>> +	struct perf_event_attr default_sw_attrs[] = {
>> +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_TASK_CLOCK		},
>> +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CONTEXT_SWITCHES	},
>> +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_CPU_MIGRATIONS		},
>> +  { .type = PERF_TYPE_SOFTWARE, .config = PERF_COUNT_SW_PAGE_FAULTS		},
> 
> hum, why not use default_attrs0, it's the same, no?
> 

The default_attrs0 has one more item " {.type = PERF_TYPE_HARDWARE, .config = 
PERF_COUNT_HW_CPU_CYCLES },"

So I have to only pick out the sw attrs and save them to default_sw_attrs.

>>   };
>>   
>>   /*
>> @@ -1863,6 +1876,14 @@ static int add_default_attributes(void)
>>   	}
>>   
>>   	if (!evsel_list->core.nr_entries) {
>> +		if (perf_pmu__has_hybrid()) {
>> +			if (evlist__add_default_attrs(evsel_list,
>> +						      default_sw_attrs) < 0) {
>> +				return -1;
>> +			}
>> +			return add_default_hybrid_events(evsel_list);
> 
> please do it the same way like when topdown calls parse events,
> we don't need to check for cycles, but please check result and
> display the error
> 

Something like this?

err = parse_events(evsel_list, "cycles,instructions,branches,branch-misses", &errinfo);
if (err) {
	fprintf(stderr,...);
	parse_events_print_error(&errinfo, ...);
	return -1;
}

> 
>> +		}
>> +
>>   		if (target__has_cpu(&target))
>>   			default_attrs0[0].config = PERF_COUNT_SW_CPU_CLOCK;
> 
> also you still want this change for hybrid pmus as well
> 

Yes, the default_sw_attr only uses 'PERF_COUNT_SW_TASK_CLOCK', we do need to change it to 
PERF_COUNT_SW_CPU_CLOCK for system wide.

> thanks,
> jirka
>

Thanks
Jin Yao

>>   
>> -- 
>> 2.17.1
>>
> 
