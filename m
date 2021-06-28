Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241E13B5707
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 03:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhF1BzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 21:55:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:58698 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231678AbhF1BzL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 21:55:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10028"; a="271732524"
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="271732524"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 18:52:46 -0700
X-IronPort-AV: E=Sophos;i="5.83,304,1616482800"; 
   d="scan'208";a="456126462"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 18:52:44 -0700
Subject: Re: [PATCH v1] perf tools: Fix pattern matching for same substring
 used in different pmu type
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210609045738.1051-1-yao.jin@linux.intel.com>
 <982714a5-8a5d-8f8a-4e30-bd9a497ffa40@linux.intel.com>
 <4787334d-cf28-5b25-8d11-c767c52288f1@linux.intel.com>
 <YNWr7zsEaNPCn4CR@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <14a70048-ddd0-3297-9ae9-6b76dd0f1000@linux.intel.com>
Date:   Mon, 28 Jun 2021 09:52:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNWr7zsEaNPCn4CR@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 6/25/2021 6:11 PM, Jiri Olsa wrote:
> On Wed, Jun 23, 2021 at 10:02:01AM +0800, Jin, Yao wrote:
>> Hi Arnaldo, Jiri,
>>
>> Any comments for this bug fix patch?
>>
>> The issue does impact some uncore events and even some metrics.
> 
> sry for delay
> 
> SNIP
> 
>>>> Some different pmu types may have same substring. For example,
>>>> on Icelake server, we have pmu types "uncore_imc" and
>>>> "uncore_imc_free_running". Both pmu types have substring "uncore_imc".
>>>> But the parser would wrongly think they are the same pmu type.
>>>>
>>>> We enable an imc event,
>>>> perf stat -e uncore_imc/event=0xe3/ -a -- sleep 1
>>>>
>>>> Perf actually expands the event to:
>>>> uncore_imc_0/event=0xe3/
>>>> uncore_imc_1/event=0xe3/
>>>> uncore_imc_2/event=0xe3/
>>>> uncore_imc_3/event=0xe3/
>>>> uncore_imc_4/event=0xe3/
>>>> uncore_imc_5/event=0xe3/
>>>> uncore_imc_6/event=0xe3/
>>>> uncore_imc_7/event=0xe3/
>>>> uncore_imc_free_running_0/event=0xe3/
>>>> uncore_imc_free_running_1/event=0xe3/
>>>> uncore_imc_free_running_3/event=0xe3/
>>>> uncore_imc_free_running_4/event=0xe3/
>>>>
>>>> That's because the "uncore_imc_free_running" matches the
>>>> pattern "uncore_imc*".
>>>>
>>>> Now we check that the last characters of pmu name is
>>>> '_<digit>'.
>>>>
>>>> Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
>>>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>>>> ---
>>>>    tools/perf/util/parse-events.y |  2 ++
>>>>    tools/perf/util/pmu.c          | 25 ++++++++++++++++++++++++-
>>>>    tools/perf/util/pmu.h          |  1 +
>>>>    3 files changed, 27 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>>>> index aba12a4d488e..7a694c7f7f1a 100644
>>>> --- a/tools/perf/util/parse-events.y
>>>> +++ b/tools/perf/util/parse-events.y
>>>> @@ -317,6 +317,8 @@ event_pmu_name opt_pmu_config
>>>>                    strncmp($1, "uncore_", 7))
>>>>                    name += 7;
>>>>                if (!fnmatch(pattern, name, 0)) {
>>>> +                if (!perf_pmu__valid_suffix($1, name))
>>>> +                    continue;
> 
> could this be part of the fnmatch's pattern?
>

Actually I had used the pattern "uncore_imc_[0-9]" before. But for some units, e.g., CHA, they have 
more than 10 units. So this simple pattern couldn't satisfy them.

And then I changed the pattern to "uncore_imc_[0-9]+$", which can match the string 
"uncore_imc_<integer id>". But unfortunately it didn't work for fnmatch.

I used regex, such as:

asprintf(&pattern, "%s_[0-9]+$", tok);
regcomp(&regex, pattern, REG_EXTENDED);
ret = regexec(&regex, name, 0, NULL, 0);

But the regex approach looks not very simple (a bit heavy), so finally I just keep using fnmatch and 
then just check the last character.

>>>>                    if (parse_events_copy_term_list(orig_terms, &terms))
>>>>                        CLEANUP_YYABORT;
>>>>                    if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>>>> index 88c8ecdc60b0..78af01959830 100644
>>>> --- a/tools/perf/util/pmu.c
>>>> +++ b/tools/perf/util/pmu.c
>>>> @@ -3,6 +3,7 @@
>>>>    #include <linux/compiler.h>
>>>>    #include <linux/string.h>
>>>>    #include <linux/zalloc.h>
>>>> +#include <linux/ctype.h>
>>>>    #include <subcmd/pager.h>
>>>>    #include <sys/types.h>
>>>>    #include <errno.h>
>>>> @@ -768,7 +769,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
>>>>         */
>>>>        for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>>>>            name = strstr(name, tok);
>>>> -        if (!name) {
>>>> +        if (!name || !perf_pmu__valid_suffix(tok, (char *)name)) {
>>>>                res = false;
>>>>                goto out;
>>>>            }
>>>> @@ -1872,3 +1873,25 @@ bool perf_pmu__has_hybrid(void)
>>>>        return !list_empty(&perf_pmu__hybrid_pmus);
>>>>    }
>>>> +
>>>> +bool perf_pmu__valid_suffix(char *tok, char *pmu_name)
>>>> +{
>>>> +    char *p;
>>>> +
>>>> +    /*
>>>> +     * The pmu_name has substring tok. If the format of
>>>> +     * pmu_name is <tok> or <tok>_<digit>, return true.
>>>> +     */
>>>> +    p = pmu_name + strlen(tok);
>>>> +    if (*p == 0)
>>>> +        return true;
>>>> +
>>>> +    if (*p != '_')
>>>> +        return false;
>>>> +
>>>> +    ++p;
>>>> +    if (*p == 0 || !isdigit(*p))
>>>> +        return false;
>>>> +
>>>> +    return true;
>>>> +}
> 
> hum, so we have pattern serch and then another function checking
> if that search was ok..

Yes, that's what this patch does.

I understand that's convenient, because
> it's on 2 different places

Yes, on pmu_uncore_alias_match() and on parse-events.y.

but could we have some generic solution,
> line one function/search that returns/search for valid pmu name?
> 

Sorry, I don't understand this idea well. Would you like to further explain?

Or can you accept the regex approach?

> thanks,
> jirka
> 
