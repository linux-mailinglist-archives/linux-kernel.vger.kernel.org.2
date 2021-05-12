Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D0537B2A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhEKXgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:36:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229925AbhEKXgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:36:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1719F616E9;
        Tue, 11 May 2021 23:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620776098;
        bh=iMFABkrZ94E3V2i6d9nPHCOoW5cKkYdcqdM7ds8EZJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tugszo6KbplDOBLrmOTq0s9ar6+aUsUotETRZseasp6CYJDLjVmSXlBJ3Cxfff5Uv
         BqB/94EWBsYb+oywxb76l1m1rG6KJGYM8cq++2af051WN2ZbQIUoKV1wafskPULdeV
         CtjAD6XhQSoTnhng2athSbS/hM0xsex8JZpu77aYxstED27zTTV33Ecm4SlcvEisJZ
         7ze1aysDqzven9xXdyx1WfrGIWbF4aaRK5KFoBTZRbuI4jOTuT56lCS0abJq14Dl3i
         A8p/dG0EbqLdkMQkBFG1opC18JToVgpFR53Qj32LWb4sgvtxd715jOvHIZuiuiKmTF
         fOZhqQoKDafjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B27F65C0B55; Tue, 11 May 2021 16:34:57 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH v14 clocksource 4/6] clocksource: Reduce clocksource-skew threshold for TSC
Date:   Tue, 11 May 2021 16:34:53 -0700
Message-Id: <20210511233455.2897068-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
References: <20210511233403.GA2896757@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, WATCHDOG_THRESHOLD is set to detect a 62.5-millisecond skew in
a 500-millisecond WATCHDOG_INTERVAL.  This requires that clocks be skewed
by more than 12.5% in order to be marked unstable.  Except that a clock
that is skewed by that much is probably destroying unsuspecting software
right and left.  And given that there are now checks for false-positive
skews due to delays between reading the two clocks, it should be possible
to greatly decrease WATCHDOG_THRESHOLD, at least for fine-grained clocks
such as TSC.

Therefore, add a new uncertainty_margin field to the clocksource
structure that contains the maximum uncertainty in nanoseconds for
the corresponding clock.  This field may be initialized manually,
as it is for clocksource_tsc_early and clocksource_jiffies, which
is copied to refined_jiffies.  If the field is not initialized
manually, it will be computed at clock-registry time as the period
of the clock in question based on the scale and freq parameters to
__clocksource_update_freq_scale() function.  If either of those two
parameters are zero, the tens-of-milliseconds WATCHDOG_THRESHOLD is
used as a cowardly alternative to dividing by zero.  No matter how the
uncertainty_margin field is calculated, it is bounded below by twice
WATCHDOG_MAX_SKEW, that is, by 100 microseconds.

Note that manually initialized uncertainty_margin fields are not adjusted,
but there is a WARN_ON_ONCE() that triggers if any such field is less than
twice WATCHDOG_MAX_SKEW.  This WARN_ON_ONCE() is intended to discourage
production use of the one-nanosecond uncertainty_margin values that are
used to test the clock-skew code itself.

The actual clock-skew check uses the sum of the uncertainty_margin fields
of the two clocksource structures being compared.  Integer overflow is
avoided because the largest computed value of the uncertainty_margin
fields is one billion (10^9), and double that value fits into an
unsigned int.  However, if someone manually specifies (say) UINT_MAX,
they will get what they deserve.

Note that the refined_jiffies uncertainty_margin field is initialized to
TICK_NSEC, which means that skew checks involving this clocksource will
be sufficently forgiving.  In a similar vein, the clocksource_tsc_early
uncertainty_margin field is initialized to 32*NSEC_PER_MSEC, which
replicates the current behavior and allows custom setting if needed
in order to address the rare skews detected for this clocksource in
current mainline.

