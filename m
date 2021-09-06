Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 309CC401A96
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 13:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhIFLbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 07:31:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbhIFLbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 07:31:41 -0400
Date:   Mon, 6 Sep 2021 13:30:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630927836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZBR5f7NFUsEsljhaHWFAtG/p9HBHdnHvTkMUd2Dyw34=;
        b=hbcvLOMgSybY4HzWHUw7fxJ+YV3Nggt5lyjGPRatRzY6tZuBrI+hPtE0agwI4v2IdhkDWc
        yaqHILLv4y9GG9wrq1fTAaMhSnnlm092t3qs3vwkSv5ueg5MMcOPyAw+97YFUEucE1MmU6
        JAcY4tOsSE4pDIzyN5stVl+iWBk4Xv9XEi6vTYZqIc6qxOyR8aawRhP051vW6/4arqz4rg
        yMsp2rHL4tMVug/n2G1lOjEFc2F/sRFMq/SPwuNW7n+DgiTZPv8VRrQ7LzHiotjIAOap8s
        TUhPace4/2K+b72TVTOkgUb+A3ayCAnqrOoXDuOBYDyC+OAONlhPDrL8dSuNZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630927836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZBR5f7NFUsEsljhaHWFAtG/p9HBHdnHvTkMUd2Dyw34=;
        b=xEZAwaQmjhLi0Zt6An4OsMA4jGm5XZvClYGfsrXr0HC1IO+310Bxs7jouLbhK5uRDMj2ue
        Cyv0yefgzp6+6KBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched: Make the idle timer expire always in hardirq context.
Message-ID: <20210906113034.jgfxrjdvxnjqgtmc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel powerclamp driver will setup a per-CPU worker with RT
priority. The worker will then invoke play_idle() in which it remains in
the idle poll loop until it is stopped by the timer it started earlier.

That timer needs to expire in hardirq context on PREEMPT_RT. Otherwise
the timer will expire in ksoftirqd as a SOFT timer but that task won't
be scheduled on the CPU because its priority is lower than the priority
of the worker which is in the idle loop.

Always expire the idle timer in hardirq context.

Fixes:c1de45ca831ac ("sched/idle: Add support for tasks that inject idle")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/idle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 912b47aa99d82..d17b0a5ce6ac3 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -379,10 +379,10 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 	cpuidle_use_deepest_state(latency_ns);
 
 	it.done = 0;
-	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_init_on_stack(&it.timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	it.timer.function = idle_inject_timer_fn;
 	hrtimer_start(&it.timer, ns_to_ktime(duration_ns),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 
 	while (!READ_ONCE(it.done))
 		do_idle();
-- 
2.33.0

