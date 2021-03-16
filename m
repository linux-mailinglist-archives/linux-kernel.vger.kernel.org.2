Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD1C33CBB7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbhCPDNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:13:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:39088 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232057AbhCPDNI (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:13:08 -0400
IronPort-SDR: qx9jxrx5UYuEP4/oNDc3C96wpBjgCUtURs0I/dMGDYa0W2bHKFKVn2GCCYZ7760A5sCdqrwX9u
 JO7ezz7jSXEg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176322476"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176322476"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 20:13:08 -0700
IronPort-SDR: 4STfz3LBXwDNim56WUYSBVtRKmcn7YvT5xUJFpFiaO03qbgRygtQiaMqGeID6+tyN4QVTw4NWU
 hDZZgPDhjGNQ==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449577108"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 20:13:05 -0700
Subject: Re: [PATCH v2 09/27] perf parse-events: Create two hybrid hardware
 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-10-yao.jin@linux.intel.com> <YE/oIQq9XHIsKVIj@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <98f05e25-51f6-a16b-9bff-c8809c5d549e@linux.intel.com>
Date:   Tue, 16 Mar 2021 11:13:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE/oIQq9XHIsKVIj@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/16/2021 7:05 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:24PM +0800, Jin Yao wrote:
>> For hardware events, they have pre-defined configs. The kernel
>> needs to know where the event comes from (e.g. from cpu_core pmu
>> or from cpu_atom pmu). But the perf type 'PERF_TYPE_HARDWARE'
>> can't carry pmu information.
>>
>> So the kernel introduces a new type 'PERF_TYPE_HARDWARE_PMU'.
>> The new attr.config layout for PERF_TYPE_HARDWARE_PMU is:
>>
>> 0xDD000000AA
>> AA: original hardware event ID
>> DD: PMU type ID
>>
>> PMU type ID is retrieved from sysfs. For example,
>>
>>    cat /sys/devices/cpu_atom/type
>>    10
>>
>>    cat /sys/devices/cpu_core/type
>>    4
>>
>> When enabling a hybrid hardware event without specified pmu, such as,
>> 'perf stat -e cycles -a', two events are created automatically. One
>> is for atom, the other is for core.
> 
> ok I think I understand the need for this (and the following) patch
> the perf_hw_id counters could be global, so when you specify only
> event like:
> 
>     -e cycles
> 
> you want all the cycles, which on hybrid system means cycles from
> more than one pmus
> 

Yes, on hybrid system it means the cycles from two pmus. One cycle is from cpu_core pmu, another 
cycles is from cpu_atom pmu.

> SNIP
> 
>> @@ -1416,6 +1475,8 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>>   {
>>   	struct perf_event_attr attr;
>>   	LIST_HEAD(config_terms);
>> +	bool hybrid;
>> +	int ret;
>>   
>>   	memset(&attr, 0, sizeof(attr));
>>   	attr.type = type;
>> @@ -1430,6 +1491,18 @@ int parse_events_add_numeric(struct parse_events_state *parse_state,
>>   			return -ENOMEM;
>>   	}
>>   
>> +	/*
>> +	 * Skip the software dummy event.
>> +	 */
>> +	if (type != PERF_TYPE_SOFTWARE) {
>> +		if (!perf_pmu__hybrid_exist())
>> +			perf_pmu__scan(NULL);
> 
> this could be checked in the following add_hybrid_numeric call
> 

Yes, that should be OK. I will move the check in the next version.

>> +
>> +		ret = add_hybrid_numeric(parse_state, list, &attr, &hybrid);
>> +		if (hybrid)
>> +			return ret;
>> +	}
> 
> could we add this to separate object.. hybrid.c or maybe parse-events-hybrid.c,
> 
> there's already global __add_event wrapper - parse_events__add_event
> 
> 
> jirka
>

Use a new parse-events-hybrid.c, hmm, well that's OK.

Thanks
Jin Yao

>> +
>>   	return add_event(list, &parse_state->idx, &attr,
>>   			 get_config_name(head_config), &config_terms);
>>   }
>> -- 
>> 2.17.1
>>
> 
