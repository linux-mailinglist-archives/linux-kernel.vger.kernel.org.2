Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06396432B0E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 02:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbhJSALD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 20:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234062AbhJSAKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 20:10:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA79061212;
        Tue, 19 Oct 2021 00:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634602123;
        bh=sUUGaUTk5ruH9etDXT1HfPBC2ZcrmtWMTcP1SOw19VA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eKEMLWFbmqn9mZlCe32m3RCzjeySoaez3foI6CbiYTR7wHNlG3E1pwhDwo9QPH89s
         TmJwuDkCb9gOf9gP9GinEA3+cjkqHNHtF+k2YOg4f8QCI7cFI9FDF5CnJezg+W59B+
         ShLRpIsfN3t9HSWS9cKuObbQlclXrj+MoGiJREfcduVLe+kX6fLt4qh9e/eQHzq3az
         SaRwLsKDI4lAvLhdNmzhOs73RV8iAzahcDJKpwqOVSmgaBkI+SqgGIYhKlKwy8cYZW
         xAXomc1fD0qD9BPrNlytzvpI3n2sQfuE9zQj2bNb8U4ivTrol7gZFb4057JOzOdW9H
         HGF+bPSFtAj/A==
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
Subject: [PATCH 07/10] rcu/nocb: Limit number of softirq callbacks only on softirq
Date:   Tue, 19 Oct 2021 02:08:13 +0200
Message-Id: <20211019000816.455375-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019000816.455375-1-frederic@kernel.org>
References: <20211019000816.455375-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current condition to limit the number of callbacks executed in a
row checks the offloaded state of the rdp. Not only is it volatile
but it is also misleading: the rcu_core() may well be executing
callbacks concurrently with NOCB kthreads, and the offloaded state
would then be verified on both cases. As a result the limit would
spuriously not apply anymore on softirq while in the middle of
(de-)offloading process.

Fix and clarify the condition with those constraints in mind:

_ If callbacks are processed either by rcuc or NOCB kthread, the call
  to cond_resched_tasks_rcu_qs() is enough to take care of the overload.

_ If instead callbacks are processed by softirqs:
  * If need_resched(), exit the callbacks processing
  * Otherwise if CPU is idle we can continue
  * Otherwise exit because a softirq shouldn't interrupt a task for too
    long nor deprive other pending softirq vectors of the CPU.

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
 kernel/rcu/tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eaa9c7ce91bb..716dead1509d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2535,9 +2535,8 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		/*
 		 * Stop only if limit reached and CPU has something to do.
 		 */
-		if (count >= bl && !offloaded &&
-		    (need_resched() ||
-		     (!is_idle_task(current) && !rcu_is_callbacks_kthread())))
+		if (count >= bl && in_serving_softirq() &&
+		    (need_resched() || !is_idle_task(current)))
 			break;
 		if (unlikely(tlimit)) {
 			/* only call local_clock() every 32 callbacks */
-- 
2.25.1

