Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C054C3C7184
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 15:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbhGMN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbhGMN5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 09:57:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33323C0613EE
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 06:54:28 -0700 (PDT)
Message-Id: <20210713135158.054424875@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626184465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BT7n9FP62MQsymf3YSaIkQc0vDdp+TMODSJke4k2jl4=;
        b=pP0nCUa4gjOcHVFzXLCgSqziS1JMn6Eu2ySyWeKi048tUS4Wv7fAqxBhep7Z9Cir/nuwzx
        OHo9DwXkR9zTg9vHmzGUfAgma5nmOPaenY5GZGQqg+39qdoSKAGzl5i61AR68Iu4XQuV00
        nPw52WLE3YSwDSJbCDUZkAhnwbaaF7yzHFwwKRDo4ej3SaL/L7erObNF5FgomkRVXrHXts
        nMhlJpCl2R2IXcJshYdjqTmcZ6Okv3AlPCOWI+WRPfc1yoSvf5ICVbbmIrsDsyv2DE6gay
        ubrZvWXyTYEFb8RNFft7PbT91d6EXvMXrSjUKr1uaZqZYxhYmWmKPcm1QLZNdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626184465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BT7n9FP62MQsymf3YSaIkQc0vDdp+TMODSJke4k2jl4=;
        b=4vZYdiIjdMRzUx+axVYfCHYKMk1O0Ztj7kv2lRhN1sH4upHl0ZyjQIpA1MkDPXEKaaLDX6
        TZWutiPYgVKZxAAA==
Date:   Tue, 13 Jul 2021 15:39:47 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [patch V2 02/10] hrtimer: Consolidate reprogramming code
References: <20210713133945.063650594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

This code is mostly duplicated. The redudant store in the force reprogram
case does no harm and the in hrtimer interrupt condition cannot be true for
the force reprogram invocations.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/hrtimer.c |   72 ++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 43 deletions(-)

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -652,21 +652,24 @@ static inline int hrtimer_hres_active(vo
 	return __hrtimer_hres_active(this_cpu_ptr(&hrtimer_bases));
 }
 
-/*
- * Reprogram the event source with checking both queues for the
- * next event
- * Called with interrupts disabled and base->lock held
- */
 static void
-hrtimer_force_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal)
+__hrtimer_reprogram(struct hrtimer_cpu_base *cpu_base, int skip_equal,
+		    struct hrtimer *next_timer, ktime_t expires_next)
 {
-	ktime_t expires_next;
+	/*
+	 * If the hrtimer interrupt is running, then it will reevaluate the
+	 * clock bases and reprogram the clock event device.
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
@@ -689,7 +692,23 @@ hrtimer_force_reprogram(struct hrtimer_c
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
+	__hrtimer_reprogram(cpu_base, skip_equal, cpu_base->next_timer,
+			    expires_next);
 }
 
 /* High resolution timer related functions */
@@ -835,40 +854,7 @@ static void hrtimer_reprogram(struct hrt
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
+	__hrtimer_reprogram(cpu_base, true, timer, expires);
 }
 
 /*

