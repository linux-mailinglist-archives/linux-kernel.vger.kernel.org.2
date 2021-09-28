Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F01F41AEEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbhI1M0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbhI1M0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:26:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3541C061769
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:24:33 -0700 (PDT)
Message-ID: <20210928122411.648582026@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632831872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4Kt2g+3oPmE2BKXDu/RDX88I5PSbgMAsN+xKYXaHDfY=;
        b=L3zatJ0JubQb3CxZax/DLSSR0sk3eeiihvJSUGj2sgV7/XOx6Gz23ai+Rd8U1R4b3vLFJG
        Bkkl7HG5LQBxmjWgeP2tV0k3mTCPC9808nzqxkt5V3ysFDq/7WbqyRF25S/NSTWqCHlQPy
        ok7QYBepRd5OR1ulSdt3MyWupGKAvgiS+GKtkEe/wdQ3L+C7kTCtZ+I2Eu0KmKvYKR1OZt
        MMGPz+sFMe28GyzRzwWYH3UVB0Ye3jrPVVlmANE7JzLgy8p0y7XwWWfvf95Ht5Rqg8WhaU
        bMVwdc5dl9DrrrL9Z0A7z/BjzcOv9Gan6x8EwiG3rgiOJJzWJ0ZQi04bLk7icw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632831872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4Kt2g+3oPmE2BKXDu/RDX88I5PSbgMAsN+xKYXaHDfY=;
        b=hux+8OpW9HxVI+OJf1deY50ARHpsb8bZwioMaI/YwdAarO6BvRjij6L+xuZPj+Gp4hkeeh
        i1xAvl7HweitAnCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 5/5] sched: Move mmdrop to RCU on RT
References: <20210928122339.502270600@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Sep 2021 14:24:32 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmdrop() is invoked from finish_task_switch() by the incoming task to drop
the mm which was handed over by the previous task. mmdrop() can be quite
expensive which prevents an incoming real-time task from getting useful
work done.

Provide mmdrop_sched() which maps to mmdrop() on !RT kernels. On RT kernels
it delagates the eventually required invocation of __mmdrop() to RCU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm_types.h |    4 ++++
 include/linux/sched/mm.h |   20 ++++++++++++++++++++
 kernel/fork.c            |   13 +++++++++++++
 kernel/sched/core.c      |    2 +-
 4 files changed, 38 insertions(+), 1 deletion(-)
---
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -12,6 +12,7 @@
 #include <linux/completion.h>
 #include <linux/cpumask.h>
 #include <linux/uprobes.h>
+#include <linux/rcupdate.h>
 #include <linux/page-flags-layout.h>
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
@@ -572,6 +573,9 @@ struct mm_struct {
 		bool tlb_flush_batched;
 #endif
 		struct uprobes_state uprobes_state;
+#ifdef CONFIG_PREEMPT_RT
+		struct rcu_head delayed_drop;
+#endif
 #ifdef CONFIG_HUGETLB_PAGE
 		atomic_long_t hugetlb_usage;
 #endif
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -49,6 +49,26 @@ static inline void mmdrop(struct mm_stru
 		__mmdrop(mm);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+extern void __mmdrop_delayed(struct rcu_head *rhp);
+
+/*
+ * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
+ * kernels via RCU.
+ */
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	/* Provides a full memory barrier. See mmdrop() */
+	if (atomic_dec_and_test(&mm->mm_count))
+		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
+}
+#else
+static inline void mmdrop_sched(struct mm_struct *mm)
+{
+	mmdrop(mm);
+}
+#endif
+
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -708,6 +708,19 @@ void __mmdrop(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
 
+#ifdef CONFIG_PREEMPT_RT
+/*
+ * RCU callback for delayed mm drop. Not strictly RCU, but call_rcu() is
+ * by far the least expensive way to do that.
+ */
+void __mmdrop_delayed(struct rcu_head *rhp)
+{
+	struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);
+
+	__mmdrop(mm);
+}
+#endif
+
 static void mmdrop_async_fn(struct work_struct *work)
 {
 	struct mm_struct *mm;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4840,7 +4840,7 @@ static struct rq *finish_task_switch(str
 	 */
 	if (mm) {
 		membarrier_mm_sync_core_before_usermode(mm);
-		mmdrop(mm);
+		mmdrop_sched(mm);
 	}
 	if (unlikely(prev_state == TASK_DEAD)) {
 		if (prev->sched_class->task_dead)

