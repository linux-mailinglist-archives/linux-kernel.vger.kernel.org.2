Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAFD4149C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 14:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhIVMzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 08:55:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236016AbhIVMzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 08:55:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7E9561181;
        Wed, 22 Sep 2021 12:53:48 +0000 (UTC)
Date:   Wed, 22 Sep 2021 14:53:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     hdanton@sina.com, hch@infradead.org, stefanha@redhat.com,
        jasowang@redhat.com, mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 6/9] io_uring: switch to kernel_worker
Message-ID: <20210922125346.qd2koricy5vt3655@wittgenstein>
References: <20210921215218.89844-1-michael.christie@oracle.com>
 <20210921215218.89844-7-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210921215218.89844-7-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 04:52:15PM -0500, Mike Christie wrote:
> Convert io_uring and io-wq to use kernel_worker.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <christian.brauner@ubuntu.com>

>  fs/io-wq.c                 | 15 ++++++++-------
>  fs/io_uring.c              | 11 +++++------
>  include/linux/sched/task.h |  1 -
>  3 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index c2e0e8e80949..74e68132a227 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -69,6 +69,9 @@ struct io_worker {
>  
>  #define IO_WQ_NR_HASH_BUCKETS	(1u << IO_WQ_HASH_ORDER)
>  
> +#define IO_WQ_CLONE_FLAGS	(CLONE_FS | CLONE_FILES | CLONE_SIGHAND | \
> +				 CLONE_THREAD | CLONE_IO)
> +
>  struct io_wqe_acct {
>  	unsigned nr_workers;
>  	unsigned max_workers;
> @@ -549,13 +552,9 @@ static int io_wqe_worker(void *data)
>  	struct io_wqe *wqe = worker->wqe;
>  	struct io_wq *wq = wqe->wq;
>  	bool last_timeout = false;
> -	char buf[TASK_COMM_LEN];
>  
>  	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
>  
> -	snprintf(buf, sizeof(buf), "iou-wrk-%d", wq->task->pid);
> -	set_task_comm(current, buf);
> -
>  	while (!test_bit(IO_WQ_BIT_EXIT, &wq->state)) {
>  		long ret;
>  
> @@ -652,7 +651,7 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
>  	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
>  	worker->flags |= IO_WORKER_F_FREE;
>  	raw_spin_unlock(&wqe->lock);
> -	wake_up_new_task(tsk);
> +	kernel_worker_start(tsk, "iou-wrk-%d", wqe->wq->task->pid);
>  }
>  
>  static bool io_wq_work_match_all(struct io_wq_work *work, void *data)
> @@ -682,7 +681,8 @@ static void create_worker_cont(struct callback_head *cb)
>  	worker = container_of(cb, struct io_worker, create_work);
>  	clear_bit_unlock(0, &worker->create_state);
>  	wqe = worker->wqe;
> -	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
> +	tsk = kernel_worker(io_wqe_worker, worker, wqe->node,
> +			    IO_WQ_CLONE_FLAGS, KERN_WORKER_IO);
>  	if (!IS_ERR(tsk)) {
>  		io_init_new_worker(wqe, worker, tsk);
>  		io_worker_release(worker);
> @@ -752,7 +752,8 @@ static bool create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
>  	if (index == IO_WQ_ACCT_BOUND)
>  		worker->flags |= IO_WORKER_F_BOUND;
>  
> -	tsk = create_io_thread(io_wqe_worker, worker, wqe->node);
> +	tsk = kernel_worker(io_wqe_worker, worker, wqe->node, IO_WQ_CLONE_FLAGS,
> +			    KERN_WORKER_IO);
>  	if (!IS_ERR(tsk)) {
>  		io_init_new_worker(wqe, worker, tsk);
>  	} else if (!io_should_retry_thread(PTR_ERR(tsk))) {
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index e372d5b9f6dc..1df7bec8bd76 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -7393,12 +7393,8 @@ static int io_sq_thread(void *data)
>  	struct io_sq_data *sqd = data;
>  	struct io_ring_ctx *ctx;
>  	unsigned long timeout = 0;
> -	char buf[TASK_COMM_LEN];
>  	DEFINE_WAIT(wait);
>  
> -	snprintf(buf, sizeof(buf), "iou-sqp-%d", sqd->task_pid);
> -	set_task_comm(current, buf);
> -
>  	if (sqd->sq_cpu != -1)
>  		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
>  	else
> @@ -8580,6 +8576,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
>  		fdput(f);
>  	}
>  	if (ctx->flags & IORING_SETUP_SQPOLL) {
> +		unsigned long flags = CLONE_FS | CLONE_FILES | CLONE_SIGHAND |
> +					CLONE_THREAD | CLONE_IO;
>  		struct task_struct *tsk;
>  		struct io_sq_data *sqd;
>  		bool attached;
> @@ -8621,7 +8619,8 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
>  
>  		sqd->task_pid = current->pid;
>  		sqd->task_tgid = current->tgid;
> -		tsk = create_io_thread(io_sq_thread, sqd, NUMA_NO_NODE);
> +		tsk = kernel_worker(io_sq_thread, sqd, NUMA_NO_NODE,
> +				    flags, KERN_WORKER_IO);
>  		if (IS_ERR(tsk)) {
>  			ret = PTR_ERR(tsk);
>  			goto err_sqpoll;
> @@ -8629,7 +8628,7 @@ static int io_sq_offload_create(struct io_ring_ctx *ctx,
>  
>  		sqd->thread = tsk;
>  		ret = io_uring_alloc_task_context(tsk, ctx);
> -		wake_up_new_task(tsk);
> +		kernel_worker_start(tsk, "iou-sqp-%d", sqd->task_pid);
>  		if (ret)
>  			goto err;
>  	} else if (p->flags & IORING_SETUP_SQ_AFF) {
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index ba0499b6627c..781abbc1c288 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -87,7 +87,6 @@ extern void exit_files(struct task_struct *);
>  extern void exit_itimers(struct signal_struct *);
>  
>  extern pid_t kernel_clone(struct kernel_clone_args *kargs);
> -struct task_struct *create_io_thread(int (*fn)(void *i), void *arg, int node);
>  struct task_struct *kernel_worker(int (*fn)(void *), void *arg, int node,
>  				  unsigned long clone_flags, u32 worker_flags);
>  __printf(2, 3)
> -- 
> 2.25.1
> 
