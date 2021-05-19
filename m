Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237A3388AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344801AbhESJiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 05:38:09 -0400
Received: from outbound-smtp54.blacknight.com ([46.22.136.238]:60403 "EHLO
        outbound-smtp54.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238196AbhESJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 05:38:07 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp54.blacknight.com (Postfix) with ESMTPS id 3A2ABFACD1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 10:36:47 +0100 (IST)
Received: (qmail 5319 invoked from network); 19 May 2021 09:36:47 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 May 2021 09:36:47 -0000
Date:   Wed, 19 May 2021 10:36:44 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v3 0/8] sched/fair: wake_affine improvements
Message-ID: <20210519093644.GD3735@techsingularity.net>
References: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210513074027.543926-1-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 01:10:19PM +0530, Srikar Dronamraju wrote:
> Recently we found that some of the benchmark numbers on Power10 were lesser
> than expected. Some analysis showed that the problem lies in the fact that
> L2-Cache on Power10 is at core level i.e only 4 threads share the L2-cache.
> 
> One probable solution to the problem was worked by Gautham where he posted
> http://lore.kernel.org/lkml/1617341874-1205-1-git-send-email-ego@linux.vnet.ibm.com/t/#u
> a patch that marks MC domain as LLC.
> 
> Here the focus is on improving the current core scheduler's wakeup
> mechanism by looking at idle-cores and nr_busy_cpus that is already
> maintained per Last level cache(aka LLC)
> 
> Hence this approach can work well with the mc-llc too. It can help
> other architectures too.
> 

It took a while for the test grid to process this series but I finally
got results of this on different machines, including Zen1-3 that has
many LLCs per NUMA node and it's a mixed bag.  While there are some
substantial gains depending on workload and machine, there are also some
substantial losses. The most consistent in terms of showing losses was
tbench4 but in general, the mix of major gains and losses may lead to a
game of whack-a-mole regression hinting where fixes for one workload and
machine introduce regressions in another setup.

The mix of gains/losses across multiple machines makes it difficult to
reach a solid ack/nak conclusion. My biggest concern is that machines with
multiple LLCs-per-node were most likely to show major gains or major losses
depending on the workload and the treatment of LLCs is a big aspect of
what the series does. I have not read the series in detail but the idler
LLC selection appears to ignore NUMA locality and that might be part of
the problem.

Relative to your own results

Hackbench: I didn't see the same gains but that is likely related to
	architecture and the topology.

DayTrader: I think this is an IBM benchmark that I'm guessing has a
	complex software stack required to reproduce it so I cannot
	comment.

Schbench: What parameters did you use? For me, I saw some big losses on
	the 99%+ percentiles but I could be using different parameters
	to you

Mongodb: I do not have an equivalent workload. What load generator did
	you use and what parameters?

More details below

NAS Parallal Benchmark was mostly ok. Zen2 for NAS-OMP-SP showed a 20%
	regression and higher system CPU usage but it was an outlier.
	While there were some other negative results, they were relatively
	short-lived in terms of absolute time.

DBench on XFS -- mostly ok. Intel machines were neutral. Zen2 showed
	0-8% regressions depending on client count but Zen3 showed major
	gains 0-39%

SpecJBB 2005 (1 VM per NUMA node) showed variable results across both
	Intel and AMD based machines.
	2-socket Broadwell:	-10% loss to 16% gain but the gain was
				an outlier, it was mostly losses
	2-socket Haswell:	-11% loss to 2% gain, mostly losses
	2-socket Zen1:		-5% loss to 20% gain, low thread loss, high thread gain
	2-socket Zen2:		-25% loss to 44% gain, mostly losses
	2-socket Zen3:		-4% loss to 42% gain, mostly gains

Perf bench pipe showed mostly small losses and higher system CPU usage.
	Worst case was an 8% loss, but mostly it was in the 0-2% range

