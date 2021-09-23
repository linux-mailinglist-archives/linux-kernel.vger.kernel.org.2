Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C484162A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242396AbhIWQFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:05:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35412 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242254AbhIWQFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:05:53 -0400
Message-ID: <20210923153339.437521634@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ohISsOI8tgBD5YIxvKmjwysILMYODAAguQoN+PGttvQ=;
        b=z1nbtertSbcHr2Xp3vVrryxP89CX/E7hI/vOJjjy0XyN4E6WlUG5vJo48fW1oGBLFlm9Cp
        LWKvn46gColjoZ7KmfC3ZpmjlAev2aoKYVTfESTlAazTpDC8uwSpAKD1tCFvbU5lppMcrx
        aJqnLnys2F3zlXfWXVdVFQW9pJ0W81td+uyZYcwVKVzum1Ng2gGjzbwclOKYgQOaPsVDSZ
        eBdrpf17Cil598z4HleqyXuQvwu7x9r7Esn5EvvZsIRdORPPZQJz/bydDC+scce6Brg/MM
        NwdOMG83HX42/wC6zdKNwvv92d3QtR/4o7zPhd+OuHCrbSEOTOfNrN1Fl5sXDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ohISsOI8tgBD5YIxvKmjwysILMYODAAguQoN+PGttvQ=;
        b=8MJhroJGWYSyfr9r2Qrgtv8Znw4CKVb1NR7cQ1sRC908MM2SuyzhxODmFD0nYEfxEzmVu4
        bvQf+3THob1LACBg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: [patch 01/11] hrtimer: Add a mechanism to catch runaway timers
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:20 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent report from syzbot unearthed a problem with self rearming timers
which fire late and try to catch up to now with a short period. That causes
the timer to be rearmed in the past until it eventually catches up with
now. If that rearming happens from the timer callback the hard or soft
interrupt expiry loop can run for a long time with either interrupts or
bottom halves disabled which causes RCU stalls and other lockups.

There is no safety net to stop or at least identify such runaway timers.

Detection is trivial. Cache the pointer to the last expired timer. The next
invocation from the same loop compares the pointer with the next expiring
hrtimer pointer and if they match 10 times in a row (in the same hard or
soft interrupt expiry instance) then it's reasonable to declare it as a
runaway.

In that case emit a warning and skip the callback invocation which stops
the misbehaving timer right there.

It's obviously incomplete, but it's definitely better than nothing and would
have caught the reported issue in mac80211_hwsim.

Suggested-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1714,6 +1714,13 @@ static void __run_hrtimer(struct hrtimer
 	base->running = NULL;
 }
 
+static void hrtimer_del_runaway(struct hrtimer_clock_base *base,
+				struct hrtimer *timer)
+{
+	__remove_hrtimer(timer, base, HRTIMER_STATE_INACTIVE, 0);
+	pr_warn("Runaway hrtimer %p %ps stopped\n", timer, timer->function);
+}
+
 static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 				 unsigned long flags, unsigned int active_mask)
 {
@@ -1722,6 +1729,8 @@ static void __hrtimer_run_queues(struct
 
 	for_each_active_base(base, cpu_base, active) {
 		struct timerqueue_node *node;
+		struct hrtimer *last = NULL;
+		unsigned int cnt = 0;
 		ktime_t basenow;
 
 		basenow = ktime_add(now, base->offset);
@@ -1732,6 +1741,22 @@ static void __hrtimer_run_queues(struct
 			timer = container_of(node, struct hrtimer, node);
 
 			/*
+			 * Catch timers which rearm themself with a expiry
+			 * time in the past over and over which makes this
+			 * loop run forever.
+			 */
+			if (IS_ENABLED(CONFIG_DEBUG_OBJECTS_TIMERS)) {
+				if (unlikely(last == timer)) {
+					if (++cnt == 10) {
+						hrtimer_del_runaway(base, timer);
+						continue;
+					}
+				}
+				last = timer;
+				cnt = 0;
+			}
+
+			/*
 			 * The immediate goal for using the softexpires is
 			 * minimizing wakeups, not running timers at the
 			 * earliest interrupt after their soft expiration.

