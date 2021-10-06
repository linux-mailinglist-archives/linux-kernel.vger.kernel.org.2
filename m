Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19BC423D7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238283AbhJFMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:51274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238117AbhJFMN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:13:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CA3D861076;
        Wed,  6 Oct 2021 12:12:02 +0000 (UTC)
Date:   Wed, 6 Oct 2021 14:12:00 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 5/9] fork: add helper to clone a process
Message-ID: <20211006121200.udx2skkwllmjor4v@wittgenstein>
References: <20211004192128.381453-1-michael.christie@oracle.com>
 <20211004192128.381453-6-michael.christie@oracle.com>
 <20211005125018.5nzmhwdxivyye5on@wittgenstein>
 <00d724df-5781-035f-54ad-e0432ec92646@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00d724df-5781-035f-54ad-e0432ec92646@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 12:10:55PM -0500, Mike Christie wrote:
> On 10/5/21 7:50 AM, Christian Brauner wrote:
> > On Mon, Oct 04, 2021 at 02:21:24PM -0500, Mike Christie wrote:
> >> The vhost layer has similar requirements as io_uring where its worker
> >> threads need to access the userspace thread's memory, want to inherit the
> >> parents's cgroups and namespaces, and be checked against the parent's
> >> RLIMITs. Right now, the vhost layer uses the kthread API which has
> >> kthread_use_mm for mem access, and those threads can use
> >> cgroup_attach_task_all for v1 cgroups, but there are no helpers for the
> >> other items.
> >>
> >> This adds a helper to clone a process so we can inherit everything we
> >> want in one call. It's a more generic version of create_io_thread which
> >> will be used by the vhost layer and io_uring in later patches in this set.
> >>
> >> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> >> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> >> ---
> >>  include/linux/sched/task.h |  6 ++++-
> >>  kernel/fork.c              | 48 ++++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 53 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> >> index e165cc67fd3c..ba0499b6627c 100644
> >> --- a/include/linux/sched/task.h
> >> +++ b/include/linux/sched/task.h
> >> @@ -87,7 +87,11 @@ extern void exit_files(struct task_struct *);
> >>  extern void exit_itimers(struct signal_struct *);
> >>  
> >>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
> >> -struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
> >> +struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);
> >> +struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
> >> +				  unsigned long clone_flags, u32 worker_flags);
> >> +__printf(2, 3)
> >> +void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...);
> >>  struct task_struct *fork_idle(int);
> >>  struct mm_struct *copy_init_mm(void);
> >>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
> >> diff --git a/kernel/fork.c b/kernel/fork.c
> >> index 98264cf1d6a6..3f3fcabffa5f 100644
> >> --- a/kernel/fork.c
> >> +++ b/kernel/fork.c
> >> @@ -2540,6 +2540,54 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
> >>  	return copy_process(NULL, 0, node, &args);
> >>  }
> >>  
> >> +/**
> >> + * kernel_worker - create a copy of a process to be used by the kernel
> >> + * @fn: thread stack
> >> + * @arg: data to be passed to fn
> >> + * @node: numa node to allocate task from
> >> + * @clone_flags: CLONE flags
> >> + * @worker_flags: KERN_WORKER flags
> >> + *
> >> + * This returns a created task, or an error pointer. The returned task is
> >> + * inactive, and the caller must fire it up through kernel_worker_start(). If
> >> + * this is an PF_IO_WORKER all singals but KILL and STOP are blocked.
> >> + */
> >> +struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
> >> +				  unsigned long clone_flags, u32 worker_flags)
> >> +{
> >> +	struct kernel_clone_args args = {
> >> +		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
> >> +				   CLONE_UNTRACED) & ~CSIGNAL),
> >> +		.exit_signal	= (lower_32_bits(clone_flags) & CSIGNAL),
> >> +		.stack		= (unsigned long)fn,
> >> +		.stack_size	= (unsigned long)arg,
> >> +		.worker_flags	= KERN_WORKER_USER | worker_flags,
> >> +	};
> >> +
> >> +	return copy_process(NULL, 0, node, &args);
> >> +}
> >> +EXPORT_SYMBOL_GPL(kernel_worker);
> >> +
> >> +/**
> >> + * kernel_worker_start - Start a task created with kernel_worker
> >> + * @tsk: task to wake up
> >> + * @namefmt: printf-style format string for the thread name
> >> + * @arg: arguments for @namefmt
> >> + */
> >> +void kernel_worker_start(struct task_struct *tsk, const char namefmt[], ...)
> >> +{
> >> +	char name[TASK_COMM_LEN];
> >> +	va_list args;
> > 
> > You could think about reporting an error from this function if
> > KERN_WORK_USER isn't set or only call the below when KERN_WORK_USER is
> > set. Both options are fine.
> > 
> 
> I'm not sure how to handle this comment, because I might have misread
> an older comment or made it up in my head.
> 
> KERN_WORK_USER is only set on the kernel_clone_args, so at this point we
> don't have that struct available anymore.

Ah, right.

> 
> I didn't add a new PF_KTHREAD_WORK_USER flag to sched.h, because I thought
> I had got a review comment to not add another PF flag for this. However, I
> can't seem to find that comment now so I'm not sure if maybe I misread a
> comment or made it up.
> 
> If it's ok I could add a PF_KTHREAD_WORK_USER, then do a:
> 
> WARN_ON(!(tsk->flags & PF_KTHREAD_WORK_USER)
> 
> so future developers get loud feedback they are doing the
> wrong thing right away.

I think a PF_USER_WORKER might just do fine as it fits with the naming
of PF_IO_WORKER.

Christian
