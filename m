Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB43137B1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhEKW4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:56:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhEKW4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:56:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7299761606;
        Tue, 11 May 2021 22:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773718;
        bh=Oy59l9RHsVlDTjqMz7OJ6JbrcibwxWsdKR9GQ/YUkgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faATVf7awwu8b//WhDG1+WovcruzADS3F72PlRNEibQ58r2J3a2pqUCA2WkpgUxpq
         OWBooygeLAmAUaULBOAnPEnPhSYFiG5ZJCYTFOfyaWRMldqUWSL/0nv/xpUaY6fweT
         3lw5VCUqR1hHmdLs4iR5Rveff3j9tFTuXLNLWY1ARJV2xcVeClm8FCOC9H1ksE29pd
         x/kfn4hwrYFDHSj/+P1wm8s/NWfRVBp7KqpXPrwDMACXZ/LkE7vMTC0HqLq/8zJxZA
         zMMd9IMf4rGaXu+UNb4HcFVZ5MWwauwV3wP8ibyCMhvL6HIS9tOP238PKp9686mJyF
         rsWjkhxR/qgpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 0AA775C09EF; Tue, 11 May 2021 15:55:18 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/7] kvfree_rcu: Add a bulk-list check when a scheduler is run
Date:   Tue, 11 May 2021 15:55:12 -0700
Message-Id: <20210511225516.2893420-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225450.GA2893337@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

The rcu_scheduler_active flag is set to RCU_SCHEDULER_RUNNING once the
scheduler is up and running.  That signal is used in order to check
and queue a "monitor work" to reclaim freed objects (if there are any)
during early boot.  This flag is used by kvfree_rcu() to determine when
work can safely be queued, at which point memory passed to earlier
invocations of kvfree_rcu() can be processed.

However, only "krcp->head" is checked for objects that need to be
released, and there are now two more, namely, "krcp->bkvhead[0]" and
"krcp->bkvhead[1]".  Therefore, check these two additional channels.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 676a49ab5b2b..e86f32d6b8f9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3739,7 +3739,8 @@ void __init kfree_rcu_scheduler_running(void)
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
 
 		raw_spin_lock_irqsave(&krcp->lock, flags);
-		if (!krcp->head || krcp->monitor_todo) {
+		if ((!krcp->bkvhead[0] && !krcp->bkvhead[1] && !krcp->head) ||
+				krcp->monitor_todo) {
 			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 			continue;
 		}
-- 
2.31.1.189.g2e36527f23

