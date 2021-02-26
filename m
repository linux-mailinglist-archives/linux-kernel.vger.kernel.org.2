Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DDC325B09
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 01:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbhBZAnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 19:43:20 -0500
Received: from mga09.intel.com ([134.134.136.24]:40191 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhBZAnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 19:43:18 -0500
IronPort-SDR: tb9oFQjaD1t57br1I6guyiOnZUabSZgwRdMClRFOeNgWSsvwlif/LQE1aAqSzO1lyUC9kpxeBN
 Ji1Anwi+e1rQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9906"; a="185850143"
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="185850143"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 16:41:31 -0800
IronPort-SDR: bRGuErTqTx6yWedPPgOAn6ewhlPxcU33I5Go5q5qy94jdtC3Tqp97DcBe2dT5w/VbNS+izPDyw
 lRrNmO5DJr1g==
X-IronPort-AV: E=Sophos;i="5.81,207,1610438400"; 
   d="scan'208";a="404642017"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2021 16:41:28 -0800
Subject: Re: [drm/i915/gt] 8c3b1ba0e7:
 perf-sanity-tests.Parse_event_definition_strings.fail
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>,
        "Yi, Ammy" <ammy.yi@intel.com>
References: <20210224074841.GD6114@xsang-OptiPlex-9020>
 <cabd8692-07ca-13c8-efb5-e088b4547f80@linux.intel.com>
 <YDenRVGzh5Dv1pC2@krava> <YDfph8b9p8sSk1AF@krava> <YDfxgfi5DBDMFgwu@krava>
 <YDf0fP8XmnTrkIT8@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d416a908-6a54-5e4c-e377-dc9d2b778941@linux.intel.com>
Date:   Fri, 26 Feb 2021 08:41:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YDf0fP8XmnTrkIT8@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2/26/2021 3:03 AM, Jiri Olsa wrote:
> On Thu, Feb 25, 2021 at 07:50:46PM +0100, Jiri Olsa wrote:
>> On Thu, Feb 25, 2021 at 07:16:44PM +0100, Jiri Olsa wrote:
>>> On Thu, Feb 25, 2021 at 02:33:57PM +0100, Jiri Olsa wrote:
>>>> On Thu, Feb 25, 2021 at 04:06:23PM +0800, Jin, Yao wrote:
>>>>> Hi Chris, Arnaldo, Jiri,
>>>>>
>>>>> We observe the parsing error for "software/xxx/" on some platforms.
>>>>>
>>>>> For example,
>>>>>
>>>>> # perf stat -e software/r1a/ -a -- sleep 1
>>>>> event syntax error: 'software/r1a/'
>>>>>                       \___ parser error
>>>>> Run 'perf list' for a list of valid events
>>>>>
>>>>>   Usage: perf stat [<options>] [<command>]
>>>>>
>>>>>      -e, --event <event>   event selector. use 'perf list' to list available events
>>>>>
>>>>> And perf test is failed too.
>>>>>
>>>>> # perf test 6 -vv
>>>>> ...
>>>>> running test 4 'software/r1a/'failed to parse event 'software/r1a/', err 1, str 'parser error'
>>>>> event syntax error: 'software/r1a/'
>>>>>                       \___ parser error
>>>>>
>>>>> running test 4 'software/r0x1a/'failed to parse event 'software/r0x1a/', err 1, str 'parser error'
>>>>> event syntax error: 'software/r0x1a/'
>>>>>                       \___ parser error
>>>>> ...
>>>>>
>>>>> The issue should be the conflict between event "i915/software-gt-awake-time/" and pmu "software".
>>>>>
>>>>> # perf list | grep i915/software
>>>>>    i915/software-gt-awake-time/                       [Kernel PMU event]
>>>>>
>>>>> Perf supports the event format as "prefix-xxx-suffix", so the "software"
>>>>> string in "software-gt-awake-time" is added to perf_pmu_events_list as
>>>>> PMU_EVENT_SYMBOL_PREFIX. When parsing the string such as "software/xxx/",
>>>>> it’s parsed as PMU_EVENT_SYMBOL_PREFIX for "software", then it would error
>>>>> out in next processing.
>>>>>
>>>>> So the easy way is to rename "software-gt-awake-time" to "gt-awake-time",
>>>>> right? Otherwise we have to hardcode something in perf tool.
>>>>>
>>>>> What do you think of this issue and the solution?
>>>>>
>>>>> BTW, as the robot reported, it's related to the commit 8c3b1ba0e7ea
>>>>> ("drm/i915/gt: Track the overall awake/busy time").
>>>>
>>>> yes, I think you're right.. I'll try to reproduce and check on this
>>>>
>>>> I'm still not clear why is that parsing fail if those 2 events are
>>>> distinguished by - and / ... but yep, we are asking for trouble in
>>>> here ;-)
>>>>
>>>> I think we could either prioritaze one or add extra check when we
>>>> add prefix-xxx-suffix events and do not add ones that have conflict..
>>>> that seems like best solution to me now
>>>
>>> would patch below work for you?
>>>
>>> jirka
>>
>> and now with more fixes after I ran tests ;-)
>>
>> we should perhaps add also same check for non '-' aliases, I'll check
> 
> and one more version ;-)
> 
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 42c84adeb2fb..d9e795056d15 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2028,30 +2028,49 @@ static void perf_pmu__parse_init(void)
>   		perf_pmu_events_list_num = -1;
>   		return;
>   	}
> -	perf_pmu_events_list = malloc(sizeof(struct perf_pmu_event_symbol) * len);
> +	perf_pmu_events_list = zalloc(sizeof(struct perf_pmu_event_symbol) * len);
>   	if (!perf_pmu_events_list)
>   		return;
> -	perf_pmu_events_list_num = len;
>   
>   	len = 0;
>   	pmu = NULL;
>   	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
>   		list_for_each_entry(alias, &pmu->aliases, list) {
>   			struct perf_pmu_event_symbol *p = perf_pmu_events_list + len;
> -			char *tmp = strchr(alias->name, '-');
> +			char *prefix = strdup(alias->name);
> +			char *tmp = strchr(prefix, '-');
> +
> +			if (tmp != NULL)
> +				*tmp = 0;
> +
> +			/*
> +			 * Skip any prefix that conflicts with pmu name,
> +			 * otherwise the event parser gets confused.
> +			 */
> +			if (perf_pmu__find(prefix)) {
> +				pr_debug2("perf_pmu__parse_init: skipping conflicting alias '%s'\n",
> +					  alias->name);
> +				free(prefix);
> +				continue;
> +			}
>   
>   			if (tmp != NULL) {
> -				SET_SYMBOL(strndup(alias->name, tmp - alias->name),
> -						PMU_EVENT_SYMBOL_PREFIX);
> +				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL_PREFIX);
>   				p++;
>   				SET_SYMBOL(strdup(++tmp), PMU_EVENT_SYMBOL_SUFFIX);
>   				len += 2;
>   			} else {
> -				SET_SYMBOL(strdup(alias->name), PMU_EVENT_SYMBOL);
> +				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL);
>   				len++;
>   			}
>   		}
>   	}
> +
> +	/* unlikely, but still.. */
> +	if (!len)
> +		goto err;
> +	perf_pmu_events_list_num = len;
> +
>   	qsort(perf_pmu_events_list, len,
>   		sizeof(struct perf_pmu_event_symbol), comp_pmu);
>   
> 

Thanks so much for the patch! It works with my tests.

# ./perf test 6
  6: Parse event definition strings                                  : Ok

# ./perf stat -e software/r1a/ -a -- sleep 1

  Performance counter stats for 'system wide':

    <not supported>      software/r1a/

        1.000940433 seconds time elapsed

In theory, do we also need to check suffix as well? I think returning PMU_EVENT_SYMBOL_SUFFIX may 
also confuse the parser. But yes, we don't have this case now.

Thanks
Jin Yao

