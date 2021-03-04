Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1821E32C4B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238137AbhCDARJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1388876AbhCDAMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80E7E64F8F;
        Thu,  4 Mar 2021 00:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816696;
        bh=HjxRefAVEDtyC572wZIVjBocbJ6bL5n78qbG5hVM5Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdnLj6LiEk2Yp76/L9kWWYD4WCC80LCMpXYEKR800AbB2x+GH4BAyoh5TmibJQAgd
         pQB1t+5PBQ0NVUphPbmoV9spaOPxhD5IAw477YYrBzFmVzFIMnQKdBQoKRnXAWBq54
         da2Uptrwzz0xjWU+HSRAzn5OIweqzoheUkcifPy77Jz9LifGXhPbtoSkUbN5E65iKd
         mGC7sV7ctK45u9E11J9oKKfsNK09sRtBM5bUq2VNmOob5IJb0y2sAxiqxRFKHv7POj
         wOA8vUo4poNTsgPE/P0nnGDGJTnM3gwTpbxv4nMp1qruDirNi4Y8eqH6pZ65rUqv5C
         Dzu9vasRmAb0Q==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/6] kvfree_rcu: Make krc_this_cpu_unlock() use raw_spin_unlock_irqrestore()
Date:   Wed,  3 Mar 2021 16:11:31 -0800
Message-Id: <20210304001134.22977-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304001044.GA22871@paulmck-ThinkPad-P72>
References: <20210304001044.GA22871@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The krc_this_cpu_unlock() function does a raw_spin_unlock() immediately
followed by a local_irq_restore().  This commit saves a line of code by
merging them into a raw_spin_unlock_irqrestore().  This transformation
also reduces scheduling latency because raw_spin_unlock_irqrestore()
responds immediately to a reschedule request.  In contrast,
local_irq_restore() does a scheduling-oblivious enabling of interrupts.

Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 08b5044..7ee83f3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3229,8 +3229,7 @@ krc_this_cpu_lock(unsigned long *flags)
 static inline void
 krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
 {
-	raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
 static inline struct kvfree_rcu_bulk_data *
-- 
2.9.5

