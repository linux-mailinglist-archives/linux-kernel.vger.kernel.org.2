Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B31364ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbhDST7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:59:06 -0400
Received: from foss.arm.com ([217.140.110.172]:49324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhDST7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:59:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 959521435;
        Mon, 19 Apr 2021 12:58:34 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 241F33F792;
        Mon, 19 Apr 2021 12:58:33 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+9362b31a2e0cad8b749d@syzkaller.appspotmail.com>,
        bp@alien8.de, dwmw@amazon.co.uk, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Subject: Re: [syzbot] WARNING in kthread_is_per_cpu
In-Reply-To: <20210419184553.GA26214@worktop.programming.kicks-ass.net>
References: <000000000000a61f7705c050e601@google.com> <87im4ilddh.mognet@arm.com> <20210419184553.GA26214@worktop.programming.kicks-ass.net>
Date:   Mon, 19 Apr 2021 20:58:26 +0100
Message-ID: <874kg2kpwd.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/21 20:45, Peter Zijlstra wrote:
> On Mon, Apr 19, 2021 at 12:31:22PM +0100, Valentin Schneider wrote:
>
>>   if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
>>                                  `\
>>                                    to_kthread(p);
>>                                     `\
>>                                       WARN_ON(!(p->flags & PF_KTHREAD));
>>
>> ... Huh?
>
> Something like so perhaps?
>

Looks about right, IIUC the key being:

  p->flags & PF_KTHREAD + p->set_child_tid => the struct kthread is
  persistent

  p->flags & PF_KTHREAD => you may or may not have a struct kthread (see
  kernel/umh.c kernel_thread() uses). PF_KTHREAD isn't even guaranteed to
  persist (begin_new_exec()), which seems to be what the syzbot hit.

I'd be happy to see is_per_cpu_kthread() die, but that's somewhat
orthogonal to this here. For now, this does need the tiny extra below.

While we're at it, does free_kthread_struct() want the __to_kthread()
treatment as well? The other to_kthread() callsites looked like they only
made sense with a "proper" kthread anyway.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 49636a49843f..8b470c2d5680 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7612,7 +7612,7 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 
 	/* Disregard pcpu kthreads; they are where they need to be. */
-	if ((p->flags & PF_KTHREAD) && kthread_is_per_cpu(p))
+	if (kthread_is_per_cpu(p))
 		return 0;
 
 	if (!cpumask_test_cpu(env->dst_cpu, p->cpus_ptr)) {

> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 1578973c5740..eeba40df61ac 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -78,6 +78,14 @@ static inline void set_kthread_struct(void *kthread)
>       current->set_child_tid = (__force void __user *)kthread;
>  }
>
> +static inline struct kthread *__to_kthread(struct task_struct *k)
> +{
> +	void *kthread = (__force void *)k->set_child_tid;
> +	if (kthread && !(k->flags & PF_KTHREAD))
> +		kthread = NULL;
> +	return kthread;
> +}
> +
>  static inline struct kthread *to_kthread(struct task_struct *k)
>  {
>       WARN_ON(!(k->flags & PF_KTHREAD));
> @@ -516,7 +524,7 @@ void kthread_set_per_cpu(struct task_struct *k, int cpu)
>
>  bool kthread_is_per_cpu(struct task_struct *k)
>  {
> -	struct kthread *kthread = to_kthread(k);
> +	struct kthread *kthread = __to_kthread(k);
>       if (!kthread)
>               return false;
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3384ea74cad4..dc6311bd6986 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7658,7 +7658,7 @@ static void balance_push(struct rq *rq)
>        * histerical raisins.
>        */
>       if (rq->idle == push_task ||
> -	    ((push_task->flags & PF_KTHREAD) && kthread_is_per_cpu(push_task)) ||
> +	    kthread_is_per_cpu(push_task) ||
>           is_migration_disabled(push_task)) {
>
>               /*
