Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4823455E50
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKROjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:39:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39454 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbhKROiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:38:02 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJ/j+RSho2k1HLNYW3vQru62KzHZDO3Y8owSeLvRnFU=;
        b=kdF+OnjzQb/mEvNu44RYcU5J3OFUhPPpUivoHOEIsbI7Fvz8vgaCcI8oIUGZiPlHk0O08A
        nbqXkEPfMRuZ82cAjCHkjMe0xdXOFxr4r7MkpHkVZi01tj1moEx3ZZ3F3GJ0ifNWTPh67V
        syNmpygPMiQ8La5Ygaom+LSYrx0G4w7inDkgxaab0+oc3JA9ocUAOcZuqJ5ULQ86/noMX6
        SNjlDYhtIOyJ3gNaVnwpM6VhD1Xxu4fFgC9yAvoaQXqyhNCYswvzH0C+os1jZkIWonbpvK
        AnAM4tnjO1hcUzllKAY7AUC5AANwSfC6LZ0AidioeJun6Gk0mE8Ydg6oZO+uxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DJ/j+RSho2k1HLNYW3vQru62KzHZDO3Y8owSeLvRnFU=;
        b=ini6jE5OY2Ap9U14ZA1Dwh022vj94Fjiv5cqmtXl/4ceag9dUa9rHaztJWT9GR/nHJ9R3j
        bax7R2GHoP3fN6BA==
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
Subject: [PATCH 5/8] kernel/fork: Move memcg_charge_kernel_stack() into CONFIG_VMAP_STACK.
Date:   Thu, 18 Nov 2021 15:34:49 +0100
Message-Id: <20211118143452.136421-6-bigeasy@linutronix.de>
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcg_charge_kernel_stack() is only used in the CONFIG_VMAP_STACK case.

Move memcg_charge_kernel_stack() into the CONFIG_VMAP_STACK block and
invoke it from within alloc_thread_stack_node().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/fork.c | 69 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 33 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5e58e0a923f85..cdbfc9280f3b1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -210,6 +210,32 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
=20
+static int memcg_charge_kernel_stack(struct task_struct *tsk)
+{
+	struct vm_struct *vm =3D task_stack_vm_area(tsk);
+	int i;
+	int ret;
+
+	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 !=3D 0);
+	BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
+
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+		ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL, 0);
+		if (ret)
+			goto err;
+	}
+	return 0;
+err:
+	/*
+	 * If memcg_kmem_charge_page() fails, page's memory cgroup pointer is
+	 * NULL, and memcg_kmem_uncharge_page() in free_thread_stack() will
+	 * ignore this page.
+	 */
+	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		memcg_kmem_uncharge_page(vm->pages[i], 0);
+	return ret;
+}
+
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	void *stack;
@@ -229,6 +255,11 @@ static int alloc_thread_stack_node(struct task_struct =
*tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
=20
+		if (memcg_charge_kernel_stack(tsk)) {
+			vfree(s->addr);
+			return -ENOMEM;
+		}
+
 		tsk->stack_vm_area =3D s;
 		tsk->stack =3D s->addr;
 		return 0;
@@ -246,6 +277,11 @@ static int alloc_thread_stack_node(struct task_struct =
*tsk, int node)
 				     0, node, __builtin_return_address(0));
 	if (!stack)
 		return -ENOMEM;
+
+	if (memcg_charge_kernel_stack(tsk)) {
+		vfree(stack);
+		return -ENOMEM;
+	}
 	/*
 	 * We can't call find_vm_area() in interrupt context, and
 	 * free_thread_stack() can be called in interrupt context,
@@ -414,36 +450,6 @@ static void account_kernel_stack(struct task_struct *t=
sk, int account)
 	}
 }
=20
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
-{
-#ifdef CONFIG_VMAP_STACK
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
-	int ret;
-
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_VMAP_STACK) && PAGE_SIZE % 1024 !=3D 0);
-
-	if (vm) {
-		int i;
-
-		BUG_ON(vm->nr_pages !=3D THREAD_SIZE / PAGE_SIZE);
-
-		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
-			/*
-			 * If memcg_kmem_charge_page() fails, page's
-			 * memory cgroup pointer is NULL, and
-			 * memcg_kmem_uncharge_page() in free_thread_stack()
-			 * will ignore this page.
-			 */
-			ret =3D memcg_kmem_charge_page(vm->pages[i], GFP_KERNEL,
-						     0);
-			if (ret)
-				return ret;
-		}
-	}
-#endif
-	return 0;
-}
-
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(READ_ONCE(tsk->__state) !=3D TASK_DEAD))
@@ -907,9 +913,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	if (err)
 		goto free_tsk;
=20
-	if (memcg_charge_kernel_stack(tsk))
-		goto free_stack;
-
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
--=20
2.33.1

