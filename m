Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF536AC0B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhDZGKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:10:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:62040 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDZGKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:10:34 -0400
IronPort-SDR: P8NSQvXcU/1WIXVG/Gxfl+jG6S8v/5nf8DJ2oRKWDC10RXYprM0o3Cd5SBpEX22c9bM1cK+sk7
 xyXGmvBY3aFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="260238511"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="260238511"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 23:09:52 -0700
IronPort-SDR: iP+pSDzK5amSXxyFVpJOKGXAPH+IV7mNLlGuKYq5o/Rd+rSATiYyL76JlWYP+vPQmaefq+bk7/
 PLDQs9OWmc9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="422516133"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 25 Apr 2021 23:09:48 -0700
Subject: Re: [PATCH v1 3/3] perf session: Dump PERF_RECORD_TIME_CONV event
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
 <20210412083459.462817-4-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <eff215af-d25c-1141-081c-93e62ada299b@intel.com>
Date:   Mon, 26 Apr 2021 09:10:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210412083459.462817-4-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/21 11:34 am, Leo Yan wrote:
> Now perf tool uses the common stub function process_event_op2_stub() for
> dumping TIME_CONV event, thus it doesn't output the clock parameters
> contained in the event.
> 
> This patch adds the callback function for dumping the hardware clock
> parameters in TIME_CONV event.
> 
> Before:
> 
>   # perf report -D
> 
>   0x978 [0x38]: event: 79
>   .
>   . ... raw event: size 56 bytes
>   .  0000:  4f 00 00 00 00 00 38 00 15 00 00 00 00 00 00 00  O.....8.........
>   .  0010:  00 00 40 01 00 00 00 00 86 89 0b bf df ff ff ff  ..@........<BF><DF><FF><FF><FF>
>   .  0020:  d1 c1 b2 39 03 00 00 00 ff ff ff ff ff ff ff 00  <D1><C1><B2>9....<FF><FF><FF><FF><FF><FF><FF>.
>   .  0030:  01 01 00 00 00 00 00 00                          ........
> 
>   0 0 0x978 [0x38]: PERF_RECORD_TIME_CONV
>   : unhandled!
> 
>   [...]
> 
> After:
> 
>   # perf report -D
> 
>   0x978 [0x38]: event: 79
>   .
>   . ... raw event: size 56 bytes
>   .  0000:  4f 00 00 00 00 00 38 00 15 00 00 00 00 00 00 00  O.....8.........
>   .  0010:  00 00 40 01 00 00 00 00 86 89 0b bf df ff ff ff  ..@........<BF><DF><FF><FF><FF>
>   .  0020:  d1 c1 b2 39 03 00 00 00 ff ff ff ff ff ff ff 00  <D1><C1><B2>9....<FF><FF><FF><FF><FF><FF><FF>.
>   .  0030:  01 01 00 00 00 00 00 00                          ........
> 
>   0 0 0x978 [0x38]: PERF_RECORD_TIME_CONV
>   ... Time Shift      21
>   ... Time Muliplier  20971520
>   ... Time Zero       18446743935180835206
>   ... Time Cycles     13852918225
>   ... Time Mask       0xffffffffffffff
>   ... Cap Time Zero   1
>   ... Cap Time Short  1
>   : unhandled!
> 
>   [...]
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

Perhaps could make use of a helper like the one described in my comments for patch 2.
Nevertheless:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>


> ---
>  tools/perf/util/session.c | 13 ++++++++++++-
>  tools/perf/util/tsc.c     | 31 +++++++++++++++++++++++++++++++
>  tools/perf/util/tsc.h     |  4 ++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index afca3d5fc851..19a0b2bc5f33 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -29,6 +29,7 @@
>  #include "thread-stack.h"
>  #include "sample-raw.h"
>  #include "stat.h"
> +#include "tsc.h"
>  #include "ui/progress.h"
>  #include "../perf.h"
>  #include "arch/common.h"
> @@ -451,6 +452,16 @@ static int process_stat_round_stub(struct perf_session *perf_session __maybe_unu
>  	return 0;
>  }
>  
> +static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
> +					union perf_event *event)
> +{
> +	if (dump_trace)
> +		perf_event__fprintf_time_conv(event, stdout);
> +
> +	dump_printf(": unhandled!\n");
> +	return 0;
> +}
> +
>  static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
>  						       union perf_event *event __maybe_unused,
>  						       u64 file_offset __maybe_unused)
> @@ -532,7 +543,7 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
>  	if (tool->stat_round == NULL)
>  		tool->stat_round = process_stat_round_stub;
>  	if (tool->time_conv == NULL)
> -		tool->time_conv = process_event_op2_stub;
> +		tool->time_conv = process_event_time_conv_stub;
>  	if (tool->feature == NULL)
>  		tool->feature = process_event_op2_stub;
>  	if (tool->compressed == NULL)
> diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
> index 62b4c75c966c..e2a2c63e5189 100644
> --- a/tools/perf/util/tsc.c
> +++ b/tools/perf/util/tsc.c
> @@ -1,5 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
> +#include <inttypes.h>
> +#include <string.h>
>  
>  #include <linux/compiler.h>
>  #include <linux/perf_event.h>
> @@ -110,3 +112,32 @@ u64 __weak rdtsc(void)
>  {
>  	return 0;
>  }
> +
> +size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
> +{
> +	struct perf_record_time_conv *tc = (struct perf_record_time_conv *)event;
> +	size_t ret;
> +
> +	ret  = fprintf(fp, "\n... Time Shift      %" PRI_lu64 "\n", tc->time_shift);
> +	ret += fprintf(fp, "... Time Muliplier  %" PRI_lu64 "\n", tc->time_mult);
> +	ret += fprintf(fp, "... Time Zero       %" PRI_lu64 "\n", tc->time_zero);
> +
> +	/*
> +	 * The event TIME_CONV was extended for the fields from "time_cycles"
> +	 * when supported cap_user_time_short, for backward compatibility,
> +	 * checks the event size and prints these extended fields if these
> +	 * fields are contained in the perf data file.
> +	 */
> +	if (tc->header.size > ((void *)&tc->time_cycles - (void *)tc)) {
> +		ret += fprintf(fp, "... Time Cycles     %" PRI_lu64 "\n",
> +			       tc->time_cycles);
> +		ret += fprintf(fp, "... Time Mask       %#" PRI_lx64 "\n",
> +			       tc->time_mask);
> +		ret += fprintf(fp, "... Cap Time Zero   %" PRId32 "\n",
> +			       tc->cap_user_time_zero);
> +		ret += fprintf(fp, "... Cap Time Short  %" PRId32 "\n",
> +			       tc->cap_user_time_short);
> +	}
> +
> +	return ret;
> +}
> diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
> index 72a15419f3b3..7d83a31732a7 100644
> --- a/tools/perf/util/tsc.h
> +++ b/tools/perf/util/tsc.h
> @@ -4,6 +4,8 @@
>  
>  #include <linux/types.h>
>  
> +#include "event.h"
> +
>  struct perf_tsc_conversion {
>  	u16 time_shift;
>  	u32 time_mult;
> @@ -24,4 +26,6 @@ u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
>  u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
>  u64 rdtsc(void);
>  
> +size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
> +
>  #endif // __PERF_TSC_H
> 

