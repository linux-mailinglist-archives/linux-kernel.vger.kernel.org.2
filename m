Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D94132C91D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356442AbhCDBEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:54698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1450997AbhCDAak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:30:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6948964EBA;
        Thu,  4 Mar 2021 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614817797;
        bh=hdLIi/GxehNgqRlNQtgUDCSTsM8C6t45OhCRDD7Yshc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QNTofXqaqHClq6atqGh9Iad4PTUBU4dIj7Q0ADZo5xSnfjuGBTkHWkfVC/desEt6/
         1dLmo/jGVuD6OHMNdnB2PbKvl8X6bj4Bje0u4kX2cxOoaGtjqBF9i0TPxCWkKy8Dxq
         L7ULgq3nWk6OkJqBdIzbllvLy5YntuAhAYXuEdJZXdKhXwNGDhoag2QeFp7qAHp6Ue
         q4DPTgXcv6ky5PkgGcXKeJT6C7ixN24Wld1zVQB7gi3tjDKPmNGxpA0/oL9/uBChbH
         h9xMTWfqYTZXqz9VMJ07+AXSzZ4yA+wf4IDJrotZVMSNy3PtaOpUxKxvj4ZkTD66yr
         KfmdbmLSF/7SA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 4/5] rcu: Make rcu_read_unlock_special() expedite strict grace periods
Date:   Wed,  3 Mar 2021 16:29:54 -0800
Message-Id: <20210304002955.24132-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304002919.GA24003@paulmck-ThinkPad-P72>
References: <20210304002919.GA24003@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

In kernels built with CONFIG_RCU_STRICT_GRACE_PERIOD=y, every grace
period is an expedited grace period.  However, rcu_read_unlock_special()
does not treat them that way, instead allowing the deferred quiescent
state to be reported whenever.  This commit therefore adds a check of
this Kconfig option that causes rcu_read_unlock_special() to treat all
grace periods as expedited for CONFIG_RCU_STRICT_GRACE_PERIOD=y kernels.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e17cb23..a21c41c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -615,6 +615,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 
 		expboost = (t->rcu_blocked_node && READ_ONCE(t->rcu_blocked_node->exp_tasks)) ||
 			   (rdp->grpmask & READ_ONCE(rnp->expmask)) ||
+			   IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ||
 			   (IS_ENABLED(CONFIG_RCU_BOOST) && irqs_were_disabled &&
 			    t->rcu_blocked_node);
 		// Need to defer quiescent state until everything is enabled.
-- 
2.9.5

