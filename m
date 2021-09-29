Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440B741C1B6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245083AbhI2JjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245070AbhI2JjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:39:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9408BC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:37:35 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632908253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B89tcA2zIRUY38M29xvDCozhHJ1KXo9Xns8L/CZPgPo=;
        b=AJaLgDEF+x/Oan8EDhS8+LxyufOs4g4u2wkXyIx/S8ZQ4Gh3vJ7UzCD6JoxnZlUWl/RGRf
        IhBKYYdATUBgz3ZWFCOBNaouGdvvnnucbgN7ttmHu17FqBvY754ETqJz2ut6KiL4gr6m/0
        UrWoGQcjU5A3fiak9ZlS2uHSARRhvDa2w3pFs/CAoDUfZR7301zQ/RbgtxDsmQ9MIiDugM
        M1/fq43iDFMiMjxMtrFvUE6WZNYMWbf5gS/JsNOwCwnT5AwD8076vyfej0Dgn5erveYY7q
        qmbZATY5Pscpf6LAC3ZPSvSsq5corQIdMH7gs7rtw7oxr9aCuO1EMUkF7ZijAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632908253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B89tcA2zIRUY38M29xvDCozhHJ1KXo9Xns8L/CZPgPo=;
        b=BzWzpf3f7t3kFOU9KaIRf/+RcLbSUZY25bz2BdcE8TnIuET/cQW0I2UfFqHI7agzkC1lfy
        rQNp5ReX6pfBKUCA==
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Oskolkov <posk@posk.io>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] sched: Remove pointless preemption disable in
 sched_submit_work()
In-Reply-To: <CAJhGHyBwVLpcWoizJaMvQUFhAO_rz4CBQ1=D8hZ2iAadruh7WQ@mail.gmail.com>
References: <87sfxoai2l.ffs@tglx>
 <CAJhGHyBwVLpcWoizJaMvQUFhAO_rz4CBQ1=D8hZ2iAadruh7WQ@mail.gmail.com>
Date:   Wed, 29 Sep 2021 11:37:32 +0200
Message-ID: <8735pnafj7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neither wq_worker_sleeping() nor io_wq_worker_sleeping() require to be invoked
with preemption disabled:

  - The worker flag checks operations only need to be serialized against
    the worker thread itself.

  - The accounting and worker pool operations are serialized with locks.

which means that disabling preemption has neither a reason nor a
value. Remove it and update the stale comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
V2: Update comment as pointed out by Lai
---
 kernel/sched/core.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6319,20 +6319,14 @@ static inline void sched_submit_work(str
 
 	task_flags = tsk->flags;
 	/*
-	 * If a worker went to sleep, notify and ask workqueue whether
-	 * it wants to wake up a task to maintain concurrency.
-	 * As this function is called inside the schedule() context,
-	 * we disable preemption to avoid it calling schedule() again
-	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
-	 * requires it.
+	 * If a worker goes to sleep, notify and ask workqueue whether it
+	 * wants to wake up a task to maintain concurrency.
 	 */
 	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		preempt_disable();
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
-		preempt_enable_no_resched();
 	}
 
 	if (tsk_is_pi_blocked(tsk))
