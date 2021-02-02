Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A83B30B96D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhBBIRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:17:46 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2472 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhBBIRf (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:17:35 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DVHYs67QCz67jG5;
        Tue,  2 Feb 2021 16:10:41 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 2 Feb 2021 09:16:51 +0100
Received: from [10.47.5.6] (10.47.5.6) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 08:16:50 +0000
Subject: Re: [PATCH] perf metricgroup: Fix segmentation fault for metrics with
 no pmu event
To:     Jin Yao <yao.jin@linux.intel.com>, <acme@kernel.org>,
        <jolsa@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>
CC:     <Linux-kernel@vger.kernel.org>, <ak@linux.intel.com>,
        <kan.liang@intel.com>, <yao.jin@intel.com>
References: <20210202022424.10787-1-yao.jin@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <77af7dc5-eac4-4591-cba7-8937c94a058f@huawei.com>
Date:   Tue, 2 Feb 2021 08:15:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210202022424.10787-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.5.6]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2021 02:24, Jin Yao wrote:
> Hit a segmentation fault for DRAM_BW_Use on SKL/KBL.
> 
>    # perf stat -M DRAM_BW_Use -a -- sleep 1
> 
>    Segmentation fault (core dumped)
> 
>    (gdb) backtrace
>    #0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
>    #1  0x0000555c9facd9ce in find_evsel_group (evlist_used=0x555ca16d09c0, metric_events=0x555ca16e9160, has_constraint=false, metric_no_merge=false,
>        pctx=0x555ca16c8ff0, perf_evlist=0x555ca16c5340) at util/metricgroup.c:281
>    #2  metricgroup__setup_events (metric_events_list=0x555ca0044378 <stat_config+280>, perf_evlist=0x555ca16c5340, metric_no_merge=<optimized out>,
>        groups=0x7ffc599193f0) at util/metricgroup.c:323
>    #3  parse_groups (perf_evlist=perf_evlist@entry=0x555ca16c5340, str=str@entry=0x7ffc599205f8 "DRAM_BW_Use", metric_no_group=metric_no_group@entry=false,
>        metric_no_merge=metric_no_merge@entry=false, fake_pmu=fake_pmu@entry=0x0, metric_events=metric_events@entry=0x555ca0044378 <stat_config+280>,
>        map=0x555ca004e780 <pmu_events_map+768>) at util/metricgroup.c:1235
>    #4  0x0000555c9face096 in metricgroup__parse_groups (opt=<optimized out>, str=0x7ffc599205f8 "DRAM_BW_Use", metric_no_group=<optimized out>,
>        metric_no_merge=<optimized out>, metric_events=0x555ca0044378 <stat_config+280>) at util/metricgroup.c:1253
>    #5  0x0000555c9fbd084e in get_value (p=p@entry=0x7ffc599196b0, opt=0x555ca0043f60 <stat_options+4032>, flags=flags@entry=1) at parse-options.c:251
>    #6  0x0000555c9fbd1aa2 in parse_short_opt (options=<optimized out>, p=<optimized out>) at parse-options.c:351
>    #7  parse_options_step (usagestr=0x7ffc59919830, options=0x555ca0042fa0 <stat_options>, ctx=0x7ffc599196b0) at parse-options.c:539
>    #8  parse_options_subcommand (argc=argc@entry=7, argv=argv@entry=0x7ffc5991e6c0, options=options@entry=0x555ca0042fa0 <stat_options>,
>        subcommands=subcommands@entry=0x7ffc59919840, usagestr=usagestr@entry=0x7ffc59919830, flags=flags@entry=2) at parse-options.c:654
>    #9  0x0000555c9fa15154 in cmd_stat (argc=7, argv=0x7ffc5991e6c0) at builtin-stat.c:2136
>    #10 0x0000555c9fa8bafd in run_builtin (p=0x555ca004df20 <commands+288>, argc=7, argv=0x7ffc5991e6c0) at perf.c:312
>    #11 0x0000555c9f9f413a in handle_internal_command (argv=0x7ffc5991e6c0, argc=7) at perf.c:364
>    #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:408
>    #13 main (argc=7, argv=0x7ffc5991e6c0) at perf.c:538
> 
> DRAM_BW_Use uses an event 'duration_time' but it doesn't have pmu, so
> ev->leader->pmu_name is NULL for this case. See following code piece:
> 
> !strcmp(ev->leader->pmu_name,
> 	metric_events[i]->leader->pmu_name)
> 
> It causes the segmentation fault. Now check the pmu_name before strcmp.
> 
> Fixes: c2337d67199a("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>

This should be fixed in v5.11-rc6 - please check it.

9c880c24cb0d perf metricgroup: Fix for metrics containing duration_time

Thanks,
John


> ---
>   tools/perf/util/metricgroup.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index ee94d3e8dd65..a36a1305c506 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -280,6 +280,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>   			 */
>   			if (!has_constraint &&
>   			    ev->leader != metric_events[i]->leader &&
> +			    ev->leader->pmu_name &&
>   			    !strcmp(ev->leader->pmu_name,
>   				    metric_events[i]->leader->pmu_name))
>   				break;
> 

