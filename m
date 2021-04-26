Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEC236ABD7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhDZFkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:40:36 -0400
Received: from mga01.intel.com ([192.55.52.88]:29258 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDZFkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:40:35 -0400
IronPort-SDR: 139w858mWYGkfMWXtpNSMBs0NLpsvalKNpW0S32yUv24U5ZRGHe16A2F0+0JtK560xgKnvweu5
 fXh/yvft9ypg==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="216979245"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="216979245"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:39:51 -0700
IronPort-SDR: biyUaBdAexN6+2TN5TJCfWhh2CjsjNSjzmviRAjwOv/w2fDrX2Lec5llX1X3FPcE+aAZteZp64
 YRaTuzBM6QTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422503436"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2021 22:39:48 -0700
Subject: Re: [PATCH v1 2/3] perf session: Add swap operation for event
 TIME_CONV
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
 <20210412083459.462817-3-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <1b4fa7c3-79cd-6f73-873e-4792b8a1b732@intel.com>
Date:   Mon, 26 Apr 2021 08:40:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412083459.462817-3-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 11:34 am, Leo Yan wrote:
> Since commit d110162cafc8 ("perf tsc: Support cap_user_time_short for
> event TIME_CONV"), the event PERF_RECORD_TIME_CONV has extended the data
> structure for clock parameters.
> 
> To be backwards-compatible, this patch adds a dedicated swap operation
> for the event PERF_RECORD_TIME_CONV, based on checking the event size,
> it can support both for the old and new event formats.
> 
> Fixes: d110162cafc8 ("perf tsc: Support cap_user_time_short for event TIME_CONV")
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/session.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 9a8808507bd9..afca3d5fc851 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -949,6 +949,26 @@ static void perf_event__stat_round_swap(union perf_event *event,
>  	event->stat_round.time = bswap_64(event->stat_round.time);
>  }
>  
> +static void perf_event__time_conv_swap(union perf_event *event,
> +				       bool sample_id_all __maybe_unused)
> +{
> +	size_t time_zero_size;
> +
> +	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
> +	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
> +	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
> +
> +	time_zero_size = (void *)&event->time_conv.time_cycles - (void *)event;
> +	if (event->header.size > time_zero_size) {

I wonder if we could have a helper for this e.g. (untested)

#define event_contains(obj, mem) (obj.header.size > offsetof(typeof(obj), mem))

	if (event_contains(event->time_conv, time_cycles)) {


> +		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
> +		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
> +		event->time_conv.cap_user_time_zero =
> +			bswap_32(event->time_conv.cap_user_time_zero);
> +		event->time_conv.cap_user_time_short =
> +			bswap_32(event->time_conv.cap_user_time_short);

'struct perf_record_time_conv' contains bool, the sizeof which, AFAIK, is not defined.
Is it really 4 bytes on your implementation?  It is only 1 byte with gcc on x86.

Either way, you should change 'struct perf_record_time_conv' so it uses a type of known size.
Since you are the only one using it, it should match your implementation.

> +	}
> +}
> +
>  typedef void (*perf_event__swap_op)(union perf_event *event,
>  				    bool sample_id_all);
>  
> @@ -985,7 +1005,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
>  	[PERF_RECORD_STAT]		  = perf_event__stat_swap,
>  	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
>  	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
> -	[PERF_RECORD_TIME_CONV]		  = perf_event__all64_swap,
> +	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
>  	[PERF_RECORD_HEADER_MAX]	  = NULL,
>  };
>  
> 

