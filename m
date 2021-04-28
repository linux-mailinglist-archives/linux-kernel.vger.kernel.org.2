Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F7736D05F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238391AbhD1BtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235984AbhD1BtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:49:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 337496100C;
        Wed, 28 Apr 2021 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619574500;
        bh=B2Y40YakNFJ0bB9L9P7SI99QssBMewlQIfxw07jXH9k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ON0cjLoGaubXAtHNfj4ZoMKMN15/n/6LTiYnqshTu4xlOAIRdr/vgYskHkKM69dZz
         bOfjOEmzPF+YlwYGBjv32auuQGxxtzvaaSkBPgwL/T+Ibogp2Yt1E3gnCfzfCDTIfL
         k1ErpnG2WT98x/uwg9jhi/tAHIq4SU08Mgd75heI3ffPWUMWZeUPaAjlRXoYYTzyTr
         8Qa5r9ALswFtmkkMdT3GdUTXrbah93VZMuSfzj83x4wpnB6QYvTBhA5g798W9fdlFD
         xWgKHWLKRFJ+OOIDeFeUAE7lWoLZ2sIdNFlroPW6+873a+C0CCCBwjysacfixSXsdv
         lf7YiACOekdFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EFB555C0153; Tue, 27 Apr 2021 18:48:19 -0700 (PDT)
Date:   Tue, 27 Apr 2021 18:48:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org, zhengjun.xing@intel.com
Subject: Re: [clocksource]  8c30ace35d:
 WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
Message-ID: <20210428014819.GA965980@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210427175027.GA945820@paulmck-ThinkPad-P17-Gen-1>
 <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 11:09:49PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> On Tue, Apr 27 2021 at 10:50, Paul E. McKenney wrote:
> > On Tue, Apr 27, 2021 at 06:37:46AM -0700, Paul E. McKenney wrote:
> >> I suppose that I give it (say) 120 seconds instead of the current 60,
> >> which might be the right thing to do, but it does feel like papering
> >> over a very real initramfs problem.  Alternatively, I could provide a
> >> boot parameter allowing those with slow systems to adjust as needed.
> >
> > OK, it turns out that there are systems for which boot times in excess
> > of one minute are expected behavior.  They are a bit rare, though.
> > So what I will do is keep the 60-second default, add a boot parameter,
> > and also add a comment by the warning pointing out the boot parameter.
> 
> Oh, no. This starts to become yet another duct tape horror show.
> 
> I'm not at all against a more robust and resilent watchdog mechanism,
> but having a dozen knobs to tune and heuristics which are doomed to fail
> is not a solution at all.

One problem is that I did the .max_drift patch backwards.  I tightened
the skew requirements on all clocks except those specially marked, and
I should have done the reverse.  With that change, all of the clocks
except for clocksource_tsc would work (or as the case might be, fail to
work) in exactly the same way that they do today, but still rejecting
false-positive skew events due to NMIs, SMIs, vCPU preemption, and so on.

Then patch v10 7/7 can go away completely, and patch 6/7 becomes much
smaller (and gets renamed), for example, as shown below.

Does that help?

							Thanx, Paul

------------------------------------------------------------------------

commit ba1fca950a4bcd8a5737efc552f937529496b5fc
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Apr 27 18:43:37 2021 -0700

    clocksource: Reduce clocksource-skew threshold for TSC
    
    Currently, WATCHDOG_THRESHOLD is set to detect a 62.5-millisecond skew in
    a 500-millisecond WATCHDOG_INTERVAL.  This requires that clocks be skewed
    by more than 12.5% in order to be marked unstable.  Except that a clock
    that is skewed by that much is probably destroying unsuspecting software
    right and left.  And given that there are now checks for false-positive
    skews due to delays between reading the two clocks, it should be possible
    to greatly decrease WATCHDOG_THRESHOLD, at least for fine-grained clocks
    such as TSC.
    
    Therefore, decrease WATCHDOG_THRESHOLD from the current 62.5 milliseconds
    down to 200 microseconds, but only for clocksource_tsc through use of
    a new max_drift field in struct clocksource.  Coarse-grained clocks
    such as refined-jiffies retain their old skew checks, courtesy of the
    default-zero initialization of the max_drift field.
    
    Suggested-by: Thomas Gleixner <tglx@linutronix.de>
    Cc: John Stultz <john.stultz@linaro.org>
    Cc: Stephen Boyd <sboyd@kernel.org>
    Cc: Jonathan Corbet <corbet@lwn.net>
    Cc: Mark Rutland <Mark.Rutland@arm.com>
    Cc: Marc Zyngier <maz@kernel.org>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
    Cc: Feng Tang <feng.tang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 56289170753c..c281575ed5c2 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1147,6 +1147,7 @@ static struct clocksource clocksource_tsc_early = {
 static struct clocksource clocksource_tsc = {
 	.name			= "tsc",
 	.rating			= 300,
+	.max_drift		= 200 * NSEC_PER_USEC,
 	.read			= read_tsc,
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 83a3ebff7456..44b567fbf435 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -42,6 +42,8 @@ struct module;
  * @shift:		Cycle to nanosecond divisor (power of two)
  * @max_idle_ns:	Maximum idle time permitted by the clocksource (nsecs)
  * @maxadj:		Maximum adjustment value to mult (~11%)
+ * @max_drift:		Maximum drift rate in nanoseconds per half second.
+ *			Zero says to use default WATCHDOG_THRESHOLD.
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
@@ -93,6 +95,7 @@ struct clocksource {
 	u32			shift;
 	u64			max_idle_ns;
 	u32			maxadj;
+	u32			max_drift;
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f71f375df544..e33955c322cf 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -377,6 +377,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	u32 md;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -423,7 +424,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 
 		/* Check the deviation from the watchdog clocksource. */
-		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
+		md = cs->max_drift ?: WATCHDOG_THRESHOLD;
+		if (abs(cs_nsec - wd_nsec) > md) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
