Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810B74206FD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhJDIIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 04:08:00 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:58705 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhJDIHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 04:07:53 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 18730FB413
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:05:49 +0100 (IST)
Received: (qmail 2753 invoked from network); 4 Oct 2021 08:05:48 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Oct 2021 08:05:48 -0000
Date:   Mon, 4 Oct 2021 09:05:47 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <20211004080547.GK3959@techsingularity.net>
References: <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
 <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
 <20210927111730.GG3959@techsingularity.net>
 <ae821481769c4cd82a1672f0aac427c52e0a1647.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae821481769c4cd82a1672f0aac427c52e0a1647.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:17:25PM +0200, Mike Galbraith wrote:
> On Mon, 2021-09-27 at 12:17 +0100, Mel Gorman wrote:
> > On Thu, Sep 23, 2021 at 02:41:06PM +0200, Vincent Guittot wrote:
> > > On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> > > >
> > > > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > > > >
> > > > > a 100us value should even be enough to fix Mel's problem without
> > > > > impacting common wakeup preemption cases.
> > > >
> > > > It'd be nice if it turn out to be something that simple, but color me
> > > > skeptical.  I've tried various preemption throttling schemes, and while
> > >
> > > Let's see what the results will show. I tend to agree that this will
> > > not be enough to cover all use cases and I don't see any other way to
> > > cover all cases than getting some inputs from the threads about their
> > > latency fairness which bring us back to some kind of latency niceness
> > > value
> > >
> >
> > Unfortunately, I didn't get a complete set of results but enough to work
> > with. The missing tests have been requeued. The figures below are based
> > on a single-socket Skylake machine with 8 CPUs as it had the most set of
> > results and is the basic case.
> 
> There's something missing, namely how does whatever load you measure
> perform when facing dissimilar competition. Instead of only scaling
> loads running solo from underutilized to heavily over-committed, give
> them competition. eg something switch heavy, say tbench, TCP_RR et al
> (latency bound load) pairs=CPUS vs something hefty like make -j CPUS or
> such.
> 

Ok, that's an interesting test. I've been out intermittently and will be
for the next few weeks but I managed to automate something that can test
this. The test runs a kernel compile with -jNR_CPUS and TCP_RR running
NR_CPUS pairs of clients/servers in the background with the default
openSUSE Leap kernel config (CONFIG_PREEMPT_NONE) with the two patches
and no tricks done with task priorities.  5 kernel compilations are run
and TCP_RR is shutdown when the compilation finishes.

This can be reproduced with the mmtests config
config-multi-kernbench__netperf-tcp-rr-multipair using xfs as the
filesystem for the kernel compilation.

sched-scalewakegran-v2r5: my patch
sched-moveforward-v1r1: Vincent's patch


multi subtest kernbench
                              5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                                 vanillasched-scalewakegran-v2r5 sched-moveforward-v1r1
Amean     user-80     1518.87 (   0.00%)     1520.34 (  -0.10%)     1518.93 (  -0.00%)
Amean     syst-80      248.57 (   0.00%)      247.74 (   0.33%)      232.93 *   6.29%*
Amean     elsp-80       48.76 (   0.00%)       48.51 (   0.52%)       48.70 (   0.14%)
Stddev    user-80       10.15 (   0.00%)        9.17 (   9.70%)       10.25 (  -0.93%)
Stddev    syst-80        2.83 (   0.00%)        3.02 (  -6.65%)        3.65 ( -28.83%)
Stddev    elsp-80        3.54 (   0.00%)        3.28 (   7.28%)        2.40 (  32.13%)
CoeffVar  user-80        0.67 (   0.00%)        0.60 (   9.79%)        0.67 (  -0.93%)
CoeffVar  syst-80        1.14 (   0.00%)        1.22 (  -7.01%)        1.57 ( -37.48%)
CoeffVar  elsp-80        7.26 (   0.00%)        6.76 (   6.79%)        4.93 (  32.04%)

With either patch,  time to finish compilations is not affected with
differences in elapsed time being well within the noise

Meanwhile, netperf tcp-rr running with NR_CPUS pairs showed the
following

multi subtest netperf-tcp-rr
                        5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                           vanilla sched-scalewakegran-v2r5 sched-moveforward-v1r1
Min       1    32388.28 (   0.00%)    32208.66 (  -0.55%)    31824.54 (  -1.74%)
Hmean     1    39112.22 (   0.00%)    39364.10 (   0.64%)    39552.30 *   1.13%*
Stddev    1     3471.61 (   0.00%)     3357.28 (   3.29%)     3713.97 (  -6.98%)
CoeffVar  1        8.81 (   0.00%)        8.47 (   3.87%)        9.31 (  -5.67%)
Max       1    53019.93 (   0.00%)    51263.38 (  -3.31%)    51263.04 (  -3.31%)

This shows a slightly different picture with Vincent's patch having a small
impact on netperf tcp-rr. It's noisy and may be subject to test-to-test
variances but it's a mild concern. A greater concern is that across
all machines, dbench was heavily affected by Vincent's patch even for
relatively low thread counts which is surprising.

For the same Cascadelake machine both resulst are from, dbench reports

                          5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                             vanillasched-scalewakegran-v2r5 sched-moveforward-v1r1
Amean     1         15.99 (   0.00%)       16.20 *  -1.27%*       16.18 *  -1.16%*
Amean     2         18.43 (   0.00%)       18.34 *   0.50%*       22.72 * -23.28%*
Amean     4         22.32 (   0.00%)       22.06 *   1.14%*       45.86 *-105.52%*
Amean     8         30.58 (   0.00%)       30.22 *   1.18%*       99.04 *-223.88%*
Amean     16        41.79 (   0.00%)       41.68 *   0.25%*      161.09 *-285.52%*
Amean     32        63.45 (   0.00%)       63.16 *   0.45%*      248.13 *-291.09%*
Amean     64       127.81 (   0.00%)      128.50 *  -0.54%*      402.93 *-215.25%*
Amean     128      330.42 (   0.00%)      336.06 *  -1.71%*      531.35 * -60.81%*

That is an excessive impairment. While it varied across machines, there
was some impact on all of them. For a 1-socket skylake machine to rule
out NUMA artifacts, I get

dbench4 Loadfile Execution Time
                         5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                            vanillasched-scalewakegran-v2r5 sched-moveforward-v1r1
Amean     1        29.51 (   0.00%)       29.45 *   0.21%*       29.58 *  -0.22%*
Amean     2        37.46 (   0.00%)       37.16 *   0.82%*       39.81 *  -6.26%*
Amean     4        51.31 (   0.00%)       51.34 (  -0.04%)       57.14 * -11.35%*
Amean     8        81.77 (   0.00%)       81.65 (   0.15%)       88.68 *  -8.44%*
Amean     64      406.94 (   0.00%)      408.08 *  -0.28%*      433.64 *  -6.56%*
Stddev    1         1.43 (   0.00%)        1.44 (  -0.79%)        1.54 (  -7.45%)

Not as dramatic but indicates that we likely do not want to cut off
wakeup_preempt too early a problem.

The test was not profiling times to switch tasks as the overhead
distorts resules.

-- 
Mel Gorman
SUSE Labs
