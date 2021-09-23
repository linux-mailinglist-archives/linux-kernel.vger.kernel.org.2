Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0154162B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242520AbhIWQGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:06:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35498 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242404AbhIWQGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:06:05 -0400
Message-ID: <20210923153339.870134240@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632413073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UMSZ2Z9AHmRgzTNPXSaBo283amgd878TyWwnMiQYSw4=;
        b=UUHRpQAoZkWRD+juQwehPbUjvipZ5ByP1Xx1aTuiUVFK+rWN6qgqDR8zlORNOi4OWxw7/Z
        aU3AsLNEg1QSclyHmSU/IMHE6GLOKg7p+LeH2Lwgt+UU/cxRRYTSeQAm6b++ZzWh99E3q6
        N12uVcVnuj0IxnftWDiTHCeTdMIbG7obBOrlZaex+DqY8vMeHj99KnDniT9PZtm1Ge1J8C
        ECHgrVkylKBLIuiZIjS4h42EZoea0H4dLezPJSIYGIygdMJBUteUJj8ISKPey9wO3RthU6
        psIWEgzvZcBhbpBgZbm3UiE77N4Qu3Um1ehyTkEdYDSCtaBhidDEChky5hp6TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632413073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UMSZ2Z9AHmRgzTNPXSaBo283amgd878TyWwnMiQYSw4=;
        b=1PNe1xlSC61Lqo4BXzkrizYXkfVWAiswTTYxdquWE5OjjLPG6yDa6S4lJnuiCV4rFkSOxj
        fsuAwRTwqTBdTpAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [patch 08/11] signal: Move itimer rearming into itimer code
References: <20210923153311.225307347@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:04:32 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the itimer rearming functionality into itimer.c which cleans up the
ifdeffery in the signal code.

While at it replace the open coded hrtimer_forward() invocation with
hrtimer_forward_now() which is equivalent.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/posix-timers.h |    3 +++
 kernel/signal.c              |   14 ++------------
 kernel/time/itimer.c         |   13 +++++++++++++
 3 files changed, 18 insertions(+), 12 deletions(-)

--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -174,6 +174,8 @@ static inline void posix_cputimers_rt_wa
 	.posix_cputimers = {						\
 		.bases = INIT_CPU_TIMERBASES(s.posix_cputimers.bases),	\
 	},
+
+void itimer_restart(void);
 #else
 struct posix_cputimers { };
 struct cpu_timer { };
@@ -181,6 +183,7 @@ struct cpu_timer { };
 static inline void posix_cputimers_init(struct posix_cputimers *pct) { }
 static inline void posix_cputimers_group_init(struct posix_cputimers *pct,
 					      u64 cpu_limit) { }
+static inline void itimer_restart(void) { }
 #endif
 
 #ifdef CONFIG_POSIX_CPU_TIMERS_TASK_WORK
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -651,7 +651,6 @@ int dequeue_signal(struct task_struct *t
 	if (!signr) {
 		signr = __dequeue_signal(&tsk->signal->shared_pending,
 					 mask, info, &resched_timer);
-#ifdef CONFIG_POSIX_TIMERS
 		/*
 		 * itimer signal ?
 		 *
@@ -665,17 +664,8 @@ int dequeue_signal(struct task_struct *t
 		 * reducing the timer noise on heavy loaded !highres
 		 * systems too.
 		 */
-		if (unlikely(signr == SIGALRM)) {
-			struct hrtimer *tmr = &tsk->signal->real_timer;
-
-			if (!hrtimer_is_queued(tmr) &&
-			    tsk->signal->it_real_incr != 0) {
-				hrtimer_forward(tmr, tmr->base->get_time(),
-						tsk->signal->it_real_incr);
-				hrtimer_restart(tmr);
-			}
-		}
-#endif
+		if (unlikely(signr == SIGALRM))
+			itimer_restart();
 	}
 
 	recalc_sigpending();
--- a/kernel/time/itimer.c
+++ b/kernel/time/itimer.c
@@ -150,6 +150,19 @@ COMPAT_SYSCALL_DEFINE2(getitimer, int, w
 }
 #endif
 
+void itimer_restart(void)
+{
+	struct task_struct *tsk = current;
+	struct hrtimer *tmr = &tsk->signal->real_timer;
+
+	lockdep_assert_task_sighand_held(current);
+
+	if (!hrtimer_is_queued(tmr) && tsk->signal->it_real_incr != 0) {
+		hrtimer_forward_now(tmr, tsk->signal->it_real_incr);
+		hrtimer_restart(tmr);
+	}
+}
+
 /*
  * The timer is automagically restarted, when interval != 0
  */

