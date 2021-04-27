Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D083B36BCBE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 02:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbhD0Asy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 20:48:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:15744 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232022AbhD0Asv (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 20:48:51 -0400
IronPort-SDR: H6V/V/RCrIfhOQ/I+RMckzg7w0OojMAPdGHX/B4LttQzhtcpq4MoO7WhtJkWumtSupzMapUqlc
 SxKQ1ZrHLH7g==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="196487137"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="196487137"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 17:48:08 -0700
IronPort-SDR: GYEjqFgjeWR2MAWoKQGW9l+fnjmZpiz6pJvNE0U0tp5kYcPCsYRxbMZztAvy9kAbB7b5vQg63R
 oo+rLDS+5KEA==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="429601024"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 17:48:05 -0700
Subject: Re: [PATCH v5 00/26] perf tool: AlderLake hybrid support series 1
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
 <YIclfrZzqt388xBP@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <726ec7d5-52b0-42d2-a13f-184ed402d2aa@linux.intel.com>
Date:   Tue, 27 Apr 2021 08:48:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIclfrZzqt388xBP@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 4/27/2021 4:41 AM, Arnaldo Carvalho de Melo wrote:
> Em Fri, Apr 23, 2021 at 01:35:15PM +0800, Jin Yao escreveu:
>> AlderLake uses a hybrid architecture utilizing Golden Cove cores
>> (core cpu) and Gracemont cores (atom cpu). Each cpu has dedicated
>> event list. Some events are available on core cpu, some events
>> are available on atom cpu and some events can be available on both.
>>
>> Kernel exports new pmus "cpu_core" and "cpu_atom" through sysfs:
>> /sys/devices/cpu_core
>> /sys/devices/cpu_atom
> 
> [acme@five perf]$ b4 am -t -s -l --cc-trailers 20210423053541.12521-1-yao.jin@linux.intel.com
> Looking up https://lore.kernel.org/r/20210423053541.12521-1-yao.jin%40linux.intel.com
> Grabbing thread from lore.kernel.org/lkml
> Analyzing 29 messages in the thread
> ---
> Writing ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
>    [PATCH v5 01/26] tools headers uapi: Update tools's copy of linux/perf_event.h
>      + Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>      + Link: https://lore.kernel.org/r/20210423053541.12521-2-yao.jin@linux.intel.com
>      + Cc: peterz@infradead.org
>      + Cc: kan.liang@intel.com
>      + Cc: yao.jin@intel.com
>      + Cc: acme@kernel.org
>      + Cc: jolsa@kernel.org
>      + Cc: ak@linux.intel.com
>      + Cc: alexander.shishkin@linux.intel.com
>      + Cc: mingo@redhat.com
>      + Cc: Linux-kernel@vger.kernel.org
> <SNIP>
> ---
> Total patches: 26
> ---
> Cover: ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.cover
>   Link: https://lore.kernel.org/r/20210423053541.12521-1-yao.jin@linux.intel.com
>   Base: not found
>         git am ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
> [acme@five perf]$        git am ./v5_20210423_yao_jin_perf_tool_alderlake_hybrid_support_series_1.mbx
> Applying: tools headers uapi: Update tools's copy of linux/perf_event.h
> Applying: perf jevents: Support unit value "cpu_core" and "cpu_atom"
> Applying: perf pmu: Simplify arguments of __perf_pmu__new_alias
> Applying: perf pmu: Save pmu name
> Applying: perf pmu: Save detected hybrid pmus to a global pmu list
> Applying: perf pmu: Add hybrid helper functions
> Applying: perf stat: Uniquify hybrid event name
> error: patch failed: tools/perf/builtin-stat.c:68
> error: tools/perf/builtin-stat.c: patch does not apply
> error: patch failed: tools/perf/util/stat-display.c:17
> error: tools/perf/util/stat-display.c: patch does not apply
> Patch failed at 0007 perf stat: Uniquify hybrid event name
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> [acme@five perf]$
> 
> [acme@five perf]$ git am --show-current-patch=diff | patch -p1
> patching file tools/perf/builtin-stat.c
> Hunk #1 FAILED at 68.
> Hunk #2 succeeded at 2402 (offset 24 lines).
> 1 out of 2 hunks FAILED -- saving rejects to file tools/perf/builtin-stat.c.rej
> patching file tools/perf/util/evsel.h
> Hunk #1 succeeded at 116 (offset 1 line).
> patching file tools/perf/util/parse-events.c
> patching file tools/perf/util/stat-display.c
> Hunk #1 FAILED at 17.
> Hunk #2 succeeded at 538 (offset 6 lines).
> Hunk #3 succeeded at 553 (offset 6 lines).
> 1 out of 3 hunks FAILED -- saving rejects to file tools/perf/util/stat-display.c.rej
> [acme@five perf]$ vim tools/perf/builtin-stat.c.rej
> [acme@five perf]$ cat tools/perf/builtin-stat.c.rej
> --- tools/perf/builtin-stat.c
> +++ tools/perf/builtin-stat.c
> @@ -68,6 +68,7 @@
>   #include "util/affinity.h"
>   #include "util/pfm.h"
>   #include "util/bpf_counter.h"
> +#include "util/pmu-hybrid.h"
>   #include "asm/bug.h"
> 
>   #include <linux/time64.h>
> [acme@five perf]$ cat tools/perf/util/stat-display.c.rej
> --- tools/perf/util/stat-display.c
> +++ tools/perf/util/stat-display.c
> @@ -17,6 +17,7 @@
>   #include "cgroup.h"
>   #include <api/fs/fs.h>
>   #include "util.h"
> +#include "pmu-hybrid.h"
> 
>   #define CNTR_NOT_SUPPORTED	"<not supported>"
>   #define CNTR_NOT_COUNTED	"<not counted>"
> [acme@five perf]$
> 
> 
> Its clashing with some BPF changes by Song that are still under review
> but I have in my tmp.perf/core branch so that I can test build it while
> I wait for Jiri to say if Song addressed all his comments.
> 
> So after you address the new round of comments for v5 you can please
> rebase on tmp.perf/core or, at that point, perf/core.
> 
> - Arnaldo
> 

The v6 is ready now which is based on perf/core. It only has a minor update (adding new test case 
for cache events with pmu prefix). There is no other updates in v6.

I'm OK to rebase v6 on tmp.perf/core first and then post the new series.

Thanks
Jin Yao
