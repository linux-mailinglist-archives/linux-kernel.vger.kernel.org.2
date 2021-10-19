Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFBE432B0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhJSALF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234164AbhJSAK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDF4B61351;
        Tue, 19 Oct 2021 00:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602126;
        bh=WhCvt9ECScR3wQI5K3wV2HJmM7u8a886+8u/I8Fa6eo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pBT9coqAHnLAGKfeuPv7PlD/xb3pzvLSFX465RwILjRbzC/sjpoYbgFeGfXBC0Xkh
         UGV+Roo8Vt8fG4a//Nz17ra0vXu4hhVNoL0THc4YhlWb0xhRZcAulOvNYCCM+l+obj
         EpfHEyl1DPOExryvDksNyueORc5TPR81tHmzBVG72vP5awhbas+n6QFO/OweIeQN3q
         PDfytm2uzNWkC/u390liEKSsj9ZTqD+nxbIIUz13Ggzc572fODEfDLA3JLjNSuDVKO
         Ro1yxllLxjIebavkYPXkjFx5buS3gofXL/+6CWkfIod7/aW67VenvfXTuDYa5/m3X0
         LIxPVB4uwcqDw==
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
Subject: [PATCH 08/10] rcu: Fix callbacks processing time limit retaining cond_resched()
Date:   Tue, 19 Oct 2021 02:08:14 +0200
Message-Id: <20211019000816.455375-9-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callbacks processing time limit makes sure we are not exceeding a
given amount of time executing the queue.

However its "continue" clause bypasses the cond_resched() call on
rcuc and NOCB kthreads, delaying it until we reach the limit, which can
be very long...

Make sure the scheduler has a higher priority than the time limit.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
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
 kernel/rcu/tree.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 716dead1509d..7a655d93a28a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2535,9 +2535,21 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 */
-		if (count >= bl && in_serving_softirq() &&
-		    (need_resched() || !is_idle_task(current)))
-			break;
+		if (in_serving_softirq()) {
+			if (count >= bl && (need_resched() || !is_idle_task(current)))
+				break;
+		} else {
+			local_bh_enable();
+			lockdep_assert_irqs_enabled();
+			cond_resched_tasks_rcu_qs();
+			lockdep_assert_irqs_enabled();
+			local_bh_disable();
+		}
+
+		/*
+		 * Make sure we don't spend too much time here and deprive other
+		 * softirq vectors of CPU cycles.
+		 */
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
 			if (likely((count & 31) || local_clock() < tlimit))
@@ -2545,13 +2557,6 @@ static void rcu_do_batch(struct rcu_data *rdp)
 			/* Exceeded the time limit, so leave. */
 			break;
 		}
-		if (!in_serving_softirq()) {
-			local_bh_enable();
-			lockdep_assert_irqs_enabled();
-			cond_resched_tasks_rcu_qs();
-			lockdep_assert_irqs_enabled();
-			local_bh_disable();
-		}
 	}
 
 	rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.25.1

