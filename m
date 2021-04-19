Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6266364AB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbhDSTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234946AbhDSTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618861213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L9+VU/5SpOTfDHXr3CS+pWsnnvfSjJCp11ICFIZ5F0E=;
        b=PN10B2xXPHP8XpjaiO9l9R+yZjNftvLA2CX0Fb8QzqZqNjkUEM1kOIkj7uVOH1tFWrJ8TM
        tSvnQU3v+TeeXLSKIpsDKqyKJetKUB0YruIk8a4MLZBoHtMnZv8E7eazG2eGQ0cWWhY0b5
        7vM82prENfr9wbrp0j0ltB1LRE2+kxY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-CW23drAqMvikR0HmDNZUfQ-1; Mon, 19 Apr 2021 15:40:08 -0400
X-MC-Unique: CW23drAqMvikR0HmDNZUfQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F438B5DD5;
        Mon, 19 Apr 2021 19:40:01 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCCC039A5F;
        Mon, 19 Apr 2021 19:39:25 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id DF8A8416D8BC; Mon, 19 Apr 2021 16:39:02 -0300 (-03)
Date:   Mon, 19 Apr 2021 16:39:02 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: [PATCH v6] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210419193902.GB57245@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet>
 <87o8en4k9a.ffs@nanos.tec.linutronix.de>
 <20210409165146.GA40118@fuller.cnet>
 <87lf9q4lue.ffs@nanos.tec.linutronix.de>
 <20210413170431.GA16190@fuller.cnet>
 <20210415153935.GA69750@fuller.cnet>
 <87im4nv0fh.ffs@nanos.tec.linutronix.de>
 <20210415204017.GA111847@fuller.cnet>
 <20210416160023.GA6187@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416160023.GA6187@fuller.cnet>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

v6:
  - Do not take softirq_raised into account (Peter Xu).
  - Include BOOTTIME as base that requires IPI (Thomas).
  - Unconditional reprogram on resume path, since there is
    nothing to gain in such path anyway.

v5:
  - Add missing hrtimer_update_base (Peter Xu).

v4:
   - Drop unused code (Thomas).

v3:
   - Nicer changelog  (Thomas).
   - Code style fixes (Thomas).
   - Compilation warning with CONFIG_HIGH_RES_TIMERS=n (Thomas).
   - Shrink preemption disabled section (Thomas).

v2:
   - Only REALTIME and TAI bases are affected by offset-to-monotonic changes (Thomas).
   - Don't special case nohz_full CPUs (Thomas).


diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index bb5e7b0a4274..14a6e449b221 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -318,7 +318,7 @@ struct clock_event_device;
 
 extern void hrtimer_interrupt(struct clock_event_device *dev);
 
-extern void clock_was_set_delayed(void);
+extern void clock_was_set_delayed(bool force_reprogram);
 
 extern unsigned int hrtimer_resolution;
 
@@ -326,7 +326,7 @@ extern unsigned int hrtimer_resolution;
 
 #define hrtimer_resolution	(unsigned int)LOW_RES_NSEC
 
-static inline void clock_was_set_delayed(void) { }
+static inline void clock_was_set_delayed(bool force_reprogram) { }
 
 #endif
 
@@ -351,7 +351,7 @@ hrtimer_expires_remaining_adjusted(const struct hrtimer *timer)
 						    timer->base->get_time());
 }
 
-extern void clock_was_set(void);
+extern void clock_was_set(bool);
 #ifdef CONFIG_TIMERFD
 extern void timerfd_clock_was_set(void);
 #else
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5c9d968187ae..2258782fd714 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -758,9 +758,17 @@ static void hrtimer_switch_to_hres(void)
 	retrigger_next_event(NULL);
 }
 
+static void clock_was_set_force_reprogram_work(struct work_struct *work)
+{
+	clock_was_set(true);
+}
+
+static DECLARE_WORK(hrtimer_force_reprogram_work, clock_was_set_force_reprogram_work);
+
+
 static void clock_was_set_work(struct work_struct *work)
 {
-	clock_was_set();
+	clock_was_set(false);
 }
 
 static DECLARE_WORK(hrtimer_work, clock_was_set_work);
@@ -769,9 +777,12 @@ static DECLARE_WORK(hrtimer_work, clock_was_set_work);
  * Called from timekeeping and resume code to reprogram the hrtimer
  * interrupt device on all cpus.
  */
-void clock_was_set_delayed(void)
+void clock_was_set_delayed(bool force_reprogram)
 {
-	schedule_work(&hrtimer_work);
+	if (force_reprogram)
+		schedule_work(&hrtimer_force_reprogram_work);
+	else
+		schedule_work(&hrtimer_work);
 }
 
 #else
@@ -871,6 +882,18 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	tick_program_event(expires, 1);
 }
 
+#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
+			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
+			 (1U << HRTIMER_BASE_TAI) |		\
+			 (1U << HRTIMER_BASE_TAI_SOFT) |	\
+			 (1U << HRTIMER_BASE_BOOTTIME) |	\
+			 (1U << HRTIMER_BASE_BOOTTIME_SOFT))
+
+static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
+{
+	return (cpu_base->active_bases & CLOCK_SET_BASES) != 0;
+}
+
 /*
  * Clock realtime was set
  *
@@ -882,11 +905,42 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
  * resolution timer interrupts. On UP we just disable interrupts and
  * call the high resolution interrupt code.
  */
-void clock_was_set(void)
+void clock_was_set(bool force_reprogram)
 {
 #ifdef CONFIG_HIGH_RES_TIMERS
-	/* Retrigger the CPU local events everywhere */
-	on_each_cpu(retrigger_next_event, NULL, 1);
+	cpumask_var_t mask;
+	int cpu;
+
+	if (force_reprogram == true) {
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto set_timerfd;
+	}
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
+		else
+			hrtimer_update_base(cpu_base);
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
@@ -903,7 +957,7 @@ void hrtimers_resume(void)
 	/* Retrigger on the local CPU */
 	retrigger_next_event(NULL);
 	/* And schedule a retrigger for all others */
-	clock_was_set_delayed();
+	clock_was_set_delayed(true);
 }
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6aee5768c86f..3fef237267bd 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1323,7 +1323,7 @@ int do_settimeofday64(const struct timespec64 *ts)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	/* signal hrtimers about time change */
-	clock_was_set();
+	clock_was_set(false);
 
 	if (!ret)
 		audit_tk_injoffset(ts_delta);
@@ -1371,7 +1371,7 @@ static int timekeeping_inject_offset(const struct timespec64 *ts)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	/* signal hrtimers about time change */
-	clock_was_set();
+	clock_was_set(false);
 
 	return ret;
 }
@@ -1736,7 +1736,7 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
 	/* signal hrtimers about time change */
-	clock_was_set();
+	clock_was_set(true);
 }
 #endif
 
@@ -2187,7 +2187,7 @@ static void timekeeping_advance(enum timekeeping_adv_mode mode)
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 	if (clock_set)
 		/* Have to call _delayed version, since in irq context*/
-		clock_was_set_delayed();
+		clock_was_set_delayed(false);
 }
 
 /**
@@ -2425,7 +2425,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		timekeeping_advance(TK_ADV_FREQ);
 
 	if (tai != orig_tai)
-		clock_was_set();
+		clock_was_set(false);
 
 	ntp_notify_cmos_timer();
 

