Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8463BDE42
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhGFUFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 16:05:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:10453 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGFUFH (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 16:05:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="206174735"
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="206174735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 13:02:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,329,1616482800"; 
   d="scan'208";a="497240369"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jul 2021 13:02:28 -0700
Received: from [10.209.95.225] (kliang2-MOBL.ccr.corp.intel.com [10.209.95.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 7775F580297;
        Tue,  6 Jul 2021 13:02:26 -0700 (PDT)
Subject: Re: [PATCH v3] perf tools: Fix pattern matching for same substring in
 different pmu type
To:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210701064253.1175-1-yao.jin@linux.intel.com>
 <YOSyhwJ/E0JoeWOS@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <8c2b5f66-c85e-8717-d218-4d6a2182262a@linux.intel.com>
Date:   Tue, 6 Jul 2021 16:02:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOSyhwJ/E0JoeWOS@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2021 3:44 PM, Jiri Olsa wrote:
> On Thu, Jul 01, 2021 at 02:42:53PM +0800, Jin Yao wrote:
>> Some different pmu types may have same substring. For example,
>> on Icelake server, we have pmu types "uncore_imc" and
>> "uncore_imc_free_running". Both pmu types have substring "uncore_imc".
>> But the parser would wrongly think they are the same pmu type.
>>
>> We enable an imc event,
>> perf stat -e uncore_imc/event=0xe3/ -a -- sleep 1
>>
>> Perf actually expands the event to:
>> uncore_imc_0/event=0xe3/
>> uncore_imc_1/event=0xe3/
>> uncore_imc_2/event=0xe3/
>> uncore_imc_3/event=0xe3/
>> uncore_imc_4/event=0xe3/
>> uncore_imc_5/event=0xe3/
>> uncore_imc_6/event=0xe3/
>> uncore_imc_7/event=0xe3/
>> uncore_imc_free_running_0/event=0xe3/
>> uncore_imc_free_running_1/event=0xe3/
>> uncore_imc_free_running_3/event=0xe3/
>> uncore_imc_free_running_4/event=0xe3/
>>
>> That's because the "uncore_imc_free_running" matches the
>> pattern "uncore_imc*".
>>
>> Now we check that the last characters of pmu name is
>> '_<digit>'.
>>
>> For example, for pattern "uncore_imc*", "uncore_imc_0" is parsed ok,
>> but "uncore_imc_free_running_0" would be failed.
>>
>> Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> looks good to me, Kan, Andi?

Yes, it looks good to me too.

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

BTW: The new uncore patch[1] for the "alias" attribute should be easily 
rebase on this patch. I believe Yao has already finished the test as 
well. I think he will resend the new "alias" attribute patch later soon.
[1] 
https://lore.kernel.org/lkml/1624990443-168533-7-git-send-email-kan.liang@linux.intel.com

Thanks,
Kan

> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> 
> thanks,
> jirka
> 
>> ---
>>   tools/perf/util/parse-events.y |  2 +-
>>   tools/perf/util/pmu.c          | 36 +++++++++++++++++++++++++++++++++-
>>   tools/perf/util/pmu.h          |  1 +
>>   3 files changed, 37 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index aba12a4d488e..9321bd0e2f76 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -316,7 +316,7 @@ event_pmu_name opt_pmu_config
>>   			if (!strncmp(name, "uncore_", 7) &&
>>   			    strncmp($1, "uncore_", 7))
>>   				name += 7;
>> -			if (!fnmatch(pattern, name, 0)) {
>> +			if (!perf_pmu__match(pattern, name, $1)) {
>>   				if (parse_events_copy_term_list(orig_terms, &terms))
>>   					CLEANUP_YYABORT;
>>   				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 88c8ecdc60b0..44b90d638ad5 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/compiler.h>
>>   #include <linux/string.h>
>>   #include <linux/zalloc.h>
>> +#include <linux/ctype.h>
>>   #include <subcmd/pager.h>
>>   #include <sys/types.h>
>>   #include <errno.h>
>> @@ -17,6 +18,7 @@
>>   #include <locale.h>
>>   #include <regex.h>
>>   #include <perf/cpumap.h>
>> +#include <fnmatch.h>
>>   #include "debug.h"
>>   #include "evsel.h"
>>   #include "pmu.h"
>> @@ -740,6 +742,27 @@ struct pmu_events_map *__weak pmu_events_map__find(void)
>>   	return perf_pmu__find_map(NULL);
>>   }
>>   
>> +static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
>> +{
>> +	char *p;
>> +
>> +	if (strncmp(pmu_name, tok, strlen(tok)))
>> +		return false;
>> +
>> +	p = pmu_name + strlen(tok);
>> +	if (*p == 0)
>> +		return true;
>> +
>> +	if (*p != '_')
>> +		return false;
>> +
>> +	++p;
>> +	if (*p == 0 || !isdigit(*p))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>   bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>   {
>>   	char *tmp = NULL, *tok, *str;
>> @@ -768,7 +791,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>   	 */
>>   	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>>   		name = strstr(name, tok);
>> -		if (!name) {
>> +		if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
>>   			res = false;
>>   			goto out;
>>   		}
>> @@ -1872,3 +1895,14 @@ bool perf_pmu__has_hybrid(void)
>>   
>>   	return !list_empty(&perf_pmu__hybrid_pmus);
>>   }
>> +
>> +int perf_pmu__match(char *pattern, char *name, char *tok)
>> +{
>> +	if (fnmatch(pattern, name, 0))
>> +		return -1;
>> +
>> +	if (tok && !perf_pmu__valid_suffix(name, tok))
>> +		return -1;
>> +
>> +	return 0;
>> +}
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index a790ef758171..926da483a141 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>>   				   char *name);
>>   
>>   bool perf_pmu__has_hybrid(void);
>> +int perf_pmu__match(char *pattern, char *name, char *tok);
>>   
>>   #endif /* __PMU_H */
>> -- 
>> 2.17.1
>>
> 
