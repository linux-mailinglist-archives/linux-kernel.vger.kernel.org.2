Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6823E3F82D8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239999AbhHZHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 03:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40723 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234415AbhHZHEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 03:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629961435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yy+7SH52lkpsFpwVI1FV8ZHvBbwn+JPBJyEQCnI8skM=;
        b=cPDGsjP8q/X5Gj2qlNbgY8AE79BvW4hsk3A2CLElVIh4nHAN1y0+ZoJ/sinC19hgR8SRXn
        dZYf3UGwXsiRjgkzkHd8rueKG0+J4fUDbGrGRfjawmHtwHyNaGDQlPPypFQlpLbaTpwf7l
        XFGa03Ow6yZKKH2Vajeq86XkWZX9vOY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-p9V3QM2-NL2ugRPbS6dPLA-1; Thu, 26 Aug 2021 03:03:53 -0400
X-MC-Unique: p9V3QM2-NL2ugRPbS6dPLA-1
Received: by mail-pf1-f197.google.com with SMTP id h14-20020a62b40e0000b02903131bc4a1acso1067691pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yy+7SH52lkpsFpwVI1FV8ZHvBbwn+JPBJyEQCnI8skM=;
        b=UQyTwni5H+VElRBbo3pdgjIqm9RZJFtK6JfkI3bU3DguKsGWmTeD215byozBnBUHmi
         HypN7jre/qXeJVmou0/tOo6XghLLUlHEhMe6VsJ/fdEnvXr/zxVCZB9eHB3nlDDtLNZC
         yUlh4LZI+kYvdfzgoUUXoFaq+RNByGLRiejWzTpCvTdyLfqfi/vGcIbxFUp0BswwZKF2
         YoYD7sT8yRMhYJhBLxD3IYZgiDNV6zjiXkwtOWFBfilBBNHf4m1lw+OVPmlDOjt1gT5s
         tPxUzr0PcPvx7nEFzfYV6OnegjC4UBv05YA18yK2nzbA5C0TjFBXHYwLu2/T8AIJMuGw
         fRIA==
X-Gm-Message-State: AOAM532skEML5PrWCBPqr0CmWLB9Sorjqn2yUH/9boR4NUuZcH/rAKTK
        WEyY/Eo6i7VD19Ycy3sesQCfoRB1jzmDEAbw7YssXdE2/VtsDdjQJhdL7gt4i9h5BFAZLg5tSTw
        NnzkVGevDd3UXh8vr06YKLG4Y
X-Received: by 2002:a17:90a:ab87:: with SMTP id n7mr2737935pjq.32.1629961432774;
        Thu, 26 Aug 2021 00:03:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTeTQOv/Z+0nHL04Z0lk7jjcCnUw2SnEt1Oj6Ao22OHX1Knpyn9aOkH7mU3qu/5bhTFkDR/w==
X-Received: by 2002:a17:90a:ab87:: with SMTP id n7mr2737899pjq.32.1629961432477;
        Thu, 26 Aug 2021 00:03:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u24sm1900157pfm.27.2021.08.26.00.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Aug 2021 00:03:51 -0700 (PDT)
Subject: Re: [PATCH] eventfd: Make signal recursion protection a task bit
To:     Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <87pmv23lru.ffs@nanos.tec.linutronix.de>
 <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com> <875ywujlzx.ffs@tglx>
 <87wnp9idso.ffs@tglx>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <0f22bf8f-6211-427d-6c3f-f23cae07971c@redhat.com>
Date:   Thu, 26 Aug 2021 15:03:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87wnp9idso.ffs@tglx>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/7/29 ÏÂÎç7:01, Thomas Gleixner Ð´µÀ:
> The recursion protection for eventfd_signal() is based on a per CPU
> variable and relies on the !RT semantics of spin_lock_irqsave() for
> protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
> disables preemption nor interrupts which allows the spin lock held section
> to be preempted. If the preempting task invokes eventfd_signal() as well,
> then the recursion warning triggers.
>
> Paolo suggested to protect the per CPU variable with a local lock, but
> that's heavyweight and actually not necessary. The goal of this protection
> is to prevent the task stack from overflowing, which can be achieved with a
> per task recursion protection as well.
>
> Replace the per CPU variable with a per task bit similar to other recursion
> protection bits like task_struct::in_page_owner. This works on both !RT and
> RT kernels and removes as a side effect the extra per CPU storage.
>
> No functional change for !RT kernels.
>
> Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


