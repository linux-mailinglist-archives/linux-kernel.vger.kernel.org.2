Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447823C7189
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhGMN52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbhGMN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93606C0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:54:33 -0700 (PDT)
Message-Id: <20210713135158.691083465@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eoHYufcTHZOFvalCuCzUSOU4m5oXCDmtNn7Cnpi7lbk=;
        b=kYl/reQAJhjW4Ti7A11zGJBeYXjPveyekSqgW3gvxnsS+wWo/fyeIJTbieyDLaaz/I15sA
        EkHSXM+FolSomlVtbJA7lHMt/aMJP6QIFwYdW+v7cryZGoAJ/XETbG5nzdMV/IoYCzH2G5
        3Sf4z9T3qyqkZutF3J05Jhex3CTDnGvMuCQjRam6z6m26dq5/q8LTMDCElFOvk6KShaFhu
        LkRQwhNFWflQxjpUk/zkCZLcy5YK8zT2tlZ3/7FVC5edWxyDUB/z3QT6Tfo4neQcsMeS2j
        t53B0IV9iVdgshSQ8m9AWiL87ND18ytf/aTW/1f9XQGrmnOukXLWcyXck0zflQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=eoHYufcTHZOFvalCuCzUSOU4m5oXCDmtNn7Cnpi7lbk=;
        b=vsJFO+V0fuu1FyCt0cDIbBcvO1/scmEbDuaaE+ubUtcdYEbjXjwycoAeJdhQnWQ0bxpN6p
        O9XsMKC/zI7XfuDQ==
Date:   Tue, 13 Jul 2021 15:39:53 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 08/10] hrtimer: Add bases argument to clock_was_set()
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
@@ -880,7 +880,7 @@ static void hrtimer_reprogram(struct hrt
  * in the tick, which obviously might be stopped, so this has to bring out
  * the remote CPU which might sleep in idle to get this sorted.
  */
-void clock_was_set(void)
+void clock_was_set(unsigned int bases)
 {
 	if (!hrtimer_hres_active() && !tick_nohz_active)
 		goto out_timerfd;
@@ -894,7 +894,7 @@ void clock_was_set(void)
 
 static void clock_was_set_work(struct work_struct *work)
 {
-	clock_was_set();
+	clock_was_set(CLOCK_SET_WALL);
 }
 
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -166,7 +166,14 @@ DECLARE_PER_CPU(struct hrtimer_cpu_base,
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
@@ -1323,8 +1323,8 @@ int do_settimeofday64(const struct times
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
 
 	if (!ret)
 		audit_tk_injoffset(ts_delta);
@@ -1371,8 +1371,8 @@ error: /* even if we error out, we forwa
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL);
 
 	return ret;
 }
@@ -1746,8 +1746,8 @@ void timekeeping_inject_sleeptime64(cons
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	/* signal hrtimers about time change */
-	clock_was_set();
+	/* Signal hrtimers about time change */
+	clock_was_set(CLOCK_SET_WALL | CLOCK_SET_BOOT);
 }
 #endif
 
@@ -2440,7 +2440,7 @@ int do_adjtimex(struct __kernel_timex *t
 		clock_set |= timekeeping_advance(TK_ADV_FREQ);
 
 	if (clock_set)
-		clock_was_set();
+		clock_was_set(CLOCK_REALTIME);
 
 	ntp_notify_cmos_timer();
 

