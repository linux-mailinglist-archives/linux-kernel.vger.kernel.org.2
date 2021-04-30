Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96DF36F631
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbhD3HNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:13:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhD3HNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:13:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619766735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IrXy/HXeHVQq2gwOsAyIXri8trNqU3yD0eyvkZ6A8uU=;
        b=v/YWcvj/xCNHpp8TslwR24tvt5Nmv0KHceo8RHmEEnYanaMPksweZziTT3kTukYAtX8/vC
        MEpxOwtzeLfa8JuufZuPeMRKeACpDiNKL8n7YDxfvYLbfEj4tUS5etFfN4KRsdthp8dOgS
        pH0LK40UVcj1J5sH31a/792V+JNxHRw3QzXRG0/TwwWkyFBDdKcqBmx/8hM8vpHW+WPCrX
        LxNhp/cp+9bVapgURxBQwFjvDOVDW1/evuhw0gT4KLSGZ/xWlU76K849tmUSB2fLHRgsYJ
        RB5O6kPDKs8zFCAubu/2ZLgNVYhtCDuLz0na4Q9wX8dTBHFR3QNsTd59YiBFkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619766735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IrXy/HXeHVQq2gwOsAyIXri8trNqU3yD0eyvkZ6A8uU=;
        b=qM6YkwXFsZLIO7PyaT81HfSNgHV2NR4wkyne7HDp+LXMM5IsVX7EFoJ0Dy+6ophu2l+4Z9
        b3Omaf2/MQk2spBg==
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: [patch V2 8/8] hrtimer: Avoid more SMP function calls in clock_was_set()
In-Reply-To: <877dkno5w0.ffs@nanos.tec.linutronix.de>
References: <20210427082537.611978720@linutronix.de> <20210427083724.840364566@linutronix.de> <20210427151125.GA171315@fuller.cnet> <877dkno5w0.ffs@nanos.tec.linutronix.de>
Date:   Fri, 30 Apr 2021 09:12:15 +0200
Message-ID: <87a6pgfdps.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By unconditionally updating the offsets there are more indicators
whether the SMP function calls on clock_was_set() can be avoided:

  - When the offset update already happened on the remote CPU then the
    remote update attempt will yield the same seqeuence number and no
    IPI is required.

  - When the remote CPU is currently handling hrtimer_interrupt(). In
    that case the remote CPU will reevaluate the timer bases before
    reprogramming anyway, so nothing to do.

  - After updating it can be checked whether the first expiring timer in
    the affected clock bases moves before the first expiring (softirq)
    timer of the CPU. If that's not the case then sending the IPI is not
    required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Fix the in_hrtirq thinko (Marcelo)
    Add the missing masking (reported by 0day)

P.S.: The git branch is updated as well

---
 kernel/time/hrtimer.c |   74 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 65 insertions(+), 9 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -880,6 +880,68 @@ static void hrtimer_reprogram(struct hrt
 	tick_program_event(expires, 1);
 }
 
+static bool update_needs_ipi(struct hrtimer_cpu_base *cpu_base,
+			     unsigned int active)
+{
+	struct hrtimer_clock_base *base;
+	unsigned int seq;
+	ktime_t expires;
+
+	/*
+	 * Update the base offsets unconditionally so the following
+	 * checks whether the SMP function call is required works.
+	 *
+	 * The update is safe even when the remote CPU is in the hrtimer
+	 * interrupt or the hrtimer soft interrupt and expiring affected
+	 * bases. Either it will see the update before handling a base or
+	 * it will see it when it finishes the processing and reevaluates
+	 * the next expiring timer.
+	 */
+	seq = cpu_base->clock_was_set_seq;
+	hrtimer_update_base(cpu_base);
+
+	/*
+	 * If the sequence did not change over the update then the
+	 * remote CPU already handled it.
+	 */
+	if (seq == cpu_base->clock_was_set_seq)
+		return false;
+
+	/*
+	 * If the remote CPU is currently handling an hrtimer interrupt, it
+	 * will reevaluate the first expiring timer of all clock bases
+	 * before reprogramming. Nothing to do here.
+	 */
+	if (cpu_base->in_hrtirq)
+		return false;
+
+	/*
+	 * Walk the affected clock bases and check whether the first expiring
+	 * timer in a clock base is moving ahead of the first expiring timer of
+	 * @cpu_base. If so, the IPI must be invoked because per CPU clock
+	 * event devices cannot be remotely reprogrammed.
+	 */
+	active &= cpu_base->active_bases;
+
+	for_each_active_base(base, cpu_base, active) {
+		struct timerqueue_node *next;
+
+		next = timerqueue_getnext(&base->active);
+		expires = ktime_sub(next->expires, base->offset);
+		if (expires < cpu_base->expires_next)
+			return true;
+
+		/* Extra check for softirq clock bases */
+		if (base->clockid < HRTIMER_BASE_MONOTONIC_SOFT)
+			continue;
+		if (cpu_base->softirq_activated)
+			continue;
+		if (expires < cpu_base->softirq_expires_next)
+			return true;
+	}
+	return false;
+}
+
 /*
  * Clock was set. This might affect CLOCK_REALTIME, CLOCK_TAI and
  * CLOCK_BOOTTIME (for late sleep time injection).
@@ -914,16 +976,10 @@ void clock_was_set(unsigned int bases)
 		unsigned long flags;
 
 		raw_spin_lock_irqsave(&cpu_base->lock, flags);
-		/*
-		 * Only send the IPI when there are timers queued in one of
-		 * the affected clock bases. Otherwise update the base
-		 * remote to ensure that the next enqueue of a timer on
-		 * such a clock base will see the correct offsets.
-		 */
-		if (cpu_base->active_bases & bases)
+
+		if (update_needs_ipi(cpu_base, bases))
 			cpumask_set_cpu(cpu, mask);
-		else
-			hrtimer_update_base(cpu_base);
+
 		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 	}
 
