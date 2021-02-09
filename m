Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F43144C6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 01:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhBIAT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 19:19:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:47541 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhBIAT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 19:19:27 -0500
IronPort-SDR: ZJQCO/A3787mfUV0ZUWZHh+9B5Rumv23ViYKSf79xhWk51zaQ5CRHEftU34X972bBF/SKU1ggM
 O6WFflld8Gxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="160957488"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="160957488"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:17:41 -0800
IronPort-SDR: u6DxJ2vfJjDslyiSUWZ5Rx31sPnoNoA2G2fmV4r476kY2YGGWEQ1GsT5+NEri8VCZKLFjD+g0u
 ppdDucux2tlQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="395797398"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 16:17:38 -0800
Subject: Re: [PATCH 27/49] perf util: Save pmu name to struct perf_pmu_alias
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        kan.liang@linux.intel.com
Cc:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        "Jin, Yao" <yao.jin@intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
 <1612797946-18784-28-git-send-email-kan.liang@linux.intel.com>
 <20210208185732.GK920417@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <07a75656-a49d-0ca9-b1f5-e69501a5dd9c@linux.intel.com>
Date:   Tue, 9 Feb 2021 08:17:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210208185732.GK920417@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 2/9/2021 2:57 AM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 08, 2021 at 07:25:24AM -0800, kan.liang@linux.intel.com escreveu:
>> From: Jin Yao <yao.jin@linux.intel.com>
>>
>> On hybrid platform, one event is available on one pmu
>> (such as, cpu_core or cpu_atom).
>>
>> This patch saves the pmu name to the pmu field of struct perf_pmu_alias.
>> Then next we can know the pmu where the event can be enabled.
>>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/pmu.c | 17 +++++++++++++----
>>   tools/perf/util/pmu.h |  1 +
>>   2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 44ef283..0c25457 100644
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
>> @@ -311,7 +316,8 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>   				 char *unit, char *perpkg,
>>   				 char *metric_expr,
>>   				 char *metric_name,
>> -				 char *deprecated)
>> +				 char *deprecated,
>> +				 char *pmu)
>>   {
>>   	struct parse_events_term *term;
>>   	struct perf_pmu_alias *alias;
>> @@ -382,6 +388,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
>>   	}
>>   	alias->per_pkg = perpkg && sscanf(perpkg, "%d", &num) == 1 && num == 1;
>>   	alias->str = strdup(newval);
>> +	alias->pmu = pmu ? strdup(pmu) : NULL;
>>   
>>   	if (deprecated)
>>   		alias->deprecated = true;
>> @@ -407,7 +414,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
>>   	strim(buf);
>>   
>>   	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
>> -				     NULL, NULL, NULL, NULL);
>> +				     NULL, NULL, NULL, NULL, NULL);
>>   }
>>   
>>   static inline bool pmu_alias_info_file(char *name)
>> @@ -797,7 +804,8 @@ void pmu_add_cpu_aliases_map(struct list_head *head, struct perf_pmu *pmu,
>>   				(char *)pe->unit, (char *)pe->perpkg,
>>   				(char *)pe->metric_expr,
>>   				(char *)pe->metric_name,
>> -				(char *)pe->deprecated);
>> +				(char *)pe->deprecated,
>> +				(char *)pe->pmu);
>>   	}
>>   }
>>   
>> @@ -870,7 +878,8 @@ static int pmu_add_sys_aliases_iter_fn(struct pmu_event *pe, void *data)
>>   				      (char *)pe->perpkg,
>>   				      (char *)pe->metric_expr,
>>   				      (char *)pe->metric_name,
>> -				      (char *)pe->deprecated);
>> +				      (char *)pe->deprecated,
>> +				      NULL);
> 
> At some point I think passing the whole 'struct pme_event' pointer
> should be better?
> 

Yes, I'm thinking the changes as following,

Before:

static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
				 char *desc, char *val,
				 char *long_desc, char *topic,
				 char *unit, char *perpkg,
				 char *metric_expr,
				 char *metric_name,
				 char *deprecated);

After:

static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
				 char *desc, char *val,
				 struct pmu_event *pe);

That looks much simpler than before.

Thanks
Jin Yao

>>   	}
>>   
>>   	return 0;
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 8164388..0e724d5 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -72,6 +72,7 @@ struct perf_pmu_alias {
>>   	bool deprecated;
>>   	char *metric_expr;
>>   	char *metric_name;
>> +	char *pmu;
>>   };
>>   
>>   struct perf_pmu *perf_pmu__find(const char *name);
>> -- 
>> 2.7.4
>>
> 
