Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434094163B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242420AbhIWQ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:56:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242290AbhIWQ4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:17 -0400
Message-ID: <20210923165358.305969211@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632416085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s9aeG490t7G5G79kYLvX8jUIfAoEnZOsviDDWoDjJv8=;
        b=S/ZEdZiI3P9l8CHztGXB6Nm5YFeBsnez7j+nCUZ5sZ4e0tCVw2Qi8J7l9gTzuQEst9e+Cq
        PFbVqxfOTtWsSfSYWcyg4c/o0kIQsX9f9C/GC3ocyzzWUf+iF38hveWp+bhTOSSu3dJUWV
        +VPBw/UU32WONdhbS4FZDWe3ZAnjMYer2D+II+uwypWtwR+zhzVHDb2Dfza6PuHM6KRjh6
        3LwK1khZjApxa2y2itMhnJtN4W3cS2FMxJ6tb2Ib9ypxxdm99ssCfaxZvqEeDjkDWPlKS+
        Y3lva8et9S/7Vb9BWgBfhHGTAEhccYgDQu5W9+zRA/kPctgHuIpz5aF6zlcS4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632416085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=s9aeG490t7G5G79kYLvX8jUIfAoEnZOsviDDWoDjJv8=;
        b=upeRqNC4adYSIorw3yRoaR7v2ZXBUPp/IuBSbNI7GygVe0eSqqG6QxvbiuT/oyDOqXanPo
        pMW/D9LGt5kGosDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [patch 7/8] sched: Make cond_resched_lock() variants RT aware
References: <20210923164145.466686140@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 23 Sep 2021 18:54:44 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __might_resched() checks in the cond_resched_lock() variants use
PREEMPT_LOCK_OFFSET for preempt count offset checking which takes the
preemption disable by the spin_lock() which is still held at that point
into account.

On PREEMPT_RT enabled kernels spin/rw_lock held sections stay preemptible
which means PREEMPT_LOCK_OFFSET is 0, but that still triggers the
__might_resched() check because that takes RCU read side nesting into
account.

On RT enabled kernels spin/read/write_lock() issue rcu_read_lock() to
resemble the !RT semantics, which means in cond_resched_lock() the might
resched check will see preempt_count() == 0 and rcu_preempt_depth() == 1.

Introduce PREEMPT_LOCK_SCHED_OFFSET for those might resched checks and map
them depending on CONFIG_PREEMPT_RT.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/preempt.h |    5 +++--
 include/linux/sched.h   |   34 +++++++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 11 deletions(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -122,9 +122,10 @@
  * The preempt_count offset after spin_lock()
  */
 #if !defined(CONFIG_PREEMPT_RT)
-#define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#define PREEMPT_LOCK_OFFSET		PREEMPT_DISABLE_OFFSET
 #else
-#define PREEMPT_LOCK_OFFSET	0
+/* Locks on RT do not disable preemption */
+#define PREEMPT_LOCK_OFFSET		0
 #endif
 
 /*
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2052,19 +2052,35 @@ extern int __cond_resched_rwlock_write(r
 #define MIGHT_RESCHED_RCU_SHIFT		8
 #define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
 
-#define cond_resched_lock(lock) ({					\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_lock(lock);					\
+#ifndef CONFIG_PREEMPT_RT
+/*
+ * Non RT kernels have an elevated preempt count due to the held lock,
+ * but are not allowed to be inside a RCU read side critical section
+ */
+# define PREEMPT_LOCK_RESCHED_OFFSETS	PREEMPT_LOCK_OFFSET
+#else
+/*
+ * spin/rw_lock() on RT implies rcu_read_lock(). The might_sleep() check in
+ * cond_resched*lock() has to take that into account because it checks for
+ * preempt_count() and rcu_preempt_depth().
+ */
+# define PREEMPT_LOCK_RESCHED_OFFSETS	\
+	(PREEMPT_LOCK_OFFSET + (1U << MIGHT_RESCHED_RCU_SHIFT))
+#endif
+
+#define cond_resched_lock(lock) ({						\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_lock(lock);						\
 })
 
-#define cond_resched_rwlock_read(lock) ({				\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_read(lock);				\
+#define cond_resched_rwlock_read(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_read(lock);					\
 })
 
-#define cond_resched_rwlock_write(lock) ({				\
-	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
-	__cond_resched_rwlock_write(lock);				\
+#define cond_resched_rwlock_write(lock) ({					\
+	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
+	__cond_resched_rwlock_write(lock);					\
 })
 
 static inline void cond_resched_rcu(void)

