Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E188B3FA61B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234335AbhH1N4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhH1N4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 09:56:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15BC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 06:55:56 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630158953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szT5lkD+YWto/0wcn5LngBYE8usayOdbrKOZ9uNLgNI=;
        b=csJu0jMX4yt4WEZoYCHowPRFviaigHrC4t5wJ2Z6nfuzYm2AHunep4zQhaoQCTVrWz2XvK
        3mwfK424sBX93//QS9c4fDKB/bT8+40dg5Idr6Hl/GQy8S4KaHl09dqXFLiPHOg13e39Nd
        lESjSOscH5K3AHvhyVE2XOOTl9Zvi30DO9zs87tiY3lPSzZNBfZiiIGm7tJbSYMsG7bEpL
        TisAnRhToY/uLNalB9omnR/oOmoLruGLdMQm6RBbNFQ7yy9NYhrjQVdBfNbbR8x5S2fsFi
        B3wh2ytt6uZty4ZK7HeNQxQtRypho8ewv2ZvZVnkoG9o5IszrEJJObZ67BBkcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630158953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=szT5lkD+YWto/0wcn5LngBYE8usayOdbrKOZ9uNLgNI=;
        b=t5sHQTMaI0H8e5OxYviLacK2pQTLScvYqMXthgFniEO3MH4hs5NEVBj4sPNCBrAbmS0z7r
        lsbqRurp0ZgRFaBA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH V2] sched: Prevent balance_push() on remote runqueues
In-Reply-To: <87eeae11cr.ffs@tglx>
References: <87tujb0yn1.ffs@tglx> <87eeae11cr.ffs@tglx>
Date:   Sat, 28 Aug 2021 15:55:52 +0200
Message-ID: <87zgt1hdw7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_setscheduler() and rt_mutex_setprio() invoke the run-queue balance
callback after changing priorities or the scheduling class of a task. The
run-queue for which the callback is invoked can be local or remote.

That's not a problem for the regular rq::push_work which is serialized with
a busy flag in the run-queue struct, but for the balance_push() work which
is only valid to be invoked on the outgoing CPU that's wrong. It not only
triggers the debug warning, but also leaves the per CPU variable push_work
unprotected, which can result in double enqueues on the stop machine list.

Remove the warning and validate that the function is invoked on the
outgoing CPU.

Fixes: ae7927023243 ("sched: Optimize finish_lock_switch()")
Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
V2: Use the correct check for the outgoing CPU
---
 kernel/sched/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8435,7 +8435,6 @@ static void balance_push(struct rq *rq)
 	struct task_struct *push_task = rq->curr;
 
 	lockdep_assert_rq_held(rq);
-	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
 	/*
 	 * Ensure the thing is persistent until balance_push_set(.on = false);
@@ -8443,9 +8442,10 @@ static void balance_push(struct rq *rq)
 	rq->balance_callback = &balance_push_callback;
 
 	/*
-	 * Only active while going offline.
+	 * Only active while going offline and when invoked on the outgoing
+	 * CPU.
 	 */
-	if (!cpu_dying(rq->cpu))
+	if (!cpu_dying(rq->cpu) || rq != this_rq())
 		return;
 
 	/*
