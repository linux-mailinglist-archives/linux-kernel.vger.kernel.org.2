Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC5A36C11B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhD0IjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:39:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39588 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhD0Iio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:44 -0400
Message-Id: <20210427083724.637378509@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tQTgltj9Y5rN8zCs/ZTYEajzd/sZ+4+33frM4mAoVbY=;
        b=ERGdw73e8eTAnJrMVTZ/biEUw5WX8e9vUfz540o5fAyNXlnQ663Dhi5XR7lOzl5CYJ1U+8
        9qbo6dz0+JUbPX1/A6b3PouPVV+Gx/Bzg0tKGuAMJfeajb2GHnD+n/jl22rEVPl6m4Xl6+
        8IrGQT4fm5gR23zBRAUJqEdJvggUIwah1OM98XOYusrq8NnVtmQg0hWBxQYJBnJkLggyP7
        EqVojZaUN32tSKDrlmQFLf4NMn0LPcyZDMa/vQ0i0My0RewjwfGo5FJ23UC4+MQQ5rRw7G
        o6QeM8I4xxbsZ0WfJifj4nI7B8zMBK82T02XNMix8ZGa9F+j9qFiv++FdslMNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=tQTgltj9Y5rN8zCs/ZTYEajzd/sZ+4+33frM4mAoVbY=;
        b=wW5CGWROG0rA3MEVOdeaN+A0XaQbpUDueMS3eXKNcMH+mBAq9ovjBKVRDu3tKPEOJ4muG7
        jAtDYkOV6JjySyCQ==
Date:   Tue, 27 Apr 2021 10:25:43 +0200
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
Subject: [patch 6/8] hrtimer: Add bases argument to clock_was_set()
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clock_was_set() unconditionaly invokes retrigger_next_event() on all online
CPUs. This was necessary because that mechanism was also used for resume
from suspend to idle which is not longer the case.

The bases arguments allows the callers of clock_was_set() to hand in a mask
which tells clock_was_set() which of the hrtimer clock bases are affected
by the clock setting. This mask will be used in the next step to check
whether a CPU base has timers queued on a clock base affected by the event
and avoid the SMP function call if there are none.

Add a @bases argument, provide defines for the active bases masking and
fixup all callsites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c       |    4 ++--
 kernel/time/tick-internal.h |    9 ++++++++-
 kernel/time/timekeeping.c   |   14 +++++++-------
 3 files changed, 17 insertions(+), 10 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -894,7 +894,7 @@ static void hrtimer_reprogram(struct hrt
  * in the tick, which obviously might be stopped, so this has to bring out
  * the remote CPU which might sleep in idle to get this sorted.
  */
-void clock_was_set(void)
+void clock_was_set(unsigned int bases)
 {
 	if (!hrtimer_hres_active() && !tick_nohz_active)
 		goto out_timerfd;
@@ -908,7 +908,7 @@ void clock_was_set(void)
 
 static void clock_was_set_work(struct work_struct *work)
 {
-	clock_was_set();
+	clock_was_set(CLOCK_SET_WALL);
 }
 
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -165,7 +165,14 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base,
 extern u64 get_next_timer_interrupt(unsigned long basej, u64 basem);
 void timer_clear_idle(void);
 
-void clock_was_set(void);
+#define CLOCK_SET_WALL							\
+	(BIT(HRTIMER_BASE_REALTIME) | BIT(HRTIMER_BASE_REALTIME_SOFT) |	\
+	 BIT(HRTIMER_BASE_TAI) | BIT(HRTIMER_BASE_TAI_SOFT))
+
+#define CLOCK_SET_BOOT							\
+	(BIT(HRTIMER_BASE_BOOTTIME) | BIT(HRTIMER_BASE_BOOTTIME_SOFT))
+
+void clock_was_set(unsigned int bases);
 void clock_was_set_delayed(void);
 
 void hrtimers_resume_local(void);
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1322,8 +1322,8 @@ int do_settimeofday64(const struct times
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
 
 	if (!ret)
 		audit_tk_injoffset(ts_delta);
@@ -1370,8 +1370,8 @@ error: /* even if we error out, we forwa
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
 
 	return ret;
 }
@@ -1735,8 +1735,8 @@ void timekeeping_inject_sleeptime64(cons
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
 }
 #endif
 
@@ -2429,7 +2429,7 @@ int do_adjtimex(struct __kernel_timex *t
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set();
+		clock_was_set(CLOCK_REALTIME);
 
 	ntp_notify_cmos_timer();
 

