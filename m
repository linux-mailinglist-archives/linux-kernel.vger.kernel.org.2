Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3640F46A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245512AbhIQItl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:54510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235322AbhIQItk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:49:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66B796112E;
        Fri, 17 Sep 2021 08:48:17 +0000 (UTC)
Date:   Fri, 17 Sep 2021 10:48:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] fork: add helper to clone a process
Message-ID: <20210917084815.audgjc4q6wcbirwp@wittgenstein>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916212051.6918-2-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:20:44PM -0500, Mike Christie wrote:
> The vhost layer has similar requirements as io_uring where its worker
> threads need to access the userspace thread's memory, want to inherit the
> parents's cgroups and namespaces, and be checked against the parent's
> RLIMITs. Right now, the vhost layer uses the kthread API which has
> kthread_use_mm for mem access, and those threads can use
> cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
> other items.
> 
> This adds a helper to clone a process so we can inherit everything we
> want in one call. It's a more generic version of create_io_thread which
> will be used by the vhost layer and io_uring in later patches in this set.
> 
> This patch also exports __set_task_comm and wake_up_new_task which is
> needed by modules to use the new helper. io_uring calls these functions
> already but its always built into the kernel so was not needed before.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  fs/exec.c                  |  7 +++++++
>  include/linux/sched/task.h |  3 +++
>  kernel/fork.c              | 29 +++++++++++++++++++++++++++++
>  kernel/sched/core.c        |  4 +++-
>  4 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index a098c133d8d7..9fc4bb0c5c7e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1220,6 +1220,12 @@ EXPORT_SYMBOL_GPL(__get_task_comm);
>   * so that a new one can be started
>   */
>  
> +/**
> + * __set_task_comm - set the task's executable name
> + * @tsk: task_struct to modify
> + * @buf: executable name
> + * @exec: true if called during a process exec. false for name changes.
> + */
>  void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  {
>  	task_lock(tsk);
> @@ -1228,6 +1234,7 @@ void __set_task_comm(struct task_struct *tsk, const char *buf, bool exec)
>  	task_unlock(tsk);
>  	perf_event_comm(tsk, exec);
>  }
> +EXPORT_SYMBOL_GPL(__set_task_comm);
>  
>  /*
>   * Calling this is the point of no return. None of the failures will be
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index ef02be869cf2..c55f1eb69d41 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -84,6 +84,9 @@ extern void exit_itimers(struct signal_struct *);
>  
>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
>  struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
> +struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
> +					unsigned long clone_flags,
> +					int io_thread);
>  struct task_struct *fork_idle(int);
>  struct mm_struct *copy_init_mm(void);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 38681ad44c76..cec7b6011beb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2532,6 +2532,35 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  	return copy_process(NULL, 0, node, &args);
>  }
>  
> +/**
> + * kernel_copy_process - create a copy of a process to be used by the kernel
> + * @fn: thread stack
> + * @arg: data to be passed to fn
> + * @node: numa node to allocate task from
> + * @clone_flags: CLONE flags
> + * @io_thread: 1 if this will be a PF_IO_WORKER else 0.
> + *
> + * This returns a created task, or an error pointer. The returned task is
> + * inactive, and the caller must fire it up through wake_up_new_task(p). If
> + * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
> + */
> +struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
> +					unsigned long clone_flags,
> +					int io_thread)

Hm, not excited about the name. I think

kernel_worker_create()

or simply

kernel_worker()

is better.
