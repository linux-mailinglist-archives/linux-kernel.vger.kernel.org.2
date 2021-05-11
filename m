Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E75137B21C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhEKXE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230035AbhEKXEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:04:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D73A061937;
        Tue, 11 May 2021 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774218;
        bh=+duX/kCZVYrWk4w0f3LNTFdWTV55VP0msoEAr187hu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LeHkyo5au6RE3Bm+Bpn2K5n3trchr+GkD/fwYmqu0A73Tu9L4RXpnV2TM+hqoADjG
         fqlUaXYMR47W6IFSZK76KUg99OJ5TxlwsWTXd7lX1Bx/jfMJYW08jaHJY6YSQSDSCP
         hMUQODQo5gGFnLq8r3rq3eI7EtodNOpnNq+fjL5/L5eEkI6cNB9V5QOKHCSdrpE4oC
         0Et3FJSPifTeXfd4rhdNR6q8n1myGje806I0+foBoSDm2nQaTuAW1J18BjQu3Z3FN4
         3vuhVzcplweP1hgsdXjd+SCGEjt3TLBzIDoQzDlGkBbaWPKp0uJSPh5n2vJQ4KnbPH
         GewqvxUlWvFhQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 650815C0DD7; Tue, 11 May 2021 16:03:38 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 07/10] rcu/nocb: Only cancel nocb timer if not polling
Date:   Tue, 11 May 2021 16:03:33 -0700
Message-Id: <20210511230336.2894314-7-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
References: <20210511230244.GA2894061@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

This commit refrains deleting the ->nocb_timer if rcu_nocb is polling
because it should not ever have been queued in the polling case.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 4253a0ecc14f..db28e3123f32 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2176,18 +2176,18 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
 	if (bypass) {
-		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
-		// Avoid race with first bypass CB.
-		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
-			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
-			del_timer(&my_rdp->nocb_timer);
-		}
 		if (!rcu_nocb_poll) {
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			// Avoid race with first bypass CB.
+			if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
+				WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
+				del_timer(&my_rdp->nocb_timer);
+			}
 			// At least one child with non-empty ->nocb_bypass, so set
 			// timer in order to avoid stranding its callbacks.
 			mod_timer(&my_rdp->nocb_bypass_timer, j + 2);
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 		}
-		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
 	}
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
-- 
2.31.1.189.g2e36527f23

