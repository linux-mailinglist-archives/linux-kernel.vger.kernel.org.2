Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F35F332C477
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352174AbhCDAOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:14:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240141AbhCDABC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:01:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3631E64FBE;
        Thu,  4 Mar 2021 00:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614816021;
        bh=uz/R6PrP7HbrdTlpi/oHylBT+DoTNag425UGx/sRHiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f3bkO+fupR4qsehxQ3icX6zz1tJbC/QLYBEe2i2klaWGKonF0EnBmJGG0/6MAgJPh
         WuMM5RTunmke+PYuxiM9UA9JcOFBgpiSLGrthKkpqoDlwz+VhaDeYtieFsTBNcM83O
         ZkYaqtQW3zM1eEt8avuoLqCWuAV46wh9pErF0Bl93tW12c5X3ZWFS6Jnqb4XEF1fsE
         GdAJXb1NV3VVWlcMJdqx/baL6tyhVv/K6Lf3PLPt7uXyPfVcxpY8MB5Y7dvBGrnbWx
         rBtFxCVTT9jXydUFzfvbFl8Y5sEqZ47TAvJCnZf7gy5KAByIjoFmIJQJgRXrvnkOzL
         zgb/PXbKOJZgA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/10] rcu: Fix CPU-offline trace in rcutree_dying_cpu
Date:   Wed,  3 Mar 2021 16:00:11 -0800
Message-Id: <20210304000019.22459-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210303235958.GA22373@paulmck-ThinkPad-P72>
References: <20210303235958.GA22373@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

The condition in the trace_rcu_grace_period() in rcutree_dying_cpu() is
backwards, so that it uses the string "cpuofl" when the offline CPU is
blocking the current grace period and "cpuofl-bgp" otherwise.  Given that
the "-bgp" stands for "blocking grace period", this is at best misleading.
This commit therefore switches these strings in order to correctly trace
whether the outgoing cpu blocks the current grace period.

Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cdf091f..e62c2de 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2413,7 +2413,7 @@ int rcutree_dying_cpu(unsigned int cpu)
 
 	blkd = !!(rnp->qsmask & rdp->grpmask);
 	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
-			       blkd ? TPS("cpuofl") : TPS("cpuofl-bgp"));
+			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
 	return 0;
 }
 
-- 
2.9.5

