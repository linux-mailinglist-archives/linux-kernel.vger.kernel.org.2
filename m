Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD594432B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhJSAKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhJSAKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DFFC26134F;
        Tue, 19 Oct 2021 00:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602114;
        bh=SUELVCRP5ACiu9FTbVAeY3f2v6/npNMQ+AvNWYclvy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9nabvqHJCbOOvcWWrbmqGAMPK1KQ4wfw13n17Xm5auxYE7BKQsQjE0i/vqgLK85i
         rP7e3DdVxBjUUxpis/R91J8/9kFyr3yzqfrhIVSAy30/NXIxSICSYI/vgCANgzWr1F
         48sDhquNSBij+izw36MRedHoEbk0csT/L07HaJTF40fDutNovFw5TrOgKgGxkB0AQj
         ze2PQqQ2hIvkXV0RlRzyjI+CvHWrc/A0zD3Z/HV8xsGM7dJwk7Q94RgF0Mq1A3taDh
         BP4PKYhRrqsFRvNsj0MrlMj9MhT/6MRxiFbNKCEB+gZwL0HRnA98rR4oBxLw7fj0os
         1S/SCI0Rigz4w==
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
Subject: [PATCH 04/10] rcu/nocb: Make rcu_core() callbacks acceleration (de-)offloading safe
Date:   Tue, 19 Oct 2021 02:08:10 +0200
Message-Id: <20211019000816.455375-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When callbacks are offloaded, the NOCB kthreads handle the callbacks
progression on behalf of rcu_core().

However during the (de-)offloading process, the kthread may not be
entirely up to the task. As a result some callbacks grace period
sequence number may remain stale for a while because rcu_core() won't
take care of them either.

Fix this with forcing callbacks acceleration from rcu_core() as long
as the offloading process isn't complete.

Reported-and-tested-by: Valentin Schneider <valentin.schneider@arm.com>
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
 kernel/rcu/tree.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4869a6856bf1..a43924244000 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2288,6 +2288,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
+	bool needacc = false;
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2315,16 +2316,29 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
 		 *
-		 * NOCB kthreads have their own way to deal with that.
+		 * NOCB kthreads have their own way to deal with that...
 		 */
-		if (!rcu_rdp_is_offloaded(rdp))
+		if (!rcu_rdp_is_offloaded(rdp)) {
 			needwake = rcu_accelerate_cbs(rnp, rdp);
+		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
+			/*
+			 * ...but NOCB kthreads may miss or delay callbacks acceleration
+			 * if in the middle of a (de-)offloading process.
+			 */
+			needacc = true;
+		}
 
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
 		if (needwake)
 			rcu_gp_kthread_wake();
+
+		if (needacc) {
+			rcu_nocb_lock_irqsave(rdp, flags);
+			rcu_accelerate_cbs_unlocked(rnp, rdp);
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+		}
 	}
 }
 
-- 
2.25.1

