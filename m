Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33D336ABEE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhDZFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:55:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:45935 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDZFzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:55:52 -0400
IronPort-SDR: wiGbxDK0wU7SZQxXcPnBNjQ3ol32X5wEWOOx4ohhUkh3VocVHMmF5OcEY8Ic6Jh9Qgg72czlfs
 LHxmth/UrLaQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="195837768"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="195837768"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:55:11 -0700
IronPort-SDR: Ym5rzJuV8O6vKtLMfvZYxiPZwJ5QlVFB9tOZWynsi6WoPFiIyan1hv6mmXVl+M0jr9AvDwLWQ5
 AlpMfN0C++OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422509303"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2021 22:55:06 -0700
Subject: Re: [PATCH v1 1/3] perf jit: Let convert_timestamp() to be
 backwards-compatible
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210412083459.462817-1-leo.yan@linaro.org>
 <20210412083459.462817-2-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9efe1e7f-a0e3-7908-acf1-ca4a26fa29b9@intel.com>
Date:   Mon, 26 Apr 2021 08:55:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412083459.462817-2-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 11:34 am, Leo Yan wrote:
> Commit d110162cafc8 ("perf tsc: Support cap_user_time_short for event
> TIME_CONV") supports the extended parameters for event TIME_CONV, but it
> broke the backwards compatibility, so any perf data file with old event
> format fails to convert timestamp.
> 
> For the backwards-compatibility, this patch checks the event size, if
> the event size confirms the extended parameters are supported in the
> event TIME_CONV, then copies these parameters.
> 
> Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Perhaps could make use of a helper like the one described in my comments for patch 2.
Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/util/jitdump.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 9760d8e7b386..67b514c38a43 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -396,21 +396,32 @@ static pid_t jr_entry_tid(struct jit_buf_desc *jd, union jr_entry *jr)
>  
>  static uint64_t convert_timestamp(struct jit_buf_desc *jd, uint64_t timestamp)
>  {
> -	struct perf_tsc_conversion tc;
> +	struct perf_tsc_conversion tc = { 0 };
> +	struct perf_record_time_conv *time_conv = &jd->session->time_conv;
>  
>  	if (!jd->use_arch_timestamp)
>  		return timestamp;
>  
> -	tc.time_shift	       = jd->session->time_conv.time_shift;
> -	tc.time_mult	       = jd->session->time_conv.time_mult;
> -	tc.time_zero	       = jd->session->time_conv.time_zero;
> -	tc.time_cycles	       = jd->session->time_conv.time_cycles;
> -	tc.time_mask	       = jd->session->time_conv.time_mask;
> -	tc.cap_user_time_zero  = jd->session->time_conv.cap_user_time_zero;
> -	tc.cap_user_time_short = jd->session->time_conv.cap_user_time_short;
> +	tc.time_shift = time_conv->time_shift;
> +	tc.time_mult  = time_conv->time_mult;
> +	tc.time_zero  = time_conv->time_zero;
>  
> -	if (!tc.cap_user_time_zero)
> -		return 0;
> +	/*
> +	 * The event TIME_CONV was extended for the fields from "time_cycles"
> +	 * when supported cap_user_time_short, for backward compatibility,
> +	 * checks the event size and assigns these extended fields if these
> +	 * fields are contained in the event.
> +	 */
> +	if (time_conv->header.size >
> +		((void *)&time_conv->time_cycles - (void *)time_conv)) {
> +		tc.time_cycles	       = time_conv->time_cycles;
> +		tc.time_mask	       = time_conv->time_mask;
> +		tc.cap_user_time_zero  = time_conv->cap_user_time_zero;
> +		tc.cap_user_time_short = time_conv->cap_user_time_short;
> +
> +		if (!tc.cap_user_time_zero)
> +			return 0;
> +	}
>  
>  	return tsc_to_perf_time(timestamp, &tc);
>  }
> 

