Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6A30828C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 01:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhA2Ak0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 19:40:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:9252 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231138AbhA2AjZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 19:39:25 -0500
IronPort-SDR: sbHrHeP/JVKF2SWhVXLpYK9fvLIMzUHM6RulkOtAjoNlo4LmoAhICMvZpS0msIGaJdxMAiHhJR
 G37ESAzz1Uwg==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="176832787"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="176832787"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:37:34 -0800
IronPort-SDR: s08TLblClisQrLC90pPu0hD6sdRvTsQdu5fguuhmPEvxoE0eYc/r2lxU9n9MajJEIwPy7WBodp
 7GtvI7cKcxEg==
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="389075504"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 16:37:32 -0800
Subject: Re: [PATCH 2/2] perf script: Support dso filter
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210124232750.19170-1-yao.jin@linux.intel.com>
 <20210124232750.19170-2-yao.jin@linux.intel.com>
 <20210128131209.GD775562@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <680b4844-aa4a-cb75-72ea-1a70221beb1f@linux.intel.com>
Date:   Fri, 29 Jan 2021 08:37:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210128131209.GD775562@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 1/28/2021 9:12 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 25, 2021 at 07:27:50AM +0800, Jin Yao escreveu:
>> Other perf tool builtins have already supported dso filter.
>>
>> For example,
>> perf report --dso, which only considers symbols in these dsos.
>>
>> Now dso filter is supported for perf-script.
>>
>> root@kbl-ppc:~# ./perf script --dso "[kernel.kallsyms]"
>>              perf 18123 [000] 6142863.075104:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>>              perf 18123 [000] 6142863.075107:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>>              perf 18123 [000] 6142863.075108:         10   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>>              perf 18123 [000] 6142863.075109:        273   cycles:  ffffffff9ca7730a native_write_msr+0xa ([kernel.kallsyms])
>>              perf 18123 [000] 6142863.075110:       7684   cycles:  ffffffff9ca3c9c0 native_sched_clock+0x50 ([kernel.kallsyms])
>>              perf 18123 [000] 6142863.075112:     213017   cycles:  ffffffff9d765a92 syscall_exit_to_user_mode+0x32 ([kernel.kallsyms])
>>              perf 18123 [001] 6142863.075156:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>>              perf 18123 [001] 6142863.075158:          1   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
>>              perf 18123 [001] 6142863.075159:         17   cycles:  ffffffff9ca77308 native_write_msr+0x8 ([kernel.kallsyms])
> 
> Applied, and in testing it I noticed this fix was also needed, added
> just before it, please ack :-)
> 
> - Arnaldo
> 
> commit d4b6078bd58b799a8ea2a57842193504c867bee5
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Jan 28 09:52:47 2021 -0300
> 
>      perf tools: Fix DSO filtering when not finding a map for a sampled address
>      
>      When we lookup an address and don't find a map we should filter that
>      sample if the user specified a list of --dso entries to filter on, fix
>      it.
>      
>      Before:
>      
>        $ perf script
>                   sleep 274800  2843.556162:          1 cycles:u:  ffffffffbb26bff4 [unknown] ([unknown])
>                   sleep 274800  2843.556168:          1 cycles:u:  ffffffffbb2b047d [unknown] ([unknown])
>                   sleep 274800  2843.556171:          1 cycles:u:  ffffffffbb2706b2 [unknown] ([unknown])
>                   sleep 274800  2843.556174:          6 cycles:u:  ffffffffbb2b0267 [unknown] ([unknown])
>                   sleep 274800  2843.556176:         59 cycles:u:  ffffffffbb2b03b1 [unknown] ([unknown])
>                   sleep 274800  2843.556180:        691 cycles:u:  ffffffffbb26bff4 [unknown] ([unknown])
>                   sleep 274800  2843.556189:       9160 cycles:u:      7fa9550eeaa3 __GI___tunables_init+0xf3 (/usr/lib64/ld-2.32.so)
>                   sleep 274800  2843.556312:      86937 cycles:u:      7fa9550e157b _dl_lookup_symbol_x+0x4b (/usr/lib64/ld-2.32.so)
>        $
>      
>      So we have some samples we somehow didn't find in a map for, if we now
>      do:
>      
>        $ perf report --stdio --dso /usr/lib64/ld-2.32.so
>        # dso: /usr/lib64/ld-2.32.so
>        #
>        # Total Lost Samples: 0
>        #
>        # Samples: 8  of event 'cycles:u'
>        # Event count (approx.): 96856
>        #
>        # Overhead  Command  Symbol
>        # ........  .......  ........................
>        #
>            89.76%  sleep    [.] _dl_lookup_symbol_x
>             9.46%  sleep    [.] __GI___tunables_init
>             0.71%  sleep    [k] 0xffffffffbb26bff4
>             0.06%  sleep    [k] 0xffffffffbb2b03b1
>             0.01%  sleep    [k] 0xffffffffbb2b0267
>             0.00%  sleep    [k] 0xffffffffbb2706b2
>             0.00%  sleep    [k] 0xffffffffbb2b047d
>        $
>      
>      After this patch we get the right output with just entries for the DSOs
>      specified in --dso:
>      
>        $ perf report --stdio --dso /usr/lib64/ld-2.32.so
>        # dso: /usr/lib64/ld-2.32.so
>        #
>        # Total Lost Samples: 0
>        #
>        # Samples: 8  of event 'cycles:u'
>        # Event count (approx.): 96856
>        #
>        # Overhead  Command  Symbol
>        # ........  .......  ........................
>        #
>            89.76%  sleep    [.] _dl_lookup_symbol_x
>             9.46%  sleep    [.] __GI___tunables_init
>        $
>      
>        # To display the perf.data header info, please use --header/--header-only options.
>        #
>      
>      Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>      Cc: Andi Kleen <ak@linux.intel.com>
>      Cc: Ingo Molnar <mingo@redhat.com>
>      Cc: Jin Yao <yao.jin@linux.intel.com>
>      Cc: Jiri Olsa <jolsa@kernel.org>
>      Cc: Kan Liang <kan.liang@intel.com>
>      Cc: Namhyung Kim <namhyung@kernel.org>
>      Cc: Peter Zijlstra <peterz@infradead.org>
>      Fixes: 96415e4d3f5fdf9c ("perf symbols: Avoid unnecessary symbol loading when dso list is specified")
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index fbe8578e4c475773..208b6c141d98bb5d 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -692,6 +692,8 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>   		}
>   
>   		al->sym = map__find_symbol(al->map, al->addr);
> +	} else if (symbol_conf.dso_list) {
> +		al->filtered |= (1 << HIST_FILTER__DSO);
>   	}
>   
>   	if (symbol_conf.sym_list) {
> 

This fix guarantees the "[unknown]" dso is filtered when we enable "--dso" option (whatever the dso 
list in --dso).

Acked-by: Jin Yao (yao.jin@linux.intel.com>

Thanks
Jin Yao
