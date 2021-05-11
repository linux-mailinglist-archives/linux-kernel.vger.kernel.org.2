Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2846637B1EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 00:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEKWyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 18:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhEKWyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 18:54:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B6FF61958;
        Tue, 11 May 2021 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620773587;
        bh=EotQ6cg7YP76P2IiUcgViwV/juVh+1b5V3AQ01poaqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjVhl1SYcF/nSFYdhPCGq2qvIXT/fxMkEvg7YDg5Rjqv2t8dV7M7zhdXZZD0+5PQl
         dJjBqeX5Jcdgi2wDdGQLBQCvWMY/r31gZOwP2UL7348Yax0fbGF6m5MjzK92x46BKE
         KLXZdMHcIc9x212F6/w0JsFeoaQHqQx18m2mLrgO6WNR5hsZtvUg64DSl/3xIoZXh5
         wylgTxbyHJ5oUWfxhg/ZzY3VpehLuDcXiOofvtkj3nQIjj0ZNXcv31qj3y9kgTvWvG
         8Ig2/c9cV8jLiFtUWzUM1ULfQzr0K4QjIbuCUGhC4/7TOd4dQ+5r0FTBwxfkuUsHkU
         MyZyBd+5SE/Nw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9D2D5C0E5C; Tue, 11 May 2021 15:53:06 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Jules Irenge <jbi.octave@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/19] rcu: Add missing __releases() annotation
Date:   Tue, 11 May 2021 15:53:04 -0700
Message-Id: <20210511225304.2893154-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
References: <20210511225241.GA2893003@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jules Irenge <jbi.octave@gmail.com>

Sparse reports a warning at rcu_print_task_stall():

"warning: context imbalance in rcu_print_task_stall - unexpected unlock"

The root cause is a missing annotation on rcu_print_task_stall().

This commit therefore adds the missing __releases(rnp->lock) annotation.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e6bd518e0bc4..ffb8cf6c6437 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -314,6 +314,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  * tasks blocked within RCU read-side critical sections.
  */
 static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
+	__releases(rnp->lock)
 {
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	return 0;
-- 
2.31.1.189.g2e36527f23

