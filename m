Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07F530C707
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 18:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhBBRIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 12:08:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237068AbhBBRHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 12:07:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8440364F87;
        Tue,  2 Feb 2021 17:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612285597;
        bh=KaMUmGr3azy9DQAkMwwvhM4y3A5x0Q/1YvPOK6DGS8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujjCoO72ZgSBEjxXf9+5IlNBltlwixK7JLzgxx+MRWrSTBIQfVT1ircLJ3XTjX/Oe
         KmN20CTpEWkQ5xCC1DQqVBWSUYy+jPhlY6O7GdwPEoRb97FrQ1XxvncuTU3uyZ/P/J
         S63dWQsbrVZCpl44MzLfLX9n14fnzNYbSgIuqG3ng/5LgcV7Kp7P2XQXIeUopB0vuk
         wk0og2uSuPCJLCvUD+kpr+Whd8dM1UCBzwgwHaJDD2kwROXVxq9GrTNInyvjhKTXy0
         InhpO2UyHBKWb9IouUlwomVcLP0zH/3XXdFhDRqRgdepmYGkhI69oyiCrT1BaeMN95
         pAk+z/kBlW5VA==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, ak@linux.intel.com, clm@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH clocksource 1/5] clocksource: Provide module parameters to inject delays in watchdog
Date:   Tue,  2 Feb 2021 09:06:31 -0800
Message-Id: <20210202170635.24839-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210202170437.GA23593@paulmck-ThinkPad-P72>
References: <20210202170437.GA23593@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

When the clocksource watchdog marks a clock as unstable, this might be due
to that clock being unstable or it might be due to delays that happen to
occur between the reads of the two clocks.  Yes, interrupts are disabled
across those two reads, but there are no shortage of things that can
delay interrupts-disabled regions of code ranging from SMI handlers to
vCPU preemption.  It would be good to have some indication as to why
the clock was marked unstable.

The first step is a way of injecting such delays, and this
commit therefore provides a clocksource.inject_delay_freq and
clocksource.inject_delay_run kernel boot parameters that specify that
sufficient delay be injected to cause the clocksource_watchdog()
function to mark a clock unstable.  This delay is injected every
Nth set of M calls to clocksource_watchdog(), where N is the value
specified for the inject_delay_freq boot parameter and M is the value
specified for the inject_delay_run boot parameter.  Values of zero or
less for either parameter disable delay injection, and the default for
clocksource.inject_delay_freq is zero, that is, disabled.  The default for
clocksource.inject_delay_run is the value one, that is single-call runs.

This facility is intended for diagnostic use only, and should be avoided
on production systems.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
[ paulmck: Apply Rik van Riel feedback. ]
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 22 ++++++++++++++++++++
 kernel/time/clocksource.c                       | 27 +++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a10b545..9965266 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -577,6 +577,28 @@
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.inject_delay_freq= [KNL]
+			Number of runs of calls to clocksource_watchdog()
+			before delays are injected between reads from the
+			two clocksources.  Values less than or equal to
+			zero disable this delay injection.  These delays
+			can cause clocks to be marked unstable, so use
+			of this parameter should therefore be avoided on
+			production systems.  Defaults to zero (disabled).
+
+	clocksource.inject_delay_run= [KNL]
+			Run lengths of clocksource_watchdog() delay
+			injections.  Specifying the value 8 will result
+			in eight consecutive delays followed by eight
+			times the value specified for inject_delay_freq
+			of consecutive non-delays.
+
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
index cce484a..545889c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
@@ -184,6 +185,31 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
+static int inject_delay_freq;
+module_param(inject_delay_freq, int, 0644);
+static int inject_delay_run = 1;
+module_param(inject_delay_run, int, 0644);
+static int max_read_retries = 3;
+module_param(max_read_retries, int, 0644);
+
+static void clocksource_watchdog_inject_delay(void)
+{
+	int i;
+	static int injectfail = -1;
+
+	if (inject_delay_freq <= 0 || inject_delay_run <= 0)
+		return;
+	if (injectfail < 0 || injectfail > INT_MAX / 2)
+		injectfail = inject_delay_run;
+	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {
+		printk("%s(): Injecting delay.\n", __func__);
+		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC; i++)
+			udelay(1000);
+		printk("%s(): Done injecting delay.\n", __func__);
+	}
+	WARN_ON_ONCE(injectfail < 0);
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
@@ -208,6 +234,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		local_irq_disable();
 		csnow = cs->read(cs);
+		clocksource_watchdog_inject_delay();
 		wdnow = watchdog->read(watchdog);
 		local_irq_enable();
 
-- 
2.9.5

