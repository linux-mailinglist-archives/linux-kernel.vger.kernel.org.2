Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D6843DE14
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhJ1JwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 05:52:02 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:45033 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230044AbhJ1Jvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 05:51:36 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 7E8A5F8337
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 10:48:55 +0100 (IST)
Received: (qmail 23157 invoked from network); 28 Oct 2021 09:48:55 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPA; 28 Oct 2021 09:48:55 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Date:   Thu, 28 Oct 2021 10:48:33 +0100
Message-Id: <20211028094834.1312-2-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211028094834.1312-1-mgorman@techsingularity.net>
References: <20211028094834.1312-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch mitigates a problem where wake_wide() allows a heavy waker
(e.g. X) to stack an excessive number of wakees on the same CPU. This
is due to the cpu_load check in wake_affine_weight. As noted by the
original patch author (Mike Galbraith)[1];

	Between load updates, X, or any other waker of many, can stack
	wakees to a ludicrous depth.  Tracing kbuild vs firefox playing a
	youtube clip, I watched X stack 20 of the zillion firefox minions
	while their previous CPUs all had 1 lousy task running but a
	cpu_load() higher than the cpu_load() of X's CPU.  Most of those
	prev_cpus were where X had left them when it migrated. Each and
	every crazy depth migration was wake_affine_weight() deciding we
	should pull.

Parahrasing Mike's test results from the patch.

	With make -j8 running along with firefox with two tabs, one
	containing youtube's suggestions of stuff, the other a running
	clip, if the idle tab in focus, and don't drive mouse around,
	flips decay enough for wake_wide() to lose interest, but just
	wiggle the mouse, and it starts waking wide. Focus on the running
	clip, and it continuously wakes wide.  

The end result is that heavy wakers are less likely to stack tasks and,
depending on the workload, reduce migrations.

From additional tests on various servers, the impact is machine dependant
but generally this patch improves the situation.

hackbench-process-pipes
                          5.15.0-rc3             5.15.0-rc3
                             vanilla  sched-wakeeflips-v1r1
Amean     1        0.3667 (   0.00%)      0.3890 (  -6.09%)
Amean     4        0.5343 (   0.00%)      0.5217 (   2.37%)
Amean     7        0.5300 (   0.00%)      0.5387 (  -1.64%)
Amean     12       0.5737 (   0.00%)      0.5443 (   5.11%)
Amean     21       0.6727 (   0.00%)      0.6487 (   3.57%)
Amean     30       0.8583 (   0.00%)      0.8033 (   6.41%)
Amean     48       1.3977 (   0.00%)      1.2400 *  11.28%*
Amean     79       1.9790 (   0.00%)      1.8200 *   8.03%*
Amean     110      2.8020 (   0.00%)      2.5820 *   7.85%*
Amean     141      3.6683 (   0.00%)      3.2203 *  12.21%*
Amean     172      4.6687 (   0.00%)      3.8200 *  18.18%*
Amean     203      5.2183 (   0.00%)      4.3357 *  16.91%*
Amean     234      6.1077 (   0.00%)      4.8047 *  21.33%*
Amean     265      7.1313 (   0.00%)      5.1243 *  28.14%*
Amean     296      7.7557 (   0.00%)      5.5940 *  27.87%*

While different machines showed different results, in general
there were much less CPU migrations of tasks

tbench4
                           5.15.0-rc3             5.15.0-rc3
                              vanilla  sched-wakeeflips-v1r1
Hmean     1         824.05 (   0.00%)      802.56 *  -2.61%*
Hmean     2        1578.49 (   0.00%)     1645.11 *   4.22%*
Hmean     4        2959.08 (   0.00%)     2984.75 *   0.87%*
Hmean     8        5080.09 (   0.00%)     5173.35 *   1.84%*
Hmean     16       8276.02 (   0.00%)     9327.17 *  12.70%*
Hmean     32      15501.61 (   0.00%)    15925.55 *   2.73%*
Hmean     64      27313.67 (   0.00%)    24107.81 * -11.74%*
Hmean     128     32928.19 (   0.00%)    36261.75 *  10.12%*
Hmean     256     35434.73 (   0.00%)    38670.61 *   9.13%*
Hmean     512     50098.34 (   0.00%)    53243.75 *   6.28%*
Hmean     1024    69503.69 (   0.00%)    67425.26 *  -2.99%*

Bit of a mixed bag but wins more than it loses.

A new workload was added that runs a kernel build in the background
-jNR_CPUS while NR_CPUS pairs of tasks run Netperf TCP_RR. The
intent is to see if heavy background tasks disrupt ligher tasks

multi subtest kernbench
                               5.15.0-rc3             5.15.0-rc3
                                  vanilla  sched-wakeeflips-v1r1
Min       elsp-256       20.80 (   0.00%)       14.89 (  28.41%)
Amean     elsp-256       24.08 (   0.00%)       20.94 (  13.05%)
Stddev    elsp-256        3.32 (   0.00%)        4.68 ( -41.16%)
CoeffVar  elsp-256       13.78 (   0.00%)       22.36 ( -62.33%)
Max       elsp-256       29.11 (   0.00%)       26.49 (   9.00%)

multi subtest netperf-tcp-rr
                        5.15.0-rc3             5.15.0-rc3
                           vanilla  sched-wakeeflips-v1r1