Link: https://lore.kernel.org/lkml/202104291438.PuHsxRkl-lkp@intel.com/
Link: https://lore.kernel.org/lkml/20210429140440.GT975577@paulmck-ThinkPad-P17-Gen-1
Link: https://lore.kernel.org/lkml/20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210420064934.GE31773@xsang-OptiPlex-9020/
Link: https://lore.kernel.org/lkml/20210106004013.GA11179@paulmck-ThinkPad-P72/
Link: https://lore.kernel.org/lkml/20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1/
Link: https://lore.kernel.org/lkml/20210419045155.GA596058@paulmck-ThinkPad-P17-Gen-1/
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
---
 arch/x86/kernel/tsc.c       |  1 +
 include/linux/clocksource.h |  3 +++
 kernel/time/clocksource.c   | 48 +++++++++++++++++++++++++++++--------
 kernel/time/jiffies.c       | 15 ++++++------
 4 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 6eb1b097e97e..2e076a459a0c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1128,6 +1128,7 @@ static int tsc_cs_enable(struct clocksource *cs)
 static struct clocksource clocksource_tsc_early = {
 	.name			= "tsc-early",
 	.rating			= 299,
+	.uncertainty_margin	= 32 * NSEC_PER_MSEC,
 	.read			= read_tsc,
 	.mask			= CLOCKSOURCE_MASK(64),
 	.flags			= CLOCK_SOURCE_IS_CONTINUOUS |
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7f83d51c0fd7..895203727cb5 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -43,6 +43,8 @@ struct module;
  * @shift:		Cycle to nanosecond divisor (power of two)
  * @max_idle_ns:	Maximum idle time permitted by the clocksource (nsecs)
  * @maxadj:		Maximum adjustment value to mult (~11%)
+ * @uncertainty_margin:	Maximum uncertainty in nanoseconds per half second.
+ *			Zero says to use default WATCHDOG_THRESHOLD.
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
@@ -98,6 +100,7 @@ struct clocksource {
 	u32			shift;
 	u64			max_idle_ns;
 	u32			maxadj;
+	u32			uncertainty_margin;
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 66243da2dadb..9ebf9931f3d6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -95,6 +95,20 @@ static char override_name[CS_NAME_LEN];
 static int finished_booting;
 static u64 suspend_start;
 
+/*
+ * Threshold: 0.0312s, when doubled: 0.0625s.
+ * Also a default for cs->uncertainty_margin when registering clocks.
+ */
+#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 5)
+
+/*
+ * Maximum permissible delay between two readouts of the watchdog
+ * clocksource surrounding a read of the clocksource being validated.
+ * This delay could be due to SMIs, NMIs, or to VCPU preemptions.  Used as
+ * a lower bound for cs->uncertainty_margin values when registering clocks.
+ */
+#define WATCHDOG_MAX_SKEW (50 * NSEC_PER_USEC)
+
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
 static void clocksource_select(void);
@@ -121,17 +135,9 @@ static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
 /*
- * Interval: 0.5sec Threshold: 0.0625s
+ * Interval: 0.5sec.
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
-#define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
-
-/*
- * Maximum permissible delay between two readouts of the watchdog
- * clocksource surrounding a read of the clocksource being validated.
- * This delay could be due to SMIs, NMIs, or to VCPU preemptions.
- */
-#define WATCHDOG_MAX_SKEW (100 * NSEC_PER_USEC)
 
 static void clocksource_watchdog_work(struct work_struct *work)
 {
@@ -347,6 +353,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 	int next_cpu, reset_pending;
 	int64_t wd_nsec, cs_nsec;
 	struct clocksource *cs;
+	u32 md;
 
 	spin_lock(&watchdog_lock);
 	if (!watchdog_running)
@@ -393,7 +400,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 
 		/* Check the deviation from the watchdog clocksource. */
-		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
+		md = cs->uncertainty_margin + watchdog->uncertainty_margin;
+		if (abs(cs_nsec - wd_nsec) > md) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
@@ -1046,6 +1054,26 @@ void __clocksource_update_freq_scale(struct clocksource *cs, u32 scale, u32 freq
 		clocks_calc_mult_shift(&cs->mult, &cs->shift, freq,
 				       NSEC_PER_SEC / scale, sec * scale);
 	}
+
+	/*
+	 * If the uncertainty margin is not specified, calculate it.
+	 * If both scale and freq are non-zero, calculate the clock
+	 * period, but bound below at 2*WATCHDOG_MAX_SKEW.  However,
+	 * if either of scale or freq is zero, be very conservative and
+	 * take the tens-of-milliseconds WATCHDOG_THRESHOLD value for the
+	 * uncertainty margin.  Allow stupidly small uncertainty margins
+	 * to be specified by the caller for testing purposes, but warn
+	 * to discourage production use of this capability.
+	 */
+	if (scale && freq && !cs->uncertainty_margin) {
+		cs->uncertainty_margin = NSEC_PER_SEC / (scale * freq);
+		if (cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW)
+			cs->uncertainty_margin = 2 * WATCHDOG_MAX_SKEW;
+	} else if (!cs->uncertainty_margin) {
+		cs->uncertainty_margin = WATCHDOG_THRESHOLD;
+	}
+	WARN_ON_ONCE(cs->uncertainty_margin < 2 * WATCHDOG_MAX_SKEW);
+
 	/*
 	 * Ensure clocksources that have large 'mult' values don't overflow
 	 * when adjusted.
diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index a492e4da69ba..b3f608c2b936 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -49,13 +49,14 @@ static u64 jiffies_read(struct clocksource *cs)
  * for "tick-less" systems.
  */
 static struct clocksource clocksource_jiffies = {
-	.name		= "jiffies",
-	.rating		= 1, /* lowest valid rating*/
-	.read		= jiffies_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.mult		= TICK_NSEC << JIFFIES_SHIFT, /* details above */
-	.shift		= JIFFIES_SHIFT,
-	.max_cycles	= 10,
+	.name			= "jiffies",
+	.rating			= 1, /* lowest valid rating*/
+	.uncertainty_margin	= TICK_NSEC,
+	.read			= jiffies_read,
+	.mask			= CLOCKSOURCE_MASK(32),
+	.mult			= TICK_NSEC << JIFFIES_SHIFT, /* details above */
+	.shift			= JIFFIES_SHIFT,
+	.max_cycles		= 10,
 };
 
 __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(jiffies_lock);
-- 
2.31.1.189.g2e36527f23

