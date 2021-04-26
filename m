Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4236736AFFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhDZIuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhDZIuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:50:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E6BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:49:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619426974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCyMnv4HLYYaNHDMqqeqff5nYJqhFU92C+HAIPOa9MU=;
        b=w1r76OFa4nfXCB/k/9RunyS2ofOIMQNSJNeN2iF/VRL8W5omNtxOExKE/Sth8FsMnUA75N
        AX5jCbjFVgBAWlcUriNo3kHtlhogR/kCGsvze8CoEGHg2PC+8NBHaPK9RwE+38vqDwZA4j
        IoVua+s9H3JH4MunDIM9MvEvZEbD1VrPL4sOTPy6+FsETZatevorGx+Wbrtgb2tTQH89gx
        u8FRXmQk5YNOGzrBcAJ7/DQVOamigwhM9cvfpIxfV9XkyXbiPRn4vlip7M6MpyWlJvsQpD
        frS8O8fpXNF6zqhb70Mn31eV2eNk+mTfY+XkbBUl8qO2Kd5NhPtXgv8CkxiYbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619426974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCyMnv4HLYYaNHDMqqeqff5nYJqhFU92C+HAIPOa9MU=;
        b=vILJ6CS8MhFPJq6IR6Fg5LgrCd9au6YVLpGVNEhJj1sIyKuFhrYU9C9SBtZf5sJO2uHWQ0
        YX7U2hzVk3qz6QDg==
To:     Lorenzo Colitti <lorenzo@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Maciej =?utf-8?Q?=C5=BBenczykows?= =?utf-8?Q?ki?= 
        <zenczykowski@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        mikael.beckius@windriver.com,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] hrtimer: Avoid double reprogramming in __hrtimer_start_range_ns()
In-Reply-To: <87eef5qbrx.ffs@nanos.tec.linutronix.de>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com> <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CAKD1Yr1o=zN5K9PaB3wag5xOS2oY6AzEsV6dmL7pnTysK_GOhA@mail.gmail.com> <87eef5qbrx.ffs@nanos.tec.linutronix.de>
Date:   Mon, 26 Apr 2021 10:49:33 +0200
Message-ID: <87v989topu.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __hrtimer_start_range_ns() is invoked with an already armed hrtimer then
the timer has to be canceled first and then added back. If the timer is the
first expiring timer then on removal the clockevent device is reprogrammed
to the next expiring timer to avoid that the pending expiry fires needlessly.

If the new expiry time ends up to be the first expiry again then the clock
event device has to reprogrammed again.

Avoid this by checking whether the timer is the first to expire and in that
case, keep the timer on the current CPU and delay the reprogramming up to
the point where the timer has been enqueued again. 

Reported-by: Lorenzo Colitti <lorenzo@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |   60 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 7 deletions(-)

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
 
