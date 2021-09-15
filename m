Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5838D40D032
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbhIOXfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 19:35:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231233AbhIOXfE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 19:35:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F33316113E;
        Wed, 15 Sep 2021 23:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631748825;
        bh=k7yNQkcydFuuP5qSmMadxFfLeKBvp9arjKxIIdfS/uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JLsxPmqMtnp0WLRryaq9XpJB9fzVxSwockzBxaOGb/imfnXPYkfLpdM6m07DzlTmf
         1OKU3kVZ5W9JzmoX/TRmHf1UCFMUPvLybZoBClkvvysT73c14eLggPU+sqyVhUeO64
         +JVWavr32uQLgIxOSC8fkTsXu6MQrmeislGtdKNd0oMRr+5OrRc5+KFLY/aSw3qqYl
         XVMEqPWWNp9/aHBkpPoOH3le7z5Bb7dVVgxnhag2z/iTB5RMcEm9cq2h1Gqdr61CDQ
         UuD5QAR94mdzymV1PNB5pTdVJ9jvUhdfTQLLfx2KPa38x+CBDAoL89b7TbW78HMZwE
         j8J+TNHiizj9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BD5AB5C06B9; Wed, 15 Sep 2021 16:33:44 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/14] rcu-nocb: Fix a couple of tree_nocb code-style nits
Date:   Wed, 15 Sep 2021 16:33:31 -0700
Message-Id: <20210915233343.3906738-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes a non-value-returning "return" statement at the end
of __call_rcu_nocb_wake() and adds a blank line following declarations
in nocb_cb_can_run().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_nocb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 8fdf44f8523f..368ef7b9af4f 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -549,7 +549,6 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("WakeNot"));
 	}
-	return;
 }
 
 /*
@@ -767,6 +766,7 @@ static int rcu_nocb_gp_kthread(void *arg)
 static inline bool nocb_cb_can_run(struct rcu_data *rdp)
 {
 	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_CB;
+
 	return rcu_segcblist_test_flags(&rdp->cblist, flags);
 }
 
-- 
2.31.1.189.g2e36527f23

