Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006FA33CC50
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhCPDwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:52:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:16533 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231265AbhCPDvo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:51:44 -0400
IronPort-SDR: opnHW+haMMZmIrGqmNJIWTJi8el9tBtsXyDDE41KGB9FRw5ie0rz7OgmdSq6jp8f1ibdMJC74q
 sMjmVTq/pVsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="189285821"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="189285821"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 20:51:43 -0700
IronPort-SDR: Do6y7maavqrhgeP96re9TEixggByEVwR8cYTfLXhDh14KKl8ClpkbDUhBr1BjPeGVZt8AWYlFE
 MjdKXyqfnqmw==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449583495"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 20:51:40 -0700
Subject: Re: [PATCH v2 10/27] perf parse-events: Create two hybrid cache
 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-11-yao.jin@linux.intel.com> <YE/n85ULSpgh6DRf@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f669d850-7e1f-ed6b-c85e-95c1f9817550@linux.intel.com>
Date:   Tue, 16 Mar 2021 11:51:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE/n85ULSpgh6DRf@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/16/2021 7:05 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:25PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> +						config_terms, pmu);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int parse_events_add_cache(struct list_head *list, int *idx,
>>   			   char *type, char *op_result1, char *op_result2,
>>   			   struct parse_events_error *err,
>> @@ -474,7 +516,8 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>>   	char name[MAX_NAME_LEN], *config_name;
>>   	int cache_type = -1, cache_op = -1, cache_result = -1;
>>   	char *op_result[2] = { op_result1, op_result2 };
>> -	int i, n;
>> +	int i, n, ret;
>> +	bool hybrid;
>>   
>>   	/*
>>   	 * No fallback - if we cannot get a clear cache type
>> @@ -534,6 +577,15 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>>   		if (get_config_terms(head_config, &config_terms))
>>   			return -ENOMEM;
>>   	}
>> +
>> +	if (!perf_pmu__hybrid_exist())
>> +		perf_pmu__scan(NULL);
> 
> actualy how about construct like:
> 
> 	perf_pmu_is_hybrid()
> 		return hybrid_add_event_cache(...)
> 
> 	return add_event(...)
> 
> 
> with:
> 	perf_pmu_is_hybrid()
> 	{
> 		static bool initialized;
> 
> 		if (!initialized) {
> 			initialized = true;
> 			perf_pmu__scan(NULL)
> 		}
> 
> 		return ...
> 	}
> 
> jirka
> 

Thanks, that's a good solution. I will do that in v3.

Thanks
Jin Yao

>> +
>> +	ret = add_hybrid_cache(list, idx, &attr, config_name ? : name,
>> +			       &config_terms, &hybrid);
>> +	if (hybrid)
>> +		return ret;
>> +
>>   	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
>>   }
>>   
>> -- 
>> 2.17.1
>>
> 
