Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F54F3B72E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbhF2NHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 09:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233593AbhF2NHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 09:07:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 646F061CFA;
        Tue, 29 Jun 2021 13:04:53 +0000 (UTC)
Date:   Tue, 29 Jun 2021 15:04:50 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        christian@brauner.io, akpm@linux-foundation.org,
        peterz@infradead.org
Subject: Re: [PATCH 2/3] kernel/fork, cred.c: allow copy_process to take user
Message-ID: <20210629130450.tvrweqy7z2hlwsbh@wittgenstein>
References: <20210624030804.4932-1-michael.christie@oracle.com>
 <20210624030804.4932-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624030804.4932-3-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:08:03PM -0500, Mike Christie wrote:
> This allows kthread to pass copy_process the user we want to check for the
> RLIMIT_NPROC limit for and also charge for the new process. It will be used
> by vhost where userspace has that driver create threads but the kthreadd
> thread is checked/charged.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  include/linux/cred.h |  3 ++-
>  kernel/cred.c        |  7 ++++---
>  kernel/fork.c        | 12 +++++++-----
>  3 files changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 14971322e1a0..9a2c1398cdd4 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -153,7 +153,8 @@ struct cred {
>  
>  extern void __put_cred(struct cred *);
>  extern void exit_creds(struct task_struct *);
> -extern int copy_creds(struct task_struct *, unsigned long);
> +extern int copy_creds(struct task_struct *, unsigned long,
> +		      struct user_struct *);
>  extern const struct cred *get_task_cred(struct task_struct *);
>  extern struct cred *cred_alloc_blank(void);
>  extern struct cred *prepare_creds(void);
> diff --git a/kernel/cred.c b/kernel/cred.c
> index e1d274cd741b..e006aafa8f05 100644
> --- a/kernel/cred.c
> +++ b/kernel/cred.c
> @@ -330,7 +330,8 @@ struct cred *prepare_exec_creds(void)
>   * The new process gets the current process's subjective credentials as its
>   * objective and subjective credentials
>   */
> -int copy_creds(struct task_struct *p, unsigned long clone_flags)
> +int copy_creds(struct task_struct *p, unsigned long clone_flags,
> +	       struct user_struct *user)
>  {
>  	struct cred *new;
>  	int ret;
> @@ -351,7 +352,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  		kdebug("share_creds(%p{%d,%d})",
>  		       p->cred, atomic_read(&p->cred->usage),
>  		       read_cred_subscribers(p->cred));
> -		atomic_inc(&p->cred->user->processes);
> +		atomic_inc(&user->processes);

Hey Mike,

This won't work anymore since this has moved into ucounts. So in v5.14
atomic_inc(&p->cred->user->processes);
will have been replaced by
inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);

From what I can see from your code vhost will always create this kthread
for current. So you could e.g. add an internal flag/bitfield entry to
struct kernel_clone_args that you can use to tell copy_creds() that you
want to charge this thread against current's process limit.

>  		return 0;
>  	}
>  
> @@ -384,7 +385,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
>  	}
>  #endif
>  
> -	atomic_inc(&new->user->processes);
> +	atomic_inc(&user->processes);
>  	p->cred = p->real_cred = get_cred(new);
>  	alter_cred_subscribers(new, 2);
>  	validate_creds(new);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index dc06afd725cb..6389aea6d3eb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1860,6 +1860,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	struct file *pidfile = NULL;
>  	u64 clone_flags = args->flags;
>  	struct nsproxy *nsp = current->nsproxy;
> +	struct user_struct *user = args->user;
>  
>  	/*
>  	 * Don't allow sharing the root directory with processes in a different
> @@ -1976,16 +1977,17 @@ static __latent_entropy struct task_struct *copy_process(
>  #ifdef CONFIG_PROVE_LOCKING
>  	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
>  #endif
> +	if (!user)
> +		user = p->real_cred->user;
>  	retval = -EAGAIN;
> -	if (atomic_read(&p->real_cred->user->processes) >=
> -			task_rlimit(p, RLIMIT_NPROC)) {
> -		if (p->real_cred->user != INIT_USER &&
> +	if (atomic_read(&user->processes) >= task_rlimit(p, RLIMIT_NPROC)) {
> +		if (user != INIT_USER &&
>  		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
>  			goto bad_fork_free;
>  	}
>  	current->flags &= ~PF_NPROC_EXCEEDED;
>  
> -	retval = copy_creds(p, clone_flags);
> +	retval = copy_creds(p, clone_flags, user);
>  	if (retval < 0)
>  		goto bad_fork_free;
>  
> @@ -2385,7 +2387,7 @@ static __latent_entropy struct task_struct *copy_process(
>  #endif
>  	delayacct_tsk_free(p);
>  bad_fork_cleanup_count:
> -	atomic_dec(&p->cred->user->processes);
> +	atomic_dec(&user->processes);
>  	exit_creds(p);
>  bad_fork_free:
>  	p->state = TASK_DEAD;
> -- 
> 2.25.1
