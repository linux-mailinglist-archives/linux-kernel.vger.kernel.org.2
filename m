Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324ED35B7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236375AbhDLBP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:15:56 -0400
Received: from mga05.intel.com ([192.55.52.43]:38727 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235835AbhDLBPz (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:15:55 -0400
IronPort-SDR: 23dfKJ5xcrYRFZ3F5MWmpWvqRQKZGj95NgRcdzPxUZQEdQH32LLw5cz7FCchBCaCsroqz7lbJv
 W4jy/n0WpoXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="279381991"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="279381991"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:15:38 -0700
IronPort-SDR: n6uThAuu0JhtEm7/fJYJGpEV2nB9cTYvrTy+zJGZG95qwqzHtoGbmR3+eQh8un5QxAMgSVK11t
 OteXsn89D4gw==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="451215568"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:15:36 -0700
Subject: Re: [PATCH v3 09/27] perf parse-events: Create two hybrid cache
 events
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
 <20210329070046.8815-10-yao.jin@linux.intel.com> <YHBa820crfHSIZuz@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <00b56b3c-c88d-8340-e8b7-703f6023bf03@linux.intel.com>
Date:   Mon, 12 Apr 2021 09:15:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YHBa820crfHSIZuz@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/9/2021 9:48 PM, Jiri Olsa wrote:
> On Mon, Mar 29, 2021 at 03:00:28PM +0800, Jin Yao wrote:
> 
> SNIP
> 
>> index 1bbd0ba92ba7..3692fa3c964a 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -458,6 +458,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>>   	int cache_type = -1, cache_op = -1, cache_result = -1;
>>   	char *op_result[2] = { op_result1, op_result2 };
>>   	int i, n;
>> +	bool hybrid;
>>   
>>   	/*
>>   	 * No fallback - if we cannot get a clear cache type
>> @@ -517,6 +518,13 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>>   		if (get_config_terms(head_config, &config_terms))
>>   			return -ENOMEM;
>>   	}
>> +
>> +	i = parse_events__add_cache_hybrid(list, idx, &attr,
>> +					   config_name ? : name, &config_terms,
>> +					   &hybrid);
>> +	if (hybrid)
>> +		return i;
> 
> please define 'ret' for the return value, i is confusing
> 
> thanks,
> jirka
> 

Previously I wanted to save a 'ret' variable, but yes it's confusing. I will define 'ret' in next 
version.

Thanks
Jin Yao

>> +
>>   	return add_event(list, idx, &attr, config_name ? : name, &config_terms);
>>   }
>>   
>> -- 
>> 2.17.1
>>
> 
