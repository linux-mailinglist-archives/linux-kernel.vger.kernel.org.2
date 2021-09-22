Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A1B4149BA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236244AbhIVMyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:54:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236189AbhIVMyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:54:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1BA59610A0;
        Wed, 22 Sep 2021 12:52:37 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:52:36 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/9] fork: Add worker flag to ignore signals
Message-ID: <20210922125236.7cb77rxbwkv7x4zj@wittgenstein>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-8-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-8-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:16PM -0500, Mike Christie wrote:
> The kthread API creates threads that ignore all signals by default so
> modules like vhost that will move from that API to kernel_worker will
> not be expecting them. This patch adds a worker flag that tells
> kernel_worker to setup the task to ignore signals.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---

Looks good,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/linux/sched/task.h |  1 +
>  kernel/fork.c              | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 781abbc1c288..aefa0d221b57 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -21,6 +21,7 @@ struct css_set;
>  #define KERN_WORKER_IO		BIT(0)
>  #define KERN_WORKER_USER	BIT(1)
>  #define KERN_WORKER_NO_FILES	BIT(2)
> +#define KERN_WORKER_NO_SIGS	BIT(3)
>  
>  struct kernel_clone_args {
>  	u64 flags;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 3f3fcabffa5f..34d3dca70cfb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2555,6 +2555,8 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
>  struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  				  unsigned long clone_flags, u32 worker_flags)
>  {
> +	struct task_struct *tsk;
> +
>  	struct kernel_clone_args args = {
>  		.flags		= ((lower_32_bits(clone_flags) | CLONE_VM |
>  				   CLONE_UNTRACED) & ~CSIGNAL),
> @@ -2564,7 +2566,14 @@ struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  		.worker_flags	= KERN_WORKER_USER | worker_flags,
>  	};
>  
> -	return copy_process(NULL, 0, node, &args);
> +	tsk = copy_process(NULL, 0, node, &args);
> +	if (IS_ERR(tsk))
> +		return tsk;
> +
> +	if (worker_flags & KERN_WORKER_NO_SIGS)
> +		ignore_signals(tsk);
> +
> +	return tsk;
>  }
>  EXPORT_SYMBOL_GPL(kernel_worker);
>  
> -- 
> 2.25.1
> 
