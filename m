Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8A36E2FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 03:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbhD2Bbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 21:31:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232992AbhD2BbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 21:31:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4847161445;
        Thu, 29 Apr 2021 01:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619659838;
        bh=/gf8dzBTEnJGSXC08IG3vONwR7WbWLaP/iX0tI3JGQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTCl5ccbNlD5arrh1IrI4vcGMFNyQppDSsSAL7KQoGZnlHIrdmhlCaIfO2wv8VU4x
         +DYadlhT6OzjThtk0Sgnd6FNejqp2WxP+HQNyyVEo7RFedwkNxajQ9fHf7h74C9S3Y
         nc3/NmTKWlaccDmJ4BT00UPutdmpOOgpyQzjtNsn9awxUxX88mwXBSBexkCZ5lJcld
         CLcW5MunJ6rtDyx7jYym3HOE93n5qhVvgrDWXP2HzQdcyw7Zyo40/+uRaBpefmNvGz
         tL9ygCm57moLBxziH+1FzxgsSD5ZJRFzNtudNhHVOKbcaRMAmua8gQ4pl+3dqNcVR0
         0vnf1ZMQQc+Ug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1268A5C0530; Wed, 28 Apr 2021 18:30:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>
Subject: [PATCH v11 clocksource 1/6] clocksource: Provide module parameters to inject delays in watchdog
Date:   Wed, 28 Apr 2021 18:30:32 -0700
Message-Id: <20210429013037.3958717-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
References: <20210429012909.GA3958584@paulmck-ThinkPad-P17-Gen-1>
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
Cc: Feng Tang <feng.tang@intel.com>
Cc: Xing Zhengjun <zhengjun.xing@linux.intel.com>
[ paulmck: Apply Rik van Riel feedback. ]
[ paulmck: Apply Thomas Gleixner feedback. ]
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 21 +++++++++++++++++
 kernel/time/clocksource.c                     | 23 +++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 04545725f187..b68cb54bc872 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -583,6 +583,27 @@
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
+			delayed reads.	Set to 1 to test isolated delays
+			being silently ignored and recovered from,
+			to between 2 and clocksource.max_read_retries
+			to test grouped delays being ignored, recovered
+			from, and complained about, and to larger values
+			to force the clock to be marked unstable.
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

