Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB754192F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhI0LTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:19:20 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:50773 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234022AbhI0LTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:19:11 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id EDC5C1C3CA9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:17:32 +0100 (IST)
Received: (qmail 13966 invoked from network); 27 Sep 2021 11:17:32 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Sep 2021 11:17:32 -0000
Date:   Mon, 27 Sep 2021 12:17:30 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <20210927111730.GG3959@techsingularity.net>
References: <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
 <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 02:41:06PM +0200, Vincent Guittot wrote:
> On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> >
> > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > >
> > > a 100us value should even be enough to fix Mel's problem without
> > > impacting common wakeup preemption cases.
> >
> > It'd be nice if it turn out to be something that simple, but color me
> > skeptical.  I've tried various preemption throttling schemes, and while
> 
> Let's see what the results will show. I tend to agree that this will
> not be enough to cover all use cases and I don't see any other way to
> cover all cases than getting some inputs from the threads about their
> latency fairness which bring us back to some kind of latency niceness
> value
> 

Unfortunately, I didn't get a complete set of results but enough to work
with. The missing tests have been requeued. The figures below are based
on a single-socket Skylake machine with 8 CPUs as it had the most set of
results and is the basic case.

The reported kernels are

vanilla:			vanilla 5.15-rc1
sched-scalewakegran-v2r4:	My patch
sched-moveforward-v1r1:		Vincent's patch



hackbench-process-pipes
                          5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                             vanilla sched-scalewakegran-v2r4 sched-moveforward-v1r1
Amean     1        0.3253 (   0.00%)      0.3330 (  -2.36%)      0.3257 (  -0.10%)
Amean     4        0.8300 (   0.00%)      0.7570 (   8.80%)      0.7560 (   8.92%)
Amean     7        1.1003 (   0.00%)      1.1457 *  -4.12%*      1.1163 (  -1.45%)
Amean     12       1.7263 (   0.00%)      1.6393 *   5.04%*      1.5963 *   7.53%*
Amean     21       3.0063 (   0.00%)      2.6590 *  11.55%*      2.4487 *  18.55%*
Amean     30       4.2323 (   0.00%)      3.5657 *  15.75%*      3.3410 *  21.06%*
Amean     48       6.5657 (   0.00%)      5.4180 *  17.48%*      5.0857 *  22.54%*
Amean     79      10.4867 (   0.00%)      8.4357 *  19.56%*      7.9563 *  24.13%*
Amean     110     14.8880 (   0.00%)     11.0423 *  25.83%*     10.7407 *  27.86%*
Amean     141     19.2083 (   0.00%)     14.0820 *  26.69%*     13.3780 *  30.35%*
Amean     172     23.4847 (   0.00%)     16.9880 *  27.66%*     16.4293 *  30.04%*
Amean     203     27.3763 (   0.00%)     20.2480 *  26.04%*     19.6430 *  28.25%*
Amean     234     31.3707 (   0.00%)     23.2477 *  25.89%*     22.8287 *  27.23%*
Amean     265     35.4663 (   0.00%)     26.2483 *  25.99%*     25.8683 *  27.06%*
Amean     296     39.2380 (   0.00%)     29.4237 *  25.01%*     28.8727 *  26.42%*

For hackbench, either Vincent or my patch has a similar impact.

tbench4
                         5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                            vanillasched-scalewakegran-v2r4 sched-moveforward-v1r1
Hmean     1       598.71 (   0.00%)      608.31 *   1.60%*      586.05 *  -2.11%*
Hmean     2      1096.74 (   0.00%)     1110.07 *   1.22%*     1106.70 *   0.91%*
Hmean     4      1529.35 (   0.00%)     1531.20 *   0.12%*     1551.11 *   1.42%*
Hmean     8      2824.32 (   0.00%)     2847.96 *   0.84%*     2684.21 *  -4.96%*
Hmean     16     2573.30 (   0.00%)     2591.77 *   0.72%*     2445.41 *  -4.97%*
Hmean     32     2518.77 (   0.00%)     2532.70 *   0.55%*     2409.30 *  -4.35%*

For tbench, it's ok for lower thread counts for 8 threads (machine
overloaded), Vincent's patch regresses slightly. With these test runs,
I don't have detailed information as to why but the most likely solution
is that preemption gets disabled prematurely.

specjbb
                             5.15.0-rc1             5.15.0-rc1             5.15.0-rc1
                                vanillasched-scalewakegran-v2r4 sched-moveforward-v1r1
Hmean     tput-1    71199.00 (   0.00%)    69492.00 *  -2.40%*    71126.00 *  -0.10%*
Hmean     tput-2   154478.00 (   0.00%)   146060.00 *  -5.45%*   153073.00 *  -0.91%*
Hmean     tput-3   211889.00 (   0.00%)   209386.00 *  -1.18%*   219434.00 *   3.56%*
Hmean     tput-4   257842.00 (   0.00%)   248012.00 *  -3.81%*   262903.00 *   1.96%*
Hmean     tput-5   253506.00 (   0.00%)   242511.00 *  -4.34%*   250828.00 *  -1.06%*
Hmean     tput-6   246202.00 (   0.00%)   236480.00 *  -3.95%*   244236.00 *  -0.80%*
Hmean     tput-7   241133.00 (   0.00%)   230905.00 *  -4.24%*   237619.00 *  -1.46%*
Hmean     tput-8   237983.00 (   0.00%)   230010.00 *  -3.35%*   235275.00 *  -1.14%*

For specjbb, it's different again, Vincent's patch is better for the
overloaded case but both patches show light regressions.

-- 
Mel Gorman
SUSE Labs