Git checkout (shellscript intensive) was mostly neutral on Intel but
	gained heavily on Zen*
	Zen1:	+5.48% gain
	Zen2:	+5.42% gain
	Zen3:	+17%   gain

Kernel compilation: Mix of gains and losses, mostly neural with one
	exception

Schbench (Facebook-based benchmark sensitive to wakeup latency) fine on
	most machines but some major regressing outliers on zen3

Hackbench-process-pipes: Mostly neutral, Zen 1 showed gains, Zen 3
	showed losses

Hackbench-process-sockets: Mostly neural but for Zen, Zen1 showed
	losses, Zen 3 showed gains (the opposite of pipes)

Hackbench-process-pipes: Bit mixed but mostly either netural or gains

Hackbench-socket-pipes: Bit mixed but Zen1 showed mostly losses

Netperf-TCP_STREAM: Mostly slight mix except for Zen3 with 15-26% losses

        Zen 3 netperf-tcp
                                    5.13.0-rc1             5.13.0-rc1
                                       vanilla   sched-wakeidler-v3r1
        Hmean     64        2278.21 (   0.00%)     1670.67 * -26.67%*
        Hmean     128       4299.84 (   0.00%)     3199.04 * -25.60%*
        Hmean     256       8176.62 (   0.00%)     5800.95 * -29.05%*
        Hmean     1024     27050.12 (   0.00%)    20743.79 * -23.31%*
        Hmean     2048     42558.18 (   0.00%)    33819.75 * -20.53%*
        Hmean     3312     50576.24 (   0.00%)    39549.06 * -21.80%*
        Hmean     4096     57782.00 (   0.00%)    49030.97 * -15.14%*
        Hmean     8192     72400.49 (   0.00%)    53489.29 * -26.12%*
        Hmean     16384    80997.97 (   0.00%)    63521.05 * -21.58%*

Netperf-UDP_STREAM: Mostly neutral but some machines show 0-13% losses

Tbench4: Mostly leaned towards being a loss

Single-socket Skylake
                         5.13.0-rc1             5.13.0-rc1
                            vanilla   sched-wakeidler-v3r1
Hmean     1       591.86 (   0.00%)      585.56 *  -1.07%*
Hmean     2      1050.84 (   0.00%)     1069.35 *   1.76%*
Hmean     4      1546.96 (   0.00%)     1501.62 *  -2.93%*
Hmean     8      2740.19 (   0.00%)     2675.56 *  -2.36%*
Hmean     16     2450.22 (   0.00%)     2413.80 *  -1.49%*
Hmean     32     2426.44 (   0.00%)     2361.36 *  -2.68%*

	Small losses, higher system CPU usage (not shown)

2-socket Cascadelake
                          5.13.0-rc1             5.13.0-rc1
                             vanilla   sched-wakeidler-v3r1
Hmean     1        544.22 (   0.00%)      548.16 *   0.72%*
Hmean     2       1058.67 (   0.00%)     1044.67 *  -1.32%*
Hmean     4       2049.38 (   0.00%)     2017.99 *  -1.53%*
Hmean     8       4071.51 (   0.00%)     3893.55 *  -4.37%*
Hmean     16      6575.50 (   0.00%)     6576.01 (   0.01%)
Hmean     32     10185.98 (   0.00%)    10303.26 *   1.15%*
Hmean     64     12145.38 (   0.00%)    11616.73 *  -4.35%*
Hmean     128    22335.44 (   0.00%)    21765.91 *  -2.55%*
Hmean     256    20274.37 (   0.00%)    21505.92 *   6.07%*
Hmean     320    20709.22 (   0.00%)    20733.21 *   0.12%*

	Mix of gains and losses, higher system CPU usage

2-socket Broadwell
                          5.13.0-rc1             5.13.0-rc1
                             vanilla   sched-wakeidler-v3r1
