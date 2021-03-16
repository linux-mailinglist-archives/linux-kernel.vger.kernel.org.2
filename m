Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6300333CA83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 02:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbhCPA77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 20:59:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:12333 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhCPA7n (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 20:59:43 -0400
IronPort-SDR: 0QaEPHzzE3mSUs5v8p0UpN6GxHQ88Be0ZNs7b8y/VKI3R8zwdQIPDhqCoyxCDLUMtaGekh3HKy
 9nRx0dIaG5JQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="176771628"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="176771628"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:59:42 -0700
IronPort-SDR: WbvNz1bdyVvI4ef8A0oLjzcVjAjeifJrh3Ek6U2cHeqcQwR8EQFWPCkC21t9ZOZMz5UEnqPqNR
 KiiIVho6FcXg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449548076"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:59:40 -0700
Subject: Re: [PATCH v2 04/27] perf pmu: Save pmu name
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210311070742.9318-1-yao.jin@linux.intel.com>
 <20210311070742.9318-5-yao.jin@linux.intel.com> <YE/n3yfo37V+cigN@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <cbb39b21-0529-09e3-8310-a4efd7a6f828@linux.intel.com>
Date:   Tue, 16 Mar 2021 08:59:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YE/n3yfo37V+cigN@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 3/16/2021 7:03 AM, Jiri Olsa wrote:
> On Thu, Mar 11, 2021 at 03:07:19PM +0800, Jin Yao wrote:
>> On hybrid platform, one event is available on one pmu
>> (such as, available on cpu_core or on cpu_atom).
>>
>> This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
>> Then next we can know the pmu which the event can be available on.
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/pmu.c | 10 +++++++++-
>>   tools/perf/util/pmu.h |  1 +
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 54e586bf19a5..45d8db1af8d2 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -283,6 +283,7 @@ void perf_pmu_free_alias(struct perf_pmu_alias *newalias)
>>   	zfree(&newalias->str);
>>   	zfree(&newalias->metric_expr);
>>   	zfree(&newalias->metric_name);
>> +	zfree(&newalias->pmu);
>>   	parse_events_terms__purge(&newalias->terms);
>>   	free(newalias);
>>   }
>> @@ -297,6 +298,10 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alias *newalias,
>>   
>>   	list_for_each_entry(a, alist, list) {
>>   		if (!strcasecmp(newalias->name, a->name)) {
>> +			if (newalias->pmu && a->pmu &&
>> +			    !strcasecmp(newalias->pmu, a->pmu)) {
>> +				continue;
>> +			}
>>   			perf_pmu_update_alias(a, newalias);
>>   			perf_pmu_free_alias(newalias);
>>   			return true;
>> @@ -314,7 +319,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>   	int num;
>>   	char newval[256];
>>   	char *long_desc = NULL, *topic = NULL, *unit = NULL, *perpkg = NULL,
>> -	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL;
>> +	     *metric_expr = NULL, *metric_name = NULL, *deprecated = NULL,
>> +	     *pmu = NULL;
>>   
>>   	if (pe) {
>>   		long_desc = (char *)pe->long_desc;
>> @@ -324,6 +330,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>   		metric_expr = (char *)pe->metric_expr;
>>   		metric_name = (char *)pe->metric_name;
>>   		deprecated = (char *)pe->deprecated;
>> +		pmu = (char *)pe->pmu;
>>   	}
>>   
>>   	alias = malloc(sizeof(*alias));
>> @@ -389,6 +396,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>   	}
>>   	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>>   	alias->str = strdup(newval);
>> +	alias->pmu = pmu ? strdup(pmu) : NULL;
>>   
>>   	if (deprecated)
>>   		alias->deprecated = true;
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 8164388478c6..0e724d5b84c6 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -72,6 +72,7 @@ struct perf_pmu_alias {
>>   	bool deprecated;
>>   	char *metric_expr;
>>   	char *metric_name;
>> +	char *pmu;
> 
> please use pmu_name
> 
> thanks,
> jirka
> 

OK, I will use pmu_name in next version.

Thanks
Jin Yao

