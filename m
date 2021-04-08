Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A989A358FDF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhDHWj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232834AbhDHWjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B7A361106;
        Thu,  8 Apr 2021 22:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921552;
        bh=/8lOvv02fbJoqAABTAzMdRSZlGS0NO/Q+ZmhS6o46SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nT27ewTW6Ph+2/gZtTNfaimWbfZnPLkF/BKwFATkdkPjBkyFzVaDUfnsL50cuSAoE
         FTEoNyPJw+XwFRB6GDfuFa62+Sm5oufWbqlWMvmhsZDcGZjqcorz8Vy7eur0esuLoG
         7j9Cs7Ga/Fd9ZADjEGj5h2J/a4xWtGEbCkrxm4NaY5mbxv3GjCiB453wH2QXVO53T3
         VPzmz78lAJAvFXOC1ipgX/1vt6qLPq9YhOO99vFkOVe3ejkslVmlt+3gHIGHpAOE10
         NatcRKvFtH4xhGYcmx+pd3SI7bD7r6Mq8Xj85IAQbpe6uErLCEm2zBL3BzP4XCwZHp
         s3+F7ov8ChylA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/5] srcu: Initialize SRCU after timers
Date:   Fri,  9 Apr 2021 00:38:59 +0200
Message-Id: <20210408223902.6405-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408223902.6405-1-frederic@kernel.org>
References: <20210408223902.6405-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once srcu_init() is called, the SRCU core is free to queue delayed
workqueues, which rely on timers. However init_timers() is called
several steps after rcu_init(). Any call_srcu() in-between would finish
its course inside a dangerously uninitialized timer core.

Make sure we stay in early SRCU mode until everything is well settled.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
---
 include/linux/srcu.h  | 6 ++++++
 init/main.c           | 2 ++
 kernel/rcu/rcu.h      | 6 ------
 kernel/rcu/srcutree.c | 5 +++++
 kernel/rcu/tiny.c     | 1 -
 kernel/rcu/tree.c     | 1 -
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index a0895bbf71ce..e6011a9975af 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -64,6 +64,12 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
+#ifdef CONFIG_SRCU
+void srcu_init(void);
+#else /* #ifdef CONFIG_SRCU */
+static inline void srcu_init(void) { }
+#endif /* #else #ifdef CONFIG_SRCU */
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
diff --git a/init/main.c b/init/main.c
index 53b278845b88..1bc5cc9e52ef 100644
--- a/init/main.c
+++ b/init/main.c
@@ -42,6 +42,7 @@
 #include <linux/profile.h>
 #include <linux/kfence.h>
 #include <linux/rcupdate.h>
+#include <linux/srcu.h>
 #include <linux/moduleparam.h>
 #include <linux/kallsyms.h>
 #include <linux/writeback.h>
@@ -956,6 +957,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 	tick_init();
 	rcu_init_nohz();
 	init_timers();
+	srcu_init();
 	hrtimers_init();
 	softirq_init();
 	timekeeping_init();
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index d64b842f4078..b3af34068051 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -422,12 +422,6 @@ do {									\
 
 #endif /* #if defined(CONFIG_SRCU) || !defined(CONFIG_TINY_RCU) */
 
-#ifdef CONFIG_SRCU
-void srcu_init(void);
-#else /* #ifdef CONFIG_SRCU */
-static inline void srcu_init(void) { }
-#endif /* #else #ifdef CONFIG_SRCU */
-
 #ifdef CONFIG_TINY_RCU
 /* Tiny RCU doesn't expedite, as its purpose in life is instead to be tiny. */
 static inline bool rcu_gp_is_normal(void) { return true; }
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 10e681ea7051..108f9ca06047 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1384,6 +1384,11 @@ void __init srcu_init(void)
 {
 	struct srcu_struct *ssp;
 
+	/*
+	 * Once that is set, call_srcu() can follow the normal path and
+	 * queue delayed work. This must follow RCU workqueues creation
+	 * and timers initialization.
+	 */
 	srcu_init_done = true;
 	while (!list_empty(&srcu_boot_list)) {
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index c8a029fbb114..340b3f8b090d 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -221,5 +221,4 @@ void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
 	rcu_early_boot_tests();
-	srcu_init();
 }
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5c214705c33f..740f5cd34459 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4714,7 +4714,6 @@ void __init rcu_init(void)
 	WARN_ON(!rcu_gp_wq);
 	rcu_par_gp_wq = alloc_workqueue("rcu_par_gp", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!rcu_par_gp_wq);
-	srcu_init();
 
 	/* Fill in default value for rcutree.qovld boot parameter. */
 	/* -After- the rcu_node ->lock fields are initialized! */
-- 
2.25.1

