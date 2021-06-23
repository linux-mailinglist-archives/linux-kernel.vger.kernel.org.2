Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FAF3B1180
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 04:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFWCE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 22:04:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:19983 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhFWCEZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 22:04:25 -0400
IronPort-SDR: Ec//wex5H8J7mXrFNSrEEhFI0HCB7KfE6EVGvAkY7NdauNcNfPfaNM2Zx2SG8RuPyTaufj2eky
 6A/K8dKfdvag==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="204170493"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="204170493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 19:02:08 -0700
IronPort-SDR: PwBOLsReWWv2O8YdYQzLOBkAhlcsdlwebize/Hoe7w7F00g8oGXoFxPOSRY+uOAfgG+gJOIKvP
 9lk4xt2N7k9A==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="487127314"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 19:02:04 -0700
Subject: Re: [PATCH v1] perf tools: Fix pattern matching for same substring
 used in different pmu type
From:   "Jin, Yao" <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210609045738.1051-1-yao.jin@linux.intel.com>
 <982714a5-8a5d-8f8a-4e30-bd9a497ffa40@linux.intel.com>
Message-ID: <4787334d-cf28-5b25-8d11-c767c52288f1@linux.intel.com>
Date:   Wed, 23 Jun 2021 10:02:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <982714a5-8a5d-8f8a-4e30-bd9a497ffa40@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, Jiri,

Any comments for this bug fix patch?

The issue does impact some uncore events and even some metrics.

Thanks
Jin Yao

On 6/11/2021 10:54 AM, Jin, Yao wrote:
> And, though this patch is to fix the uncore_imc/uncore_imc_free_running mismatching issue. We are 
> also surprised to see it can solve another hybrid PMU issue on Alderlake.
> 
> On Alderlake,
> 
> # ./perf stat -e cpu/event=0xc2,umask=0x2/ true
> 
> Performance counter stats for 'true':
> 
>             702,246      cpu_core/event=0xc2,umask=0x2/
>       <not counted>      cpu_atom/event=0xc2,umask=0x2/
> 
> It should error out with the wrong PMU rather than using 'cpu_core' and'cpu_atom' instead.
> 
> This is still the pattern matching issue. The pattern is "cpu*". Both "cpu_core" and "cpu_atom" can 
> match the pattern "cpu*", so the parser wrongly thinks they are the same PMU type.
> 
> Now with this patch,
> 
> # ./perf stat -e cpu/cpu-cycles/ true
> event syntax error: 'cpu/cpu-cycles/'
>                       \___ Cannot find PMU `cpu'. Missing kernel support?
> Run 'perf list' for a list of valid events
> 
> Thanks
> Jin Yao
> 
> On 6/9/2021 12:57 PM, Jin Yao wrote:
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
>> Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>>   tools/perf/util/parse-events.y |  2 ++
>>   tools/perf/util/pmu.c          | 25 ++++++++++++++++++++++++-
>>   tools/perf/util/pmu.h          |  1 +
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index aba12a4d488e..7a694c7f7f1a 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -317,6 +317,8 @@ event_pmu_name opt_pmu_config
>>                   strncmp($1, "uncore_", 7))
>>                   name += 7;
>>               if (!fnmatch(pattern, name, 0)) {
>> +                if (!perf_pmu__valid_suffix($1, name))
>> +                    continue;
>>                   if (parse_events_copy_term_list(orig_terms, &terms))
>>                       CLEANUP_YYABORT;
>>                   if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 88c8ecdc60b0..78af01959830 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/compiler.h>
>>   #include <linux/string.h>
>>   #include <linux/zalloc.h>
>> +#include <linux/ctype.h>
>>   #include <subcmd/pager.h>
>>   #include <sys/types.h>
>>   #include <errno.h>
>> @@ -768,7 +769,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>        */
>>       for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>>           name = strstr(name, tok);
>> -        if (!name) {
>> +        if (!name || !perf_pmu__valid_suffix(tok, (char *)name)) {
>>               res = false;
>>               goto out;
>>           }
>> @@ -1872,3 +1873,25 @@ bool perf_pmu__has_hybrid(void)
>>       return !list_empty(&perf_pmu__hybrid_pmus);
>>   }
>> +
>> +bool perf_pmu__valid_suffix(char *tok, char *pmu_name)
>> +{
>> +    char *p;
>> +
>> +    /*
>> +     * The pmu_name has substring tok. If the format of
>> +     * pmu_name is <tok> or <tok>_<digit>, return true.
>> +     */
>> +    p = pmu_name + strlen(tok);
>> +    if (*p == 0)
>> +        return true;
>> +
>> +    if (*p != '_')
>> +        return false;
>> +
>> +    ++p;
>> +    if (*p == 0 || !isdigit(*p))
>> +        return false;
>> +
>> +    return true;
>> +}
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index a790ef758171..ebfd2b71532b 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -133,5 +133,6 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>>                      char *name);
>>   bool perf_pmu__has_hybrid(void);
>> +bool perf_pmu__valid_suffix(char *tok, char *pmu_name);
>>   #endif /* __PMU_H */
>>
