Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26823654A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhDTIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhDTIyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:54:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fC3z/VNYzfvgFcsYoZ4hESVWGdq32x1mddKeb644MsA=; b=k3SElTyynH4i3R2XyOBFitSqm7
        f0xZW3xWeL18WFocZK51UaE7Xqmg3Km1G3hI/7YdszCxTCbj3MvJefsBdHQdQl48HyRlqV/WLGiQl
        cnNA3qwHxrN2BHkPZqnNWZh0ZM6xthLAeMfZEq3TZbQvrNxTGAp8CJ6p16qfttmjrQexeGHxNhRmD
        TEp0aGLit0PHHtlNQtu11nbYtUqzZglAoqkGfZ9tt3ue5M2GUAJdKrYn+2zxcSv3W2NPWqpq+x4/e
        f+tgDofdUjWyNNjDDDz1jPvOLytJRmEMm/0OA2pLmX0JJ3QnCALuJuu3qLnYkq7BIa2waClzlNQg6
        eNvioPrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYm6q-00EwaO-II; Tue, 20 Apr 2021 08:51:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D489F30013E;
        Tue, 20 Apr 2021 10:51:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BBCC82BDD7C7C; Tue, 20 Apr 2021 10:51:49 +0200 (CEST)
Date:   Tue, 20 Apr 2021 10:51:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
Message-ID: <YH6WJc825C4P0FCK@hirez.programming.kicks-ass.net>
References: <000000000000a61f7705c050e601@google.com>
 <87im4ilddh.mognet@arm.com>
 <20210419184553.GA26214@worktop.programming.kicks-ass.net>
 <874kg2kpwd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kg2kpwd.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 08:58:26PM +0100, Valentin Schneider wrote:

> Looks about right, IIUC the key being:
> 
>   p->flags & PF_KTHREAD + p->set_child_tid => the struct kthread is
>   persistent
> 
>   p->flags & PF_KTHREAD => you may or may not have a struct kthread (see
>   kernel/umh.c kernel_thread() uses). PF_KTHREAD isn't even guaranteed to
>   persist (begin_new_exec()), which seems to be what the syzbot hit.

Ack, that's nicely put.

> While we're at it, does free_kthread_struct() want the __to_kthread()
> treatment as well? The other to_kthread() callsites looked like they only
> made sense with a "proper" kthread anyway.

I think free_kthread_struct() is ok, because a task at that point in its
lifetime cannot be also doing exec().

kthread_func() is another 'fun' trainwreck waiting to happen -- luckily
the only caller uses current, still let me go fix it.

kthread_probe_data() relies on PF_WQ_WORKER implying PF_KTHREAD but
otherwise seems very fragile too.

Something like so then?

---
Subject: kthread: Fix PF_KTHREAD vs to_kthread() race
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Apr 20 10:18:17 CEST 2021

The kthread_is_per_cpu() construct relies on only being called on
PF_KTHREAD tasks (per the WARN in to_kthread). This gives rise to the
following usage pattern:

	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))

However, as reported by syzcaller, this is broken. The scenario is:

	CPU0				CPU1 (running p)

	(p->flags & PF_KTHREAD) // true

					begin_new_exec()
					  me->flags &= ~(PF_KTHREAD|...);
	kthread_is_per_cpu(p)
	  to_kthread(p)
	    WARN(!(p->flags & PF_KTHREAD) <-- *SPLAT*

Introduce __to_kthread() that omits the WARN and is sure to check both
values.

Use this to remove the problematic pattern for kthread_is_per_cpu()
and fix a number of other kthread_*() functions that have similar
issues but are currently not used in ways that would expose the
problem.

Notably kthread_func() is only ever called on 'current', while
kthread_probe_data() is only used for PF_WQ_WORKER, which implies the
task is from kthread_create*().

Fixes: ac687e6e8c26 ("kthread: Extract KTHREAD_IS_PER_CPU")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/kthread.c    |   33 +++++++++++++++++++++++++++------
 kernel/sched/core.c |    2 +-
 kernel/sched/fair.c |    2 +-
 3 files changed, 29 insertions(+), 8 deletions(-)

--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -84,6 +84,25 @@ static inline struct kthread *to_kthread
 	return (__force void *)k->set_child_tid;
 }
 
+/*
+ * Variant of to_kthread() that doesn't assume @p is a kthread.
+ *
+ * Per construction; when:
+ *
+ *   (p->flags & PF_KTHREAD) && p->set_child_tid
+ *
+ * the task is both a kthread and struct kthread is persistent. However
+ * PF_KTHREAD on it's own is not, kernel_thread() can exec() (See umh.c and
+ * begin_new_exec()).
+ */
+static inline struct kthread *__to_kthread(struct task_struct *p)
+{
+	void *kthread = (__force void *)p->set_child_tid;
+	if (kthread && !(p->flags & PF_KTHREAD))
+		kthread = NULL;
+	return kthread;
+}
+
 void free_kthread_struct(struct task_struct *k)
 {
 	struct kthread *kthread;
@@ -168,8 +187,9 @@ EXPORT_SYMBOL_GPL(kthread_freezable_shou
  */
 void *kthread_func(struct task_struct *task)
 {
-	if (task->flags & PF_KTHREAD)
-		return to_kthread(task)->threadfn;
+	struct kthread *kthread = __to_kthread(task);
+	if (kthread)
+		return kthread->threadfn;
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(kthread_func);
@@ -199,10 +219,11 @@ EXPORT_SYMBOL_GPL(kthread_data);
  */
 void *kthread_probe_data(struct task_struct *task)
 {
-	struct kthread *kthread = to_kthread(task);
+	struct kthread *kthread = __to_kthread(task);
 	void *data = NULL;
 
-	copy_from_kernel_nofault(&data, &kthread->data, sizeof(data));
+	if (kthread)
+		copy_from_kernel_nofault(&data, &kthread->data, sizeof(data));
 	return data;
 }
 
@@ -514,9 +535,9 @@ void kthread_set_per_cpu(struct task_str
 	set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
 }
 
-bool kthread_is_per_cpu(struct task_struct *k)
+bool kthread_is_per_cpu(struct task_struct *p)
 {
-	struct kthread *kthread = to_kthread(k);
+	struct kthread *kthread = __to_kthread(p);
 	if (!kthread)
 		return false;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8505,7 +8505,7 @@ static void balance_push(struct rq *rq)
 	 * histerical raisins.
 	 */
 	if (rq->idle == push_task ||
-	    ((push_task->flags & PF_KTHREAD) && kthread_is_per_cpu(push_task)) ||
+	    kthread_is_per_cpu(push_task) ||
 	    is_migration_disabled(push_task)) {
 
 		/*
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7619,7 +7619,7 @@ int can_migrate_task(struct task_struct
 		return 0;
 
 	/* Disregard pcpu kthreads; they are where they need to be. */
-	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
+	if (kthread_is_per_cpu(p))
 		return 0;
 
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {
