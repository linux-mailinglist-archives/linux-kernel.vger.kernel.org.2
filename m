Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA9C432B11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhJSALN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:11:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJSALE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:11:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACFA46128E;
        Tue, 19 Oct 2021 00:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602132;
        bh=Ji/8gjgKN+3NcCOkQUwlMtnEJ/UpEiJ60y0Oq/k0Cgs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3+WI1otBM0gmEfRGelVt+DdxRr5oyRaquyb4pJOA9bw5bVbCMjUtbAsxxSjUFSdq
         VtmwAd/J+RFFGnLVaFRiZrmYmnIEYz+hYqVIDAebt2/dbLOttFFOic0LcEkjR6uXSZ
         fBqudI9EfUZ8kV4SJQ12jQEcDUNDuATvhoOQCSkWLdX96zz+Y9YABDBPclC7XLbbzH
         T8RVCARQLF10e1fmhcJXcCTEdfAc5ul5WWFXr56l9DQVZW9svlvu/dUp4rfGa5xNA2
         quxppHLK+7dK9HSkvtXiTE7dYKFEK2G5ByRLi7yFikgL5zr4uwPW1qZbR2VvyYUhO0
         fJOktU6EwXT/A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 10/10] rcu/nocb: Don't invoke local rcu core on callback overload from nocb kthread
Date:   Tue, 19 Oct 2021 02:08:16 +0200
Message-Id: <20211019000816.455375-11-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rcu_core() tries to ensure that its self-invocation in case of callbacks
overload only happen in softirq/rcuc mode. Indeed it doesn't make sense
to trigger local RCU core from nocb_cb kthread since it can execute
on a CPU different from the target rdp. Also in case of overload, the
nocb_cb kthread simply iterates a new loop of callbacks processing.

However the "offloaded" check that aims at preventing misplaced
rcu_core() invocations is wrong. First of all that state is volatile
and second: softirq/rcuc can execute while the target rdp is offloaded.
As a result rcu_core() can be invoked on the wrong CPU while in the
process of (de-)offloading.

Fix that with moving the rcu_core() self-invocation to rcu_core() itself,
irrespective of the rdp offloaded state.

Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0ca4f4ec724d..8270e58cd0f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2470,7 +2470,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	int div;
 	bool __maybe_unused empty;
 	unsigned long flags;
-	const bool offloaded = rcu_rdp_is_offloaded(rdp);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count = 0;
@@ -2592,9 +2591,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	/* Re-invoke RCU core processing if there are callbacks remaining. */
-	if (!offloaded && rcu_segcblist_ready_cbs(&rdp->cblist))
-		invoke_rcu_core();
 	tick_dep_clear_task(current, TICK_DEP_BIT_RCU);
 }
 
@@ -2781,8 +2777,12 @@ static __latent_entropy void rcu_core(void)
 
 	/* If there are callbacks ready, invoke them. */
 	if (do_batch && rcu_segcblist_ready_cbs(&rdp->cblist) &&
-	    likely(READ_ONCE(rcu_scheduler_fully_active)))
+	    likely(READ_ONCE(rcu_scheduler_fully_active))) {
 		rcu_do_batch(rdp);
+		/* Re-invoke RCU core processing if there are callbacks remaining. */
+		if (rcu_segcblist_ready_cbs(&rdp->cblist))
+			invoke_rcu_core();
+	}
 
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
-- 
2.25.1

