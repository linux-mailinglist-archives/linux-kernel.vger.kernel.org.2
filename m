Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594E419616
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbhI0OTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 10:19:38 -0400
Received: from mout.gmx.net ([212.227.17.22]:42623 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234692AbhI0OTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 10:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1632752248;
        bh=q3mAu94H0JXAj80O7XMbr0ra8dkBLbi1lOkXLq26skE=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=YhQBSEHXkHqkR8EqHEAq1fYmBdcyrpesNmg6vTUFgOgNYPn9l9zYFJPVoQIgQpajg
         DJR7/d93tz6YZ4/8WFYslsQPIKegNE0YS2fuhqPNYUXwVuL907Ergk0rJ62VIWOny+
         yQqnc1kJzMJ4pvvbbij6gv8+zWai7hjdCGsv6TGE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.235]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDywu-1menb20QmS-009z1Q; Mon, 27
 Sep 2021 16:17:28 +0200
Message-ID: <ae821481769c4cd82a1672f0aac427c52e0a1647.camel@gmx.de>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
From:   Mike Galbraith <efault@gmx.de>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Sep 2021 16:17:25 +0200
In-Reply-To: <20210927111730.GG3959@techsingularity.net>
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
         <20210927111730.GG3959@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kifLch3ptvnoGnMZh57E3yRQqTzXUXxVNLcWBO1HQtN/0QC9zC+
 Dan2Za8R6S9SV5b4/mQrg1acMi0KF2zoLc1IqxREA9gGWGdd7KEXnT0YqwFcVIbPiEGKMbs
 1izRPbroo+bjvwE6hpQN0/d2aZlxHc8u5KsXeAdYapLu7o9+2YU6ILHJLLcR+dQwNNM3lRZ
 kDhY0dukckLUSwcQAyK2w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rosBAGHybGo=:fCLmOeTYnoZp23iF9PBTcB
 l/f7f4QBW2noW/wZnwtMVxty3aVlUaZDRogF3fC2/BV4xAVoqcIUlZfoK/dntgesCPjMYjqTV
 VDvhoglTSu4WLnpphoE81+LtxRcF35ximaFPhHl+SJSvRSFjNh4grFvFwrndQTSPqvnCKhvJl
 iTLmNSkNlPH50WrOe2awDCFjO2Ag+uNP5HGWBR4Q/g73XnG9U7+qrEZYjk1Skese7sSDBpeJN
 amqiKy5hJhSXBsmm5hzUCAjzsCvPTdkmKdSJ9qQVVFzHtBfRPMQxoeMBGio+Wwu4NzZZx5LxN
 7w4gjEJlSKyJUrILhDRGeyU62l5viksBuzUSA+80U0llcx/ui6jEiLDz+B1XWbEm7FomuUQ6f
 Y5j+osmnajMI+e6v60YIrHkmgVRcZ9LUm+VWIZJ9UXkxZTTRzXNOCX8GofdbI1XgipBqVfmry
 naVQ6EecGlRMmxWicm3Q5Zuu/sQfavvhMLWfi9taR944IRe7ApEr66FvPFKXAEYLT2i1ydn+s
 oqR0BtAdgN0Rv2MftPoAjoUBDWhCKHndKoFsDcYom+wYGYcg2jVJaRw7u2teGw+UsgAF+qzSG
 Zma7yQQZAWrEMFhEfkSDrFLzCVFekoNXPVPbUgZ+Ywd/4CJhAClhYdwuSYLyr0nDuyNAX0521
 6KXEPI5YhgMxV6ht8OMT8PCxnW5gh682lc42PrIXNj94v9rYlgL3d8D+7qqJ8livc8mJEEBCr
 mvVDJjo9kzf4mdp4ejCkY/0+nL8G9BYA5TtKXYCi9VK04f0EorU2jiQGfXUxmmB+uLnyILbDk
 GKGSomPQ3z85i5Qp79kftt4kYQGJLTSlXmusLIywfOlByV4xA4gkvYVOD0Uz0vnNq8iMD8w/8
 83PVeivA5BLrX4qyXqs38+C42yrFPZKnRyIdX/ORRwbAvhO5pieV/CfqnTG4xY3zGyBThjW2z
 D6u9F5aiSNVPf/iUlVwAYZLDl37JoRSn01/QnFT9TmPPkXJpyoXj67SwsiB4m5UAUCxJEztv2
 ffT7C57+/qndzlKt58PwhmxT/1LLfjyd/+RhbSwJDgFS+mCwvIQTv0CdxPx0rcmQ2KZCclAmK
 uAPy2MkD7mpJ5o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-09-27 at 12:17 +0100, Mel Gorman wrote:
> On Thu, Sep 23, 2021 at 02:41:06PM +0200, Vincent Guittot wrote:
> > On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> > >
> > > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > > >
> > > > a 100us value should even be enough to fix Mel's problem without
> > > > impacting common wakeup preemption cases.
> > >
> > > It'd be nice if it turn out to be something that simple, but color m=
e
> > > skeptical.=C2=A0 I've tried various preemption throttling schemes, a=
nd while
> >
> > Let's see what the results will show. I tend to agree that this will
> > not be enough to cover all use cases and I don't see any other way to
> > cover all cases than getting some inputs from the threads about their
> > latency fairness which bring us back to some kind of latency niceness
> > value
> >
>
> Unfortunately, I didn't get a complete set of results but enough to work
> with. The missing tests have been requeued. The figures below are based
> on a single-socket Skylake machine with 8 CPUs as it had the most set of
> results and is the basic case.

