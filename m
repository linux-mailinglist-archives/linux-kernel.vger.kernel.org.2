Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A69241AEF1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240775AbhI1M00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:26:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240652AbhI1M0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:26:10 -0400
Message-ID: <20210928122411.593486363@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632831870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=giXfEJB7VPGDd7nVML7lYRyh9lgBEYYdNV16AYd75/I=;
        b=oImR+2xEG2umK+JOVGwyho4ibCNF9vy9DHYTDc9LPKgO1FbBXrYW87sdVPh5WcyNsRf016
        z4EsbwomIIxDRRqrVCYc1eQLNuuJm1WJPQUSM0c/g/JbKizSAwdiLYKoDD9+7wfg5wZC5r
        uOdCIjSja3dmHthRfyH5piorjWLIWjNG43uumm0RdryliHd9xFjA77tjFytEs64DSxYFVc
        qcmXxYPHZgHFsya+7gswM9TmXBrXokkDiNfJtmk1d9fvRUS63EmTWEvIrpR/CchFNugTbY
        6R/waH7L89uvTx6eNUsrGgRG6TEx9/nDk+EyYR2fNXcReh9Lk+lixjaCIbfSJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632831870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=giXfEJB7VPGDd7nVML7lYRyh9lgBEYYdNV16AYd75/I=;
        b=MYrjjal9jUYLWtfUVJhzqb3D5GKBPThOfzUu2mABWGLoCUVG7TTOURlyQew0v7X9WVKwLM
        ZlxzksKDFgIV4GCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [patch 4/5] sched: Delay task stack freeing on RT
References: <20210928122339.502270600@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Sep 2021 14:24:30 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Anything which is done on behalf of a dead task at the end of
finish_task_switch() is preventing the incoming task from doing useful
work. While it is benefitial for fork heavy workloads to recycle the task
stack quickly, this is a latency source for real-time tasks.

Therefore delay the stack cleanup on RT enabled kernels.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/exit.c       |    5 +++++
 kernel/fork.c       |    5 ++++-
 kernel/sched/core.c |    8 ++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -172,6 +172,11 @@ static void delayed_put_task_struct(stru
 	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
+
+	/* RT enabled kernels delay freeing the VMAP'ed task stack */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		put_task_stack(tsk);
+
 	put_task_struct(tsk);
 }
 
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -289,7 +289,10 @@ static inline void free_thread_stack(str
 			return;
 		}
 
-		vfree_atomic(tsk->stack);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			vfree_atomic(tsk->stack);
+		else
+			vfree(tsk->stack);
 		return;
 	}
 #endif
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4846,8 +4846,12 @@ static struct rq *finish_task_switch(str
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
-		/* Task is done with its stack. */
-		put_task_stack(prev);
+		/*
+		 * Release VMAP'ed task stack immediate for reuse. On RT
+		 * enabled kernels this is delayed for latency reasons.
+		 */
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			put_task_stack(prev);
 
 		put_task_struct_rcu_user(prev);
 	}