Hmean     1        438.53 (   0.00%)      447.02 *   1.94%*
Hmean     2        835.80 (   0.00%)      786.98 *  -5.84%*
Hmean     4       1527.05 (   0.00%)     1436.70 *  -5.92%*
Hmean     8       2952.17 (   0.00%)     2806.30 *  -4.94%*
Hmean     16      5237.13 (   0.00%)     5191.26 *  -0.88%*
Hmean     32      9222.13 (   0.00%)     9004.89 *  -2.36%*
Hmean     64     10805.29 (   0.00%)    10342.93 *  -4.28%*
Hmean     128    18469.14 (   0.00%)    17522.78 *  -5.12%*
Hmean     256    16641.85 (   0.00%)    16278.08 *  -2.19%*
Hmean     320    16623.42 (   0.00%)    16521.47 *  -0.61%*

	Mostly small losses, slight increase CPU usage

2-soocket Zen1

tbench4
                          5.13.0-rc1             5.13.0-rc1
                             vanilla   sched-wakeidler-v3r1
Hmean     1        220.27 (   0.00%)      218.67 *  -0.73%*
Hmean     2        455.18 (   0.00%)      430.82 *  -5.35%*
Hmean     4        845.38 (   0.00%)      887.05 *   4.93%*
Hmean     8       1645.02 (   0.00%)     1563.07 *  -4.98%*
Hmean     16      3109.18 (   0.00%)     3074.53 *  -1.11%*
Hmean     32      4854.40 (   0.00%)     5167.61 *   6.45%*
Hmean     64     10793.06 (   0.00%)     7767.98 * -28.03%*
Hmean     128    12398.50 (   0.00%)    15067.49 *  21.53%*
Hmean     256    16756.69 (   0.00%)    11214.53 * -33.07%*
Hmean     512    10186.47 (   0.00%)    15159.09 *  48.82%*

	Two substantial losses, one substantial gain

2-socket Zen2
tbench4
                          5.13.0-rc1             5.13.0-rc1
                             vanilla   sched-wakeidler-v3r1
Hmean     1        341.84 (   0.00%)      337.45 *  -1.28%*
Hmean     2        675.90 (   0.00%)      659.10 *  -2.49%*
Hmean     4       1312.66 (   0.00%)     1250.00 *  -4.77%*
Hmean     8       2495.62 (   0.00%)     2386.57 *  -4.37%*
Hmean     16      4237.23 (   0.00%)     4835.29 *  14.11%*
Hmean     32      8505.60 (   0.00%)     8428.12 *  -0.91%*
Hmean     64     22452.58 (   0.00%)    20637.45 *  -8.08%*
Hmean     128    32493.62 (   0.00%)    27491.73 * -15.39%*
Hmean     256    40975.73 (   0.00%)    29466.08 * -28.09%*
Hmean     512    39320.56 (   0.00%)    34480.84 * -12.31%*

	Some major losses, one major gain

2-socket Zen3
tbench4
                           5.13.0-rc1             5.13.0-rc1
                              vanilla   sched-wakeidler-v3r1
Hmean     1         764.71 (   0.00%)      771.17 *   0.85%*
Hmean     2        1536.93 (   0.00%)     1504.18 *  -2.13%*
Hmean     4        2836.19 (   0.00%)     2805.02 *  -1.10%*
Hmean     8        4726.61 (   0.00%)     4762.61 *   0.76%*
Hmean     16       8341.73 (   0.00%)     8183.48 *  -1.90%*
Hmean     32      14446.04 (   0.00%)    13628.25 *  -5.66%*
Hmean     64      21852.72 (   0.00%)    24039.33 *  10.01%*
Hmean     128     27674.40 (   0.00%)    29107.56 *   5.18%*
Hmean     256     42985.16 (   0.00%)    36482.84 * -15.13%*
Hmean     512     50210.59 (   0.00%)    40899.44 * -18.54%*
Hmean     1024    63696.89 (   0.00%)    46715.28 * -26.66%*

	Some major losses, one big gain

-- 
Mel Gorman
SUSE Labs
