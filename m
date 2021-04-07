Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C46D356CF9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbhDGNLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbhDGNLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:11:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 745A960FD7;
        Wed,  7 Apr 2021 13:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617801087;
        bh=LZjeNNARiK77qCmF+aVeu0ppCkWN2Cl5SLlM/DY5eqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VUnioXAMx6pc6R4HeehyO54VVxkHfgkAtx9uW9AB1AerBSxLfmGPvPp14XO5fL9wo
         gRrgJph/0RBYxGAmwZQiDBOb2T18hYyy82mFiV9T4nWiylD7Ez9uddl6Wa9w2qGWSs
         c755TRI6UdaiZHWMr3nQyo+G6PXQacqjGse8/XMvK3cswUK9Q1khN/OuF4p5vPoiIl
         MjEGKAuwZ6nWlAL9IvorEr+Hp6fRelUU7PewmdD5k6tNXxTGvOz+5d/J05bZ6LMFme
         aSbjRsFOJAv6/XXY1w9d0oHWmziZElCn2SrnNdv2jJ8CH+T6oLtfwCKAoV0tcfK+dZ
         wCff5frC+/Ahw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D42DB40647; Wed,  7 Apr 2021 10:11:23 -0300 (-03)
Date:   Wed, 7 Apr 2021 10:11:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     will@kernel.org, mathieu.poirier@linaro.org, leo.yan@linaro.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, irogers@google.com, linuxarm@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        zhangshaokun@hisilicon.com, pc@us.ibm.com
Subject: Re: [PATCH v3 0/6] perf arm64 metricgroup support
Message-ID: <YG2ve4j8IwyJ7W2N@kernel.org>
References: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617791570-165223-1-git-send-email-john.garry@huawei.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 07, 2021 at 06:32:44PM +0800, John Garry escreveu:
> This series contains support to get basic metricgroups working for
> arm64 CPUs.
> 
> Initial support is added for HiSilicon hip08 platform.
> 
> Some sample usage on Huawei D06 board:
> 
>  $ ./perf list metric    

Thanks, applied.

- Arnaldo

 
> List of pre-defined events (to be used in -e): 
> 
> Metrics:     
> 
>   bp_misp_flush
>        [BP misp flush L3 topdown metric]
>   branch_mispredicts
>        [Branch mispredicts L2 topdown metric]
>   core_bound
>        [Core bound L2 topdown metric]
>   divider
>        [Divider L3 topdown metric]
>   exe_ports_util
>        [EXE ports util L3 topdown metric]
>   fetch_bandwidth_bound
>        [Fetch bandwidth bound L2 topdown metric]
>   fetch_latency_bound
>        [Fetch latency bound L2 topdown metric]
>   fsu_stall
>        [FSU stall L3 topdown metric]
>   idle_by_icache_miss
> 
> $ sudo ./perf stat -v -M core_bound sleep 1
> Using CPUID 0x00000000480fd010
> metric expr (exe_stall_cycle - (mem_stall_anyload + armv8_pmuv3_0@event\=0x7005@)) / cpu_cycles for core_bound
> found event cpu_cycles
> found event armv8_pmuv3_0/event=0x7005/
> found event exe_stall_cycle
> found event mem_stall_anyload
> adding {cpu_cycles -> armv8_pmuv3_0/event=0x7001/
> mem_stall_anyload -> armv8_pmuv3_0/event=0x7004/
> Control descriptor is not initialized
> cpu_cycles: 989433 385050 385050
> armv8_pmuv3_0/event=0x7005/: 19207 385050 385050
> exe_stall_cycle: 900825 385050 385050
> mem_stall_anyload: 253516 385050 385050
> 
> Performance counter stats for 'sleep':
> 
> 989,433      cpu_cycles      #     0.63 core_bound
>   19,207      armv8_pmuv3_0/event=0x7005/
>  900,825      exe_stall_cycle
>  253,516      mem_stall_anyload
> 
>        0.000805809 seconds time elapsed
> 
>        0.000875000 seconds user
>        0.000000000 seconds sys
>        
> perf stat --topdown is not supported, as this requires the CPU PMU to
> expose (alias) events for the TopDown L1 metrics from sysfs, which arm 
> does not do. To get that to work, we probably need to make perf use the
> pmu-events cpumap to learn about those alias events.
> 
> Metric reuse support is added for pmu-events parse metric testcase.
> This had been broken on power9 recently:
> https://lore.kernel.org/lkml/20210324015418.GC8931@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com/ 
> 
> Differences to v2:
> - Add TB and RB tags (Thanks!)
> - Rename metricgroup__find_metric() from metricgroup_find_metric()
> - Change resolve_metric_simple() to rescan after any insert
> 
> Differences to v1:
> - Add pmu_events_map__find() as arm64-specific function
> - Fix metric reuse for pmu-events parse metric testcase 
> 
> John Garry (6):
>   perf metricgroup: Make find_metric() public with name change
>   perf test: Handle metric reuse in pmu-events parsing test
>   perf pmu: Add pmu_events_map__find()
>   perf vendor events arm64: Add Hisi hip08 L1 metrics
>   perf vendor events arm64: Add Hisi hip08 L2 metrics
>   perf vendor events arm64: Add Hisi hip08 L3 metrics
> 
>  tools/perf/arch/arm64/util/Build              |   1 +
>  tools/perf/arch/arm64/util/pmu.c              |  25 ++
>  .../arch/arm64/hisilicon/hip08/metrics.json   | 233 ++++++++++++++++++
>  tools/perf/tests/pmu-events.c                 |  83 ++++++-
>  tools/perf/util/metricgroup.c                 |  12 +-
>  tools/perf/util/metricgroup.h                 |   3 +-
>  tools/perf/util/pmu.c                         |   5 +
>  tools/perf/util/pmu.h                         |   1 +
>  tools/perf/util/s390-sample-raw.c             |   4 +-
>  9 files changed, 356 insertions(+), 11 deletions(-)
>  create mode 100644 tools/perf/arch/arm64/util/pmu.c
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> 
> -- 
> 2.26.2
> 

-- 

- Arnaldo
