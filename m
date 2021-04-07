Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE17C35703B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353594AbhDGP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37909 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353528AbhDGP32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617809357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=lt6zYqYQXzJ6nG3sWMwPo3r3/e2UA4fAW7Oz3w0+DpU=;
        b=UBCJhiUFjQ8L5aX2X6+kUFKD7VzwNEPESXVmxc3fJV1/Jg6njwuqv7clERhVoBO9yzZTdK
        veor16ihPXn0/w3eUKK7YAqGzWpx5GNz3H7WkR7VI4b2GV324HrhVQzxn6QvBcQhfhSTXI
        IU2+gfMBkZvwtY4JRV/Uf2yUWfEQGKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-lxbv5R-vO1y3hTr9E94DXQ-1; Wed, 07 Apr 2021 11:28:26 -0400
X-MC-Unique: lxbv5R-vO1y3hTr9E94DXQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87523A0CAC;
        Wed,  7 Apr 2021 15:28:22 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-5.gru2.redhat.com [10.97.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9F5D2BFE7;
        Wed,  7 Apr 2021 15:28:14 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 559BC41486DD; Wed,  7 Apr 2021 10:53:01 -0300 (-03)
Date:   Wed, 7 Apr 2021 10:53:01 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: [PATCH] hrtimer: avoid retrigger_next_event IPI
Message-ID: <20210407135301.GA16985@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Setting the realtime clock triggers an IPI to all CPUs to reprogram
hrtimers.

However, only base, boottime and tai clocks have their offsets updated
(and therefore potentially require a reprogram).

If the CPU is a nohz_full one, check if it only has 
monotonic active timers, and in that case update the 
realtime base offsets, skipping the IPI.

This reduces interruptions to nohz_full CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 743c852e10f2..b42b1a434b22 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -853,6 +853,28 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	tick_program_event(expires, 1);
 }
 
+#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME)|		\
+			 (1U << HRTIMER_BASE_REALTIME_SOFT)|	\
+			 (1U << HRTIMER_BASE_BOOTTIME)|		\
+			 (1U << HRTIMER_BASE_BOOTTIME_SOFT)|	\
+			 (1U << HRTIMER_BASE_TAI)|		\
+			 (1U << HRTIMER_BASE_TAI_SOFT))
+
+static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
+{
+	unsigned int active = 0;
+
+	if (!cpu_base->softirq_activated)
+		active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
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
@@ -867,9 +889,41 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 void clock_was_set(void)
 {
 #ifdef CONFIG_HIGH_RES_TIMERS
-	/* Retrigger the CPU local events everywhere */
-	on_each_cpu(retrigger_next_event, NULL, 1);
+	cpumask_var_t mask;
+	int cpu;
+
+	if (!tick_nohz_full_enabled()) {
+		/* Retrigger the CPU local events everywhere */
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto set_timerfd;
+	}
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		on_each_cpu(retrigger_next_event, NULL, 1);
+		goto set_timerfd;
+	}
+
+	/* Avoid interrupting nohz_full CPUs if possible */
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		if (tick_nohz_full_cpu(cpu)) {
+			unsigned long flags;
+			struct hrtimer_cpu_base *cpu_base = &per_cpu(hrtimer_bases, cpu);
+
+			raw_spin_lock_irqsave(&cpu_base->lock, flags);
+			if (need_reprogram_timer(cpu_base))
+				cpumask_set_cpu(cpu, mask);
+			else
+				hrtimer_update_base(cpu_base);
+			raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+		}
+	}
+
+	smp_call_function_many(mask, retrigger_next_event, NULL, 1);
+	preempt_enable();
+	free_cpumask_var(mask);
 #endif
+set_timerfd:
 	timerfd_clock_was_set();
 }
 

