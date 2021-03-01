Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6862B3275BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 02:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhCABN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 20:13:58 -0500
Received: from mga03.intel.com ([134.134.136.65]:25851 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhCABN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 20:13:56 -0500
IronPort-SDR: gJfO6sHnuTYrrf1zz7jjmLng5rSrZ/TWgE0o43I4c9QPXt3qvKjaB/PMRygBZiUXhOVZrlHdQb
 o1hlNx/0E6lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="186379113"
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="186379113"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 17:12:07 -0800
IronPort-SDR: Bdt63Ro/qcWnXbCR5I+U2cpDjnySuBRDp6eLvYNlqOR4GrA2OgxV3b2LoSrLnYI70vbWOt7mZW
 2WAxVN6ZDJLA==
X-IronPort-AV: E=Sophos;i="5.81,214,1610438400"; 
   d="scan'208";a="366541623"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 17:12:04 -0800
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
 <d416a908-6a54-5e4c-e377-dc9d2b778941@linux.intel.com>
 <YDodJb4CXDT8VemG@krava> <YDtjgCcP9mLBcu/y@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d2a9769e-0632-0cfd-99e5-ab6ff2a54e46@linux.intel.com>
Date:   Mon, 1 Mar 2021 09:12:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YDtjgCcP9mLBcu/y@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2/28/2021 5:33 PM, Jiri Olsa wrote:
> On Sat, Feb 27, 2021 at 11:21:25AM +0100, Jiri Olsa wrote:
>> On Fri, Feb 26, 2021 at 08:41:26AM +0800, Jin, Yao wrote:
>>
>> SNIP
>>
>>>> +				SET_SYMBOL(prefix, PMU_EVENT_SYMBOL);
>>>>    				len++;
>>>>    			}
>>>>    		}
>>>>    	}
>>>> +
>>>> +	/* unlikely, but still.. */
>>>> +	if (!len)
>>>> +		goto err;
>>>> +	perf_pmu_events_list_num = len;
>>>> +
>>>>    	qsort(perf_pmu_events_list, len,
>>>>    		sizeof(struct perf_pmu_event_symbol), comp_pmu);
>>>>
>>>
>>> Thanks so much for the patch! It works with my tests.
>>>
>>> # ./perf test 6
>>>   6: Parse event definition strings                                  : Ok
>>>
>>> # ./perf stat -e software/r1a/ -a -- sleep 1
>>>
>>>   Performance counter stats for 'system wide':
>>>
>>>     <not supported>      software/r1a/
>>>
>>>         1.000940433 seconds time elapsed
>>>
>>> In theory, do we also need to check suffix as well? I think returning
>>> PMU_EVENT_SYMBOL_SUFFIX may also confuse the parser. But yes, we don't have
>>> this case now.
>>
>> yep, let's wait for use case ;-) you can't have suffix
>> without prefix, and that's the one failing, so I think
>> we are fine
> 
> actualy this one seems to work as well, could you plz check
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index d5b6aff82f21..d57ac86ce7ca 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -89,6 +89,7 @@ static void inc_group_count(struct list_head *list,
>   %type <str> PE_EVENT_NAME
>   %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
>   %type <str> PE_DRV_CFG_TERM
> +%type <str> event_pmu_name
>   %destructor { free ($$); } <str>
>   %type <term> event_term
>   %destructor { parse_events_term__delete ($$); } <term>
> @@ -272,8 +273,11 @@ event_def: event_pmu |
>   	   event_legacy_raw sep_dc |
>   	   event_bpf_file
>   
> +event_pmu_name:
> +PE_NAME | PE_PMU_EVENT_PRE
> +
>   event_pmu:
> -PE_NAME opt_pmu_config
> +event_pmu_name opt_pmu_config
>   {
>   	struct parse_events_state *parse_state = _parse_state;
>   	struct parse_events_error *error = parse_state->error;
> 

This fix looks good.

[root@p-tglr02 perf]# ./perf list | grep i915/software-gt-awake-time/
   i915/software-gt-awake-time/                       [Kernel PMU event]

[root@p-tglr02 perf]# ./perf test 6
  6: Parse event definition strings                                  : Ok

[root@p-tglr02 perf]# ./perf stat -e software/r1a/ -a -- sleep 1

  Performance counter stats for 'system wide':

    <not supported>      software/r1a/

        1.001379319 seconds time elapsed

Thanks
Jin Yao
