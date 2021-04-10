Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FBC35ABF6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhDJIqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:46:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:53014 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhDJIqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:46:08 -0400
IronPort-SDR: RmxAJe5jPDJFqJNs2npruoW6wvBj0oFBB7OVb8U7p1sD1mtElmp3LSBTsY/iUnWQFKt6y1tMmu
 oyXPf5dum8Mw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="191759915"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="191759915"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 01:45:54 -0700
IronPort-SDR: Nb6eMX/CXcXmCCObIzTd+MvdPeTLALusHgakQQ/hs1lVGhW9NMrBmB1yvgkRQv4EK15QFMUKNj
 4ywgVfjJFl4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="520553260"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2021 01:45:51 -0700
Subject: Re: [PATCH] perf session: Dump PERF_RECORD_TIME_CONV event
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20210410031930.18064-1-leo.yan@linaro.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <9e100c55-16b1-090e-1e81-334a55bd4b15@intel.com>
Date:   Sat, 10 Apr 2021 11:46:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210410031930.18064-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/21 6:19 am, Leo Yan wrote:
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
> ---
>  tools/perf/util/session.c | 13 ++++++++++++-
>  tools/perf/util/tsc.c     | 18 ++++++++++++++++++
>  tools/perf/util/tsc.h     |  4 ++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 9a8808507bd9..75931c8054aa 100644
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
> index 62b4c75c966c..4ac3cc72f3e1 100644
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
> @@ -110,3 +112,19 @@ u64 __weak rdtsc(void)
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
> +	ret += fprintf(fp, "... Time Cycles     %" PRI_lu64 "\n", tc->time_cycles);
> +	ret += fprintf(fp, "... Time Mask       %#" PRI_lx64 "\n", tc->time_mask);
> +	ret += fprintf(fp, "... Cap Time Zero   %" PRId32 "\n", tc->cap_user_time_zero);
> +	ret += fprintf(fp, "... Cap Time Short  %" PRId32 "\n", tc->cap_user_time_short);

Hi Leo

I think there might be some more work related to this.

Pedantically, shouldn't you cater for backward compatibility and
not assume the following were in the perf.data file:
                                                                                                                                           
       __u64                    time_cycles;                                                                                                                                             
       __u64                    time_mask;                                                                                                                                               
       bool                     cap_user_time_zero;                                                                                                                                      
       bool                     cap_user_time_short;   

That means checking the event size.

Also PERF_RECORD_TIME_CONV should have its own byte-swapper instead of  
perf_event__all64_swap() - also checking event size.

i.e. fixes for:

  commit d110162cafc80dad0622cfd40f3113aebb77e1bb
  Author: Leo Yan <leo.yan@linaro.org>
  Date:   Mon Sep 14 19:53:09 2020 +0800

    perf tsc: Support cap_user_time_short for event TIME_CONV
    

Regards
Adrian
