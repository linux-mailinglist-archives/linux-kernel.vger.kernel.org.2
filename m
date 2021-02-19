Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0831F7CE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 12:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBSK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:59:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:52158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhBSK4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:56:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613732161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oCiE5hkBgOQtGTwVoz0fI2p0EypbZJmyNY/Y9H09j0E=;
        b=lzD9V9SjlcXTEeEYfaSNFb5Cl3CsT2jNHi5FNPK/hbqrD0/EyR97lrFSvgonR8olw9Aexo
        FqOL6w+JNXKy9QNv0fjj9BJZb4PYbGdfIKwcW5J5DQvh4Kc9gMFd73loZ4zDbvVtUy80TG
        9crD9fRgAHJYdthzq8j8QzcEzGgDNqc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4988CACBF;
        Fri, 19 Feb 2021 10:56:01 +0000 (UTC)
Date:   Fri, 19 Feb 2021 11:56:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Yiwei Zhang <zzyiwei@android.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jens Axboe <axboe@kernel.dk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ilias Stamatis <stamatis.iliass@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Liang Chen <cl@rock-chips.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] kthread: add kthread_mod_pending_delayed_work api
Message-ID: <YC+ZQAwwb4RGgjDf@alley>
References: <20210214000611.2169820-1-zzyiwei@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214000611.2169820-1-zzyiwei@android.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-02-14 00:06:11, Yiwei Zhang wrote:
> The existing kthread_mod_delayed_work api will queue a new work if
> failing to cancel the current work due to no longer being pending.
> However, there's a case that the same work can be enqueued from both
> an async request and a delayed work, and a racing could happen if the
> async request comes right after the timeout delayed work gets scheduled,
> because the clean up work may not be safe to run twice.

Please, provide more details about the use case. Why the work is
originally sheduled with a delay. And and why it suddenly can/should
be proceed immediately.

> 
> Signed-off-by: Yiwei Zhang <zzyiwei@android.com>
> ---
>  include/linux/kthread.h |  3 +++
>  kernel/kthread.c        | 48 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -1142,6 +1142,54 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>  }
>  EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
>  
> +/**
> + * kthread_mod_pending_delayed_work - modify delay of a pending delayed work
> + * @worker: kthread worker to use
> + * @dwork: kthread delayed work to queue
> + * @delay: number of jiffies to wait before queuing
> + *
> + * If @dwork is still pending modify @dwork's timer so that it expires after
> + * @delay. If @dwork is still pending and @delay is zero, @work is guaranteed to
> + * be queued immediately.
> + *
> + * Return: %true if @dwork was pending and its timer was modified,
> + * %false otherwise.
> + *
> + * A special case is when the work is being canceled in parallel.
> + * It might be caused either by the real kthread_cancel_delayed_work_sync()
> + * or yet another kthread_mod_delayed_work() call. We let the other command
> + * win and return %false here. The caller is supposed to synchronize these
> + * operations a reasonable way.
> + *
> + * This function is safe to call from any context including IRQ handler.
> + * See __kthread_cancel_work() and kthread_delayed_work_timer_fn()
> + * for details.
> + */
> +bool kthread_mod_pending_delayed_work(struct kthread_worker *worker,
> +				      struct kthread_delayed_work *dwork,
> +				      unsigned long delay)
> +{

kthread_worker API tries to follow the workqueue API. It helps to use and
switch between them easily.

workqueue API does not provide this possibility. Instead it has
flush_delayed_work(). It queues the work when it was pending and
waits until the work is procced. So, we might do:

bool kthread_flush_delayed_work(struct kthread_delayed_work *dwork)


> +	struct kthread_work *work = &dwork->work;
> +	unsigned long flags;
> +	int ret = true;
> +
> +	raw_spin_lock_irqsave(&worker->lock, flags);
> +	if (!work->worker || work->canceling ||
> +	    !__kthread_cancel_work(work, true, &flags)) {
> +		ret = false;
> +		goto out;
> +	}

Please, use separate checks with comments as it is done, for example,
in kthread_mod_delayed_work()

	struct kthread_work *work = &dwork->work;
	unsigned long flags;
	int ret;

	raw_spin_lock_irqsave(&worker->lock, flags);

	/* Do not bother with canceling when never queued. */
	if (!work->worker)
		goto nope;

	/* Do not fight with another command that is canceling this work. */
	if (work->canceling)
		goto nope;

	/* Nope when the work was not pending. */
	ret = __kthread_cancel_work(work, true, &flags);
	if (!ret)
		nope;

	/* Queue the work immediately. */
	kthread_insert_work(worker, work, &worker->work_list);
	raw_spin_unlock_irqrestore(&worker->lock, flags);

	return kthread_flush_work(work);
nope:
	raw_spin_unlock_irqrestore(&worker->lock, flags);
	return false;


Will this work for you?

Best Regards,
Petr
