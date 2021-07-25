Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D373D4CEA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 11:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhGYImy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 04:42:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33142 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhGYIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 04:42:48 -0400
Date:   Sun, 25 Jul 2021 09:22:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627204998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3tBu7WAlLxC7zSkxwyPqscZ+uS43B0p5mjBAy2WNbys=;
        b=N4acZc9p7UiwWbb1RrpyurX7VgfoiKEy+cZaObDviT/hmHx14Pko6kIGcishSEtmd4lJDO
        DQUZXPLZMCV+MG1wKBwD0UP4Zg8xvqTxFRRae5k5RGajNOU5NVOyjY8wQLRSLpkRAtHRSJ
        GGb3dXNqXh5YWUBH+DR10P9FTdjDEHwKDv0tbrj/cSZlhUhus6LFPQ7F5gzvszQ5w3jfie
        PtU3AwazknTfHd8cTmScuvG+fx8komJlri1Cy9tuiuUcuU5qke6bNk4KymO9dWmBe2c4Ei
        5HVLKVt83UR21Cd2ig5PIZtqSxcZtb2oW3ZPXtLwJnYHVWRiJDwAmTU2Rt/vvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627204998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=3tBu7WAlLxC7zSkxwyPqscZ+uS43B0p5mjBAy2WNbys=;
        b=7J2TCifgzMtMW8SEJHJZcFQg7NwvYpfVsotdoaZPwp3gTBWfbS/6XPGYMNXeMCgtl4T1wc
        naH9Td1uLszkFvBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v5.14-rc3
References: <162720492071.8837.4047241618315201209.tglx@nanos>
Message-ID: <162720492432.8837.5867218068133681789.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-07-25

up to:  ff5a6a3550ce: Merge branch 'timers/urgent' of git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks into timers/urgent


A samll set of timer related fixes:

 - Plug a race between rearm and process tick in the posix CPU timers code

 - Make the optimization to avoid recalculation of the next timer interrupt
   work correctly when there are no timers pending.


Thanks,

	tglx

------------------>
Frederic Weisbecker (1):
      posix-cpu-timers: Fix rearm racing against process tick

Nicolas Saenz Julienne (1):
      timers: Fix get_next_timer_interrupt() with no timers pending


 kernel/time/posix-cpu-timers.c | 10 +++++-----
 kernel/time/timer.c            |  8 +++++---
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 29a5e54e6e10..517be7fd175e 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -991,6 +991,11 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	if (!p)
 		goto out;
 
+	/* Protect timer list r/w in arm_timer() */
+	sighand = lock_task_sighand(p, &flags);
+	if (unlikely(sighand == NULL))
+		goto out;
+
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
@@ -1001,11 +1006,6 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 
 	bump_cpu_timer(timer, now);
 
-	/* Protect timer list r/w in arm_timer() */
-	sighand = lock_task_sighand(p, &flags);
-	if (unlikely(sighand == NULL))
-		goto out;
-
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 3fadb58fc9d7..9eb11c2209e5 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -207,6 +207,7 @@ struct timer_base {
 	unsigned int		cpu;
 	bool			next_expiry_recalc;
 	bool			is_idle;
+	bool			timers_pending;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 } ____cacheline_aligned;
@@ -595,6 +596,7 @@ static void enqueue_timer(struct timer_base *base, struct timer_list *timer,
 		 * can reevaluate the wheel:
 		 */
 		base->next_expiry = bucket_expiry;
+		base->timers_pending = true;
 		base->next_expiry_recalc = false;
 		trigger_dyntick_cpu(base, timer);
 	}
@@ -1582,6 +1584,7 @@ static unsigned long __next_timer_interrupt(struct timer_base *base)
 	}
 
 	base->next_expiry_recalc = false;
+	base->timers_pending = !(next == base->clk + NEXT_TIMER_MAX_DELTA);
 
 	return next;
 }
@@ -1633,7 +1636,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 	u64 expires = KTIME_MAX;
 	unsigned long nextevt;
-	bool is_max_delta;
 
 	/*
 	 * Pretend that there is no timer pending if the cpu is offline.
@@ -1646,7 +1648,6 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 	if (base->next_expiry_recalc)
 		base->next_expiry = __next_timer_interrupt(base);
 	nextevt = base->next_expiry;
-	is_max_delta = (nextevt == base->clk + NEXT_TIMER_MAX_DELTA);
 
 	/*
 	 * We have a fresh next event. Check whether we can forward the
@@ -1664,7 +1665,7 @@ u64 get_next_timer_interrupt(unsigned long basej, u64 basem)
 		expires = basem;
 		base->is_idle = false;
 	} else {
-		if (!is_max_delta)
+		if (base->timers_pending)
 			expires = basem + (u64)(nextevt - basej) * TICK_NSEC;
 		/*
 		 * If we expect to sleep more than a tick, mark the base idle.
@@ -1947,6 +1948,7 @@ int timers_prepare_cpu(unsigned int cpu)
 		base = per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk = jiffies;
 		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
+		base->timers_pending = false;
 		base->is_idle = false;
 	}
 	return 0;

