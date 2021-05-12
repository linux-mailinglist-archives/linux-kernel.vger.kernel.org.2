Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB037ECD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382114AbhELUBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 16:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355651AbhELS26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 14:28:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8181F61407;
        Wed, 12 May 2021 18:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620844069;
        bh=/M0p63bg1/fKxbIsfDTivMgbhmIF+/ZPH4ovwSfJMCE=;
        h=From:To:Cc:Subject:Date:From;
        b=QsBmz86gcb3vxr6Yn4x9A9GdmO6SdHPtuoz5hv3wmWMSuaqk91Pp4IOblGxcCwUE/
         /rj0P4e3lQEZMrrSTiSyPZSzy7vapGkIgpmNgd3RZ42M72UsNVsrOe+DUircuAdo7V
         4FrYFPkaleuq4nAGp6cMMITj5e4XOFoSyBuh/v48YUEeJPwsQTqN71wYk4IUa/d0KX
         Bj1Unl46NAp2+PueDKpCx6XSfOcDtkeDWE4+GteM7/ohgVIgc+Zv2thX0FtXoYGdxp
         Y0sjp8X57sf57ExMtU11L4G2AnZ6EN5InIgMmha/jZHjbbQbAHMp5gTc01efZNuAgL
         m3ZK9huUSJFMQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 080485C03EC; Wed, 12 May 2021 11:27:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH tip/core/rcu 4/4] tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
Date:   Wed, 12 May 2021 11:27:47 -0700
Message-Id: <20210512182747.3445812-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some architectures, the no-op variant of show_rcu_tasks_gp_kthreads()
get "no previous prototype" compiler warnings.  These are false positives
given that kernel/rcu/tasks.h is included only once.  But why put up
with the compiler noise?

This commit therefore adds "static inline" to this definition to force
the compiler to accept this situation, while also moving it to its proper
place in kernel/rcu/rcu.h.

Reported-by: kernel test robot <lkp@intel.com>
[ paulmck: Update per Stephen Rothwell feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h   | 4 ++++
 kernel/rcu/tasks.h | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index bf0827d4b659..c0b3ab6736b8 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -441,7 +441,11 @@ bool rcu_gp_is_expedited(void);  /* Internal RCU use. */
 void rcu_expedite_gp(void);
 void rcu_unexpedite_gp(void);
 void rcupdate_announce_bootup_oddness(void);
+#ifdef CONFIG_TASKS_RCU_GENERIC
 void show_rcu_tasks_gp_kthreads(void);
+#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
+static inline void show_rcu_tasks_gp_kthreads(void) {}
+#endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
 void rcu_request_urgent_qs_task(struct task_struct *t);
 #endif /* #else #ifdef CONFIG_TINY_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d6aa352cd705..fc218539d151 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1401,5 +1401,4 @@ void __init rcu_init_tasks_generic(void)
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
-void show_rcu_tasks_gp_kthreads(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_RCU_GENERIC */
-- 
2.31.1.189.g2e36527f23

