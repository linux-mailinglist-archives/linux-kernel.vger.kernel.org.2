Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B59C3D183D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhGUT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:57:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231989AbhGUT5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:57:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6A76124B;
        Wed, 21 Jul 2021 20:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626899901;
        bh=GigiSkqXTDy+QkyYs7Y/oDOjKdcjT/+3+R3H9fSvMOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VR/mXfWqTQUi9xVyVpjTWkROpuiANmjgWANZtEIAB49b2+F0aZVWKg3zczTsoWWqx
         aXAvm0iCAR98vHKJcKVXf+qSkqLPrQRY2wbIWGUuD4j55XV79agfJjH7HwoZakR2Xa
         JGEiK/xZ4JL8ehZ1G8ut4hFpQIP2laT97Z04uGxFhneKwaznANROIwwF0atRpWUW53
         yVhByrde4bzO5D2ZqU14QhsJ3OWcFJI0FRxQsSdmoo1EF5M8iKm+RixpeOQVoGtGq0
         Y0fccOyDT8pNRY6DPNBpb2qFg7X9KWJ+JH+xWFSiyFxuCIOmv6z2zLujo68YPv9CgZ
         kWPGLUQH+TvPQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 60CFD5C0BF4; Wed, 21 Jul 2021 13:38:21 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 5/5] rcu: Fix macro name CONFIG_TASKS_RCU_TRACE
Date:   Wed, 21 Jul 2021 13:38:18 -0700
Message-Id: <20210721203818.3398345-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
References: <20210721203758.GA3386731@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

This commit fixes several typos where CONFIG_TASKS_RCU_TRACE should
instead be CONFIG_TASKS_TRACE_RCU.  Among other things, these typos
could cause CONFIG_TASKS_TRACE_RCU_READ_MB=y kernels to suffer from
memory-ordering bugs that could result in false-positive quiescent
states and too-short grace periods.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 2 +-
 kernel/rcu/tree_plugin.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index d9680b798b211..955c82b4737c5 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -167,7 +167,7 @@ void synchronize_rcu_tasks(void);
 # define synchronize_rcu_tasks synchronize_rcu
 # endif
 
-# ifdef CONFIG_TASKS_RCU_TRACE
+# ifdef CONFIG_TASKS_TRACE_RCU
 # define rcu_tasks_trace_qs(t)						\
 	do {								\
 		if (!likely(READ_ONCE((t)->trc_reader_checked)) &&	\
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index de1dc3bb7f701..6ce104242b23d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2982,17 +2982,17 @@ static void noinstr rcu_dynticks_task_exit(void)
 /* Turn on heavyweight RCU tasks trace readers on idle/user entry. */
 static void rcu_dynticks_task_trace_enter(void)
 {
-#ifdef CONFIG_TASKS_RCU_TRACE
+#ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 		current->trc_reader_special.b.need_mb = true;
-#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
 /* Turn off heavyweight RCU tasks trace readers on idle/user exit. */
 static void rcu_dynticks_task_trace_exit(void)
 {
-#ifdef CONFIG_TASKS_RCU_TRACE
+#ifdef CONFIG_TASKS_TRACE_RCU
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
 		current->trc_reader_special.b.need_mb = false;
-#endif /* #ifdef CONFIG_TASKS_RCU_TRACE */
+#endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
-- 
2.31.1.189.g2e36527f23

