Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A293BC4BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhGFCWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:22:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:60404 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhGFCWd (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:22:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="208996522"
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; 
   d="scan'208";a="208996522"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 19:19:51 -0700
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; 
   d="scan'208";a="456897709"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 19:19:49 -0700
Subject: Re: [PATCH v3] perf stat: Disable NMI watchdog message on hybrid
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210610034557.29766-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d7d01f73-0253-fe4d-c98a-ae000e289e09@linux.intel.com>
Date:   Tue, 6 Jul 2021 10:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610034557.29766-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 6/10/2021 11:45 AM, Jin Yao wrote:
> If we run a single workload that only runs on big core, there is always a
> ugly message about disabling the NMI watchdog because the atom is not
> counted.
> 
> Before:
> 
>    # ./perf stat true
> 
>     Performance counter stats for 'true':
> 
>                  0.43 msec task-clock                #    0.396 CPUs utilized
>                     0      context-switches          #    0.000 /sec
>                     0      cpu-migrations            #    0.000 /sec
>                    45      page-faults               #  103.918 K/sec
>               639,634      cpu_core/cycles/          #    1.477 G/sec
>         <not counted>      cpu_atom/cycles/                                              (0.00%)
>               643,498      cpu_core/instructions/    #    1.486 G/sec
>         <not counted>      cpu_atom/instructions/                                        (0.00%)
>               123,715      cpu_core/branches/        #  285.694 M/sec
>         <not counted>      cpu_atom/branches/                                            (0.00%)
>                 4,094      cpu_core/branch-misses/   #    9.454 M/sec
>         <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> 
>           0.001092407 seconds time elapsed
> 
>           0.001144000 seconds user
>           0.000000000 seconds sys
> 
>    Some events weren't counted. Try disabling the NMI watchdog:
>            echo 0 > /proc/sys/kernel/nmi_watchdog
>            perf stat ...
>            echo 1 > /proc/sys/kernel/nmi_watchdog
> 
>    # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true
> 
>     Performance counter stats for 'true':
> 
>         <not counted>      cpu_atom/cycles/                                              (0.00%)
>         <not counted>      msr/tsc/                                                      (0.00%)
> 
>           0.001904106 seconds time elapsed
> 
>           0.001947000 seconds user
>           0.000000000 seconds sys
> 
>    Some events weren't counted. Try disabling the NMI watchdog:
>            echo 0 > /proc/sys/kernel/nmi_watchdog
>            perf stat ...
>            echo 1 > /proc/sys/kernel/nmi_watchdog
>    The events in group usually have to be from the same PMU. Try reorganizing the group.
> 
> Now we disable the NMI watchdog message on hybrid, otherwise there
> are too many false positives.
> 
> After:
> 
>    # ./perf stat true
> 
>     Performance counter stats for 'true':
> 
>                  0.79 msec task-clock                #    0.419 CPUs utilized
>                     0      context-switches          #    0.000 /sec
>                     0      cpu-migrations            #    0.000 /sec
>                    48      page-faults               #   60.889 K/sec
>               777,692      cpu_core/cycles/          #  986.519 M/sec
>         <not counted>      cpu_atom/cycles/                                              (0.00%)
>               669,147      cpu_core/instructions/    #  848.828 M/sec
>         <not counted>      cpu_atom/instructions/                                        (0.00%)
>               128,635      cpu_core/branches/        #  163.176 M/sec
>         <not counted>      cpu_atom/branches/                                            (0.00%)
>                 4,089      cpu_core/branch-misses/   #    5.187 M/sec
>         <not counted>      cpu_atom/branch-misses/                                       (0.00%)
> 
>           0.001880649 seconds time elapsed
> 
>           0.001935000 seconds user
>           0.000000000 seconds sys
> 
>    # ./perf stat -e '{cpu_atom/cycles/,msr/tsc/}' true
> 
>     Performance counter stats for 'true':
> 
>         <not counted>      cpu_atom/cycles/                                              (0.00%)
>         <not counted>      msr/tsc/                                                      (0.00%)
> 
>           0.000963319 seconds time elapsed
> 
>           0.000999000 seconds user
>           0.000000000 seconds sys
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v3:
>   - Use evlist__has_hybrid() to check there is at least one hybrid
>     event in evlist.
> 
> v2:
>   - If the group was mixed with hybrid event and non-hybrid event,
>     the NMI watchdog message was still reported. V2 adds checking
>     for hybrid event mixed group.
> 
>   tools/perf/util/stat-display.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index b759dfd633b4..55ae0d1705a9 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -19,6 +19,7 @@
>   #include "util.h"
>   #include "iostat.h"
>   #include "pmu-hybrid.h"
> +#include "evlist-hybrid.h"
>   
>   #define CNTR_NOT_SUPPORTED	"<not supported>"
>   #define CNTR_NOT_COUNTED	"<not counted>"
> @@ -465,9 +466,11 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
>   			config->csv_sep);
>   
>   		if (counter->supported) {
> -			config->print_free_counters_hint = 1;
> -			if (is_mixed_hw_group(counter))
> -				config->print_mixed_hw_group_error = 1;
> +			if (!evlist__has_hybrid(counter->evlist)) {
> +				config->print_free_counters_hint = 1;
> +				if (is_mixed_hw_group(counter))
> +					config->print_mixed_hw_group_error = 1;
> +			}
>   		}
>   
>   		fprintf(config->output, "%-*s%s",
> 

Any comments for v3?

Thanks
Jin Yao


