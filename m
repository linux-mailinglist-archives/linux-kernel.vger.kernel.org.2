Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F96360F20
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhDOPkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232642AbhDOPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618501215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXY8qgXZKCc4z2lwTWwd4Blid0GIGNFURZ3FYBCFZtI=;
        b=hR+CTXZMWt5O07ABm2bVLQDlIfzWpVP6AwVXzAV0u/naur+ax9OegpXyb0IjOo5OlXeZpp
        6/btW3NCUjghDcAxrkkTd8WqZGNtq9AF+eDPY1dpZHoBHNmtMrwgblwK5mCH4XZ9NAw7Hw
        0GnNbmMree9dE4PAp3HzD9SnAgmBiJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-Ctb2fErJOuiP2WvEJeThWA-1; Thu, 15 Apr 2021 11:40:13 -0400
X-MC-Unique: Ctb2fErJOuiP2WvEJeThWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1413F8030C4;
        Thu, 15 Apr 2021 15:40:12 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E680E610F1;
        Thu, 15 Apr 2021 15:40:04 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id D80DC4179B89; Thu, 15 Apr 2021 12:39:35 -0300 (-03)
Date:   Thu, 15 Apr 2021 12:39:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: [PATCH v3] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210415153935.GA69750@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet>
 <87o8en4k9a.ffs@nanos.tec.linutronix.de>
 <20210409165146.GA40118@fuller.cnet>
 <87lf9q4lue.ffs@nanos.tec.linutronix.de>
 <20210413170431.GA16190@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210413170431.GA16190@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Setting the realtime clock triggers an IPI to all CPUs to reprogram
the clock event device.

However, only realtime and TAI clocks have their offsets updated
(and therefore potentially require a reprogram).

Instead of sending an IPI unconditionally, check each per CPU hrtimer base
whether it has active timers in the CLOCK_REALTIME and CLOCK_TAI bases. If
that's not the case, update the realtime and TAI base offsets remotely and
skip the IPI. This ensures that any subsequently armed timers on
CLOCK_REALTIME and CLOCK_TAI are evaluated with the correct offsets.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v3:
   - Nicer changelog  (Thomas).
   - Code style fixes (Thomas).
   - Compilation warning with CONFIG_HIGH_RES_TIMERS=n (Thomas).
   - Shrink preemption disabled section (Thomas).

v2:
   - Only REALTIME and TAI bases are affected by offset-to-monotonic changes (Thomas).
   - Don't special case nohz_full CPUs (Thomas).

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5c9d968187ae..dd9c0d2f469f 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -871,6 +871,24 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	tick_program_event(expires, 1);
 }
 
+#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
+			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
+			 (1U << HRTIMER_BASE_TAI) |		\
+			 (1U << HRTIMER_BASE_TAI_SOFT))
+
+static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
+{
+	unsigned int active = 0;
+
+	if (cpu_base->softirq_activated)
+		return true;
+
+	active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
+	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
+
+	return (cpu_base->active_bases & CLOCK_SET_BASES) != 0;
+}
+
 /*
  * Clock realtime was set
  *
@@ -885,8 +903,32 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 void clock_was_set(void)
 {
 #ifdef CONFIG_HIGH_RES_TIMERS
-	/* Retrigger the CPU local events everywhere */
-	on_each_cpu(retrigger_next_event, NULL, 1);
+	cpumask_var_t mask;
+	int cpu;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto set_timerfd;
+	}
+
+	/* Avoid interrupting CPUs if possible */
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		unsigned long flags;
+		struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
+
+		raw_spin_lock_irqsave(&cpu_base->lock, flags);
+		if (need_reprogram_timer(cpu_base))
+			cpumask_set_cpu(cpu, mask);
+		raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+	}
+
+	preempt_disable();
+	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	preempt_enable();
+	cpus_read_unlock();
+	free_cpumask_var(mask);
+set_timerfd:
 #endif
 	timerfd_clock_was_set();
 }