Acked-by: Jason Wang <jasowang@redhat.com>

Anyone want to pick this patch?


> ---
>   fs/aio.c                |    2 +-
>   fs/eventfd.c            |   12 +++++-------
>   include/linux/eventfd.h |   11 +++++------
>   include/linux/sched.h   |    4 ++++
>   4 files changed, 15 insertions(+), 14 deletions(-)
>
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_que
>   		list_del(&iocb->ki_list);
>   		iocb->ki_res.res = mangle_poll(mask);
>   		req->done = true;
> -		if (iocb->ki_eventfd && eventfd_signal_count()) {
> +		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
>   			iocb = NULL;
>   			INIT_WORK(&req->work, aio_poll_put_work);
>   			schedule_work(&req->work);
> --- a/fs/eventfd.c
> +++ b/fs/eventfd.c
> @@ -25,8 +25,6 @@
>   #include <linux/idr.h>
>   #include <linux/uio.h>
>   
> -DEFINE_PER_CPU(int, eventfd_wake_count);
> -
>   static DEFINE_IDA(eventfd_ida);
>   
>   struct eventfd_ctx {
> @@ -67,21 +65,21 @@ struct eventfd_ctx {
>   	 * Deadlock or stack overflow issues can happen if we recurse here
>   	 * through waitqueue wakeup handlers. If the caller users potentially
>   	 * nested waitqueues with custom wakeup handlers, then it should
> -	 * check eventfd_signal_count() before calling this function. If
> -	 * it returns true, the eventfd_signal() call should be deferred to a
> +	 * check eventfd_signal_allowed() before calling this function. If
> +	 * it returns false, the eventfd_signal() call should be deferred to a
>   	 * safe context.
>   	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	if (WARN_ON_ONCE(current->in_eventfd_signal))
>   		return 0;
>   
>   	spin_lock_irqsave(&ctx->wqh.lock, flags);
> -	this_cpu_inc(eventfd_wake_count);
> +	current->in_eventfd_signal = 1;
>   	if (ULLONG_MAX - ctx->count < n)
>   		n = ULLONG_MAX - ctx->count;
>   	ctx->count += n;
>   	if (waitqueue_active(&ctx->wqh))
>   		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
> -	this_cpu_dec(eventfd_wake_count);
> +	current->in_eventfd_signal = 0;
>   	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
>   
>   	return n;
> --- a/include/linux/eventfd.h
> +++ b/include/linux/eventfd.h
> @@ -14,6 +14,7 @@
>   #include <linux/err.h>
>   #include <linux/percpu-defs.h>
>   #include <linux/percpu.h>
> +#include <linux/sched.h>
>   
>   /*
>    * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
> @@ -43,11 +44,9 @@ int eventfd_ctx_remove_wait_queue(struct
>   				  __u64 *cnt);
>   void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
>   
> -DECLARE_PER_CPU(int, eventfd_wake_count);
> -
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_allowed(void)
>   {
> -	return this_cpu_read(eventfd_wake_count);
> +	return !current->in_eventfd_signal;
>   }
>   
>   #else /* CONFIG_EVENTFD */
> @@ -78,9 +77,9 @@ static inline int eventfd_ctx_remove_wai
>   	return -ENOSYS;
>   }
>   
> -static inline bool eventfd_signal_count(void)
> +static inline bool eventfd_signal_allowed(void)
>   {
> -	return false;
> +	return true;
>   }
>   
>   static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -863,6 +863,10 @@ struct task_struct {
>   	/* Used by page_owner=on to detect recursion in page tracking. */
>   	unsigned			in_page_owner:1;
>   #endif
> +#ifdef CONFIG_EVENTFD
> +	/* Recursion prevention for eventfd_signal() */
> +	unsigned			in_eventfd_signal:1;
> +#endif
>   
>   	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>   
>

