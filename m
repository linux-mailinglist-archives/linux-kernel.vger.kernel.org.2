Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479F93E0CFC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 06:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhHEEEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 00:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhHEEED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 00:04:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A11860F0F;
        Thu,  5 Aug 2021 04:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628136229;
        bh=0zTyh8OGC4yegWYuNmIO1GkgfyRER3rSurhMLLSMAXs=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LFoc9xn0qUZS5x/i1fsuaWH30aPTrB3DVvXm3eVS7zFICKh821v3cur4521wMOFq9
         PZrnm3jCR+HTc/X36eTyZ6MF+HAKvXOmQefJKNo2B63J5vvhw0fjraLnVBCz0hQdCI
         ZCb4oo6IPGrSkJ+w+HzoCKp5JD/SpzaQDrYZXDoaX3U3ZpA/5UogP5pf50A1Elb5XW
         D4AP7H9fjqxIY6WTVt1lVcR9N8bfh7kX58cBtPRh5iqj5hGyTIaAtUhBfoHOE/3cql
         ErtCfth5vBpW80TwuSg/wk5SNyn76CPGoJFJIOwM+ab6Yzq1CdZhtOMWtxAqAlYoVg
         FzHvLCwXPpClQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6C45E5C2285; Wed,  4 Aug 2021 21:03:49 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:03:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [clocksource]  8901ecc231:  stress-ng.lockbus.ops_per_sec -9.5%
 regression
Message-ID: <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
 <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805021646.GA11629@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805021646.GA11629@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 10:16:48AM +0800, Chao Gao wrote:
> On Tue, Aug 03, 2021 at 06:48:16AM -0700, Paul E. McKenney wrote:
> >On Tue, Aug 03, 2021 at 04:58:00PM +0800, Chao Gao wrote:
> >> On Mon, Aug 02, 2021 at 10:02:57AM -0700, Paul E. McKenney wrote:
> >> >On Mon, Aug 02, 2021 at 02:20:09PM +0800, Chao Gao wrote:
> >> >> [snip]
> >> >> >commit 48ebcfbfd877f5d9cddcc03c91352a8ca7b190af
> >> >> >Author: Paul E. McKenney <paulmck@kernel.org>
> >> >> >Date:   Thu May 27 11:03:28 2021 -0700
> >> >> >
> >> >> >    clocksource: Forgive repeated long-latency watchdog clocksource reads
> >> >> >    
> >> >> >    Currently, the clocksource watchdog reacts to repeated long-latency
> >> >> >    clocksource reads by marking that clocksource unstable on the theory that
> >> >> >    these long-latency reads are a sign of a serious problem.  And this theory
> >> >> >    does in fact have real-world support in the form of firmware issues [1].
> >> >> >    
> >> >> >    However, it is also possible to trigger this using stress-ng on what
> >> >> >    the stress-ng man page terms "poorly designed hardware" [2].  And it
> >> >> >    is not necessarily a bad thing for the kernel to diagnose cases where
> >> >> >    high-stress workloads are being run on hardware that is not designed
> >> >> >    for this sort of use.
> >> >> >    
> >> >> >    Nevertheless, it is quite possible that real-world use will result in
> >> >> >    some situation requiring that high-stress workloads run on hardware
> >> >> >    not designed to accommodate them, and also requiring that the kernel
> >> >> >    refrain from marking clocksources unstable.
> >> >> >    
> >> >> >    Therefore, provide an out-of-tree patch that reacts to this situation
> >> >> >    by leaving the clocksource alone, but using the old 62.5-millisecond
> >> >> >    skew-detection threshold in response persistent long-latency reads.
> >> >> >    In addition, the offending clocksource is marked for re-initialization
> >> >> >    in this case, which both restarts that clocksource with a clean bill of
> >> >> >    health and avoids false-positive skew reports on later watchdog checks.
> >> >> 
> >> >> Hi Paul,
> >> >> 
> >> >> Sorry to dig out this old thread.
> >> >
> >> >Not a problem, especially given that this is still an experimental patch
> >> >(marked with "EXP" in -rcu).  So one remaining question is "what is this
> >> >patch really supposed to do, if anything?".
> >> 
> >> We are testing with TDX [1] and analyzing why kernel in a TD, or Trust Domain,
> >> sometimes spots a large TSC skew. We have inspected tsc hardware/ucode/tdx
> >> module to ensure no hardware issue, and also ported tsc_sync.c to a userspace
> >> tool such that this tool can help to constantly check if tsc is synchronized
> >> when some workload is running. Finally, we believe that the large TSC skew 
> >> spotted by TD kernel is a false positive.
> >> 
> >> Your patches (those are merged) have improved clocksource watchdog a lot to
> >> reduce false-positives. But due to the nature of TDX, switching between TD
> >> and host takes more time. Then, the time window between two reads from
> >> watchdog clocksource in cs_watchdog_read() increases, so does the
> >> probability of the two reads being interrupted by whatever on host. Then,
> >> sometimes, especially when there are heavy workloads in both host and TD,
> >> the maximum number of retries in cs_watchdog_read() is exceeded and tsc is
> >> marked unstable.
> >> 
> >> Then we apply this out-of-tree patch, it helps to further reduce
> >> false-positives. But TD kernel still observes TSC skew in some cases. After
> >> a close look into kernel logs, we find patterns in those cases: an expected
> >> re-initialization somehow doesn't happen. That's why we raise this issue
> >> and ask for your advice.
> >
> >I am glad that the patch at least helps.  ;-)
> >
> >> [1]: https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html
> >> 
> >> >And here the clocksource failed the coarse-grained check and marked
> >> >the clocksource as unstable.  Perhaps because the previous read
> >> >forced a coarse-grained check.  Except that this should have forced
> >> >a reinitialization.  Ah, it looks like I need to suppress setting
> >> >CLOCK_SOURCE_WATCHDOG if coarse-grained checks have been enabled.
> >> >That could cause false-positive failure for the next check, after all.
> >> >
> >> >And perhaps make cs_watchdog_read() modify its print if there is
> >> >a watchdog reset pending or if the current clocksource has the
> >> >CLOCK_SOURCE_WATCHDOG flag cleared.
> >> >
> >> >Perhaps as shown in the additional patch below, to be folded into the
> >> >original?
> >> 
> >> Thanks. Will test with below patch applied.
> >
> >If this patch helps, but problems remain, another thing to try is to
> >increase the clocksource.max_cswd_read_retries kernel boot parameter
> >above its default value of 3.  Maybe to 5 or 10?
> >
> >If this patch does not help, please let me know.  In that case, there
> >are probably more fixes required.
> 
> This patch works well; no false-positive (marking TSC unstable) in a
> 10hr stress test.

Very good, thank you!  May I add your Tested-by?

I expect that I will need to modify the patch a bit more to check for
a system where it is -never- able to get a good fine-grained read from
the clock.  And it might be that your test run ended up in that state.

My current thought is that if more than (say) 100 consecutive attempts
to read the clocksource get hit with excessive delays, it is time to at
least do a WARN_ON(), and maybe also time to disable the clocksource
due to skew.  The reason is that if reading the clocksource -always-
sees excessive delays, perhaps the clock driver or hardware is to blame.

Thoughts?

							Thanx, Paul
