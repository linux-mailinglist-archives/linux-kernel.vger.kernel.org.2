Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22BAE37ECD5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384537AbhELUB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355649AbhELS26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86A5761419;
        Wed, 12 May 2021 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620844069;
        bh=Y6MaGrrbx1rhQ0TtyMb37eg0EUKdFwJ4AMTQbQ3ZCZM=;
        h=From:To:Cc:Subject:Date:From;
        b=I+m1wK8+J9IlHhbamFUZeDQ6twbyVj3+3LcPW5hl7Bxbx9jz+stpuRd7pEJvhxCln
         /2XgVslCwp+63ariot8BVS665JOBp3SfT1xpOiaD2GqsJY0u/SYszMmz6k67813N1d
         I2v5QkRCkhfON6GFCAmIt1pDwEXfA+1HUFugXhh/JYwvgPq+PyO9J67Qrvr2pCHv4K
         s1SGEwSC1lfXHmEaTKPIkjI3OSIFDiUpCTN1/FDow5oB1hLJyjFL07uf/CTcdQQ3M6
         iC/C9oPmkqfqr2wDlyUpBXGzNOWbyLFEkqlN4v6Jn3oS2VZ5EZ8TofLGqrHk6pSZ4v
         pCodDU+PO/2LA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 02BEC5C004A; Wed, 12 May 2021 11:27:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 1/4] rcu-tasks: Add block comment laying out RCU Tasks design
Date:   Wed, 12 May 2021 11:27:44 -0700
Message-Id: <20210512182747.3445812-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a block comment that gives a high-level overview of how
RCU tasks grace periods progress.  It also adds a note about how exiting
tasks are handled, plus it gives an overview of the memory ordering.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 350ebf5051f9..94d2c2c7f0ab 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -377,6 +377,46 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 // Finally, this implementation does not support high call_rcu_tasks()
 // rates from multiple CPUs.  If this is required, per-CPU callback lists
 // will be needed.
+//
+// The implementation uses rcu_tasks_wait_gp(), which relies on function
+// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_kthread()
+// function sets these function pointers up so that rcu_tasks_wait_gp()
+// invokes these functions in this order:
+//
+// rcu_tasks_pregp_step():
+//	Invokes synchronize_rcu() in order to wait for all in-flight
+//	t->on_rq and t->nvcsw transitions to complete.	This works because
+//	all such transitions are carried out with interrupts disabled.
+// rcu_tasks_pertask(), invoked on every non-idle task:
+//	For every runnable non-idle task other than the current one, use
+//	get_task_struct() to pin down that task, snapshot that task's
+//	number of voluntary context switches, and add that task to the
+//	holdout list.
+// rcu_tasks_postscan():
+//	Invoke synchronize_srcu() to ensure that all tasks that were
+//	in the process of exiting (and which thus might not know to
+//	synchronize with this RCU Tasks grace period) have completed
+//	exiting.
+// check_all_holdout_tasks(), repeatedly until holdout list is empty:
+//	Scans the holdout list, attempting to identify a quiescent state
+//	for each task on the list.  If there is a quiescent state, the
+//	corresponding task is removed from the holdout list.
+// rcu_tasks_postgp():
+//	Invokes synchronize_rcu() in order to ensure that all prior
+//	t->on_rq and t->nvcsw transitions are seen by all CPUs and tasks
+//	to have happened before the end of this RCU Tasks grace period.
+//	Again, this works because all such transitions are carried out
+//	with interrupts disabled.
+//
+// For each exiting task, the exit_tasks_rcu_start() and
+// exit_tasks_rcu_finish() functions begin and end, respectively, the SRCU
+// read-side critical sections waited for by rcu_tasks_postscan().
+//
+// Pre-grace-period update-side code is ordered before the grace via the
+// ->cbs_lock and the smp_mb__after_spinlock().  Pre-grace-period read-side
+// code is ordered before the grace period via synchronize_rcu() call
+// in rcu_tasks_pregp_step() and by the scheduler's locks and interrupt
+// disabling.
 
 /* Pre-grace-period preparation. */
 static void rcu_tasks_pregp_step(void)
-- 
2.31.1.189.g2e36527f23

