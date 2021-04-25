Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53C736A9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 00:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhDYWrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 18:47:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhDYWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 18:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1222460E08;
        Sun, 25 Apr 2021 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619390831;
        bh=mxbSJPc/7gA5UrkZDFA+JXMc2lgkyMdpLgMe/iDeIJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVxRdEqs2cyfV5+m9AVBIf+W/5PovCa/0uqclMXx43XtLNZ3Q/e27gWO2zPGsyM7u
         EscRE9egMAiw+9PI1wNfYrmvR1WA73kzIYEkLslMDeO9SjJt0XDXSp+7WKCBuA1/1F
         i7eyS6zkOFWrKbI3k7SPgS7PlGAQ08M4QV/nZSOQlnJs+S2OdA+mZds7hdNGTZ1Xtm
         oo0jvsxlfTBO0P1rkD7p+/pGocYaIK7GTl8NX/0b4iT72k7P+7SZWL+q4mGzb6+vht
         PAstL+/xjP5Yo+6umNjs6stUlh3PW2aMLzGeaARJNc6PTp+GU8nVb7SUBjeLPsttLd
         OsM+kqgvvd3cA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D123F5C010F; Sun, 25 Apr 2021 15:47:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v10 clocksource 2/7] clocksource: Retry clock read if long delays detected
Date:   Sun, 25 Apr 2021 15:47:03 -0700
Message-Id: <20210425224709.1312655-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
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

Therefore, re-read the watchdog clock on either side of the read
from the clock under test.  If the watchdog clock shows an excessive
time delta between its pair of reads, the reads are retried.  The
maximum number of retries is specified by a new kernel boot parameter
clocksource.max_read_retries, which defaults to three, that is, up to four
reads, one initial and up to three retries.  If more than one retry was
required, a message is printed on the console (the occasional single retry
is expected behavior, especially in guest OSes).  If the maximum number
of retries is exceeded, the clock under test will be marked unstable.
However, the probability of this happening due to various sorts of
delays is quite small.  In addition, the reason (clock-read delays)
for the unstable marking will be apparent.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Reported-by: Chris Mason <clm@fb.com>
[ paulmck: Per-clocksource retries per Neeraj Upadhyay feedback. ]
[ paulmck: Don't reset injectfail per Neeraj Upadhyay feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 kernel/time/clocksource.c                     | 53 ++++++++++++++++---
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4a372037b49f..7fff95bd5504 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -599,6 +599,12 @@
 			will be five delay-free reads followed by three
 			delayed reads.
 
+	clocksource.max_read_retries= [KNL]
+			Number of clocksource_watchdog() retries due to
+			external delays before the clock will be marked
+			unstable.  Defaults to three retries, that is,
+			four attempts to read the clock under test.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f1e1e6e4b387..94bfdb53f2f4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -125,6 +125,13 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating);
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
@@ -189,6 +196,8 @@ static ulong inject_delay_period;
 module_param(inject_delay_period, ulong, 0644);
 static ulong inject_delay_repeat = 1;
 module_param(inject_delay_repeat, ulong, 0644);
+static ulong max_read_retries = 3;
+module_param(max_read_retries, ulong, 0644);
 
 static void clocksource_watchdog_inject_delay(void)
 {
@@ -206,12 +215,42 @@ static void clocksource_watchdog_inject_delay(void)
 	invocations++;
 }
 
+static bool cs_watchdog_read(struct clocksource *cs, u64 *csnow, u64 *wdnow)
+{
+	unsigned int nretries;
+	u64 wd_end, wd_delta;
+	int64_t wd_delay;
+
+	for (nretries = 0; nretries <= max_read_retries; nretries++) {
+		local_irq_disable();
+		*wdnow = watchdog->read(watchdog);
+		clocksource_watchdog_inject_delay();
+		*csnow = cs->read(cs);
+		wd_end = watchdog->read(watchdog);
+		local_irq_enable();
+
+		wd_delta = clocksource_delta(wd_end, *wdnow, watchdog->mask);
+		wd_delay = clocksource_cyc2ns(wd_delta, watchdog->mult, watchdog->shift);
+		if (wd_delay <= WATCHDOG_MAX_SKEW) {
+			if (nretries > 1 || nretries >= max_read_retries) {
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
@@ -228,11 +267,11 @@ static void clocksource_watchdog(struct timer_list *unused)
 			continue;
 		}
 
-		local_irq_disable();
-		csnow = cs->read(cs);
-		clocksource_watchdog_inject_delay();
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

