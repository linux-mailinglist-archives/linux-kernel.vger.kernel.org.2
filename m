Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E053F9AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241260AbhH0OIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:08:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38472 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbhH0OIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:08:21 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630073251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=11NIC+pr+SwPLcFh+rYzsUwGFwRQn2PPhhrNnoAS/Hk=;
        b=FA/a8YDH9ZywgSQADqEWqAEC32qDJ1g3ObowrKmhnXpy8W5EgZverx9AHMuh6mqfBVNY0T
        yg1Pkb2cs3XZrm74KScyzZ83FA5loJXDF3SZ/xA6tYcgAzqZbP9pw/9qFleloyVOy2Fj9+
        H1FWQn8pE9MNgDVmlTEZvdWz2mnlGSKcVUf1twKlL2Bkv9rZkF3JuI/MDJt0YOsFLfj9g9
        N4tRP5es7MbdSGKOaECjvlauK1625y6SYmo33khDkE+IaMsVQH9YtqD41tB5pGwezcv5su
        a/B5X6xCNGSso2BVN62Tdq+NWiIq2TUQuFZbTyeSHODD9tZ/8YPEYL9Dqx29yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630073251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=11NIC+pr+SwPLcFh+rYzsUwGFwRQn2PPhhrNnoAS/Hk=;
        b=Tt7ESV8hwG8E9hl9zdPAzSx+ERfKFDb5RXSUMYOtUjiqVNI00gNOJWevWju1hENZfxXES+
        UwFnUzefUSnm21Bw==
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
Subject: [PATCH] sched: Prevent balance_push() on remote runqueues
Date:   Fri, 27 Aug 2021 16:07:30 +0200
Message-ID: <87tujb0yn1.ffs@tglx>
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

Remove the warning and check that the function is invoked on the
outgoing CPU. If not, just return and do nothing.

Fixes: ae7927023243 ("sched: Optimize finish_lock_switch()")
Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
---
 kernel/sched/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8523,7 +8523,6 @@ static void balance_push(struct rq *rq)
 	struct task_struct *push_task = rq->curr;
 
 	lockdep_assert_rq_held(rq);
-	SCHED_WARN_ON(rq->cpu != smp_processor_id());
 
 	/*
 	 * Ensure the thing is persistent until balance_push_set(.on = false);
@@ -8531,9 +8530,10 @@ static void balance_push(struct rq *rq)
 	rq->balance_callback = &balance_push_callback;
 
 	/*
-	 * Only active while going offline.
+	 * Only active while going offline and when invoked on the outgoing
+	 * CPU.
 	 */
-	if (!cpu_dying(rq->cpu))
+	if (!cpu_dying(rq->cpu) && rq == this_rq())
 		return;
 
 	/*
