Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6757353157
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 00:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbhDBWtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 18:49:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235559AbhDBWtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 18:49:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 782016115C;
        Fri,  2 Apr 2021 22:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617403748;
        bh=k3BIxfi+L1YBlW8Mtw5C8sYz1WXfklRN1Yk9lexwAH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpBHljzxU5WMSn1Ecwb4yu/NsMwF2oSJMaDCrIpCLi29YfAy/Otb8WCpQ90tvfW4c
         A4Dm9G0PfRVDnSUbnHWOP/uOHqeI44mIW6Og0/9JD7KMIYcySnNWavs95Qbtp+KG66
         zi4zP/RRwf3b63X3QXVRcm6WwJrJmcy6IJSTkquNdihJ7Ti6qTAlcVgVpzdi1kNGw3
         MPw8NtDXPoP+EOFa0uSM63AuuP30qqB7FwnHzqfnbwNSYP9RnX6QiZ6lbQLO5ZlZUg
         y+rPHiXSgYStRTI+G1yPTT/Yb0p/lpKGpo1EozydGlPDqPo0Y+a/SAVQVzAMDJBbno
         Ng5GAW2mN8PqA==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, neeraju@codeaurora.org, ak@linux.intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v7 clocksource 1/5] clocksource: Provide module parameters to inject delays in watchdog
Date:   Fri,  2 Apr 2021 15:49:02 -0700
Message-Id: <20210402224906.3912-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210402224828.GA3683@paulmck-ThinkPad-P72>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72>
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
index 0454572..fc57952 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -583,6 +583,28 @@
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
index cce484a..4be4391 100644
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
+		pr_warn("%s(): Injecting delay.\n", __func__);
+		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC; i++)
+			udelay(1000);
+		pr_warn("%s(): Done injecting delay.\n", __func__);
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