Min       1    48286.26 (   0.00%)    49101.48 (   1.69%)
Hmean     1    62894.82 (   0.00%)    68963.51 *   9.65%*
Stddev    1     7600.56 (   0.00%)     8804.82 ( -15.84%)
Max       1    78975.16 (   0.00%)    87124.67 (  10.32%)

The variability is higher as a result of the patch but both workloads
experienced improved performance.

SpecJBB 2005 is a slightly more realistic workload with multiple
communicating Java threads

specjbb
                              5.15.0-rc3             5.15.0-rc3
                                 vanilla  sched-wakeeflips-v1r1
Hmean     tput-1     50044.48 (   0.00%)    53969.00 *   7.84%*
Hmean     tput-2    106050.31 (   0.00%)   113580.78 *   7.10%*
Hmean     tput-3    156701.44 (   0.00%)   164857.00 *   5.20%*
Hmean     tput-4    196538.75 (   0.00%)   218373.42 *  11.11%*
Hmean     tput-5    247566.16 (   0.00%)   267173.09 *   7.92%*
Hmean     tput-6    284981.46 (   0.00%)   311007.14 *   9.13%*
Hmean     tput-7    328882.48 (   0.00%)   359373.89 *   9.27%*
Hmean     tput-8    366941.24 (   0.00%)   393244.37 *   7.17%*
Hmean     tput-9    402386.74 (   0.00%)   433010.43 *   7.61%*
Hmean     tput-10   437551.05 (   0.00%)   475756.08 *   8.73%*
Hmean     tput-11   481349.41 (   0.00%)   519824.54 *   7.99%*
Hmean     tput-12   533148.45 (   0.00%)   565070.21 *   5.99%*
Hmean     tput-13   570563.97 (   0.00%)   609499.06 *   6.82%*
Hmean     tput-14   601117.97 (   0.00%)   647876.05 *   7.78%*
Hmean     tput-15   639096.38 (   0.00%)   690854.46 *   8.10%*
Hmean     tput-16   682644.91 (   0.00%)   722826.06 *   5.89%*
Hmean     tput-17   732248.96 (   0.00%)   758805.17 *   3.63%*
Hmean     tput-18   762771.33 (   0.00%)   791211.66 *   3.73%*
Hmean     tput-19   780582.92 (   0.00%)   819064.19 *   4.93%*
Hmean     tput-20   812183.95 (   0.00%)   836664.87 *   3.01%*
Hmean     tput-21   821415.48 (   0.00%)   833734.23 (   1.50%)
Hmean     tput-22   815457.65 (   0.00%)   844393.98 *   3.55%*
Hmean     tput-23   819263.63 (   0.00%)   846109.07 *   3.28%*
Hmean     tput-24   817962.95 (   0.00%)   839682.92 *   2.66%*
Hmean     tput-25   807814.64 (   0.00%)   841826.52 *   4.21%*
Hmean     tput-26   811755.89 (   0.00%)   838543.08 *   3.30%*
Hmean     tput-27   799341.75 (   0.00%)   833487.26 *   4.27%*
Hmean     tput-28   803434.89 (   0.00%)   829022.50 *   3.18%*
Hmean     tput-29   803233.25 (   0.00%)   826622.37 *   2.91%*
Hmean     tput-30   800465.12 (   0.00%)   824347.42 *   2.98%*
Hmean     tput-31   791284.39 (   0.00%)   791575.67 (   0.04%)
Hmean     tput-32   781930.07 (   0.00%)   805725.80 (   3.04%)
Hmean     tput-33   785194.31 (   0.00%)   804795.44 (   2.50%)
Hmean     tput-34   781325.67 (   0.00%)   800067.53 (   2.40%)
Hmean     tput-35   777715.92 (   0.00%)   753926.32 (  -3.06%)
Hmean     tput-36   770516.85 (   0.00%)   783328.32 (   1.66%)
Hmean     tput-37   758067.26 (   0.00%)   772243.18 *   1.87%*
Hmean     tput-38   764815.45 (   0.00%)   769156.32 (   0.57%)
Hmean     tput-39   757885.41 (   0.00%)   757670.59 (  -0.03%)
Hmean     tput-40   750140.15 (   0.00%)   760739.13 (   1.41%)

[1] https://lore.kernel.org/r/02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..d00af3b97d8f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5865,6 +5865,14 @@ static void record_wakee(struct task_struct *p)
 	}
 
 	if (current->last_wakee != p) {
+		int min = __this_cpu_read(sd_llc_size) << 1;
+		/*
+		 * Couple the wakee flips to the waker for the case where it
+		 * doesn't accrue flips, taking care to not push the wakee
+		 * high enough that the wake_wide() heuristic fails.
+		 */
+		if (current->wakee_flips > p->wakee_flips * min)
+			p->wakee_flips++;
 		current->last_wakee = p;
 		current->wakee_flips++;
 	}
@@ -5895,7 +5903,7 @@ static int wake_wide(struct task_struct *p)
 
 	if (master < slave)
 		swap(master, slave);
-	if (slave < factor || master < slave * factor)
+	if ((slave < factor && master < (factor>>1)*factor) || master < slave * factor)
 		return 0;
 	return 1;
 }
-- 
2.31.1

