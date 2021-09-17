Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AC040F472
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbhIQI4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:56:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233979AbhIQI4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:56:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8754161056;
        Fri, 17 Sep 2021 08:54:57 +0000 (UTC)
Date:   Fri, 17 Sep 2021 10:54:55 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] fork: add option to not clone or dup files
Message-ID: <20210917085455.xggfayhxdq6eejz4@wittgenstein>
References: <20210916212051.6918-1-michael.christie@oracle.com>
 <20210916212051.6918-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210916212051.6918-4-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:20:46PM -0500, Mike Christie wrote:
> Each vhost device gets a thread that is used to perform IO and management
> operations. Instead of a thread that is accessing a device, the thread is
> part of the device, so when it calls kernel_copy_process we can't dup or
> clone the parent's (Qemu thread that does the VHOST_SET_OWNER ioctl)
> files/FDS because it would do an extra increment on ourself.
> 
> Later, when we do:
> 
> Qemu process exits:
> 	do_exit -> exit_files -> put_files_struct -> close_files
> 
> we would leak the device's resources because of that extra refcount
> on the fd or file_struct.
> 
> This patch adds a no_files option so these worker threads can prevent
> taking an extra refcount on themselves.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  include/linux/sched/task.h |  3 ++-
>  kernel/fork.c              | 14 +++++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index c55f1eb69d41..d0b0872f56cc 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -32,6 +32,7 @@ struct kernel_clone_args {
>  	size_t set_tid_size;
>  	int cgroup;
>  	int io_thread;
> +	int no_files;
>  	struct cgroup *cgrp;
>  	struct css_set *cset;
>  };
> @@ -86,7 +87,7 @@ extern pid_t kernel_clone(struct kernel_clone_args *kargs);
>  struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
>  struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
>  					unsigned long clone_flags,
> -					int io_thread);
> +					int io_thread, int no_files);
>  struct task_struct *fork_idle(int);
>  struct mm_struct *copy_init_mm(void);
>  extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
> diff --git a/kernel/fork.c b/kernel/fork.c
> index cec7b6011beb..a0468e30b27e 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1532,7 +1532,8 @@ static int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
>  	return 0;
>  }
>  
> -static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
> +static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
> +		      int no_files)
>  {
>  	struct files_struct *oldf, *newf;
>  	int error = 0;
> @@ -1544,6 +1545,11 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk)
>  	if (!oldf)
>  		goto out;
>  
> +	if (no_files) {
> +		tsk->files = NULL;
> +		goto out;
> +	}
> +
>  	if (clone_flags & CLONE_FILES) {
>  		atomic_inc(&oldf->count);
>  		goto out;
> @@ -2179,7 +2185,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	retval = copy_semundo(clone_flags, p);
>  	if (retval)
>  		goto bad_fork_cleanup_security;
> -	retval = copy_files(clone_flags, p);
> +	retval = copy_files(clone_flags, p, args->no_files);
>  	if (retval)
>  		goto bad_fork_cleanup_semundo;
>  	retval = copy_fs(clone_flags, p);
> @@ -2539,6 +2545,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>   * @node: numa node to allocate task from
>   * @clone_flags: CLONE flags
>   * @io_thread: 1 if this will be a PF_IO_WORKER else 0.
> + * @no_files: Do not duplicate or copy the parent's open files.
>   *
>   * This returns a created task, or an error pointer. The returned task is
>   * inactive, and the caller must fire it up through wake_up_new_task(p). If
> @@ -2546,7 +2553,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>   */
>  struct task_struct *kernel_copy_process(int (*fn)(void *), void *arg, int node,
>  					unsigned long clone_flags,
> -					int io_thread)
> +					int io_thread, int no_files)

I think that the addition of no_files together with io_thread might be a
sign to introduce a set of kernel internal clone flags in
kernel_clone_args.
