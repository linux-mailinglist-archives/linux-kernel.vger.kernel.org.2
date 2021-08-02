Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20D3DDE2E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 19:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhHBRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 13:03:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBRDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 13:03:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C00F60F6E;
        Mon,  2 Aug 2021 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627923777;
        bh=sJnuLZVcTC5tlrXJXjxx1R2NazTGzbzKKu+BheYkeZM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ANCYcEJzYQQh9pcpw5fVLWIu2nMstr9U2tX1c+oNm+KRE9dVeyk1QNDXfSVFnrjHx
         HVDjntKzOQJMAdyxzMAfOK9nFGMZyLXHhSs7FN3XDmS374H3O+V4ghw8TRNfy8GHxX
         MmGlZB3IAY1PIvUUylPT0KFPrj3KBpfeZVz6zO1Ub/9NG5y6H10GyKQ1voPaQVymhj
         acKcXaGuq+A1ejHYgOVShFHpTLMI/XiyUx7zuK71rl8HmIYuDAoDZnp/qvKVk8fjTU
         /gWxFCk1KKN6ml6NYAiLj1PV8az7qfErrFOcS66ZVUge+x7E7N2j2wPkb/Ni8xD2KW
         YKFUl5bJ1scFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 39B365C0892; Mon,  2 Aug 2021 10:02:57 -0700 (PDT)
Date:   Mon, 2 Aug 2021 10:02:57 -0700
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
Message-ID: <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062008.GA24720@gao-cwp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:20:09PM +0800, Chao Gao wrote:
> [snip]
> >commit 48ebcfbfd877f5d9cddcc03c91352a8ca7b190af
> >Author: Paul E. McKenney <paulmck@kernel.org>
> >Date:   Thu May 27 11:03:28 2021 -0700
> >
> >    clocksource: Forgive repeated long-latency watchdog clocksource reads
> >    
> >    Currently, the clocksource watchdog reacts to repeated long-latency
> >    clocksource reads by marking that clocksource unstable on the theory that
> >    these long-latency reads are a sign of a serious problem.  And this theory
> >    does in fact have real-world support in the form of firmware issues [1].
> >    
> >    However, it is also possible to trigger this using stress-ng on what
> >    the stress-ng man page terms "poorly designed hardware" [2].  And it
> >    is not necessarily a bad thing for the kernel to diagnose cases where
> >    high-stress workloads are being run on hardware that is not designed
> >    for this sort of use.
> >    
> >    Nevertheless, it is quite possible that real-world use will result in
> >    some situation requiring that high-stress workloads run on hardware
> >    not designed to accommodate them, and also requiring that the kernel
> >    refrain from marking clocksources unstable.
> >    
> >    Therefore, provide an out-of-tree patch that reacts to this situation
> >    by leaving the clocksource alone, but using the old 62.5-millisecond
> >    skew-detection threshold in response persistent long-latency reads.
> >    In addition, the offending clocksource is marked for re-initialization
> >    in this case, which both restarts that clocksource with a clean bill of
> >    health and avoids false-positive skew reports on later watchdog checks.
> 
> Hi Paul,
> 
> Sorry to dig out this old thread.

Not a problem, especially given that this is still an experimental patch
(marked with "EXP" in -rcu).  So one remaining question is "what is this
patch really supposed to do, if anything?"

