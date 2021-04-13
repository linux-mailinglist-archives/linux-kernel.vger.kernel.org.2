Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8013535E499
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347066AbhDMRGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56081 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347043AbhDMRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618333582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G3nmYNoMFE6gpI8WlNkjcMOqeEXahAFNsVntSPTP+z4=;
        b=YmKRYYHwcD8XjEBhHfdg8ZEU3+Q4uqW9Mj4alnfs3Lc7TXbZ23VKwUBhevk5aMQBe4Ees7
        7EpQA3vFW1evEfcjPgMt6aTYHOiQjT6lEr6J5oVHafCu8ytY53nidq5MH5mMIuqqMUf3YJ
        zp35iXvc+8r6w/yG/aWyuoi9Umn69rw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-XztBx-C5P_uVR3x7nc09Gg-1; Tue, 13 Apr 2021 13:06:18 -0400
X-MC-Unique: XztBx-C5P_uVR3x7nc09Gg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A47C65B378;
        Tue, 13 Apr 2021 17:06:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A495918111;
        Tue, 13 Apr 2021 17:06:09 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id E935A41486FD; Tue, 13 Apr 2021 14:04:31 -0300 (-03)
Date:   Tue, 13 Apr 2021 14:04:31 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: [PATCH v2] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210413170431.GA16190@fuller.cnet>
References: <20210407135301.GA16985@fuller.cnet>
 <87o8en4k9a.ffs@nanos.tec.linutronix.de>
 <20210409165146.GA40118@fuller.cnet>
 <87lf9q4lue.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf9q4lue.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Setting the realtime clock triggers an IPI to all CPUs to reprogram
hrtimers.

However, only realtime and TAI clocks have their offsets updated
(and therefore potentially require a reprogram).

Check if it only has monotonic active timers, and in that case 
update the realtime and TAI base offsets remotely, skipping the IPI.

This reduces interruptions to latency sensitive applications.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---

v2:
   - Only REALTIME and TAI bases are affected by offset-to-monotonic changes (Thomas).
   - Don't special case nohz_full CPUs (Thomas).
   

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5c9d968187ae..be21b85c679d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -871,6 +871,28 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	tick_program_event(expires, 1);
 }
 
+#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME)|		\
+			 (1U << HRTIMER_BASE_REALTIME_SOFT)|	\
+			 (1U << HRTIMER_BASE_TAI)|		\
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
+
+	active = active | (cpu_base->active_bases & HRTIMER_ACTIVE_HARD);
+
+	if ((active & CLOCK_SET_BASES) == 0)
+		return false;
+
+	return true;
+}
+
 /*
  * Clock realtime was set
  *
@@ -885,9 +907,31 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
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
+	preempt_disable();
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
+	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	preempt_enable();
+	free_cpumask_var(mask);
 #endif
+set_timerfd:
 	timerfd_clock_was_set();
 }

