Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5B3DD052
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 08:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhHBGM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 02:12:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:46078 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhHBGM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 02:12:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="200566005"
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="200566005"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 23:12:47 -0700
X-IronPort-AV: E=Sophos;i="5.84,288,1620716400"; 
   d="scan'208";a="509929037"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 23:12:43 -0700
Date:   Mon, 2 Aug 2021 14:20:09 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <20210802062008.GA24720@gao-cwp>
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>commit 48ebcfbfd877f5d9cddcc03c91352a8ca7b190af
>Author: Paul E. McKenney <paulmck@kernel.org>
>Date:   Thu May 27 11:03:28 2021 -0700
>
>    clocksource: Forgive repeated long-latency watchdog clocksource reads
>    
>    Currently, the clocksource watchdog reacts to repeated long-latency
>    clocksource reads by marking that clocksource unstable on the theory that
>    these long-latency reads are a sign of a serious problem.  And this theory
>    does in fact have real-world support in the form of firmware issues [1].
>    
>    However, it is also possible to trigger this using stress-ng on what
>    the stress-ng man page terms "poorly designed hardware" [2].  And it
>    is not necessarily a bad thing for the kernel to diagnose cases where
>    high-stress workloads are being run on hardware that is not designed
>    for this sort of use.
>    
>    Nevertheless, it is quite possible that real-world use will result in
>    some situation requiring that high-stress workloads run on hardware
>    not designed to accommodate them, and also requiring that the kernel
>    refrain from marking clocksources unstable.
>    
>    Therefore, provide an out-of-tree patch that reacts to this situation
>    by leaving the clocksource alone, but using the old 62.5-millisecond
>    skew-detection threshold in response persistent long-latency reads.
>    In addition, the offending clocksource is marked for re-initialization
>    in this case, which both restarts that clocksource with a clean bill of
>    health and avoids false-positive skew reports on later watchdog checks.

Hi Paul,

Sorry to dig out this old thread.

I am testing with this patch in a VM, but I find sometimes re-initialization
after coarse-grained skew check may not happen as expected because ...

>    
>    Link: https://lore.kernel.org/lkml/20210513155515.GB23902@xsang-OptiPlex-9020/ # [1]
>    Link: https://lore.kernel.org/lkml/20210521083322.GG25531@xsang-OptiPlex-9020/ # [2]
>    Link: https://lore.kernel.org/lkml/20210521084405.GH25531@xsang-OptiPlex-9020/
>    Link: https://lore.kernel.org/lkml/20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1/
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
>index 01df12395c0e..b72a969f7b93 100644
>--- a/kernel/time/clocksource-wdtest.c
>+++ b/kernel/time/clocksource-wdtest.c
>@@ -146,13 +146,12 @@ static int wdtest_func(void *arg)
> 		else if (i <= max_cswd_read_retries)
> 			s = ", expect message";
> 		else
>-			s = ", expect clock skew";
>+			s = ", expect coarse-grained clock skew check and re-initialization";
> 		pr_info("--- Watchdog with %dx error injection, %lu retries%s.\n", i, max_cswd_read_retries, s);
> 		WRITE_ONCE(wdtest_ktime_read_ndelays, i);
> 		schedule_timeout_uninterruptible(2 * HZ);
> 		WARN_ON_ONCE(READ_ONCE(wdtest_ktime_read_ndelays));
>-		WARN_ON_ONCE((i <= max_cswd_read_retries) !=
>-			     !(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE));
>+		WARN_ON_ONCE(clocksource_wdtest_ktime.flags & CLOCK_SOURCE_UNSTABLE);
> 		wdtest_ktime_clocksource_reset();
> 	}
> 
>diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
>index 4485635b69f5..6c0820779bd3 100644
>--- a/kernel/time/clocksource.c
>+++ b/kernel/time/clocksource.c
>@@ -225,13 +225,13 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
> 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
> 					smp_processor_id(), watchdog->name, nretries);
> 			}
>-			return true;
>+			return false;
> 		}
> 	}
> 
>-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
>+	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
> 		smp_processor_id(), watchdog->name, wd_delay, nretries);
>-	return false;
>+	return true;
> }
> 
> static u64 csnow_mid;
>@@ -355,6 +355,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> 	int next_cpu, reset_pending;
> 	int64_t wd_nsec, cs_nsec;
> 	struct clocksource *cs;
>+	bool coarse;
> 	u32 md;
> 
> 	spin_lock(&watchdog_lock);
>@@ -372,11 +373,7 @@ static void clocksource_watchdog(struct timer_list *unused)
> 			continue;
> 		}
> 
>-		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
>-			/* Clock readout unreliable, so give it up. */
>-			__clocksource_unstable(cs);
>-			continue;
>-		}
>+		coarse = cs_watchdog_read(cs, &csnow, &wdnow);
> 
> 		/* Clocksource initialized ? */
> 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
>@@ -402,7 +399,13 @@ static void clocksource_watchdog(struct timer_list *unused)
> 			continue;
> 
> 		/* Check the deviation from the watchdog clocksource. */
>-		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>+		if (coarse) {
>+			md = 62500 * NSEC_PER_USEC;
>+			cs->flags &= ~CLOCK_SOURCE_WATCHDOG;
>+			pr_warn("timekeeping watchdog on CPU%d: %s coarse-grained %lu.%03lu ms clock-skew check followed by re-initialization\n", smp_processor_id(), watchdog->name, md / NSEC_PER_MSEC, md % NSEC_PER_MSEC / NSEC_PER_USEC);

... this message on CPU5 doesn't show up in below kernel logs.
Do you think it is a bug? if yes, any idea to resolve it?

[  498.571086] clocksource: timekeeping watchdog on CPU1: hpet read-back delay of 432490ns, attempt 4, coarse-grained skew check followed by re-initialization
[  498.572867] clocksource: timekeeping watchdog on CPU1: hpet coarse-grained 62.500 ms clock-skew check followed by re-initialization
[  504.071959] clocksource: timekeeping watchdog on CPU4: hpet read-back delay of 1679880ns, attempt 4, coarse-grained skew check followed by re-initialization
[  504.073817] clocksource: timekeeping watchdog on CPU4: hpet coarse-grained 62.500 ms clock-skew check followed by re-initialization
[  504.568821] clocksource: timekeeping watchdog on CPU5: hpet read-back delay of 554880ns, attempt 4, coarse-grained skew check followed by re-initialization
[  505.067666] clocksource: timekeeping watchdog on CPU6: hpet retried 3 times before success
[  505.068593] clocksource: timekeeping watchdog on CPU6: Marking clocksource 'tsc' as unstable because the skew is too large:
[  505.069596] clocksource:                       'hpet' wd_nsec: 499376790 wd_now: be2f200d wd_last: bb3522fe mask: ffffffff
[  505.071131] clocksource:                       'tsc' cs_nsec: 498867307 cs_now: 103895c060a cs_last: 1034aea96ea mask: ffffffffffffffff
[  505.072994] clocksource:                       'tsc' is current clocksource.
[  505.074748] tsc: Marking TSC unstable due to clocksource watchdog

Thanks
-Chao

>+		} else {
>+			md = cs->uncertainty_margin + watchdog->uncertainty_margin;
>+		}
> 		if (abs(cs_nsec - wd_nsec) > md) {
> 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
> 				smp_processor_id(), cs->name);
