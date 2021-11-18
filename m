Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F48A455E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhKROjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:39:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbhKROiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:38:02 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637246101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MecIn1ScqIndHgHCyJHHAGKguvnOFr/kKyw8G5ubMs=;
        b=xenHtvNPss87Qg6s2ieLoKcUCTrMT5OaEUW0XsHR2Q8pneer8djyFKMAsd2b0JgTTTzR7J
        CAsNXmRZDCVzkPOJPYK0/pq1MZ8NOna/IOS00xf4PS5uUeRQblsloeYMR4g4O1LE1hj3WY
        DBWotY89lMEDEweZg0/dU5C8HD94e+a7qtxj7vFR+tp9GUS23uki0DulP7BhrM8+b7YGgQ
        cKGgUPaHL2iGUQM+r9MfvDIQW+v7yk+GjEpMjVpOy9/GKmsWD/vZZr+/Pv4ySML4/AiEoB
        dmrkGDQWjsB3DasSv43+L4OHArCnf4qYPVTmMIZWe3xcMObQjwJbbQLr1NYAyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637246101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1MecIn1ScqIndHgHCyJHHAGKguvnOFr/kKyw8G5ubMs=;
        b=3JmHE9KCi4w97CWfGbRwKDzBJNeAFstK/MC6idbJoEYjGKwr+y+76F57pAvHgCmZlSzzLY
        yP7sqbbYDZuP8cCg==
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
Subject: [PATCH 6/8] kernel/fork: Move task stack account to do_exit().
Date:   Thu, 18 Nov 2021 15:34:50 +0100
Message-Id: <20211118143452.136421-7-bigeasy@linutronix.de>
In-Reply-To: <20211118143452.136421-1-bigeasy@linutronix.de>
References: <20211118143452.136421-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to perform the stack accounting of the outgoing task in
its final schedule() invocation which happens with disabled preemption.
The task is leaving, the resources will be freed and the accounting can
happen in do_exit() before the actual schedule invocation which
frees the stack memory.

Move the accounting of the stack memory from release_task_stack() to
exit_task_stack_account() which then can be invoked from do_exit().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched/task_stack.h |  2 ++
 kernel/exit.c                    |  1 +
 kernel/fork.c                    | 35 +++++++++++++++++++++-----------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_st=
ack.h
index d10150587d819..892562ebbd3aa 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -79,6 +79,8 @@ static inline void *try_get_task_stack(struct task_struct=
 *tsk)
 static inline void put_task_stack(struct task_struct *tsk) {}
 #endif
=20
+void exit_task_stack_account(struct task_struct *tsk);
+
 #define task_stack_end_corrupted(task) \
 		(*(end_of_stack(task)) !=3D STACK_END_MAGIC)
=20
diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686e..41236da175d56 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -871,6 +871,7 @@ void __noreturn do_exit(long code)
 		put_page(tsk->task_frag.page);
=20
 	validate_creds_for_do_exit(tsk);
+	exit_task_stack_account(tsk);
=20
 	check_stack_usage();
 	preempt_disable();
diff --git a/kernel/fork.c b/kernel/fork.c
index cdbfc9280f3b1..257cd048359fd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -210,9 +210,8 @@ static int free_vm_stack_cache(unsigned int cpu)
 	return 0;
 }
=20
-static int memcg_charge_kernel_stack(struct task_struct *tsk)
+static int memcg_charge_kernel_stack(struct vm_struct *vm)
 {
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
 	int i;
 	int ret;
=20
@@ -238,6 +237,7 @@ static int memcg_charge_kernel_stack(struct task_struct=
 *tsk)
=20
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
+	struct vm_struct *vm;
 	void *stack;
 	int i;
=20
@@ -255,7 +255,7 @@ static int alloc_thread_stack_node(struct task_struct *=
tsk, int node)
 		/* Clear stale pointers from reused stack. */
 		memset(s->addr, 0, THREAD_SIZE);
=20
-		if (memcg_charge_kernel_stack(tsk)) {
+		if (memcg_charge_kernel_stack(s)) {
 			vfree(s->addr);
 			return -ENOMEM;
 		}
@@ -278,7 +278,8 @@ static int alloc_thread_stack_node(struct task_struct *=
tsk, int node)
 	if (!stack)
 		return -ENOMEM;
=20
-	if (memcg_charge_kernel_stack(tsk)) {
+	vm =3D find_vm_area(stack);
+	if (memcg_charge_kernel_stack(vm)) {
 		vfree(stack);
 		return -ENOMEM;
 	}
@@ -287,19 +288,15 @@ static int alloc_thread_stack_node(struct task_struct=
 *tsk, int node)
 	 * free_thread_stack() can be called in interrupt context,
 	 * so cache the vm_struct.
 	 */
-	tsk->stack_vm_area =3D find_vm_area(stack);
+	tsk->stack_vm_area =3D vm;
 	tsk->stack =3D stack;
 	return 0;
 }
=20
 static void free_thread_stack(struct task_struct *tsk)
 {
-	struct vm_struct *vm =3D task_stack_vm_area(tsk);
 	int i;
=20
-	for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
-		memcg_kmem_uncharge_page(vm->pages[i], 0);
-
 	for (i =3D 0; i < NR_CACHED_STACKS; i++) {
 		if (this_cpu_cmpxchg(cached_stacks[i], NULL,
 				     tsk->stack_vm_area) !=3D NULL)
@@ -450,12 +447,25 @@ static void account_kernel_stack(struct task_struct *=
tsk, int account)
 	}
 }
=20
+void exit_task_stack_account(struct task_struct *tsk)
+{
+	account_kernel_stack(tsk, -1);
+
+	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
+		struct vm_struct *vm;
+		int i;
+
+		vm =3D task_stack_vm_area(tsk);
+		for (i =3D 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			memcg_kmem_uncharge_page(vm->pages[i], 0);
+	}
+}
+
 static void release_task_stack(struct task_struct *tsk)
 {
 	if (WARN_ON(READ_ONCE(tsk->__state) !=3D TASK_DEAD))
 		return;  /* Better to leak the stack than to free prematurely */
=20
-	account_kernel_stack(tsk, -1);
 	free_thread_stack(tsk);
 }
=20
@@ -916,6 +926,7 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	refcount_set(&tsk->stack_refcount, 1);
 #endif
+	account_kernel_stack(tsk, 1);
=20
 	err =3D scs_prepare(tsk, node);
 	if (err)
@@ -959,8 +970,6 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	tsk->wake_q.next =3D NULL;
 	tsk->pf_io_worker =3D NULL;
=20
-	account_kernel_stack(tsk, 1);
-
 	kcov_task_init(tsk);
 	kmap_local_fork(tsk);
=20
@@ -979,6 +988,7 @@ static struct task_struct *dup_task_struct(struct task_=
struct *orig, int node)
 	return tsk;
=20
 free_stack:
+	exit_task_stack_account(tsk);
 	free_thread_stack(tsk);
 free_tsk:
 	free_task_struct(tsk);
@@ -2475,6 +2485,7 @@ static __latent_entropy struct task_struct *copy_proc=
ess(
 	exit_creds(p);
 bad_fork_free:
 	WRITE_ONCE(p->__state, TASK_DEAD);
+	exit_task_stack_account(p);
 	put_task_stack(p);
 	delayed_free_task(p);
 fork_out:
--=20
2.33.1

