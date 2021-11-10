Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB8F44CCED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 23:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhKJWfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 17:35:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234228AbhKJWfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 17:35:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C164061186;
        Wed, 10 Nov 2021 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636583570;
        bh=G0MThH4R6TuSSQPr3TCoAD4wpVTDfYfda3miM3C1GO8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CsYZHEBNRP3yiEexpkOutKM6yb5AvBMN9y+s9qXz6xqDn+IehEQe5YnxT158uRrMr
         eZhTdxDrYPJ+SK+KkrU/v1ykWOELYtmVGkSczboayjGnR6l7xTVa6GUWlmiPl6/V0I
         OvD3W+NDUBwPFeck2vgyEZgMQigikFvKMg3loYye+P4yYGl90jforlv3PM5tr3hoAX
         5I503rOpu1Yp199DX/Aq5gEtMRcynY5WCihE8ecr4EhWMPkkAQXKMiNuTkJaVmnpc+
         0FLbbE9VmYLAo2H6OFB4zK9lgYf/0ngSV90n4vDVxVs+cFUURh34t5pkqU5mfMssa+
         oA+0qJes8q78g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 90C6B5C119C; Wed, 10 Nov 2021 14:32:50 -0800 (PST)
Date:   Wed, 10 Nov 2021 14:32:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Message-ID: <20211110223250.GG641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20211110221732.272986-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110221732.272986-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
> It was found that when an x86 system was being stressed by running
> various different benchmark suites, the clocksource watchdog might
> occasionally mark TSC as unstable and fall back to hpet which will
> have a signficant impact on system performance.
> 
> The current watchdog clocksource skew threshold of 50us is found to be
> insufficient. So it is changed back to 100us before commit 2e27e793e280
> ("clocksource: Reduce clocksource-skew threshold") in patch 1. Patch 2
> adds a Kconfig option to allow kernel builder to control the actual
> threshold to be used.
> 
> Waiman Long (2):
>   clocksource: Avoid accidental unstable marking of clocksources
>   clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW

The ability to control the fine-grained threshold seems useful, but is
the TSC still marked unstable when this commit from -rcu is applied?
It has passed significant testing on other workloads.

2a43fb0479aa ("clocksource: Forgive repeated long-latency watchdog clocksource reads")

If the patch below takes care of your situation, my thought is to
also take your second patch, which would allow people to set the
cutoff more loosely or more tightly, as their situation dictates.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit 2a43fb0479aa53c6ff866aa26df2708de0c86b12
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
    heavy memory-contention workloads are being run on hardware that is not
    designed for this sort of use.
    
    Nevertheless, it is quite possible that real-world use will result in
    some situation requiring that high-stress workloads run on hardware
    not designed to accommodate them, and also requiring that the kernel
    refrain from marking clocksources unstable.
    
    Therefore, react to persistent long-latency reads by leaving the
    clocksource alone, but using the old 62.5-millisecond skew-detection
    threshold.  In addition, the offending clocksource is marked for
    re-initialization, which both restarts that clocksource with a clean bill
    of health and avoids false-positive skew reports on later watchdog checks.
    Once marked for re-initialization, the clocksource is not subjected to
    further watchdog checking until a subsequent successful read from that
    clocksource that is free of excessive delays.
    
    However, if clocksource.max_cswd_coarse_reads consecutive clocksource read
    attempts result in long latencies, a warning (splat) will be emitted.
    This kernel boot parameter defaults to 1000, and this warning can be
    disabled by setting it to zero or to a negative value.
    
    [ paulmck: Apply feedback from Chao Gao and Oliver Sang. ]
    
    Link: https://lore.kernel.org/lkml/20210513155515.GB23902@xsang-OptiPlex-9020/ # [1]
    Link: https://lore.kernel.org/lkml/20210521083322.GG25531@xsang-OptiPlex-9020/ # [2]
    Link: https://lore.kernel.org/lkml/20210521084405.GH25531@xsang-OptiPlex-9020/
    Link: https://lore.kernel.org/lkml/20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1/
    Tested-by: Chao Gao <chao.gao@intel.com>
    Tested-by: Jiri Wiesner <jwiesner@suse.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 316027c3aadce..61d2436ae9dfc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -600,6 +600,14 @@
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.max_cswd_coarse_reads= [KNL]
+			Number of consecutive clocksource_watchdog()
+			coarse reads (that is, clocksource reads that
+			were unduly delayed) that are permitted before
+			the kernel complains (gently).	Set to a value
+			less than or equal to zero to suppress these
+			complaints.
+
 	clocksource.max_cswd_read_retries= [KNL]
 			Number of clocksource_watchdog() retries due to
 			external delays before the clock will be marked
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 1d42d4b173271..3e925d9ffc31c 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -110,6 +110,7 @@ struct clocksource {
 	int			rating;
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
+	unsigned int		n_coarse_reads;
 	unsigned long		flags;
 
 	int			(*enable)(struct clocksource *cs);
@@ -291,6 +292,7 @@ static inline void timer_probe(void) {}
 #define TIMER_ACPI_DECLARE(name, table_id, fn)		\
 	ACPI_DECLARE_PROBE_ENTRY(timer, name, table_id, 0, NULL, 0, fn)
 
+extern int max_cswd_coarse_reads;
 extern ulong max_cswd_read_retries;
 void clocksource_verify_percpu(struct clocksource *cs);
 
diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index df922f49d171b..7e82500c400b9 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -145,13 +145,12 @@ static int wdtest_func(void *arg)
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
index b8a14d2fb5ba6..553b479c4e73e 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -199,6 +199,9 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
+int max_cswd_coarse_reads = 1000;
+module_param(max_cswd_coarse_reads, int, 0644);
+EXPORT_SYMBOL_GPL(max_cswd_coarse_reads);
 ulong max_cswd_read_retries = 3;
 module_param(max_cswd_read_retries, ulong, 0644);
 EXPORT_SYMBOL_GPL(max_cswd_read_retries);
@@ -226,13 +229,22 @@ static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-			return true;
+			cs->n_coarse_reads = 0;
+			return false;
 		}
+		WARN_ONCE(max_cswd_coarse_reads > 0 &&
+			  !(++cs->n_coarse_reads % max_cswd_coarse_reads),
+			  "timekeeping watchdog on CPU%d: %s %u consecutive coarse-grained reads\n", smp_processor_id(), watchdog->name, cs->n_coarse_reads);
 	}
 
-	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
-		smp_processor_id(), watchdog->name, wd_delay, nretries);
-	return false;
+	if ((cs->flags & CLOCK_SOURCE_WATCHDOG) && !atomic_read(&watchdog_reset_pending)) {
+		pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, coarse-grained skew check followed by re-initialization\n",
+			smp_processor_id(), watchdog->name, wd_delay, nretries);
+	} else {
+		pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, awaiting re-initialization\n",
+			smp_processor_id(), watchdog->name, wd_delay, nretries);
+	}
+	return true;
 }
 
 static u64 csnow_mid;
@@ -356,6 +368,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	bool coarse;
 	u32 md;
 
 	spin_lock(&watchdog_lock);
@@ -373,16 +386,13 @@ static void clocksource_watchdog(struct timer_list *unused)
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
 		    atomic_read(&watchdog_reset_pending)) {
-			cs->flags |= CLOCK_SOURCE_WATCHDOG;
+			if (!coarse)
+				cs->flags |= CLOCK_SOURCE_WATCHDOG;
 			cs->wd_last = wdnow;
 			cs->cs_last = csnow;
 			continue;
@@ -403,7 +413,13 @@ static void clocksource_watchdog(struct timer_list *unused)
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
