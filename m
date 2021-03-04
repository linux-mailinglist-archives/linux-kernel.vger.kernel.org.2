Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BDD32C916
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353367AbhCDBDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:03:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388610AbhCDAZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:25:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0297A64E6C;
        Thu,  4 Mar 2021 00:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817394;
        bh=OT84WHTEVokTFBZt6hb+mqM/4v/N/t9Kb7CDDaI0o4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WdcMJL3XAbcGsRiBOYLxSvj3cbJeHgYXBXdexGTaIWBaGj3Zeui1td/uLJvdNK3ls
         P0uQlPM7Gi42nJWTwGvQfnjFK9TTzO9M4/NAtkxKyFiUsYIFzvP19Ob2TZGSu5on2z
         Q26gqp4x+nxrqOqajOYVKt9f6enh1RmO3ZpAH/YAAbZG4IqAElpK9OZmP8Py1RCcz9
         HzMYwSZ68z4zk8MzQUh+kzPr+qCMF38tGVztPdmBsfUTAa2MRJ5E6s1buEpp8F+cax
         6pNz5pXCsE9R8Ya+G+sWR/d0YokVQ8FS12mp+nbCAMeFa+4/t2Sh21qqX91U0sRcLO
         UiWQq0pdjxGdw==
From:   paulmck@kernel.org
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
Subject: [PATCH tip/core/rcu 05/12] rcu/nocb: Avoid confusing double write of rdp->nocb_cb_sleep
Date:   Wed,  3 Mar 2021 16:23:04 -0800
Message-Id: <20210304002311.23655-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002225.GA23492@paulmck-ThinkPad-P72>
References: <20210304002225.GA23492@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frederic Weisbecker <frederic@kernel.org>

The nocb_cb_wait() function first sets the rdp->nocb_cb_sleep flag to
true by after invoking the callbacks, and then sets it back to false if
it finds more callbacks that are ready to invoke.

This is confusing and will become unsafe if this flag is ever read
locklessly.  This commit therefore writes it only once, based on the
state after both callback invocation and checking.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9fd8588..6a7f77d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2230,6 +2230,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	unsigned long flags;
 	bool needwake_state = false;
 	bool needwake_gp = false;
+	bool can_sleep = true;
 	struct rcu_node *rnp = rdp->mynode;
 
 	local_irq_save(flags);
@@ -2253,8 +2254,6 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
 
-	WRITE_ONCE(rdp->nocb_cb_sleep, true);
-
 	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
 		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB)) {
 			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_CB);
@@ -2262,7 +2261,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 				needwake_state = true;
 		}
 		if (rcu_segcblist_ready_cbs(cblist))
-			WRITE_ONCE(rdp->nocb_cb_sleep, false);
+			can_sleep = false;
 	} else {
 		/*
 		 * De-offloading. Clear our flag and notify the de-offload worker.
@@ -2275,6 +2274,8 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 			needwake_state = true;
 	}
 
+	WRITE_ONCE(rdp->nocb_cb_sleep, can_sleep);
+
 	if (rdp->nocb_cb_sleep)
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("CBSleep"));
 
-- 
2.9.5

