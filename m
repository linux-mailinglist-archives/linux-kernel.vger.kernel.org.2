Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D24344E1A7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 06:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhKLFrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 00:47:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:11591 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhKLFrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 00:47:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10165"; a="231802701"
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="231802701"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 21:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,228,1631602800"; 
   d="scan'208";a="504755009"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.189])
  by orsmga008.jf.intel.com with ESMTP; 11 Nov 2021 21:44:17 -0800
Date:   Fri, 12 Nov 2021 13:44:17 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] clocksource: Avoid accidental unstable marking of
 clocksources
Message-ID: <20211112054417.GA29845@shbuild999.sh.intel.com>
References: <20211110221732.272986-1-longman@redhat.com>
 <20211110221732.272986-2-longman@redhat.com>
 <20211111045703.GA15896@shbuild999.sh.intel.com>
 <20211111144311.GK641268@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111144311.GK641268@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 06:43:11AM -0800, Paul E. McKenney wrote:
> On Thu, Nov 11, 2021 at 12:57:03PM +0800, Feng Tang wrote:
> > On Wed, Nov 10, 2021 at 05:17:31PM -0500, Waiman Long wrote:
> > > Since commit db3a34e17433 ("clocksource: Retry clock read if long delays
> > > detected") and commit 2e27e793e280 ("clocksource: Reduce clocksource-skew
> > > threshold"), it is found that tsc clocksource fallback to hpet can
> > > sometimes happen on both Intel and AMD systems especially when they are
> > > running stressful benchmarking workloads. Of the 23 systems tested with
> > > a v5.14 kernel, 10 of them have switched to hpet clock source during
> > > the test run.
> > > 
> > > The result of falling back to hpet is a drastic reduction of performance
> > > when running benchmarks. For example, the fio performance tests can
> > > drop up to 70% whereas the iperf3 performance can drop up to 80%.
> > > 
> > > 4 hpet fallbacks happened during bootup. They were:
> > > 
> > >   [    8.749399] clocksource: timekeeping watchdog on CPU13: hpet read-back delay of 263750ns, attempt 4, marking unstable
> > >   [   12.044610] clocksource: timekeeping watchdog on CPU19: hpet read-back delay of 186166ns, attempt 4, marking unstable
> > >   [   17.336941] clocksource: timekeeping watchdog on CPU28: hpet read-back delay of 182291ns, attempt 4, marking unstable
> > >   [   17.518565] clocksource: timekeeping watchdog on CPU34: hpet read-back delay of 252196ns, attempt 4, marking unstable
> > > 
> > > Other fallbacks happen when the systems were running stressful
> > > benchmarks. For example:
> > > 
> > >   [ 2685.867873] clocksource: timekeeping watchdog on CPU117: hpet read-back delay of 57269ns, attempt 4, marking unstable
> > >   [46215.471228] clocksource: timekeeping watchdog on CPU8: hpet read-back delay of 61460ns, attempt 4, marking unstable
> > > 
> > > Commit 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold"),
> > > changed the skew margin from 100us to 50us. I think this is too small
> > > and can easily be exceeded when running some stressful workloads on
> > > a thermally stressed system.  So it is switched back to 100us. On
> > > the other hand, it doesn't look like we need to increase the minimum
> > > uncertainty margin. So it is kept the same at 100us too.
> > > 
> > > Even a maximum skew margin of 100us may be too small in for some systems
> > > when booting up especially if those systems are under thermal stress. To
> > > eliminate the case that the large skew is due to the system being too
> > > busy slowing down the reading of both the watchdog and the clocksource,
> > > a final check is done by reading watchdog time again and comparing the
> > > consecutive watchdog timing read delay against WATCHDOG_MAX_SKEW/2. If
> > > that delay exceeds the limit, we assume that the system is just too
> > > busy. A warning will be printed to the console and the watchdog check
> > > is then skipped for this round. For example:
> > > 
> > >   [    8.789316] clocksource: timekeeping watchdog on CPU13: hpet consecutive read-back delay of 174541ns, system too busy
> >  
> > 
> > I think it may be better to add more details about the root cause, other
> > than that it looks good to me, as we tested similar patch on our test
> > platforms.
> > 
> > Reviewed-by: Feng Tang <feng.tang@intel.com>
> 
> Thank you both!
> 
> I agree on the bit about root cause.  Would it make sense to compare the
> difference between HPET reads 1 and 2 (containing the read of the TSC)
> and the difference between HPET reads 2 and 3?  If the 2-1 difference was
> no more than (say) 8/7ths of the 3-2 difference, or the 2-1 difference
> was no more than (say) 20 microseconds more than the 3-2 difference,
> this could be considered a good-as-it-gets read, ending the retry loop.
> Then if the 3-1 difference was greater than the default (100 microseconds
> in current -rcu), that difference could be substituted for that particular
> clocksource watchdog check.  With a console message noting the unusually
> high overhead (but not a splat).
> 
> So if it took 75 microseconds for each HPET read and 1 microsecond for
> the TSC read, then 226 microseconds would be substituted for the default
> of 100 microseconds for that cycle's skew cutoff.  Unless the previous
> skew cutoff was larger, in which case the previous cutoff should be
> used instead.  Either way, the current cutoff is recorded for comparison
> for the next clocksource watchdog check.
> 
> If the 3-1 difference was greater than 62.5 milliseconds, a warning should
> probably be emitted anyway.
 
I can test the patch with our cases that could reproduce the problem.

> Or did you have something else in mind?

I'm not sure the detail in  Waiman's cases, and in our cases (stress-ng)
the delay between watchdog's (HPET here) read were not linear, that
from debug data, sometimes the 3-2 difference could be bigger or much
bigger than the 2-1 difference.

The reason could be the gap between 2 reads depends hugely on the system
pressure at that time that 3 HPET read happens. On our test box (a
2-Socket Cascade Lake AP server), the 2-1 and 3-2 difference are stably
about 2.5 us,  while under the stress it could be bumped to from 6 us
to 2800 us.

So I think checking the 3-2 difference plus increasing the max retries
to 10 may be a simple way, if the watchdog read is found to be
abnormally long, we skip this round of check.

Thanks,
Feng


> 
> 							Thanx, Paul
 
