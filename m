Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6D74096D8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346761AbhIMPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:15:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:9562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345583AbhIMPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:15:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="221369664"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="221369664"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 08:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="698789609"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2021 08:13:58 -0700
Received: from [10.212.195.45] (kliang2-MOBL.ccr.corp.intel.com [10.212.195.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E9B0658072B;
        Mon, 13 Sep 2021 08:13:57 -0700 (PDT)
Subject: Re: [PATCH] perf script: Fix ip display when type != attr->type
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210911133053.15682-1-adrian.hunter@intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <a961928d-41a5-6dce-75e1-25ae260f3e12@linux.intel.com>
Date:   Mon, 13 Sep 2021 11:13:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210911133053.15682-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/2021 9:30 AM, Adrian Hunter wrote:
> set_print_ip_opts() was not being called when type != attr->type
> because there is not a one-to-one relationship between output types
> and attr->type. That resulted in ip not printing.
> 
> The attr_type() function is removed, and the match of attr->type to
> output type is corrected.
> 
> Example on ADL using taskset to select an atom cpu:
> 
>   # perf record -e cpu_atom/cpu-cycles/ taskset 0x1000 uname
>   Linux
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.003 MB perf.data (7 samples) ]
> 
>   Before:
> 
>    # perf script | head
>           taskset   428 [-01] 10394.179041:          1 cpu_atom/cpu-cycles/:
>           taskset   428 [-01] 10394.179043:          1 cpu_atom/cpu-cycles/:
>           taskset   428 [-01] 10394.179044:         11 cpu_atom/cpu-cycles/:
>           taskset   428 [-01] 10394.179045:        407 cpu_atom/cpu-cycles/:
>           taskset   428 [-01] 10394.179046:      16789 cpu_atom/cpu-cycles/:
>           taskset   428 [-01] 10394.179052:     676300 cpu_atom/cpu-cycles/:
>             uname   428 [-01] 10394.179278:    4079859 cpu_atom/cpu-cycles/:
> 
>   After:
> 
>    # perf script | head
>           taskset   428 10394.179041:          1 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
>           taskset   428 10394.179043:          1 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
>           taskset   428 10394.179044:         11 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
>           taskset   428 10394.179045:        407 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
>           taskset   428 10394.179046:      16789 cpu_atom/cpu-cycles/:  ffffffff95a0bb97 __intel_pmu_enable_all.constprop.48+0x47 ([kernel.kallsyms])
>           taskset   428 10394.179052:     676300 cpu_atom/cpu-cycles/:      7f829ef73800 cfree+0x0 (/lib/libc-2.32.so)
>             uname   428 10394.179278:    4079859 cpu_atom/cpu-cycles/:  ffffffff95bae912 vma_interval_tree_remove+0x1f2 ([kernel.kallsyms])
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>   tools/perf/builtin-script.c | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 0e824f7d8b19..6211d0b84b7a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -368,16 +368,6 @@ static inline int output_type(unsigned int type)
>   	return OUTPUT_TYPE_OTHER;
>   }
>   
> -static inline unsigned int attr_type(unsigned int type)
> -{
> -	switch (type) {
> -	case OUTPUT_TYPE_SYNTH:
> -		return PERF_TYPE_SYNTH;
> -	default:
> -		return type;
> -	}
> -}
> -
>   static bool output_set_by_user(void)
>   {
>   	int j;
> @@ -556,6 +546,18 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
>   		output[type].print_ip_opts |= EVSEL__PRINT_SRCLINE;
>   }
>   
> +static struct evsel *find_first_output_type(struct evlist *evlist,
> +					    unsigned int type)
> +{
> +	struct evsel *evsel;
> +
> +	evlist__for_each_entry(evlist, evsel) {
> +		if (output_type(evsel->core.attr.type) == (int)type)
> +			return evsel;
> +	}
> +	return NULL;
> +}
> +
>   /*
>    * verify all user requested events exist and the samples
>    * have the expected data
> @@ -567,7 +569,7 @@ static int perf_session__check_output_opt(struct perf_session *session)
>   	struct evsel *evsel;
>   
>   	for (j = 0; j < OUTPUT_TYPE_MAX; ++j) {
> -		evsel = perf_session__find_first_evtype(session, attr_type(j));

I think the only consumer of perf_session__find_first_evtype() will only 
be in session.c. Seems we can further clean up the function and make it 
static. Other than that, the patch looks good to me.

   Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan
> +		evsel = find_first_output_type(session->evlist, j);
>   
>   		/*
>   		 * even if fields is set to 0 (ie., show nothing) event must
> 
