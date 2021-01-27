Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059A23066E2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 22:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhA0V6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 16:58:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:13062 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232221AbhA0V6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 16:58:04 -0500
IronPort-SDR: w+r22T7vHqyk4n2BDJgW1QvId/kEBi+JsOh7az8q/f7USqqEiE58dt/L6H9zqbf7qOQ9UDEa5H
 J/TWECtFjDkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159311789"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="159311789"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:54:40 -0800
IronPort-SDR: YL+xoGecSr73XFMCkkETkA/IIqPw2iXLnJH6sr/UWk3+FbipPu2U+pQUHrEaHIqtolbCmG8Gin
 prsIqJruETsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="357204495"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2021 13:54:39 -0800
Received: from [10.251.8.120] (kliang2-MOBL.ccr.corp.intel.com [10.251.8.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 07FD6580342;
        Wed, 27 Jan 2021 13:54:37 -0800 (PST)
Subject: Re: [PATCH V2 1/5] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com
References: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
 <1611761925-159055-2-git-send-email-kan.liang@linux.intel.com>
 <YBG5F2rCbsto+Y9F@hirez.programming.kicks-ass.net>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <f0aedd45-d03c-789c-bcfa-727f4ff452ef@linux.intel.com>
Date:   Wed, 27 Jan 2021 16:54:36 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YBG5F2rCbsto+Y9F@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/2021 2:03 PM, Peter Zijlstra wrote:
> On Wed, Jan 27, 2021 at 07:38:41AM -0800, kan.liang@linux.intel.com wrote:
>> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> index b15e344..13b4019 100644
>> --- a/include/uapi/linux/perf_event.h
>> +++ b/include/uapi/linux/perf_event.h
>> @@ -145,12 +145,14 @@ enum perf_event_sample_format {
>>   	PERF_SAMPLE_CGROUP			= 1U << 21,
>>   	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
>>   	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
>> +	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
>>   
>> -	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
>> +	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
>>   
>>   	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>>   };
>>   
>> +#define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
>>   /*
>>    * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
>>    *
>> @@ -890,7 +892,16 @@ enum perf_event_type {
>>   	 * 	  char			data[size];
>>   	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
>>   	 *
>> -	 *	{ u64			weight;   } && PERF_SAMPLE_WEIGHT
>> +	 *	{ union perf_sample_weight
>> +	 *	 {
>> +	 *		u64		full; && PERF_SAMPLE_WEIGHT
>> +	 *		struct {
>> +	 *			u32	low_dword;
>> +	 *			u16	high_word;
>> +	 *			u16	higher_word;
>> +	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
>> +	 *	 }
>> +	 *	}
>>   	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
>>   	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
>>   	 *	{ u64			abi; # enum perf_sample_regs_abi
>> @@ -1248,4 +1259,13 @@ struct perf_branch_entry {
>>   		reserved:40;
>>   };
>>   
>> +union perf_sample_weight {
>> +	__u64		full;
>> +	struct {
>> +		__u32	low_dword;
>> +		__u16	high_word;
>> +		__u16	higher_word;
>> +	};
>> +};
> 
> *urgh*, my naming lives ... anybody got a better suggestion?

I think we need a generic name here, but the problem is that the 
'weight' field has different meanings among architectures.

The 'weight' fields are to store all kinds of latency on X86.
On PowerPC, it stores MMCRA[TECX/TECM], which doesn't look like a latency.

I don't think I can use the name, 'cache_lat' or 'instruction_lat', 
here. Right?
If so, how about 'var'?

u32 var_1_dw;
u16 var_2_w;
u16 var_3_w;


> 
> Also, do we want to care about byte order?

Sure. I will add the big-endian and little-endian support.


Thanks,
Kan
