Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36DA38FA02
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 07:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhEYFlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 01:41:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:48048 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhEYFl3 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 01:41:29 -0400
IronPort-SDR: PjzDN90RX/has5WXYi2NrRtiPs2TDyOTgu4HpRWAmft4lkUoKP2h1EbMiyIGMPcxKfzkHi/k2a
 BhC89Dzofb6g==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="202126755"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="202126755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 22:40:00 -0700
IronPort-SDR: Ev44/IgM1T+58J6F+93wdRRKbmcyaOlwChtxRlPWYkqpvUUaBE3GPkylGrGyvbcZXHXLYBh4nn
 lE4G+yLJRPdQ==
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="442388439"
Received: from unknown (HELO [10.239.159.33]) ([10.239.159.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 22:39:57 -0700
Subject: Re: [PATCH v1 2/5] perf tools: Support pmu name in
 perf_mem_events__name
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210520070040.710-1-yao.jin@linux.intel.com>
 <20210520070040.710-3-yao.jin@linux.intel.com> <YKvgQiJrrn/1Rh23@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <ffa9f2aa-8bd3-3604-8bd4-13bfce94bfa9@linux.intel.com>
Date:   Tue, 25 May 2021 13:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YKvgQiJrrn/1Rh23@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 5/25/2021 1:20 AM, Jiri Olsa wrote:
> On Thu, May 20, 2021 at 03:00:37PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> --- a/tools/perf/arch/x86/util/mem-events.c
>> +++ b/tools/perf/arch/x86/util/mem-events.c
>> @@ -4,10 +4,10 @@
>>   #include "mem-events.h"
>>   
>>   static char mem_loads_name[100];
>> -static bool mem_loads_name__init;
>> +static char mem_stores_name[100];
>>   
>>   #define MEM_LOADS_AUX		0x8203
>> -#define MEM_LOADS_AUX_NAME	"{cpu/mem-loads-aux/,cpu/mem-loads,ldlat=%u/pp}:S"
>> +#define MEM_LOADS_AUX_NAME     "{%s/mem-loads-aux/,%s/mem-loads,ldlat=%u/}:P"
>>   
>>   bool is_mem_loads_aux_event(struct evsel *leader)
>>   {
>> @@ -22,28 +22,34 @@ bool is_mem_loads_aux_event(struct evsel *leader)
>>   	return leader->core.attr.config == MEM_LOADS_AUX;
>>   }
>>   
>> -char *perf_mem_events__name(int i)
>> +char *perf_mem_events__name(int i, char *pmu_name)
>>   {
>>   	struct perf_mem_event *e = perf_mem_events__ptr(i);
>>   
>>   	if (!e)
>>   		return NULL;
>>   
>> -	if (i == PERF_MEM_EVENTS__LOAD) {
>> -		if (mem_loads_name__init)
>> -			return mem_loads_name;
>> -
>> -		mem_loads_name__init = true;
>> +	if (!pmu_name)
>> +		pmu_name = (char *)"cpu";
>>   
>> -		if (pmu_have_event("cpu", "mem-loads-aux")) {
>> +	if (i == PERF_MEM_EVENTS__LOAD) {
>> +		if (pmu_have_event(pmu_name, "mem-loads-aux")) {
>>   			scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> -				  MEM_LOADS_AUX_NAME, perf_mem_events__loads_ldlat);
>> +				  MEM_LOADS_AUX_NAME, pmu_name, pmu_name,
>> +				  perf_mem_events__loads_ldlat);
>>   		} else {
>>   			scnprintf(mem_loads_name, sizeof(mem_loads_name),
>> -				  e->name, perf_mem_events__loads_ldlat);
>> +				  e->name, pmu_name,
>> +				  perf_mem_events__loads_ldlat);
>>   		}
>>   		return mem_loads_name;
>>   	}
>>   
>> +	if (i == PERF_MEM_EVENTS__STORE) {
>> +		scnprintf(mem_stores_name, sizeof(mem_stores_name),
>> +			  e->name, pmu_name);
>> +		return mem_stores_name;
>> +	}
> 
> so the patch also adds mem_stores_name and removes mem_loads_name__init,
> that should be explained or more likely in separated patches
> 
> jirka
> 

I will not remove mem_loads_name__init in order to keep the original behavior for non-hybrid platform.

I can move the mem_store to a separate patch.

Thanks
Jin Yao
