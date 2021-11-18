Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53693455E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhKROjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbhKROiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:38:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F46C06175C;
        Thu, 18 Nov 2021 06:35:02 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKv7/S++igpwRRMI31ZQXmTblRNIVp/T1R6Y07Jvo0k=;
        b=1pXf7QNNOPUPgH/2+6/KLHU97NvjAfztV9rZLJBzhy3YsZnmJR1uddRDDQ7ldyHxro06VF
        EcJaBe3GY4UBqG+aTVlvXZQIw8JUJI9c3b+jHWrdCSQLil6mvFdbQYiRYeEMsSQ5WnGvEC
        9jYn8rLQLJKYdtHp1MOPwzjgY3bhlglGb+aQByig1Gt9eTjebKJLdlniWZWPD37tj7Umc1
        eby8EVNtM+p0HB4ISqBib7OFwU3VSAomZC9dJtVx4iV61UEyPUNRf7auiIoAhKUEG8v/aa
        EAAdgmJsVUjdMVM1OkAmkX62u9LEMs2ZlfiR6258OmXziMY4aYpRHqJXt4H6DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qKv7/S++igpwRRMI31ZQXmTblRNIVp/T1R6Y07Jvo0k=;
        b=tHS31gIlAH8vVjujo5IrIp6dvI+yrk5VJoiDwaEHnapYtSCg2ndXuXxfEyRvv7NQatLrxd
        GeoUqrz6ECB42kBw==
To:     linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/8] kernel/fork: Don't assign the stack pointer in dup_task_struct().
Date:   Thu, 18 Nov 2021 15:34:48 +0100
Message-Id: <20211118143452.136421-5-bigeasy@linutronix.de>
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All four versions of alloc_thread_stack_node() assign now
task_struct::stack in case the allocation was successful.

Let alloc_thread_stack_node() return an error code instead of the stack
pointer and remove the stack assignment in dup_task_struct().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 47 ++++++++++++++++-------------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d1681a415cdf1..5e58e0a923f85 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -210,7 +210,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	void *stack;
 	int i;
@@ -231,7 +231,7 @@ static unsigned long *alloc_thread_stack_node(struct ta=
sk_struct *tsk, int node)
=20
 		tsk->stack_vm_area =3D s;
 		tsk->stack =3D s->addr;
-		return s->addr;
+		return 0;
 	}
=20
 	/*
@@ -244,17 +244,16 @@ static unsigned long *alloc_thread_stack_node(struct =
task_struct *tsk, int node)
 				     THREADINFO_GFP & ~__GFP_ACCOUNT,
 				     PAGE_KERNEL,
 				     0, node, __builtin_return_address(0));
-
+	if (!stack)
+		return -ENOMEM;
 	/*
 	 * We can't call find_vm_area() in interrupt context, and
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	if (stack) {
-		tsk->stack_vm_area =3D find_vm_area(stack);
-		tsk->stack =3D stack;
-	}
-	return stack;
+	tsk->stack_vm_area =3D find_vm_area(stack);
+	tsk->stack =3D stack;
+	return 0;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
@@ -281,16 +280,16 @@ static void free_thread_stack(struct task_struct *tsk)
=20
 #  else /* !CONFIG_VMAP_STACK */
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct page *page =3D alloc_pages_node(node, THREADINFO_GFP,
 					     THREAD_SIZE_ORDER);
=20
 	if (likely(page)) {
 		tsk->stack =3D kasan_reset_tag(page_address(page));
-		return tsk->stack;
+		return 0;
 	}
-	return NULL;
+	return -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
@@ -304,14 +303,13 @@ static void free_thread_stack(struct task_struct *tsk)
=20
 static struct kmem_cache *thread_stack_cache;
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk,
-						  int node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
 	stack =3D kmem_cache_alloc_node(thread_stack_cache, THREADINFO_GFP, node);
 	stack =3D kasan_reset_tag(stack);
 	tsk->stack =3D stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
@@ -331,13 +329,13 @@ void thread_stack_cache_init(void)
 # endif /* THREAD_SIZE >=3D PAGE_SIZE || defined(CONFIG_VMAP_STACK) */
 #else /* CONFIG_ARCH_THREAD_STACK_ALLOCATOR */
=20
-static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int=
 node)
+static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	unsigned long *stack;
=20
 	stack =3D arch_alloc_thread_stack_node(tsk, node);
 	tsk->stack =3D stack;
-	return stack;
+	return stack ? 0 : -ENOMEM;
 }
=20
 static void free_thread_stack(struct task_struct *tsk, bool cache_only)
@@ -893,8 +891,6 @@ void set_task_stack_end_magic(struct task_struct *tsk)
 static struct task_struct *dup_task_struct(struct task_struct *orig, int n=
ode)
 {
 	struct task_struct *tsk;
-	unsigned long *stack;
-	struct vm_struct *stack_vm_area __maybe_unused;
 	int err;
=20
 	if (node =3D=3D NUMA_NO_NODE)
@@ -907,24 +903,13 @@ static struct task_struct *dup_task_struct(struct tas=
k_struct *orig, int node)
 	if (err)
 		goto free_tsk;
=20
-	stack =3D alloc_thread_stack_node(tsk, node);
-	if (!stack)
+	err =3D alloc_thread_stack_node(tsk, node);
+	if (err)
 		goto free_tsk;
=20
 	if (memcg_charge_kernel_stack(tsk))
 		goto free_stack;
=20
-	stack_vm_area =3D task_stack_vm_area(tsk);
-
-	/*
-	 * arch_dup_task_struct() clobbers the stack-related fields.  Make
-	 * sure they're properly initialized before using any stack-related
-	 * functions again.
-	 */
-	tsk->stack =3D stack;
-#ifdef CONFIG_VMAP_STACK
-	tsk->stack_vm_area =3D stack_vm_area;
-#endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
--=20
2.33.1

