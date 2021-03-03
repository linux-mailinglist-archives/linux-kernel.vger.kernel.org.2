Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8392532C3E5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354450AbhCDAIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:08:49 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:44312 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390592AbhCCWKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 17:10:14 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHZg4-000hYk-DQ; Wed, 03 Mar 2021 15:09:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lHZg2-0007z3-1S; Wed, 03 Mar 2021 15:09:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
References: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de>
Date:   Wed, 03 Mar 2021 16:09:05 -0600
In-Reply-To: <20210303142025.wbbt2nnr6dtgwjfi@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Wed, 3 Mar 2021 15:20:25 +0100")
Message-ID: <m1zgzj7uv2.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lHZg2-0007z3-1S;;;mid=<m1zgzj7uv2.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX189jIHFqY2loenP1Kd3Or3M8Rwc6gVRNmc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMSubLong,
        XM_B_SpammyTLD autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_B_SpammyTLD Contains uncommon/spammy TLD
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Sebastian Andrzej Siewior <bigeasy@linutronix.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2070 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.2%), b_tie_ro: 2.5 (0.1%), parse: 0.90
        (0.0%), extract_message_metadata: 13 (0.6%), get_uri_detail_list: 3.0
        (0.1%), tests_pri_-1000: 5 (0.2%), tests_pri_-950: 1.05 (0.1%),
        tests_pri_-900: 0.81 (0.0%), tests_pri_-90: 102 (4.9%), check_bayes:
        99 (4.8%), b_tokenize: 12 (0.6%), b_tok_get_all: 11 (0.5%),
        b_comp_prob: 2.2 (0.1%), b_tok_touch_all: 72 (3.5%), b_finish: 0.61
        (0.0%), tests_pri_0: 1502 (72.6%), check_dkim_signature: 0.53 (0.0%),
        check_dkim_adsp: 4.7 (0.2%), poll_dns_idle: 428 (20.7%), tests_pri_10:
        1.75 (0.1%), tests_pri_500: 437 (21.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: Allow RT tasks to cache one sigqueue struct
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Allow realtime tasks to cache one sigqueue in task struct. This avoids an
> allocation which can increase the latency or fail.
> Ideally the sigqueue is cached after first successful delivery and will be
> available for next signal delivery. This works under the assumption that the RT
> task has never an unprocessed signal while a one is about to be queued.
>
> The caching is not used for SIGQUEUE_PREALLOC because this kind of sigqueue is
> handled differently (and not used for regular signal delivery).

What part of this is about real time tasks?  This allows any task
to cache a sigqueue entry.

Either the patch is buggy or the description is.  Overall caching one
sigqueue entry doesn't look insane. But it would help to have a clear
description of what is going on.

Eric


> [bigeasy: With a fix from Matt Fleming <matt@codeblueprint.co.uk>]
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/sched.h  |  1 +
>  include/linux/signal.h |  1 +
>  kernel/exit.c          |  2 +-
>  kernel/fork.c          |  1 +
>  kernel/signal.c        | 65 +++++++++++++++++++++++++++++++++++++++---
>  5 files changed, 65 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ef00bb22164cd..7009b25f48160 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -985,6 +985,7 @@ struct task_struct {
>  	/* Signal handlers: */
>  	struct signal_struct		*signal;
>  	struct sighand_struct __rcu		*sighand;
> +	struct sigqueue			*sigqueue_cache;
>  	sigset_t			blocked;
>  	sigset_t			real_blocked;
>  	/* Restored if set_restore_sigmask() was used: */
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index 205526c4003aa..d47a86790edc8 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -265,6 +265,7 @@ static inline void init_sigpending(struct sigpending *sig)
>  }
>  
>  extern void flush_sigqueue(struct sigpending *queue);
> +extern void flush_task_sigqueue(struct task_struct *tsk);
>  
>  /* Test if 'sig' is valid signal. Use this instead of testing _NSIG directly */
>  static inline int valid_signal(unsigned long sig)
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 04029e35e69af..346f7b76cecaa 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -152,7 +152,7 @@ static void __exit_signal(struct task_struct *tsk)
>  	 * Do this under ->siglock, we can race with another thread
>  	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
>  	 */
> -	flush_sigqueue(&tsk->pending);
> +	flush_task_sigqueue(tsk);
>  	tsk->sighand = NULL;
>  	spin_unlock(&sighand->siglock);
>  
> diff --git a/kernel/fork.c b/kernel/fork.c
> index d66cd1014211b..a767e4e49a692 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1993,6 +1993,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	spin_lock_init(&p->alloc_lock);
>  
>  	init_sigpending(&p->pending);
> +	p->sigqueue_cache = NULL;
>  
>  	p->utime = p->stime = p->gtime = 0;
>  #ifdef CONFIG_ARCH_HAS_SCALED_CPUTIME
> diff --git a/kernel/signal.c b/kernel/signal.c
> index ba4d1ef39a9ea..d99273b798085 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/task.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/cputime.h>
> +#include <linux/sched/rt.h>
>  #include <linux/file.h>
>  #include <linux/fs.h>
>  #include <linux/proc_fs.h>
> @@ -404,13 +405,30 @@ void task_join_group_stop(struct task_struct *task)
>  	task_set_jobctl_pending(task, mask | JOBCTL_STOP_PENDING);
>  }
>  
> +static struct sigqueue *sigqueue_from_cache(struct task_struct *t)
> +{
> +	struct sigqueue *q = t->sigqueue_cache;
> +
> +	if (q && cmpxchg(&t->sigqueue_cache, q, NULL) == q)
> +		return q;
> +	return NULL;
> +}
> +
> +static bool sigqueue_add_cache(struct task_struct *t, struct sigqueue *q)
> +{
> +	if (!t->sigqueue_cache && cmpxchg(&t->sigqueue_cache, NULL, q) == NULL)
> +		return true;
> +	return false;
> +}
> +
>  /*
>   * allocate a new signal queue record
>   * - this may be called without locks if and only if t == current, otherwise an
>   *   appropriate lock must be held to stop the target task from exiting
>   */
>  static struct sigqueue *
> -__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimit)
> +__sigqueue_do_alloc(int sig, struct task_struct *t, gfp_t flags,
> +		    int override_rlimit, bool fromslab)
>  {
>  	struct sigqueue *q = NULL;
>  	struct user_struct *user;
> @@ -432,7 +450,10 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
>  	rcu_read_unlock();
>  
>  	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
> -		q = kmem_cache_alloc(sigqueue_cachep, flags);
> +		if (!fromslab)
> +			q = sigqueue_from_cache(t);
> +		if (!q)
> +			q = kmem_cache_alloc(sigqueue_cachep, flags);
>  	} else {
>  		print_dropped_signal(sig);
>  	}
> @@ -449,6 +470,13 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
>  	return q;
>  }
>  
> +static struct sigqueue *
> +__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags,
> +		 int override_rlimit)
> +{
> +	return __sigqueue_do_alloc(sig, t, flags, override_rlimit, false);
> +}
> +
>  static void __sigqueue_free(struct sigqueue *q)
>  {
>  	if (q->flags & SIGQUEUE_PREALLOC)
> @@ -458,6 +486,20 @@ static void __sigqueue_free(struct sigqueue *q)
>  	kmem_cache_free(sigqueue_cachep, q);
>  }
>  
> +static void __sigqueue_cache_or_free(struct sigqueue *q)
> +{
> +	struct user_struct *up;
> +
> +	if (q->flags & SIGQUEUE_PREALLOC)
> +		return;
> +
> +	up = q->user;
> +	if (atomic_dec_and_test(&up->sigpending))
> +		free_uid(up);
> +	if (!task_is_realtime(current) || !sigqueue_add_cache(current, q))
> +		kmem_cache_free(sigqueue_cachep, q);
> +}
> +
>  void flush_sigqueue(struct sigpending *queue)
>  {
>  	struct sigqueue *q;
> @@ -470,6 +512,21 @@ void flush_sigqueue(struct sigpending *queue)
>  	}
>  }
>  
> +/*
> + * Called from __exit_signal. Flush tsk->pending and
> + * tsk->sigqueue_cache
> + */
> +void flush_task_sigqueue(struct task_struct *tsk)
> +{
> +	struct sigqueue *q;
> +
> +	flush_sigqueue(&tsk->pending);
> +
> +	q = sigqueue_from_cache(tsk);
> +	if (q)
> +		kmem_cache_free(sigqueue_cachep, q);
> +}
> +
>  /*
>   * Flush all pending signals for this kthread.
>   */
> @@ -594,7 +651,7 @@ static void collect_signal(int sig, struct sigpending *list, kernel_siginfo_t *i
>  			(info->si_code == SI_TIMER) &&
>  			(info->si_sys_private);
>  
> -		__sigqueue_free(first);
> +		__sigqueue_cache_or_free(first);
>  	} else {
>  		/*
>  		 * Ok, it wasn't in the queue.  This must be
> @@ -1807,7 +1864,7 @@ EXPORT_SYMBOL(kill_pid);
>   */
>  struct sigqueue *sigqueue_alloc(void)
>  {
> -	struct sigqueue *q = __sigqueue_alloc(-1, current, GFP_KERNEL, 0);
> +	struct sigqueue *q = __sigqueue_do_alloc(-1, current, GFP_KERNEL, 0, true);
>  
>  	if (q)
>  		q->flags |= SIGQUEUE_PREALLOC;
