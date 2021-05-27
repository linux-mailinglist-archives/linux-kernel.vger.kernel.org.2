Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F1439356D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 20:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbhE0Sbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 14:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:32936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234155AbhE0Sbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 14:31:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCE4E613D3;
        Thu, 27 May 2021 18:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622140199;
        bh=bggBIS8GMHuViK0LDowgFbGqu7Jz4cU3JzwfUQbN/b8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UV6LiEcQmEK6V4eUFVtEMGBjSwpKyjAWsspwVKiUxf60H17X71J5C3QKJkOwrHC+j
         uvMsLZWDj/Edv6rFqIBo3MB+lc4GdyISjYjQ2hcUYDmP87RPNZRAmQ1TKn/ON+/5tk
         mn3NqkRiXPQmLY4mHV+8tQsnz8n7CsgTrgQ+bpRrkfphz2tyip+xoRAMXIrENw/lAY
         IjYFbYsNggOCoW+PIwnN0qnZ60ZRZwvqqEB3F9ENUqfUeB54cTG1HtrZzh5RTxvFKE
         DbN9hudB31Mw8m9K/IArAeooCkzMPFGjzeRlHKgp5s0AtxcfVf8dj/DiVsr65hYWKD
         plNF1AwZEWW4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 99FCD5C02A9; Thu, 27 May 2021 11:29:59 -0700 (PDT)
Date:   Thu, 27 May 2021 11:29:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
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
Message-ID: <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 06:49:11AM -0700, Paul E. McKenney wrote:
> On Wed, May 26, 2021 at 02:49:22PM +0800, Feng Tang wrote:
> > On Sat, May 22, 2021 at 09:08:27AM -0700, Paul E. McKenney wrote:
> > > On Fri, May 21, 2021 at 06:56:17AM -0700, Paul E. McKenney wrote:
> > > > On Fri, May 21, 2021 at 04:33:22PM +0800, kernel test robot wrote:
> > > > > 
> > > > > 
> > > > > Greeting,
> > > > > 
> > > > > FYI, we noticed a -9.5% regression of stress-ng.lockbus.ops_per_sec due to commit:
> > > > > 
> > > > > 
> > > > > commit: 8901ecc2315b850f35a7b8c1b73b12388b72aa78 ("clocksource: Retry clock read if long delays detected")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > > > 
> > > > > 
> > > > > in testcase: stress-ng
> > > > > on test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
> > > > > with following parameters:
> > > > > 
> > > > > 	nr_threads: 100%
> > > > > 	disk: 1HDD
> > > > > 	testtime: 60s
> > > > > 	class: memory
> > > > > 	test: lockbus
> > > > > 	cpufreq_governor: performance
> > > > > 	ucode: 0x5003006
> > > > > 
> > > > > 
> > > > > please be noted below in dmesg.xz (attached)
> > > > > [   28.110351]
> > > > > [   28.302357] hrtimer: interrupt took 1878423 ns
> > > > > [   29.690760] clocksource: timekeeping watchdog on CPU53: hpet read-back delay of 169583ns, attempt 4, marking unstable
> > > > > [   29.860306] tsc: Marking TSC unstable due to clocksource watchdog
> > > > > [   30.559390] TSC found unstable after boot, most likely due to broken BIOS. Use 'tsc=unstable'.
> > > > > [   30.726282] sched_clock: Marking unstable (30052964508, 499342225)<-(30915547410, -363240730)
> > > > > [   31.620401] clocksource: Switched to clocksource hpet
> > > > 
> > > > If I am reading the dmesg correctly, there were many interrupts that
> > > > prevented a good clock read.  This sound to me like a bug that the
> > > > clocksource watchdog located, but please let me know if this is not
> > > > the case.
> > > >
> > > > There are also the later "perf: interrupt took too long" messages.
> > >
> > > And of course, increasing the clocksource.max_cswd_read_retries module
> > > boot parameter (or clocksource.max_read_retries in the earlier commits,
> > > which I will fix) can work around short bursts of NMIs.  Or long bursts
> > > of NMIs, if you set this kernel boot parameter large enough.
> > 
> > I reproduced it on a borrowed baremetal 4 nodes, 96C/192T Xeon, with
> > latest stress-ng code https://github.com/ColinIanKing/stress-ng.git.
> > (2 sockets box should also be able to reproduce it)
> > 
> > Seems this sub testcase 'lockbus' is a extreme stress case, by loop
> > doing "lock" operation:
> > 
> >   c8:	f0 83 00 01          	lock addl $0x1,(%rax)
> >   cc:	f0 83 40 04 01       	lock addl $0x1,0x4(%rax)
> >   d1:	f0 83 40 08 01       	lock addl $0x1,0x8(%rax)
> >   d6:	f0 83 40 0c 01       	lock addl $0x1,0xc(%rax)
> >   db:	f0 83 40 10 01       	lock addl $0x1,0x10(%rax)
> >   e0:	f0 83 40 14 01       	lock addl $0x1,0x14(%rax)
> >   e5:	f0 83 40 18 01       	lock addl $0x1,0x18(%rax)
> >   ea:	f0 83 40 1c 01       	lock addl $0x1,0x1c(%rax)
> >   ef:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >   f3:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >   f7:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >   fb:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >   ff:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >  103:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >  107:	f0 83 01 00          	lock addl $0x0,(%rcx)
> >  ...
> > 
> > (The source c file and objdump are attached fyi)
> > 
> > So the watchdog read (read_hpet() here) sometimes does take very
> > long time (hundreds of microseconds) which breaks this sanity
> > read check, and cause 'unstable' tsc.
> > 
> > As from the man page of stress-ng:
> > "Use stress-ng with caution as some of the tests can make a system
> > run hot on poorly designed hardware and also can cause excessive
> > system thrashing which may be difficult to stop"
> > 
> > I don't think this 'lockbus' is close to any real-world usage.
> 
> Heh!  In the past, I have had to adjust Linux-kernel RCU in order to
> avoid having too many locked operations.  So, yes, I agree that this
> test result should not require a change to the clocksource watchdog.
> 
> I just rebased to eliminate the pointless name change in the middle
> of the series from max_read_retries to max_cswd_read_retries, and will
> repost later today or tomorrow.