There's something missing, namely how does whatever load you measure
perform when facing dissimilar competition. Instead of only scaling
loads running solo from underutilized to heavily over-committed, give
them competition. eg something switch heavy, say tbench, TCP_RR et al
(latency bound load) pairs=3DCPUS vs something hefty like make -j CPUS or
such.

With your "pick a load number and roll preemption down" approach and
competing (modest) loads running on some headless enterprise test array
box, there will likely be little impact, but do the same on a desktop
box from the GUI, according to my box, you're likely to see something
entirely different.

Seems the "if current hasn't consumed at least 100us, go away" approach
should impact fast movers facing competition both a lot more and more
consistently (given modest load for both methods).

Below is my box nfs mounting itself for no other reason than I was
curious to see what running my repo update script from an nfs mount
would look like (hey, it's still more realistic than hackbench;).  It's
sorted by switches, but those at the top are also where the most cycles
landed.  I wouldn't expect throughput of a load that switch happy to
hold up well at all when faced with enforced 100us latency.

Switch happy loads don't do so just to be mean, nor do they matter less
than whatever beefier loads they may encounter in a box.

 -------------------------------------------------------------------------=
----------------------------------------
  Task                  |   Runtime ms  | Switches | Average delay ms | Ma=
ximum delay ms | Maximum delay at       |
 -------------------------------------------------------------------------=
----------------------------------------
  nfsd:2246             |  31297.564 ms |  1514806 | avg:    0.002 ms | ma=
x:  555.543 ms | max at:   9130.660504 s
  nfsd:2245             |   9536.364 ms |  1475992 | avg:    0.002 ms | ma=
x:  902.341 ms | max at:   9083.907053 s
  kworker/u17:2-x:21933 |   3629.267 ms |   768463 | avg:    0.009 ms | ma=
x: 5536.206 ms | max at:   9088.540916 s
  kworker/u17:3:7082    |   3426.631 ms |   701947 | avg:    0.010 ms | ma=
x: 5543.659 ms | max at:   9088.540901 s
  git:7100              |  12708.278 ms |   573828 | avg:    0.001 ms | ma=
x:    3.520 ms | max at:   9066.125757 s
  git:7704              |  11620.355 ms |   517010 | avg:    0.001 ms | ma=
x:    4.070 ms | max at:   9113.894832 s
  kworker/u17:0:7075    |   1812.581 ms |   397601 | avg:    0.002 ms | ma=
x:  620.321 ms | max at:   9114.655685 s
  nfsd:2244             |   4930.826 ms |   370473 | avg:    0.008 ms | ma=
x:  910.646 ms | max at:   9083.915441 s
  kworker/u16:6:7094    |   2870.424 ms |   335848 | avg:    0.005 ms | ma=
x:  580.871 ms | max at:   9114.616479 s
  nfsd:2243             |   3424.996 ms |   257274 | avg:    0.033 ms | ma=
x: 3843.339 ms | max at:   9086.848829 s
  kworker/u17:1-x:30183 |   1310.614 ms |   255990 | avg:    0.001 ms | ma=
x:    1.817 ms | max at:   9089.173217 s
  kworker/u16:60-:6124  |   2253.058 ms |   225931 | avg:    0.050 ms | ma=
x:10128.140 ms | max at:   9108.375040 s
  kworker/u16:5:7092    |   1831.385 ms |   211923 | avg:    0.007 ms | ma=
x:  905.513 ms | max at:   9083.911630 s
  kworker/u16:7:7101    |   1606.258 ms |   194944 | avg:    0.002 ms | ma=
x:   11.576 ms | max at:   9082.789700 s
  kworker/u16:4:7090    |   1484.687 ms |   189197 | avg:    0.100 ms | ma=
x:12112.172 ms | max at:   9110.360308 s
  kworker/u16:59-:6123  |   1707.858 ms |   183464 | avg:    0.073 ms | ma=
x: 6135.816 ms | max at:   9120.173398 s
  kworker/u16:3:7074    |   1528.375 ms |   173089 | avg:    0.098 ms | ma=
x:15196.567 ms | max at:   9098.202355 s
  kworker/u16:0-r:7009  |   1336.814 ms |   166043 | avg:    0.002 ms | ma=
x:   12.381 ms | max at:   9082.839130 s
  nfsd:2242             |   1876.802 ms |   154855 | avg:    0.073 ms | ma=
x: 3844.877 ms | max at:   9086.848848 s
  kworker/u16:1:7072    |   1214.642 ms |   151420 | avg:    0.002 ms | ma=
x:    6.433 ms | max at:   9075.581713 s
  kworker/u16:2:7073    |   1302.996 ms |   150863 | avg:    0.002 ms | ma=
x:   12.119 ms | max at:   9082.839133 s

