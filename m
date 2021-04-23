Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43A369BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 23:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbhDWVPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 17:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232636AbhDWVPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 17:15:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FC2D61410;
        Fri, 23 Apr 2021 21:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619212485;
        bh=Ny/kPQPnadP9Iyp68buiBCfGzmA7A9zDcsM3WlAru80=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JaUXjHeEV4GsFfjoH6IiFBjTSDoDwocFIQut89gegZsBlk9AePgL+1ZTzlvkit17u
         viGw96ZD+CkfoNJHehCoJKdJL2xGGHgzhSisqX7dEjLDVCWfvLpT51iqV7ouMoTg45
         cu7DQ4XhJjhmUbqNid/bqyqxNipBmg2mweevOFGnY6sRLcvElpBsQHtFGVeio+I84Q
         ElnhB5Y6VAChH1sPFh556X9cC6fyOsMq4oZVK527NzzK9iOEFW4pJvYB0vtFMS0UZT
         HtrEHUi7Y+ZhzapWV1oxKXFYCij0a6ZE32d+UwLPMw57B2d32mYYX02MRl8owj9BO4
         b6Zmo9Q5g25fg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D8F395C064D; Fri, 23 Apr 2021 14:14:44 -0700 (PDT)
Date:   Fri, 23 Apr 2021 14:14:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec
 -14.4% regression
Message-ID: <20210423211444.GO975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210420064934.GE31773@xsang-OptiPlex-9020>
 <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1>
 <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com>
 <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <87tunwvmmu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tunwvmmu.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 09:14:49PM +0200, Thomas Gleixner wrote:
> On Thu, Apr 22 2021 at 07:24, Paul E. McKenney wrote:
> > On Thu, Apr 22, 2021 at 03:41:26PM +0800, Feng Tang wrote:
> > So what are our options?
> >
> > 1.	Clear CLOCK_SOURCE_MUST_VERIFY from tsc-early.
> >
> > 2.	#1, but add tsc-early into the watchdog list and set
> > 	CLOCK_SOURCE_MUST_VERIFY once it is better calibrated.
> >
> > 3.	Add a field to struct clocksource that, if non-zero, gives
> > 	the maximum drift in nanoseconds per half second (AKA
> > 	WATCHDOG_INTERVAL).  If zero, the WATCHDOG_MAX_SKEW value
> > 	is used.  Set this to (say) 150,000ns for tsc-early.
> >
> > 4.	As noted earlier, increase WATCHDOG_MAX_SKEW to 150 microseconds,
> > 	which again is not a good approach given the real-world needs
> > 	of real-world applications.
> >
> > 5.	Your ideas here.
> 
> #3 or add a flag to the clocksource which says 'frequency is guesswork' and
> increase the threshold based on that.
> 
> If that flag is still set max_drift is != 0 after 20 seconds yell.

I made it 60 seconds based on recent experience with large systems,
but sounds good!

And the calls to clocksource_unregister(&clocksource_tsc_early) mean
that it is not necessary to actually clear the .max_drift field, if
I understand correctly.

It looks to me that init_tsc_clocksource() is invoked at device_initcall()
time, and that it either immediately unregisters clocksource_tsc_early
(known TSC frequency), or schedules a delayed work to make
tsc_refine_calibration_work() do the calibration and the unregister.

Please see below for an untested patch.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 56289170753c..7192b8950322 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1127,6 +1127,7 @@ static int tsc_cs_enable(struct clocksource *cs)
 static struct clocksource clocksource_tsc_early = {
 	.name			= "tsc-early",
 	.rating			= 299,
+	.max_drift		= 5 * NSEC_PER_MSEC,
 	.read			= read_tsc,
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 83a3ebff7456..0c4418b381bf 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -93,6 +93,7 @@ struct clocksource {
 	u32			shift;
 	u64			max_idle_ns;
 	u32			maxadj;
+	u32			max_drift;
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index a1f90e2b1039..871837c46c62 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -126,6 +126,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (200 * NSEC_PER_USEC)
+#define WATCHDOG_SYNC_FORGIVENESS (HZ * 60UL)
 
 /*
  * Maximum permissible delay between two readouts of the watchdog
@@ -377,6 +378,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	u32 md;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -423,6 +425,12 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 
 		/* Check the deviation from the watchdog clocksource. */
+		if (!cs->max_drift) {
+			md = WATCHDOG_MAX_SKEW;
+		} else {
+			WARN_ON_ONCE(time_after(jiffies, WATCHDOG_SYNC_FORGIVENESS));
+			md = cs->max_drift;
+		}
 		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
