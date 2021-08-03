Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C035B3DEF42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236209AbhHCNsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234324AbhHCNs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:48:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFD3E60EE8;
        Tue,  3 Aug 2021 13:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627998496;
        bh=zQcbProzWPaxleoMp6t5lAXDYvQgawbCdWjeOH+VTHE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TrO/WXFKyGWb4yUP1ijh+x8hUISwQHiCHiuUMBhcvQKIh1SrJ6JIfkms6WwNG5hmf
         O2mzGPZfH6fSTKbawZnlQk/2931/BZQLHurJ/U+urmWYMlod/IJunWR5LJbe219RWG
         ske+xmMc2aZtQGyW6fldr4UAw4eO0DGtmsjrICKLeyCrde5rARufeEhzfVf58VOFMx
         t6t7hLU5agvetWR52ChAciKmNjNvgRrWx4vNiS8Ll1KmW/tVZb8IDxUf1pwHJ/OwZq
         M//JpeDeZC/BkrXQvFJ5du50bdRYN6zfMD7DEjNvehCOYABO2NOHHuILkXDOaqgXP9
         HhfPMz/KKJ0+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A5EE05C3C26; Tue,  3 Aug 2021 06:48:16 -0700 (PDT)
Date:   Tue, 3 Aug 2021 06:48:16 -0700
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
Message-ID: <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803085759.GA31621@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 04:58:00PM +0800, Chao Gao wrote:
> On Mon, Aug 02, 2021 at 10:02:57AM -0700, Paul E. McKenney wrote:
> >On Mon, Aug 02, 2021 at 02:20:09PM +0800, Chao Gao wrote:
> >> [snip]
> >> >commit 48ebcfbfd877f5d9cddcc03c91352a8ca7b190af
> >> >Author: Paul E. McKenney <paulmck@kernel.org>
> >> >Date:   Thu May 27 11:03:28 2021 -0700
> >> >
> >> >    clocksource: Forgive repeated long-latency watchdog clocksource reads
> >> >    
> >> >    Currently, the clocksource watchdog reacts to repeated long-latency
> >> >    clocksource reads by marking that clocksource unstable on the theory that
> >> >    these long-latency reads are a sign of a serious problem.  And this theory
> >> >    does in fact have real-world support in the form of firmware issues [1].
> >> >    
> >> >    However, it is also possible to trigger this using stress-ng on what
> >> >    the stress-ng man page terms "poorly designed hardware" [2].  And it
> >> >    is not necessarily a bad thing for the kernel to diagnose cases where
> >> >    high-stress workloads are being run on hardware that is not designed
> >> >    for this sort of use.
> >> >    
> >> >    Nevertheless, it is quite possible that real-world use will result in
> >> >    some situation requiring that high-stress workloads run on hardware
> >> >    not designed to accommodate them, and also requiring that the kernel
> >> >    refrain from marking clocksources unstable.
> >> >    
> >> >    Therefore, provide an out-of-tree patch that reacts to this situation
> >> >    by leaving the clocksource alone, but using the old 62.5-millisecond
> >> >    skew-detection threshold in response persistent long-latency reads.
> >> >    In addition, the offending clocksource is marked for re-initialization
> >> >    in this case, which both restarts that clocksource with a clean bill of
> >> >    health and avoids false-positive skew reports on later watchdog checks.
> >> 
> >> Hi Paul,
> >> 
> >> Sorry to dig out this old thread.
> >
> >Not a problem, especially given that this is still an experimental patch
> >(marked with "EXP" in -rcu).  So one remaining question is "what is this
> >patch really supposed to do, if anything?".
> 
> We are testing with TDX [1] and analyzing why kernel in a TD, or Trust Domain,
> sometimes spots a large TSC skew. We have inspected tsc hardware/ucode/tdx
> module to ensure no hardware issue, and also ported tsc_sync.c to a userspace
> tool such that this tool can help to constantly check if tsc is synchronized
> when some workload is running. Finally, we believe that the large TSC skew 
> spotted by TD kernel is a false positive.
> 
> Your patches (those are merged) have improved clocksource watchdog a lot to
> reduce false-positives. But due to the nature of TDX, switching between TD
> and host takes more time. Then, the time window between two reads from
> watchdog clocksource in cs_watchdog_read() increases, so does the
> probability of the two reads being interrupted by whatever on host. Then,
> sometimes, especially when there are heavy workloads in both host and TD,
> the maximum number of retries in cs_watchdog_read() is exceeded and tsc is
> marked unstable.
> 
> Then we apply this out-of-tree patch, it helps to further reduce
> false-positives. But TD kernel still observes TSC skew in some cases. After
> a close look into kernel logs, we find patterns in those cases: an expected
> re-initialization somehow doesn't happen. That's why we raise this issue
> and ask for your advice.

I am glad that the patch at least helps.  ;-)

> [1]: https://software.intel.com/content/www/us/en/develop/articles/intel-trust-domain-extensions.html
> 
> >And here the clocksource failed the coarse-grained check and marked
> >the clocksource as unstable.  Perhaps because the previous read
> >forced a coarse-grained check.  Except that this should have forced
> >a reinitialization.  Ah, it looks like I need to suppress setting
> >CLOCK_SOURCE_WATCHDOG if coarse-grained checks have been enabled.
> >That could cause false-positive failure for the next check, after all.
> >
> >And perhaps make cs_watchdog_read() modify its print if there is
> >a watchdog reset pending or if the current clocksource has the
> >CLOCK_SOURCE_WATCHDOG flag cleared.
> >
> >Perhaps as shown in the additional patch below, to be folded into the
> >original?
> 
> Thanks. Will test with below patch applied.

If this patch helps, but problems remain, another thing to try is to
increase the clocksource.max_cswd_read_retries kernel boot parameter
above its default value of 3.  Maybe to 5 or 10?

If this patch does not help, please let me know.  In that case, there
are probably more fixes required.

							Thanx, Paul

> Thanks
> Chao
> >
> >							Thanx, Paul
> >
> >------------------------------------------------------------------------
> >
> >diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >index cfa992250c388..62da2485fd574 100644
> >--- a/kernel/time/clocksource.c
> >+++ b/kernel/time/clocksource.c
> >@@ -230,8 +230,13 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> > 		}
> > 	}
> > 
> >-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
> >-		smp_processor_id(), watchdog->name, wd_delay, nretries);
> >+	if ((cs->flags & CLOCK_SOURCE_WATCHDOG) && !atomic_read(&watchdog_reset_pending)) {
> >+		pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
> >+			smp_processor_id(), watchdog->name, wd_delay, nretries);
> >+	} else {
> >+		pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, awaiting re-initialization\n",
> >+			smp_processor_id(), watchdog->name, wd_delay, nretries);
> >+	}
> > 	return true;
> > }
> > 
> >@@ -379,7 +384,8 @@ static void clocksource_watchdog(struct timer_list *unused)
> > 		/* Clocksource initialized ? */
> > 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> > 		    atomic_read(&watchdog_reset_pending)) {
> >-			cs->flags |= CLOCK_SOURCE_WATCHDOG;
> >+			if (!coarse)
> >+				cs->flags |= CLOCK_SOURCE_WATCHDOG;
> > 			cs->wd_last = wdnow;
> > 			cs->cs_last = csnow;
> > 			continue;
