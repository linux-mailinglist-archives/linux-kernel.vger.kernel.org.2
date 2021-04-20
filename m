Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B093365B11
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhDTOTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhDTOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7354C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:19:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618928355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/ViRn2pNdErX4Ke8faeNKeEu3gSwpIw5ZJV1T1lJms=;
        b=Kkx4pXQBA8MPU1gMYiLnM7bB+ugPip9rFs8XRABtI0+Bh9jmD4wMmtM0o6H6KG7Tu+VKzr
        d7OX8h+LXdIyZCMVxRyA830ZvDoLnfkbESl2w6wd5scBHif7lFcPCY0UsdDSvwsWz39+4k
        2J30J+8xYSxuI8HzYtadbEDm3CZs2NCLCNQtu3OHUnNAhTzCaxjpsv0UVEPKfWXAkSvI/A
        VQiyJHWdJlCXi0YHj0qolZf738YBobae8PZQe7MmoHDzzja1uN2HoaXfill64b2jcV9X6T
        4eP0STCIbnAeamavk6MCde8zaIyDHEdqsO78DpnSUt14DCYRzjLfxlvWS4G3/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618928355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/ViRn2pNdErX4Ke8faeNKeEu3gSwpIw5ZJV1T1lJms=;
        b=BkOUsKnSXOt0Ay39kwtTdXLbGOJVU3L/Jr/DsRuu8+LLBEWoG4pUWwAzvFS2dZyYAaWjWk
        c9x96zoRdTz36FAA==
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykows?= =?utf-8?Q?ki?= 
        <zenczykowski@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
In-Reply-To: <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com> <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com>
Date:   Tue, 20 Apr 2021 16:19:14 +0200
Message-ID: <87eef5qbrx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20 2021 at 17:15, Lorenzo Colitti wrote:
> On Fri, Apr 16, 2021 at 1:47 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> Enable tracing and enable the following tracepoints:
>> [...]
>
> Sorry for the delay. I had to learn a bit about how to use the tracing
> infrastructure. I don't know if I can post here, but to my untrained
> eye, one big difference between the old (fast) code and the new (slow)
> code is that the new code calls tick_program_event() much more. It
> looks like that makes most of the difference.
>
> With the old code, hrtimer_start_range_ns almost never calls
> tick_program_event at all, but the new code seems to call it twice on
> every timer update.

Yes, I figured out why that happens by now, but the old behaviour was
just incorrect. So now there are clearly two issues:

  1) hrtimer is contrary to timer_list not really suited for high
     frequency start/cancel/start/... cycles of a timer. It's optimized
     for the start and expire precisely case.

  2) The cost for reprogramming depends on the underlying hardware. With
     halfways sane timer hardware it's minimal and as I measured in a
     micro benchmark in the 1% range. Now when your system ends up
     having one of the real timer trainwrecks which can be found in
     drivers/clocksource/ which are even worse than the x86 HPET horror,
     then it's going to be painful and a performance issue.

     I assume that's an ARM64 system. ARM64 CPUs have an architected per
     CPU timer where the reprogramming is pretty fast as it's next to
     the CPU, but who knows what your system is using.

Now in the meantime I looked into __hrtimer_start_range_ns() whether
that double reprogram can be avoided without creating a total trainwreck
and imposing penalty on all sensible use cases. Completely untested
patch below should do the trick and it's not ugly enough that I hate it
with a passion.

Even if that makes your problem go away #1 is still beyond suboptimal
and #2 is something you really want to look into.

Thanks,

        tglx
---
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1030,12 +1030,13 @@ static void __remove_hrtimer(struct hrti
  * remove hrtimer, called with base lock held
  */
 static inline int
-remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base, bool restart)
+remove_hrtimer(struct hrtimer *timer, struct hrtimer_clock_base *base,
+	       bool restart, bool keep_local)
 {
 	u8 state = timer->state;
 
 	if (state & HRTIMER_STATE_ENQUEUED) {
-		int reprogram;
+		bool reprogram;
 
 		/*
 		 * Remove the timer and force reprogramming when high
@@ -1048,8 +1049,16 @@ remove_hrtimer(struct hrtimer *timer, st
 		debug_deactivate(timer);
 		reprogram = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
 
+		/*
+		 * If the timer is not restarted then reprogramming is
+		 * required if the timer is local. If it is local and about
+		 * to be restarted, avoid programming it twice (on removal
+		 * and a moment later when it's requeued).
+		 */
 		if (!restart)
 			state = HRTIMER_STATE_INACTIVE;
+		else
+			reprogram &= !keep_local;
 
 		__remove_hrtimer(timer, base, state, reprogram);
 		return 1;
@@ -1103,9 +1112,31 @@ static int __hrtimer_start_range_ns(stru
 				    struct hrtimer_clock_base *base)
 {
 	struct hrtimer_clock_base *new_base;
+	bool force_local, first;
 
-	/* Remove an active timer from the queue: */
-	remove_hrtimer(timer, base, true);
+	/*
+	 * If the timer is on the local cpu base and is the first expiring
+	 * timer then this might end up reprogramming the hardware twice
+	 * (on removal and on enqueue). To avoid that by prevent the
+	 * reprogram on removal, keep the timer local to the current CPU
+	 * and enforce reprogramming after it is queued no matter whether
+	 * it is the new first expiring timer again or not.
+	 */
+	force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
+	force_local &= base->cpu_base->next_timer == timer;
+
+	/*
+	 * Remove an active timer from the queue. In case it is not queued
+	 * on the current CPU, make sure that remove_hrtimer() updates the
+	 * remote data correctly.
+	 *
+	 * If it's on the current CPU and the first expiring timer, then
+	 * skip reprogramming, keep the timer local and enforce
+	 * reprogramming later if it was the first expiring timer.  This
+	 * avoids programming the underlying clock event twice (once at
+	 * removal and once after enqueue).
+	 */
+	remove_hrtimer(timer, base, true, force_local);
 
 	if (mode & HRTIMER_MODE_REL)
 		tim = ktime_add_safe(tim, base->get_time());
@@ -1115,9 +1146,24 @@ static int __hrtimer_start_range_ns(stru
 	hrtimer_set_expires_range_ns(timer, tim, delta_ns);
 
 	/* Switch the timer base, if necessary: */
-	new_base = switch_hrtimer_base(timer, base, mode & HRTIMER_MODE_PINNED);
+	if (!force_local) {
+		new_base = switch_hrtimer_base(timer, base,
+					       mode & HRTIMER_MODE_PINNED);
+	} else {
+		new_base = base;
+	}
 
-	return enqueue_hrtimer(timer, new_base, mode);
+	first = enqueue_hrtimer(timer, new_base, mode);
+	if (!force_local)
+		return first;
+
+	/*
+	 * Timer was forced to stay on the current CPU to avoid
+	 * reprogramming on removal and enqueue. Force reprogram the
+	 * hardware by evaluating the new first expiring timer.
+	 */
+	hrtimer_force_reprogram(new_base->cpu_base, 1);
+	return 0;
 }
 
 /**
@@ -1183,7 +1229,7 @@ int hrtimer_try_to_cancel(struct hrtimer
 	base = lock_hrtimer_base(timer, &flags);
 
 	if (!hrtimer_callback_running(timer))
-		ret = remove_hrtimer(timer, base, false);
+		ret = remove_hrtimer(timer, base, false, false);
 
 	unlock_hrtimer_base(timer, &flags);
 


