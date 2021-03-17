Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4333F7FD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhCQSPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:15:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38412 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhCQSPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:15:22 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lMahT-0003WC-Re; Wed, 17 Mar 2021 18:15:20 +0000
Date:   Wed, 17 Mar 2021 19:15:18 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Li Li <dualli@chromium.org>
Cc:     dualli@google.com, tkjos@google.com, gregkh@linuxfoundation.org,
        christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com, hridya@google.com,
        surenb@google.com, joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH v3 1/3] binder: BINDER_FREEZE ioctl
Message-ID: <20210317181518.zclcb5vmhxjuk52s@wittgenstein>
References: <20210316011630.1121213-1-dualli@chromium.org>
 <20210316011630.1121213-2-dualli@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316011630.1121213-2-dualli@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 06:16:28PM -0700, Li Li wrote:
> From: Marco Ballesio <balejs@google.com>
> 
> Frozen tasks can't process binder transactions, so a way is required to
> inform transmitting ends of communication failures due to the frozen
> state of their receiving counterparts. Additionally, races are possible
> between transitions to frozen state and binder transactions enqueued to
> a specific process.
> 
> Implement BINDER_FREEZE ioctl for user space to inform the binder driver
> about the intention to freeze or unfreeze a process. When the ioctl is
> called, block the caller until any pending binder transactions toward
> the target process are flushed. Return an error to transactions to
> processes marked as frozen.
> 
> Signed-off-by: Marco Ballesio <balejs@google.com>
> Co-developed-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Signed-off-by: Li Li <dualli@google.com>
> ---
>  drivers/android/binder.c            | 139 ++++++++++++++++++++++++++--
>  drivers/android/binder_internal.h   |  12 +++
>  include/uapi/linux/android/binder.h |  13 +++
>  3 files changed, 154 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index c119736ca56a..b93ca53bb90f 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -1506,6 +1506,12 @@ static void binder_free_transaction(struct binder_transaction *t)
>  
>  	if (target_proc) {
>  		binder_inner_proc_lock(target_proc);
> +		target_proc->outstanding_txns--;
> +		if (target_proc->outstanding_txns < 0)
> +			pr_warn("%s: Unexpected outstanding_txns %d\n",
> +				__func__, target_proc->outstanding_txns);
> +		if (!target_proc->outstanding_txns && target_proc->is_frozen)
> +			wake_up_interruptible_all(&target_proc->freeze_wait);
>  		if (t->buffer)
>  			t->buffer->transaction = NULL;
>  		binder_inner_proc_unlock(target_proc);
> @@ -2331,10 +2337,11 @@ static int binder_fixup_parent(struct binder_transaction *t,
>   * If the @thread parameter is not NULL, the transaction is always queued
>   * to the waitlist of that specific thread.
>   *
> - * Return:	true if the transactions was successfully queued
> - *		false if the target process or thread is dead
> + * Return:	0 if the transaction was successfully queued
> + *		BR_DEAD_REPLY if the target process or thread is dead
> + *		BR_FROZEN_REPLY if the target process or thread is frozen
>   */
> -static bool binder_proc_transaction(struct binder_transaction *t,
> +static int binder_proc_transaction(struct binder_transaction *t,
>  				    struct binder_proc *proc,
>  				    struct binder_thread *thread)
>  {
> @@ -2354,10 +2361,11 @@ static bool binder_proc_transaction(struct binder_transaction *t,
>  
>  	binder_inner_proc_lock(proc);
>  
> -	if (proc->is_dead || (thread && thread->is_dead)) {
> +	if ((proc->is_frozen && !oneway) || proc->is_dead ||
> +			(thread && thread->is_dead)) {
>  		binder_inner_proc_unlock(proc);
>  		binder_node_unlock(node);
> -		return false;
> +		return proc->is_frozen ? BR_FROZEN_REPLY : BR_DEAD_REPLY;
>  	}
>  
>  	if (!thread && !pending_async)
> @@ -2373,10 +2381,11 @@ static bool binder_proc_transaction(struct binder_transaction *t,
>  	if (!pending_async)
>  		binder_wakeup_thread_ilocked(proc, thread, !oneway /* sync */);
>  
> +	proc->outstanding_txns++;
>  	binder_inner_proc_unlock(proc);
>  	binder_node_unlock(node);
>  
> -	return true;
> +	return 0;
>  }
>  
>  /**
> @@ -3013,13 +3022,16 @@ static void binder_transaction(struct binder_proc *proc,
>  	if (reply) {
>  		binder_enqueue_thread_work(thread, tcomplete);
>  		binder_inner_proc_lock(target_proc);
> -		if (target_thread->is_dead) {
> +		if (target_thread->is_dead || target_proc->is_frozen) {
> +			return_error = target_thread->is_dead ?
> +				BR_DEAD_REPLY : BR_FROZEN_REPLY;
>  			binder_inner_proc_unlock(target_proc);
>  			goto err_dead_proc_or_thread;
>  		}
>  		BUG_ON(t->buffer->async_transaction != 0);
>  		binder_pop_transaction_ilocked(target_thread, in_reply_to);
>  		binder_enqueue_thread_work_ilocked(target_thread, &t->work);
> +		target_proc->outstanding_txns++;
>  		binder_inner_proc_unlock(target_proc);
>  		wake_up_interruptible_sync(&target_thread->wait);
>  		binder_free_transaction(in_reply_to);
> @@ -3038,7 +3050,9 @@ static void binder_transaction(struct binder_proc *proc,
>  		t->from_parent = thread->transaction_stack;
>  		thread->transaction_stack = t;
>  		binder_inner_proc_unlock(proc);
> -		if (!binder_proc_transaction(t, target_proc, target_thread)) {
> +		return_error = binder_proc_transaction(t,
> +				target_proc, target_thread);
> +		if (return_error) {
>  			binder_inner_proc_lock(proc);
>  			binder_pop_transaction_ilocked(thread, t);
>  			binder_inner_proc_unlock(proc);
> @@ -3048,7 +3062,8 @@ static void binder_transaction(struct binder_proc *proc,
>  		BUG_ON(target_node == NULL);
>  		BUG_ON(t->buffer->async_transaction != 1);
>  		binder_enqueue_thread_work(thread, tcomplete);
> -		if (!binder_proc_transaction(t, target_proc, NULL))
> +		return_error = binder_proc_transaction(t, target_proc, NULL);
> +		if (return_error)
>  			goto err_dead_proc_or_thread;
>  	}
>  	if (target_thread)
> @@ -3065,7 +3080,6 @@ static void binder_transaction(struct binder_proc *proc,
>  	return;
>  
>  err_dead_proc_or_thread:
> -	return_error = BR_DEAD_REPLY;
>  	return_error_line = __LINE__;
>  	binder_dequeue_work(proc, tcomplete);
>  err_translate_failed:
> @@ -4298,6 +4312,9 @@ static void binder_free_proc(struct binder_proc *proc)
>  
>  	BUG_ON(!list_empty(&proc->todo));
>  	BUG_ON(!list_empty(&proc->delivered_death));
> +	if (proc->outstanding_txns)
> +		pr_warn("%s: Unexpected outstanding_txns %d\n",
> +			__func__, proc->outstanding_txns);
>  	device = container_of(proc->context, struct binder_device, context);
>  	if (refcount_dec_and_test(&device->ref)) {
>  		kfree(proc->context->name);
> @@ -4359,6 +4376,7 @@ static int binder_thread_release(struct binder_proc *proc,
>  			     (t->to_thread == thread) ? "in" : "out");
>  
>  		if (t->to_thread == thread) {
> +			thread->proc->outstanding_txns--;
>  			t->to_proc = NULL;
>  			t->to_thread = NULL;
>  			if (t->buffer) {
> @@ -4609,6 +4627,45 @@ static int binder_ioctl_get_node_debug_info(struct binder_proc *proc,
>  	return 0;
>  }
>  
> +static int binder_ioctl_freeze(struct binder_freeze_info *info,
> +			       struct binder_proc *target_proc)
> +{
> +	int ret = 0;
> +
> +	if (!info->enable) {
> +		binder_inner_proc_lock(target_proc);
> +		target_proc->is_frozen = false;
> +		binder_inner_proc_unlock(target_proc);
> +		return 0;
> +	}
> +
> +	/*
> +	 * Freezing the target. Prevent new transactions by
> +	 * setting frozen state. If timeout specified, wait
> +	 * for transactions to drain.
> +	 */
> +	binder_inner_proc_lock(target_proc);
> +	target_proc->is_frozen = true;
> +	binder_inner_proc_unlock(target_proc);
> +
> +	if (info->timeout_ms > 0)
> +		ret = wait_event_interruptible_timeout(
> +			target_proc->freeze_wait,
> +			(!target_proc->outstanding_txns),
> +			msecs_to_jiffies(info->timeout_ms));
> +
> +	if (!ret && target_proc->outstanding_txns)
> +		ret = -EAGAIN;
> +
> +	if (ret < 0) {
> +		binder_inner_proc_lock(target_proc);
> +		target_proc->is_frozen = false;
> +		binder_inner_proc_unlock(target_proc);
> +	}
> +
> +	return ret;
> +}
> +
>  static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	int ret;
> @@ -4727,6 +4784,66 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		}
>  		break;
>  	}
> +	case BINDER_FREEZE: {
> +		struct binder_freeze_info info;
> +		struct binder_proc **target_procs = NULL, *target_proc;
> +		int target_procs_count = 0, i = 0;
> +
> +		ret = 0;
> +
> +		if (copy_from_user(&info, ubuf, sizeof(info))) {

This is not at all a blocker to this I just want to point out that if
you wanted to you could ensure that this API is extensible with
guaranteed forward- and backward compatibility by switching to the
copy_struct_from_user() API that Aleksa and I added and that is nowadays
used in a bunch of syscalls (openat2((), clone3(), mount_setattr(),
sched_setattr() etc.). For the seccomp notifier work we did we extended
this concept to ioctls(), see

kernel/seccomp.c:

static long seccomp_notify_ioctl(struct file *file, unsigned int cmd,
				 unsigned long arg)
{
	struct seccomp_filter *filter = file->private_data;
	void __user *buf = (void __user *)arg;

	/* Fixed-size ioctls */
	switch (cmd) {
	case SECCOMP_IOCTL_NOTIF_RECV:
		return seccomp_notify_recv(filter, buf);
	case SECCOMP_IOCTL_NOTIF_SEND:
		return seccomp_notify_send(filter, buf);
	case SECCOMP_IOCTL_NOTIF_ID_VALID_WRONG_DIR:
	case SECCOMP_IOCTL_NOTIF_ID_VALID:
		return seccomp_notify_id_valid(filter, buf);
	}

	/* Extensible Argument ioctls */
#define EA_IOCTL(cmd)	((cmd) & ~(IOC_INOUT | IOCSIZE_MASK))
	switch (EA_IOCTL(cmd)) {
	case EA_IOCTL(SECCOMP_IOCTL_NOTIF_ADDFD):
		return seccomp_notify_addfd(filter, buf, _IOC_SIZE(cmd));
	default:
		return -EINVAL;
	}
}

Christian
