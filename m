Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C225B30D077
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhBCAtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:49:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:44425 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232988AbhBCAsw (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:48:52 -0500
IronPort-SDR: jSg1NwVPxN+kYRcjXpuW4I9oeiHyFs5kFJ0Vk3mUxpQCcBrVbiYSIdGuFh/wdkwAGgG2wao3Cl
 8NKtzr7TpwWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="265791496"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="265791496"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:46:58 -0800
IronPort-SDR: e3udEgRwWXpTOOYkEZYE+ai0txKaVx5deGQbdUENoVxjTSAGCCe763setHCSiunMiFFn/Gpca+
 a56QA5WyrtUg==
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="392027400"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.27]) ([10.238.4.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:46:55 -0800
Subject: Re: [PATCH] perf metricgroup: Fix segmentation fault for metrics with
 no pmu event
To:     John Garry <john.garry@huawei.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210202022424.10787-1-yao.jin@linux.intel.com>
 <77af7dc5-eac4-4591-cba7-8937c94a058f@huawei.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <c73fff2c-8525-f496-66da-2cb4a8ccbf94@linux.intel.com>
Date:   Wed, 3 Feb 2021 08:46:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <77af7dc5-eac4-4591-cba7-8937c94a058f@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2/2/2021 4:15 PM, John Garry wrote:
> On 02/02/2021 02:24, Jin Yao wrote:
>> Hit a segmentation fault for DRAM_BW_Use on SKL/KBL.
>>
>>    # perf stat -M DRAM_BW_Use -a -- sleep 1
>>
>>    Segmentation fault (core dumped)
>>
>>    (gdb) backtrace
>>    #0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
>>    #1  0x0000555c9facd9ce in find_evsel_group (evlist_used=0x555ca16d09c0, 
>> metric_events=0x555ca16e9160, has_constraint=false, metric_no_merge=false,
>>        pctx=0x555ca16c8ff0, perf_evlist=0x555ca16c5340) at util/metricgroup.c:281
>>    #2  metricgroup__setup_events (metric_events_list=0x555ca0044378 <stat_config+280>, 
>> perf_evlist=0x555ca16c5340, metric_no_merge=<optimized out>,
>>        groups=0x7ffc599193f0) at util/metricgroup.c:323
>>    #3  parse_groups (perf_evlist=perf_evlist@entry=0x555ca16c5340, str=str@entry=0x7ffc599205f8 
>> "DRAM_BW_Use", metric_no_group=metric_no_group@entry=false,
>>        metric_no_merge=metric_no_merge@entry=false, fake_pmu=fake_pmu@entry=0x0, 
>> metric_events=metric_events@entry=0x555ca0044378 <stat_config+280>,
>>        map=0x555ca004e780 <pmu_events_map+768>) at util/metricgroup.c:1235
>>    #4  0x0000555c9face096 in metricgroup__parse_groups (opt=<optimized out>, str=0x7ffc599205f8 
>> "DRAM_BW_Use", metric_no_group=<optimized out>,
>>        metric_no_merge=<optimized out>, metric_events=0x555ca0044378 <stat_config+280>) at 
>> util/metricgroup.c:1253
>>    #5  0x0000555c9fbd084e in get_value (p=p@entry=0x7ffc599196b0, opt=0x555ca0043f60 
>> <stat_options+4032>, flags=flags@entry=1) at parse-options.c:251
>>    #6  0x0000555c9fbd1aa2 in parse_short_opt (options=<optimized out>, p=<optimized out>) at 
>> parse-options.c:351
>>    #7  parse_options_step (usagestr=0x7ffc59919830, options=0x555ca0042fa0 <stat_options>, 
>> ctx=0x7ffc599196b0) at parse-options.c:539
>>    #8  parse_options_subcommand (argc=argc@entry=7, argv=argv@entry=0x7ffc5991e6c0, 
>> options=options@entry=0x555ca0042fa0 <stat_options>,
>>        subcommands=subcommands@entry=0x7ffc59919840, usagestr=usagestr@entry=0x7ffc59919830, 
>> flags=flags@entry=2) at parse-options.c:654
>>    #9  0x0000555c9fa15154 in cmd_stat (argc=7, argv=0x7ffc5991e6c0) at builtin-stat.c:2136
>>    #10 0x0000555c9fa8bafd in run_builtin (p=0x555ca004df20 <commands+288>, argc=7, 
>> argv=0x7ffc5991e6c0) at perf.c:312
>>    #11 0x0000555c9f9f413a in handle_internal_command (argv=0x7ffc5991e6c0, argc=7) at perf.c:364
>>    #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:408
>>    #13 main (argc=7, argv=0x7ffc5991e6c0) at perf.c:538
>>
>> DRAM_BW_Use uses an event 'duration_time' but it doesn't have pmu, so
>> ev->leader->pmu_name is NULL for this case. See following code piece:
>>
>> !strcmp(ev->leader->pmu_name,
>>     metric_events[i]->leader->pmu_name)
>>
>> It causes the segmentation fault. Now check the pmu_name before strcmp.
>>
>> Fixes: c2337d67199a("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> 
> This should be fixed in v5.11-rc6 - please check it.
> 
> 9c880c24cb0d perf metricgroup: Fix for metrics containing duration_time
> 
> Thanks,
> John

Oh, I see, your patch is in Arnaldo's perf/urgent branch. Sorry about that, I just tested Arnaldo's 
perf/core branch. :(

Thanks
Jin Yao
