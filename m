Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21EB36C11A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhD0Iiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:38:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39562 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbhD0Iil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:41 -0400
Message-Id: <20210427083724.442224402@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=za9/LpdcR7YbczNQL1q4eFoq0olLXl6oLIbI/NgZucM=;
        b=eo3zRyjk5B8V1DenZ8SBH+rx1lpm9Oo1QK5zIet7ERyb8s9KbIp141wBE1JocbiKixuaoZ
        +hKCLOJrcl7tItCV0ICv9JFWenwDkQJthnQnF1VPnQounFstVGHASxWSmXh1JquiyxWM/Z
        lCygh9gRwqEFfeI/3k3J7PeVsW3/r+Mjc9Uwrhu64iMvTt5fzM9MPNtZFdhpLolbXFRUNX
        BRf0XKSn8JNJOtgB6+gaz7749cLXbtLYPTK7nwhgbXIM8Vw/r4T1Hp6bVcaK+GpXEWtmbz
        WWDPKY2v2XQHoIIsHrD99Dfv/zEv4AXvD4/vMvhqhQDG7Ke82ReYtjjhZGWt7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=za9/LpdcR7YbczNQL1q4eFoq0olLXl6oLIbI/NgZucM=;
        b=brsdFASCE5TiZLAc7vQHtmjOD5vC1UT9/lNPPZZpKu/Z056YHd0gtlLkGhtdeeXnEdpE6B
        p00jCRntlANPGpAA==
Date:   Tue, 27 Apr 2021 10:25:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [patch 4/8] timekeeping: Distangle resume and clock-was-set events
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resuming timekeeping is a clock-was-set event and uses the clock-was-set
notification mechanism. This is in the way of making the clock-was-set
update for hrtimers selective so unnecessary IPIs are avoided when a CPU
base does not have timers queued which are affected by the clock setting.

Distangle it by invoking hrtimer_resume() on each unfreezing CPU and invoke
the new timerfd_resume() function from timekeeping_resume() which is the
only place where this is needed.

Rename hrtimer_resume() to hrtimer_resume_local() to reflect the change.

With this the clock_was_set*() functions are not longer required to IPI all
CPUs unconditionally and can get some smarts to avoid them.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/hrtimer.h     |    1 -
 kernel/time/hrtimer.c       |   15 ++++++---------
 kernel/time/tick-common.c   |    7 +++++++
 kernel/time/tick-internal.h |    2 ++
 kernel/time/timekeeping.c   |    4 +++-
 5 files changed, 18 insertions(+), 11 deletions(-)

--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -354,7 +354,6 @@ extern void timerfd_resume(void);
 static inline void timerfd_clock_was_set(void) { }
 static inline void timerfd_resume(void) { }
 #endif
-extern void hrtimers_resume(void);
 
 DECLARE_PER_CPU(struct tick_device, tick_cpu_device);
 
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -914,8 +914,8 @@ static void clock_was_set_work(struct wo
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
 
 /*
- * Called from timekeeping and resume code to reprogram the hrtimer
- * interrupt device on all cpus and to notify timerfd.
+ * Called from timekeeping code to reprogram the hrtimer interrupt device
+ * on all cpus and to notify timerfd.
  */
 void clock_was_set_delayed(void)
 {
@@ -923,18 +923,15 @@ void clock_was_set_delayed(void)
 }
 
 /*
- * During resume we might have to reprogram the high resolution timer
- * interrupt on all online CPUs.  However, all other CPUs will be
- * stopped with IRQs interrupts disabled so the clock_was_set() call
- * must be deferred.
+ * Called during resume either directly from via timekeeping_resume()
+ * or in the case of s2idle from tick_unfreeze() to ensure that the
+ * hrtimers are up to date.
  */
-void hrtimers_resume(void)
+void hrtimers_resume_local(void)
 {
 	lockdep_assert_irqs_disabled();
 	/* Retrigger on the local CPU */
 	retrigger_next_event(NULL);
-	/* And schedule a retrigger for all others */
-	clock_was_set_delayed();
 }
 
 /*
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -475,6 +475,13 @@ void tick_resume_local(void)
 		else
 			tick_resume_oneshot();
 	}
+
+	/*
+	 * Ensure that hrtimers are up to date and the clockevents device
+	 * is reprogrammed correctly when high resolution timers are
+	 * enabled.
+	 */
+	hrtimers_resume_local();
 }
 
 /**
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -167,3 +167,5 @@ void timer_clear_idle(void);
 
 void clock_was_set(void);
 void clock_was_set_delayed(void);
+
+void hrtimers_resume_local(void);
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1799,8 +1799,10 @@ void timekeeping_resume(void)
 
 	touch_softlockup_watchdog();
 
+	/* Resume the clockevent device(s) and hrtimers */
 	tick_resume();
-	hrtimers_resume();
+	/* Notify timerfd as resume is equivalent to clock_was_set() */
+	timerfd_resume();
 }
 
 int timekeeping_suspend(void)

