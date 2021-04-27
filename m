Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1536C11C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbhD0IjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:39:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39616 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235198AbhD0Iiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:38:46 -0400
Message-Id: <20210427083724.840364566@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619512683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XVZYJbAotayFIl1hGiY8jQKHKUn22N09L0dqKXvU0Xo=;
        b=IgQB1hL7taws5N3M1NauyjKQEkvcj/z5T1nE2qdO8htNzXSmORkDP8AxiHEEVYdoKskaI4
        jAmPZ4ubS7Mbuswjgqj5AK+jnFMm+K4TFUDH795FD8itLnXBrebmhKCiQEu2fyEzwtFbjM
        xI1FBg3JPNEPn+slLXYvbOgxys/KzH10OMOYvkmOWR6c+03fTT0Spk6LrsfIYHmakm2YI8
        4Iw87Ua9v7BVkSQLcpcDc4BBjaae297Wwt88j5Mpu/Isi2hmpPST69Mt6rn0B6DX5mYo+e
        3WHx13Ef79iLYs/mJjk0FfFKUltv3Fd25b6h4aM898dcrxcPsTbwmKjucHzBUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619512683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=XVZYJbAotayFIl1hGiY8jQKHKUn22N09L0dqKXvU0Xo=;
        b=lbfnB3vP22t1thNBiHjKLBR9OEtvSDV9/yvBpf/2DZfgGhdyMfdP/TbSzo6cPj8g5Hfgxg
        d3EXg0EFjMlAsnCw==
Date:   Tue, 27 Apr 2021 10:25:45 +0200
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
Subject: [patch 8/8] hrtimer: Avoid more SMP function calls in clock_was_set()
References: <20210427082537.611978720@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more indicators whether the SMP function calls on clock_was_set()
can be avoided:

    - When the remote CPU is currently handling hrtimer_interrupt(). In
      that case the remote CPU will update offsets and reevaluate the timer
      bases before reprogramming anyway, so nothing to do.

By unconditionally updating the offsets the following checks are possible:

    - When the offset update already happened on the remote CPU then the
      remote update attempt will yield the same seqeuence number and no
      IPI is required.

    - After updating it can be checked whether the first expiring timer in
      the affected clock bases moves before the first expiring (softirq)
      timer of the CPU. If that's not the case then sending the IPI is not
      required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |   66 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 9 deletions(-)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -880,6 +880,60 @@ static void hrtimer_reprogram(struct hrt
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
+	 * If the remote CPU is currently handling an hrtimer interrupt, it
+	 * will update and reevaluate the first expiring timer of all clock
+	 * bases before reprogramming. Nothing to do here.
+	 */
+	if (cpu_base->in_hrtirq)
+		return false;
+
+	/*
+	 * Update the base offsets unconditionally so the following quick
+	 * check whether the SMP function call is required works.
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
+	 * Walk the affected clock bases and check whether the first expiring
+	 * timer in a clock base is moving ahead of the first expiring timer of
+	 * @cpu_base. If so, the IPI must be invoked because per CPU clock
+	 * event devices cannot be remotely reprogrammed.
+	 */
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
@@ -914,16 +968,10 @@ void clock_was_set(unsigned int bases)
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
 

