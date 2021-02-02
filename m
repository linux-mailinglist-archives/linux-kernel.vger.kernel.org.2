Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE14030B53E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbhBBC1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 21:27:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:40273 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhBBC1B (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 21:27:01 -0500
IronPort-SDR: P9iaLMxu/mifkhPVLXnkeEFS1kgPQX5L9X3H5TAJu0Ra4uDa1vq5SUK3yydG8+M/90G7cD3+zd
 DBScRaGXC5hQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="180009046"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="180009046"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 18:25:16 -0800
IronPort-SDR: BwjMNl1gpT2wbFsYBKn4zpeRWFwksJQFNqnWVgFz7ohL2fSBapHZw4AXT4Bb8IxR848GM2K2ZR
 Mvo8wk8iQj5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="479385046"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 01 Feb 2021 18:25:13 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, john.garry@huawei.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf metricgroup: Fix segmentation fault for metrics with no pmu event
Date:   Tue,  2 Feb 2021 10:24:24 +0800
Message-Id: <20210202022424.10787-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a segmentation fault for DRAM_BW_Use on SKL/KBL.

  # perf stat -M DRAM_BW_Use -a -- sleep 1

  Segmentation fault (core dumped)

  (gdb) backtrace
  #0  __strcmp_sse2_unaligned () at ../sysdeps/x86_64/multiarch/strcmp-sse2-unaligned.S:31
  #1  0x0000555c9facd9ce in find_evsel_group (evlist_used=0x555ca16d09c0, metric_events=0x555ca16e9160, has_constraint=false, metric_no_merge=false,
      pctx=0x555ca16c8ff0, perf_evlist=0x555ca16c5340) at util/metricgroup.c:281
  #2  metricgroup__setup_events (metric_events_list=0x555ca0044378 <stat_config+280>, perf_evlist=0x555ca16c5340, metric_no_merge=<optimized out>,
      groups=0x7ffc599193f0) at util/metricgroup.c:323
  #3  parse_groups (perf_evlist=perf_evlist@entry=0x555ca16c5340, str=str@entry=0x7ffc599205f8 "DRAM_BW_Use", metric_no_group=metric_no_group@entry=false,
      metric_no_merge=metric_no_merge@entry=false, fake_pmu=fake_pmu@entry=0x0, metric_events=metric_events@entry=0x555ca0044378 <stat_config+280>,
      map=0x555ca004e780 <pmu_events_map+768>) at util/metricgroup.c:1235
  #4  0x0000555c9face096 in metricgroup__parse_groups (opt=<optimized out>, str=0x7ffc599205f8 "DRAM_BW_Use", metric_no_group=<optimized out>,
      metric_no_merge=<optimized out>, metric_events=0x555ca0044378 <stat_config+280>) at util/metricgroup.c:1253
  #5  0x0000555c9fbd084e in get_value (p=p@entry=0x7ffc599196b0, opt=0x555ca0043f60 <stat_options+4032>, flags=flags@entry=1) at parse-options.c:251
  #6  0x0000555c9fbd1aa2 in parse_short_opt (options=<optimized out>, p=<optimized out>) at parse-options.c:351
  #7  parse_options_step (usagestr=0x7ffc59919830, options=0x555ca0042fa0 <stat_options>, ctx=0x7ffc599196b0) at parse-options.c:539
  #8  parse_options_subcommand (argc=argc@entry=7, argv=argv@entry=0x7ffc5991e6c0, options=options@entry=0x555ca0042fa0 <stat_options>,
      subcommands=subcommands@entry=0x7ffc59919840, usagestr=usagestr@entry=0x7ffc59919830, flags=flags@entry=2) at parse-options.c:654
  #9  0x0000555c9fa15154 in cmd_stat (argc=7, argv=0x7ffc5991e6c0) at builtin-stat.c:2136
  #10 0x0000555c9fa8bafd in run_builtin (p=0x555ca004df20 <commands+288>, argc=7, argv=0x7ffc5991e6c0) at perf.c:312
  #11 0x0000555c9f9f413a in handle_internal_command (argv=0x7ffc5991e6c0, argc=7) at perf.c:364
  #12 run_argv (argcp=<synthetic pointer>, argv=<synthetic pointer>) at perf.c:408
  #13 main (argc=7, argv=0x7ffc5991e6c0) at perf.c:538

DRAM_BW_Use uses an event 'duration_time' but it doesn't have pmu, so
ev->leader->pmu_name is NULL for this case. See following code piece:

!strcmp(ev->leader->pmu_name,
	metric_events[i]->leader->pmu_name)

It causes the segmentation fault. Now check the pmu_name before strcmp.

Fixes: c2337d67199a("perf metricgroup: Fix metrics using aliases covering multiple PMUs")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee94d3e8dd65..a36a1305c506 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -280,6 +280,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			 */
 			if (!has_constraint &&
 			    ev->leader != metric_events[i]->leader &&
+			    ev->leader->pmu_name &&
 			    !strcmp(ev->leader->pmu_name,
 				    metric_events[i]->leader->pmu_name))
 				break;
-- 
2.17.1