In addition, please see below for a just-in-case out-of-tree patch that
takes a different approach in response to persistent long-latency reads.
It falls back to using the old 62.5-millisecond skew threshold and also
marks the offending clocksource for reinitialization.

Again, I believe that the current less-subtle approach will serve us well,
especially during hardware bringup, but just in case...

							Thanx, Paul

------------------------------------------------------------------------

commit 48ebcfbfd877f5d9cddcc03c91352a8ca7b190af
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu May 27 11:03:28 2021 -0700

    clocksource: Forgive repeated long-latency watchdog clocksource reads
    
    Currently, the clocksource watchdog reacts to repeated long-latency
    clocksource reads by marking that clocksource unstable on the theory that
    these long-latency reads are a sign of a serious problem.  And this theory
    does in fact have real-world support in the form of firmware issues [1].
    
    However, it is also possible to trigger this using stress-ng on what
    the stress-ng man page terms "poorly designed hardware" [2].  And it
    is not necessarily a bad thing for the kernel to diagnose cases where
    high-stress workloads are being run on hardware that is not designed
    for this sort of use.
    
    Nevertheless, it is quite possible that real-world use will result in
    some situation requiring that high-stress workloads run on hardware
    not designed to accommodate them, and also requiring that the kernel
    refrain from marking clocksources unstable.
    
    Therefore, provide an out-of-tree patch that reacts to this situation
    by leaving the clocksource alone, but using the old 62.5-millisecond
    skew-detection threshold in response persistent long-latency reads.
    In addition, the offending clocksource is marked for re-initialization
    in this case, which both restarts that clocksource with a clean bill of
    health and avoids false-positive skew reports on later watchdog checks.
    
    Link: https://lore.kernel.org/lkml/20210513155515.GB23902@xsang-OptiPlex-9020/ # [1]
    Link: https://lore.kernel.org/lkml/20210521083322.GG25531@xsang-OptiPlex-9020/ # [2]
    Link: https://lore.kernel.org/lkml/20210521084405.GH25531@xsang-OptiPlex-9020/
    Link: https://lore.kernel.org/lkml/20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1/
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index 01df12395c0e..b72a969f7b93 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -146,13 +146,12 @@ static int wdtest_func(void *arg)
 		else if (i <= max_cswd_read_retries)
 			s = ", expect message";
 		else
-			s = ", expect clock skew";
+			s = ", expect coarse-grained clock skew check and re-initialization";
 		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
 		schedule_timeout_uninterruptible(2 * HZ);
 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
-			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
+		WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE);
 		wdtest_ktime_clocksource_reset();
 	}
 
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 4485635b69f5..6c0820779bd3 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -225,13 +225,13 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-			return true;
+			return false;
 		}
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
+	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
 		smp_processor_id(), watchdog->name, wd_delay, nretries);
-	return false;
+	return true;
 }
 
 static u64 csnow_mid;
@@ -355,6 +355,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	bool coarse;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -372,11 +373,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
-			/* Clock readout unreliable, so give it up. */
-			__clocksource_unstable(cs);
-			continue;
-		}
+		coarse = cs_watchdog_read(cs, &csnow, &wdnow);
 
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
@@ -402,7 +399,13 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 
 		/* Check the deviation from the watchdog clocksource. */
-		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
+		if (coarse) {
+			md = 62500 * NSEC_PER_USEC;
+			cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
+			pr_warn("timekeeping watchdog on CPU%d: %s coarse-grained %lu.%03lu ms clock-skew check followed by re-initialization\n", smp_processor_id(), watchdog->name, md / NSEC_PER_MSEC, md % NSEC_PER_MSEC / NSEC_PER_USEC);
+		} else {
+			md = cs->uncertainty_margin + watchdog->uncertainty_margin;
+		}
 		if (abs(cs_nsec - wd_nsec) > md) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
