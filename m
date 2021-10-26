Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C820643B1B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 13:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhJZL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 07:59:37 -0400
Received: from outbound-smtp37.blacknight.com ([46.22.139.220]:54445 "EHLO
        outbound-smtp37.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231126AbhJZL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 07:59:35 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 6C43F2C15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 12:57:09 +0100 (IST)
Received: (qmail 9056 invoked from network); 26 Oct 2021 11:57:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Oct 2021 11:57:08 -0000
Date:   Tue, 26 Oct 2021 12:57:07 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] sched/fair: Couple wakee flips with heavy wakers
Message-ID: <20211026115707.GN3959@techsingularity.net>
References: <20211021145603.5313-1-mgorman@techsingularity.net>
 <20211021145603.5313-2-mgorman@techsingularity.net>
 <37d8c167df66a1ead16b699115548ca376494c0c.camel@gmx.de>
 <20211022110534.GJ3959@techsingularity.net>
 <496d495b290ac69fed75d02ab5915a7871243321.camel@gmx.de>
 <20211026081817.GM3959@techsingularity.net>
 <4105fd08f84c60698b38efcb4d22e999de187d6e.camel@gmx.de>
 <b53de0da7c863ec4c883a92b2526a0f9132a24cb.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <b53de0da7c863ec4c883a92b2526a0f9132a24cb.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 12:41:36PM +0200, Mike Galbraith wrote:
> On Tue, 2021-10-26 at 12:15 +0200, Mike Galbraith wrote:
> >
> ...
> 
> Well now, that interruption didn't go as planned. The briefer edit
> would have been preferred, but you get the drift, so moving on...
> 
> > > > It benefiting NUMA box
> > > > hackbench is a valid indicator, but one that is IMO too disconnected
> > > > from the real world to carry much weight.
> > > >
> > >
> > > I think if it's not shown to be harmful to a realistic workload but helps
> > > an overloaded example then it should be ok. While excessive overload is
> > > rare in a realistic workload, it does happen. There are a few workloads
> > > I've seen bugs for that were triggered when an excessive number of worker
> > > threads get spawned and compete for CPU access which in turns leads more
> > > worker threads get spawned. There are application workarounds for this
> > > corner case but it still triggers bugs.
> >
> 
> wake_wide()'s proper test environment is NUMA, not a desktop box, so
> patchlet has yet to meet a real world load that qualifies as such.
> That it could detect the test load doing nutty stuff like waking a
> thread pool three times the size of the box is all well and good, but
> not the point.
> 
> $.02 WRT poor abused hackbench: if it happens to benefit that's fine,
> but I don't think it should ever be considered change validation.  It's
> a useful tool, but the common massive overload use is just nuts IMO.
> 

hackbench is nuts and generally only useful for looking at overload
placement, overload balancing and useless search depth for idle CPUs.
I pay it some attention but it's usually not my favour workload.
Regrettably, it's mostly used because it's popular, not because it
makes sense.

The patch in question was also tested on other workloads on NUMA
machines. For a 2-socket machine (20 cores, HT enabled so 40 CPUs)
running specjbb 2005 with one JVM per NUMA node, the patch also scaled
reasonably well

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

The largest regression was within noise. Most results were outside the
noise.

Some HPC workloads showed little difference but they do not communicate
that heavily. redis microbenchmark showed mostly neutral results.
schbench (facebook simulator workload that is latency sensitive) showed a
mix of results, but helped more than it hurt. Even the machine with the
worst results for schbench showed improved wakeup latencies at the 99th
percentile. These were all on NUMA machines.

-- 
Mel Gorman
SUSE Labs
