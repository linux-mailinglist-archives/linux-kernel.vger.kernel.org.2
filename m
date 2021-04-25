Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D70436A9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 00:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhDYWsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 18:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231438AbhDYWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 18:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FAB8613B4;
        Sun, 25 Apr 2021 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619390831;
        bh=Nk84Dr2G6Tav0iGfg2m7YP1K8V/S4l5NFhDLH5nBaJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jr46kTm6T5FEd7G7dG1KJHlEOflJsF220o8ym3cs8lXbJhQeWojVyTYDMZ/xb19yJ
         pZbGQUCuzW1Db7HPktl1S+A9NnbENz7RTG8crF4lM7KfZyJMQoSLWfrpjTyhgbFdwi
         jlqWxTyqitx7PNvjYTjJQx8OkkAoISrWTHzTh9yJ0cyI5gJqoGNMxRLgl9ACO0sVQD
         iLCHU+s12LzkSD2qaJxacnKRDB7eyKOSboJ2lr8LyfMVTGl99LtQBkn3ryrTENYm/j
         UUBPLZn9gjpJTOYambYhu4pI59qpvX6jMtW8vk7Vb9EwODgazRUOfvxb0uv3LqnQMt
         8ashNkqC7aMKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D97845C0267; Sun, 25 Apr 2021 15:47:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: [PATCH v10 clocksource 6/7] clocksource: Forgive tsc_early pre-calibration drift
Date:   Sun, 25 Apr 2021 15:47:07 -0700
Message-Id: <20210425224709.1312655-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the x86 tsc_early clocksource is given a quick and semi-accurate
calibration (by design!), it might have drift rates well in excess of
the 0.1% limit that is in the process of being adopted.

Therefore, add a max_drift field to the clocksource structure that, when
non-zero, specifies the maximum allowable drift rate in nanoseconds over
a half-second period.  The tsc_early clocksource initializes this to five
miliseconds, which corresponds to the 1% drift rate limit suggested by
Xing Zhengjun.  This max_drift field is intended only for early boot,
so clocksource_watchdog() splats if it encounters a non-zero value in
this field more than 60 seconds after boot, inspired by a suggestion by
Thomas Gleixner.

This was tested by setting the clocksource_tsc ->max_drift field to 1,
which, as expected, resulted in a clock-skew event.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
 include/linux/clocksource.h |  5 +++++
 kernel/time/clocksource.c   | 19 ++++++++++++++++++-
 3 files changed, 24 insertions(+), 1 deletion(-)

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
index 83a3ebff7456..07d25a158d7a 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -42,6 +42,10 @@ struct module;
  * @shift:		Cycle to nanosecond divisor (power of two)
  * @max_idle_ns:	Maximum idle time permitted by the clocksource (nsecs)
  * @maxadj:		Maximum adjustment value to mult (~11%)
+ * @max_drift:		Maximum drift rate in nanoseconds per half second.
+ *			Zero says to use default WATCHDOG_THRESHOLD.
+ *			A non-zero value for ->max_drift more than 60 seconds after boot
+ *			will result in a splat.
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
@@ -93,6 +97,7 @@ struct clocksource {
 	u32			shift;
 	u64			max_idle_ns;
 	u32			maxadj;
+	u32			max_drift;
 #ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
 	struct arch_clocksource_data archdata;
 #endif
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f71f375df544..070b09dab815 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -126,6 +126,7 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
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
@@ -423,7 +425,22 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 
 		/* Check the deviation from the watchdog clocksource. */
-		if (abs(cs_nsec - wd_nsec) > WATCHDOG_THRESHOLD) {
+		if (!cs->max_drift) {
+			md = WATCHDOG_THRESHOLD;
+		} else {
+			static unsigned long first_jiffies;
+			static bool beenhere;
+
+			if (beenhere) {
+				WARN_ON_ONCE(time_after(jiffies,
+							first_jiffies + WATCHDOG_SYNC_FORGIVENESS));
+			} else {
+				beenhere = true;
+				first_jiffies = jiffies;
+			}
+			md = cs->max_drift;
+		}
+		if (abs(cs_nsec - wd_nsec) > md) {
 			pr_warn("timekeeping watchdog on CPU%d: Marking clocksource '%s' as unstable because the skew is too large:\n",
 				smp_processor_id(), cs->name);
 			pr_warn("                      '%s' wd_now: %llx wd_last: %llx mask: %llx\n",
-- 
2.31.1.189.g2e36527f23

