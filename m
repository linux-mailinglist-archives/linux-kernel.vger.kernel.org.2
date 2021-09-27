Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452C5419710
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbhI0PEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:04:22 -0400
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:41989 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234816AbhI0PEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:04:21 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 6AE061B9D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:02:42 +0100 (IST)
Received: (qmail 12030 invoked from network); 27 Sep 2021 15:02:42 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Sep 2021 15:02:42 -0000
Date:   Mon, 27 Sep 2021 16:02:40 +0100
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
Message-ID: <20210927150240.GI3959@techsingularity.net>
References: <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
 <ba60262d15891702cae0d59122388c6a18caaf53.camel@gmx.de>
 <CAKfTPtBBqLghrXrayyoBQQyDqdv6+pdCjiZkmzLaGvdNtN=Aug@mail.gmail.com>
 <50400427070018eff83b0782d2e26c0cc9ff4521.camel@gmx.de>
 <CAKfTPtDHYtskM7wR0w=fDry+6JJae2_q8Lw7ETcW_gBJ+n4NBA@mail.gmail.com>
 <20210927111730.GG3959@techsingularity.net>
 <CAKfTPtDETjTEno8XURNVqzkqOONuAYRnhvNXmHzC7Hc_crwA_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDETjTEno8XURNVqzkqOONuAYRnhvNXmHzC7Hc_crwA_Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:19:00PM +0200, Vincent Guittot wrote:
> On Mon, 27 Sept 2021 at 13:17, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Thu, Sep 23, 2021 at 02:41:06PM +0200, Vincent Guittot wrote:
> > > On Thu, 23 Sept 2021 at 11:22, Mike Galbraith <efault@gmx.de> wrote:
> > > >
> > > > On Thu, 2021-09-23 at 10:40 +0200, Vincent Guittot wrote:
> > > > >
> > > > > a 100us value should even be enough to fix Mel's problem without
> > > > > impacting common wakeup preemption cases.
> > > >
> > > > It'd be nice if it turn out to be something that simple, but color me
> > > > skeptical.  I've tried various preemption throttling schemes, and while
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
> >
> > The reported kernels are
> >
> > vanilla:                        vanilla 5.15-rc1
> > sched-scalewakegran-v2r4:       My patch
> > sched-moveforward-v1r1:         Vincent's patch
> 
> I imagine that this is the results for the 1st version which scales
> with the number of CPUs
> 

Yes, the v1r5 results were incomplete and had to be requeued.

-- 
Mel Gorman
SUSE Labs
