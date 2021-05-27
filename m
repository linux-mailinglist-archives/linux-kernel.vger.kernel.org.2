Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5333935DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhE0TDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236144AbhE0TDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:03:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AC9D613E6;
        Thu, 27 May 2021 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622142086;
        bh=f602isG4fDNYVv+9TyhwtBUyv6ygqeBAlXNmxLufhbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SWaDW422zED7y2KcpFAvXw2RLVCVfX0V/PER5qP7Nx20lbxbrpjnYM8dBlAnlDmQ4
         9XRvxEvlLhuBpoUzlz7eKHYqwFJytuAOZSFGi77Cvmhw+Xs45g1S8USQN3GeOSXH5w
         wPUll3ZGgmxy7I18OAUXQfq9q7RSEPuAP9SxeftGumzHLVAl+9PUnPOBLWxNUBYkU/
         jjD7mtUIfOymiYunxL7XV5ZK/YLAzzSsnGXzojXSO5qForG3zhpcOSYZ5r93TOazs3
         6uIlBDRAAEupXl0hhHXFWq4HM8uHvpOWrnaK9iSqEl+6MBy6JbvGqkOLtboYygmQRp
         5AZgU+Lwbcykw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0ED285C02A9; Thu, 27 May 2021 12:01:26 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v15 clocksource 1/6] clocksource: Retry clock read if long delays detected
Date:   Thu, 27 May 2021 12:01:19 -0700
Message-Id: <20210527190124.440372-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1>
References: <20210527190042.GA438700@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the clocksource watchdog marks a clock as unstable, this might
be due to that clock being unstable or it might be due to delays that
happen to occur between the reads of the two clocks.  Yes, interrupts are
disabled across those two reads, but there are no shortage of things that
can delay interrupts-disabled regions of code ranging from SMI handlers
to vCPU preemption.  It would be good to have some indication as to why
the clock was marked unstable.

Therefore, re-read the watchdog clock on either side of the read from
the clock under test.  If the watchdog clock shows an excessive time
delta between its pair of reads, the reads are retried.  The maximum
number of retries is specified by a new kernel boot parameter
clocksource.max_cswd_read_retries, which defaults to three, that
is, up to four reads, one initial and up to three retries.  If more
than one retry was required, a message is printed on the console (the
occasional single retry is expected behavior, especially in guest OSes).
If the maximum number of retries is exceeded, the clock under test will
be marked unstable.  However, the probability of this happening due
to various sorts of delays is quite small.  In addition, the reason
(clock-read delays) for the unstable marking will be apparent.

Link: https://lore.kernel.org/lkml/202104291438.PuHsxRkl-lkp@intel.com/
Link: https://lore.kernel.org/lkml/20210429140440.GT975577@paulmck-ThinkPad-P17-Gen-1
Link: https://lore.kernel.org/lkml/20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210420064934.GE31773@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
Acked-by: Feng Tang <feng.tang@intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Per-clocksource retries per Neeraj Upadhyay feedback. ]
[ paulmck: Don't reset injectfail per Neeraj Upadhyay feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 kernel/time/clocksource.c                     | 52 ++++++++++++++++---
 2 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbdedc46..995deccc28bc 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -581,6 +581,12 @@
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.max_cswd_read_retries= [KNL]
+			Number of clocksource_watchdog() retries due to
+			external delays before the clock will be marked
+			unstable.  Defaults to three retries, that is,
+			four attempts to read the clock under test.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 2cd902592fc1..ec9632b7e833 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -124,6 +124,13 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
 
+/*
+ * Maximum permissible delay between two readouts of the watchdog
+ * clocksource surrounding a read of the clocksource being validated.
+ * This delay could be due to SMIs, NMIs, or to VCPU preemptions.
+ */
+#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
+
 static void clocksource_watchdog_work(struct work_struct *work)
 {
 	/*
@@ -184,12 +191,44 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
+static ulong max_cswd_read_retries = 3;
+module_param(max_cswd_read_retries, ulong, 0644);
+
+static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+{
+	unsigned int nretries;
+	u64 wd_end, wd_delta;
+	int64_t wd_delay;
+
+	for (nretries = 0; nretries <= max_cswd_read_retries; nretries++) {
+		local_irq_disable();
+		*wdnow = watchdog->read(watchdog);
+		*csnow = cs->read(cs);
+		wd_end = watchdog->read(watchdog);
+		local_irq_enable();
+
+		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
+		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		if (wd_delay <= WATCHDOG_MAX_SKEW) {
+			if (nretries > 1 || nretries >= max_cswd_read_retries) {
+				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
+					smp_processor_id(), watchdog->name, nretries);
+			}
+			return true;
+		}
+	}
+
+	pr_warn("timekeeping watchdog on CPU%d: %s read-back delay of %lldns, attempt %d, marking unstable\n",
+		smp_processor_id(), watchdog->name, wd_delay, nretries);
+	return false;
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
-	struct clocksource *cs;
 	u64 csnow, wdnow, cslast, wdlast, delta;
-	int64_t wd_nsec, cs_nsec;
 	int next_cpu, reset_pending;
+	int64_t wd_nsec, cs_nsec;
+	struct clocksource *cs;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -206,10 +245,11 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		local_irq_disable();
-		csnow = cs->read(cs);
-		wdnow = watchdog->read(watchdog);
-		local_irq_enable();
+		if (!cs_watchdog_read(cs, &csnow, &wdnow)) {
+			/* Clock readout unreliable, so give it up. */
+			__clocksource_unstable(cs);
+			continue;
+		}
 
 		/* Clocksource initialized ? */
 		if (!(cs->flags & CLOCK_SOURCE_WATCHDOG) ||
-- 
2.31.1.189.g2e36527f23

