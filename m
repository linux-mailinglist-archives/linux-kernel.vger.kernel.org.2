Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C4336B30A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 14:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbhDZM0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 08:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbhDZM03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 08:26:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB80C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 05:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=glS/FhcHv7ibmY+Bj2a0n4MdUkYg0DQAi/BSJX2IGnY=; b=Wtrdn54o/EtZjcDn/WQM5Vx8nd
        aMHlnWN7EiAYeZiv3RbcoDKQWJj0FR4/XPQ6he3oc7geVAbSlEKPzsPfSIXYYzoUuPDh2/9HLYjOL
        JedD+sfgjtqFliVxyau2UDkwq9LuyWMzx5k6HqJXt6raXYKYBGXmO2XGeIej+wSTLIdBhRAnNi77a
        AV2xG8qLowTKbe3qAGguzrRGn0oowt5oANt/y9btUnWDenRSbY/miBhWo/1RDuSCLa8cdjVv5YiMb
        aOx1esDKN9jNKCvJEffpC1iiFxsnpLJxCiKdYqPAir1f0AUBCnWPHVjl8jFHURbYLnuxhQrs/kVWB
        3hREKErg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lb0Ij-005bAD-Fm; Mon, 26 Apr 2021 12:25:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E77803001D0;
        Mon, 26 Apr 2021 14:25:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D0F7F2D193756; Mon, 26 Apr 2021 14:25:19 +0200 (CEST)
Date:   Mon, 26 Apr 2021 14:25:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Avoid double reprogramming in
 __hrtimer_start_range_ns()
Message-ID: <YIaxL5zcpjbfR1gp@hirez.programming.kicks-ass.net>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com>
 <YHXRWoVIYLL4rYG9@kroah.com>
 <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com>
 <87r1jbv6jc.ffs@nanos.tec.linutronix.de>
 <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
 <87eef5qbrx.ffs@nanos.tec.linutronix.de>
 <87v989topu.ffs@nanos.tec.linutronix.de>
 <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIaKnuZDfffmmAdM@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 11:40:46AM +0200, Peter Zijlstra wrote:
> There is an unfortunate amount of duplication between
> hrtimer_force_reprogram() and hrtimer_reprogram(). The obvious cleanups
> don't work however :/ Still, does that in_hrtirq optimization make sense
> to have in force_reprogram ?


Something like so perhaps?

---
 kernel/time/hrtimer.c | 75 ++++++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 43 deletions(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 5c9d968187ae..fb8d2c58443a 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,21 +652,27 @@ static inline int hrtimer_hres_active(void)
 	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
 }
 
-/*
- * Reprogram the event source with checking both queues for the
- * next event
- * Called with interrupts disabled and base->lock held
- */
 static void
-hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+__hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal,
+			  struct hrtimer *next_timer, ktime_t expires_next)
 {
-	ktime_t expires_next;
+	/*
+	 * If the hrtimer interrupt is running, then it will
+	 * reevaluate the clock bases and reprogram the clock event
+	 * device. The callbacks are always executed in hard interrupt
+	 * context so we don't need an extra check for a running
+	 * callback.
+	 */
+	if (cpu_base->in_hrtirq)
+		return;
 
-	expires_next = hrtimer_update_next_event(cpu_base);
+	if (expires_next > cpu_base->expires_next)
+		return;
 
 	if (skip_equal && expires_next == cpu_base->expires_next)
 		return;
 
+	cpu_base->next_timer = next_timer;
 	cpu_base->expires_next = expires_next;
 
 	/*
@@ -689,7 +695,23 @@ hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
 	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
 		return;
 
-	tick_program_event(cpu_base->expires_next, 1);
+	tick_program_event(expires_next, 1);
+}
+
+/*
+ * Reprogram the event source with checking both queues for the
+ * next event
+ * Called with interrupts disabled and base->lock held
+ */
+static void
+hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+{
+	ktime_t expires_next;
+
+	expires_next = hrtimer_update_next_event(cpu_base);
+
+	__hrtimer_force_reprogram(cpu_base, skip_equal,
+				  cpu_base->next_timer, expires_next);
 }
 
 /* High resolution timer related functions */
@@ -835,40 +857,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool reprogram)
 	if (base->cpu_base != cpu_base)
 		return;
 
-	/*
-	 * If the hrtimer interrupt is running, then it will
-	 * reevaluate the clock bases and reprogram the clock event
-	 * device. The callbacks are always executed in hard interrupt
-	 * context so we don't need an extra check for a running
-	 * callback.
-	 */
-	if (cpu_base->in_hrtirq)
-		return;
-
-	if (expires >= cpu_base->expires_next)
-		return;
-
-	/* Update the pointer to the next expiring timer */
-	cpu_base->next_timer = timer;
-	cpu_base->expires_next = expires;
-
-	/*
-	 * If hres is not active, hardware does not have to be
-	 * programmed yet.
-	 *
-	 * If a hang was detected in the last timer interrupt then we
-	 * do not schedule a timer which is earlier than the expiry
-	 * which we enforced in the hang detection. We want the system
-	 * to make progress.
-	 */
-	if (!__hrtimer_hres_active(cpu_base) || cpu_base->hang_detected)
-		return;
-
-	/*
-	 * Program the timer hardware. We enforce the expiry for
-	 * events which are already in the past.
-	 */
-	tick_program_event(expires, 1);
+	__hrtimer_force_reprogram(cpu_base, true, timer, expires);
 }
 
 /*