> I am testing with this patch in a VM, but I find sometimes re-initialization
> after coarse-grained skew check may not happen as expected because ...
> 
> >    
> >    Link: https://lore.kernel.org/lkml/20210513155515.GB23902@xsang-OptiPlex-9020/ # [1]
> >    Link: https://lore.kernel.org/lkml/20210521083322.GG25531@xsang-OptiPlex-9020/ # [2]
> >    Link: https://lore.kernel.org/lkml/20210521084405.GH25531@xsang-OptiPlex-9020/
> >    Link: https://lore.kernel.org/lkml/20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1/
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
> >index 01df12395c0e..b72a969f7b93 100644
> >--- a/kernel/time/clocksource-wdtest.c
> >+++ b/kernel/time/clocksource-wdtest.c
> >@@ -146,13 +146,12 @@ static int wdtest_func(void *arg)
> > 		else if (i <= max_cswd_read_retries)
> > 			s = ", expect message";
> > 		else
> >-			s = ", expect clock skew";
> >+			s = ", expect coarse-grained clock skew check and re-initialization";
> > 		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> > 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
> > 		schedule_timeout_uninterruptible(2 * HZ);
> > 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
> >-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
> >-			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
> >+		WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE);
> > 		wdtest_ktime_clocksource_reset();
> > 	}
> > 
> >diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> >index 4485635b69f5..6c0820779bd3 100644
> >--- a/kernel/time/clocksource.c
> >+++ b/kernel/time/clocksource.c
> >@@ -225,13 +225,13 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> > 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> > 					smp_processor_id(), watchdog->name, nretries);
> > 			}
> >-			return true;
> >+			return false;
> > 		}
> > 	}
> > 
> >-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
> >+	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
> > 		smp_processor_id(), watchdog->name, wd_delay, nretries);
> >-	return false;
> >+	return true;
> > }
> > 
> > static u64 csnow_mid;
> >@@ -355,6 +355,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > 	int next_cpu, reset_pending;
> > 	int64_t wd_nsec, cs_nsec;
> > 	struct clocksource *cs;
> >+	bool coarse;
> > 	u32 md;
> > 
> > 	spin_lock(&watchdog_lock);
> >@@ -372,11 +373,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> > 			continue;
> > 		}
> > 
> >-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
> >-			/* Clock readout unreliable, so give it up. */
> >-			__clocksource_unstable(cs);
> >-			continue;
> >-		}
> >+		coarse = cs_watchdog_read(cs, &csnow, &wdnow);
> > 
> > 		/* Clocksource initialized ? */
> > 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
> >@@ -402,7 +399,13 @@ static void clocksource_watchdog(struct timer_list *unused)
> > 			continue;
> > 
> > 		/* Check the deviation from the watchdog clocksource. */
> >-		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
> >+		if (coarse) {
> >+			md = 62500 * NSEC_PER_USEC;
> >+			cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
> >+			pr_warn("timekeeping watchdog on CPU%d: %s coarse-grained %lu.%03lu ms clock-skew check followed by re-initialization\n", smp_processor_id(), watchdog->name, md / NSEC_PER_MSEC, md % NSEC_PER_MSEC / NSEC_PER_USEC);
> 
> ... this message on CPU5 doesn't show up in below kernel logs.
> Do you think it is a bug? if yes, any idea to resolve it?
> 
> [  498.571086] clocksource: timekeeping watchdog on CPU1: hpet read-back delay of 432490ns, attempt 4, coarse-grained skew check followed by re-initialization
> [  498.572867] clocksource: timekeeping watchdog on CPU1: hpet coarse-grained 62.500 ms clock-skew check followed by re-initialization
> [  504.071959] clocksource: timekeeping watchdog on CPU4: hpet read-back delay of 1679880ns, attempt 4, coarse-grained skew check followed by re-initialization
> [  504.073817] clocksource: timekeeping watchdog on CPU4: hpet coarse-grained 62.500 ms clock-skew check followed by re-initialization
> [  504.568821] clocksource: timekeeping watchdog on CPU5: hpet read-back delay of 554880ns, attempt 4, coarse-grained skew check followed by re-initialization

Up to this point, the clocksource passed the coarse-grained checks.
So at the very least, the "followed by re-initialization" is misleading.
I will change this message.

And yes, I would have expected the additional "62.500 ms clock-skew check"
message from CPU5, like we see from CPU1 and CPU4 above.  However, this
message will be omitted if there is a watchdog reset pending or if the
clocksource has not yet been initialized.  Which could well have happened
in this case.

> [  505.067666] clocksource: timekeeping watchdog on CPU6: hpet retried 3 times before success
> [  505.068593] clocksource: timekeeping watchdog on CPU6: Marking clocksource 'tsc' as unstable because the skew is too large:
> [  505.069596] clocksource:                       'hpet' wd_nsec: 499376790 wd_now: be2f200d wd_last: bb3522fe mask: ffffffff
> [  505.071131] clocksource:                       'tsc' cs_nsec: 498867307 cs_now: 103895c060a cs_last: 1034aea96ea mask: ffffffffffffffff
> [  505.072994] clocksource:                       'tsc' is current clocksource.
> [  505.074748] tsc: Marking TSC unstable due to clocksource watchdog

And here the clocksource failed the coarse-grained check and marked
the clocksource as unstable.  Perhaps because the previous read
forced a coarse-grained check.  Except that this should have forced
a reinitialization.  Ah, it looks like I need to suppress setting
CLOCK_SOURCE_WATCHDOG if coarse-grained checks have been enabled.
That could cause false-positive failure for the next check, after all.

And perhaps make cs_watchdog_read() modify its print if there is
a watchdog reset pending or if the current clocksource has the
CLOCK_SOURCE_WATCHDOG flag cleared.

Perhaps as shown in the additional patch below, to be folded into the
original?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cfa992250c388..62da2485fd574 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -230,8 +230,13 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 		}
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	if ((cs->flags & CLOCK_SOURCE_WATCHDOG) && !atomic_read(&watchdog_reset_pending)) {
+		pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
+			smp_processor_id(), watchdog->name, wd_delay, nretries);
+	} else {
+		pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, awaiting re-initialization\n",
+			smp_processor_id(), watchdog->name, wd_delay, nretries);
+	}
 	return true;
 }
 
@@ -379,7 +384,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
 		    atomic_read(&watchdog_reset_pending)) {
-			cs->flags |= CLOCK_SOURCE_WATCHDOG;
+			if (!coarse)
+				cs->flags |= CLOCK_SOURCE_WATCHDOG;
 			cs->wd_last = wdnow;
 			cs->cs_last = csnow;
 			continue;
