Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA5C36A9BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 00:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhDYWr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 18:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhDYWrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 18:47:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 193B5611CE;
        Sun, 25 Apr 2021 22:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619390831;
        bh=V3tyvBo3AegaX85JGcVdvkTvstaYYptjFpPQqi8dNl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXus277tEf8Ka9j0tumtUym4/dhTLWbRuWK+f446phVQCPKbcl+11l4Vc6C4LpUVV
         oV246YbLes3a/9IoE6lXT07DhJcgSS3xQH/p7xRswecWV5y5hUzvHVmd9k7x3NA9wz
         jetkcYp8H2+NQApdi/v4uy7zrV9fcXCsOL83mNQ15XE4jcz08rVOKu4vErHq0OlrFs
         dmYGCzuw2GyRFbvdD0bh9hWhcxCWbipaLuE2DkFqof23JC838XDBvt9DQsvHgnxXN2
         /QYNvE+Asoz1FWmX3sc1IzMLH/Szd0EbKufaekwt5M/xXaUblqhJ+olSJRZ9pd7f7r
         i7OAx+i1GRvkQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CEDFB5C00EB; Sun, 25 Apr 2021 15:47:10 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v10 clocksource 1/7] clocksource: Provide module parameters to inject delays in watchdog
Date:   Sun, 25 Apr 2021 15:47:02 -0700
Message-Id: <20210425224709.1312655-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the clocksource watchdog marks a clock as unstable, this might be due
to that clock being unstable or it might be due to delays that happen to
occur between the reads of the two clocks.  Yes, interrupts are disabled
across those two reads, but there are no shortage of things that can
delay interrupts-disabled regions of code ranging from SMI handlers to
vCPU preemption.  It would be good to have some indication as to why
the clock was marked unstable.

The first step is a way of injecting such delays.  Therefore, provide
clocksource.inject_delay_freq and clocksource.inject_delay_run kernel boot
parameters that specify that sufficient delay be injected to cause the
clocksource_watchdog() function to mark a clock unstable.  This delay is
injected every Nth set of M calls to clocksource_watchdog(), where N is
the value specified for the inject_delay_freq boot parameter and M is the
value specified for the inject_delay_run boot parameter.  Values of zero
or less for either parameter disable delay injection, and the default for
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
[ paulmck: Apply Thomas Gleixner feedback. ]
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 16 +++++++++++++
 kernel/time/clocksource.c                     | 23 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..4a372037b49f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -583,6 +583,22 @@
 			loops can be debugged more effectively on production
 			systems.
 
+	clocksource.inject_delay_period= [KNL]
+			Number of calls to clocksource_watchdog() before
+			delays are injected between reads from the
+			two clocksources.  Values of zero disable this
+			delay injection.  These delays can cause clocks
+			to be marked unstable, so use of this parameter
+			should therefore be avoided on production systems.
+			Defaults to zero (disabled).
+
+	clocksource.inject_delay_repeat= [KNL]
+			Number of repeated clocksource_watchdog() delay
+			injections per period.	If inject_delay_period
+			is five and inject_delay_repeat is three, there
+			will be five delay-free reads followed by three
+			delayed reads.
+
 	clearcpuid=BITNUM[,BITNUM...] [X86]
 			Disable CPUID feature X for the kernel. See
 			arch/x86/include/asm/cpufeatures.h for the valid bit
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index cce484a2cc7c..f1e1e6e4b387 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h> /* for spin_unlock_irq() using preempt_count() m68k */
 #include <linux/tick.h>
 #include <linux/kthread.h>
+#include <linux/delay.h>
 
 #include "tick-internal.h"
 #include "timekeeping_internal.h"
@@ -184,6 +185,27 @@ void clocksource_mark_unstable(struct clocksource *cs)
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
+static ulong inject_delay_period;
+module_param(inject_delay_period, ulong, 0644);
+static ulong inject_delay_repeat = 1;
+module_param(inject_delay_repeat, ulong, 0644);
+
+static void clocksource_watchdog_inject_delay(void)
+{
+	static unsigned int invocations = 1, injections;
+
+	if (!inject_delay_period || !inject_delay_repeat)
+		return;
+	if (!(invocations % inject_delay_period)) {
+		pr_warn("%s(): Injecting delay.\n", __func__);
+		mdelay(2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC);
+		if (++injections < inject_delay_repeat)
+			return;
+		injections = 0;
+	}
+	invocations++;
+}
+
 static void clocksource_watchdog(struct timer_list *unused)
 {
 	struct clocksource *cs;
@@ -208,6 +230,7 @@ static void clocksource_watchdog(struct timer_list *unused)
 
 		local_irq_disable();
 		csnow = cs->read(cs);
+		clocksource_watchdog_inject_delay();
 		wdnow = watchdog->read(watchdog);
 		local_irq_enable();
 
-- 
2.31.1.189.g2e36527f23

