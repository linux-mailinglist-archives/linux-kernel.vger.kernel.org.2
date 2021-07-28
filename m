Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160FE3D895F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhG1IGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:06:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58134 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbhG1IGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:06:31 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627459589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jP1dOnAADsugCfZk429dCYPdMvT+6nhaUFZ+0nKmpA=;
        b=FAwLICGs3zISGyeLgQYlLbDZj+slQtDlRdhllA0VlAlJQNP987hRVLAJImkzX8clRln6FP
        PtIy3k1qd+GU1u6ZjfE7eLmU6DSkeUTWzTQekLKXgQkee/iE+fk8N1DP0BLuyObEVIG47/
        VsNsUzqEFGehEqvCVQuX3ohqI1HhIMNdMb9Zmt+8/jww3i4OtmXNXCPKWvrKO6odB/v2BD
        PlRfAfiYWiuw25PLGnrPG1GoJzT2zuX72XPu4+KHPLsiYuAyFoKuPBQ0FTEYzVf8z2RMGD
        /7UQdZGuNbDOElwOmVjz60QC11yFjIBh2GbkacUC1IajGEPCZZjYbJPH58lARw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627459589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jP1dOnAADsugCfZk429dCYPdMvT+6nhaUFZ+0nKmpA=;
        b=/xVJjW1Nx5bkuGbQbkszwkRcyFHLW8h/JVguCuOzHAq7Irb/Pj1SHMS+anFF25eoOt48dN
        kJXykLFsi6X6uoCA==
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>
Subject: Re: 5.13-rt1 + KVM = WARNING: at fs/eventfd.c:74 eventfd_signal()
In-Reply-To: <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com> <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com> <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com> <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
Date:   Wed, 28 Jul 2021 10:06:29 +0200
Message-ID: <87pmv23lru.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14 2021 at 12:35, Paolo Bonzini wrote:
> On 14/07/21 11:23, Jason Wang wrote:
>   
> +static local_lock_t eventfd_wake_lock = INIT_LOCAL_LOCK(eventfd_wake_lock);
>   DEFINE_PER_CPU(int, eventfd_wake_count);
>   
>   static DEFINE_IDA(eventfd_ida);
> @@ -71,8 +73,11 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>   	 * it returns true, the eventfd_signal() call should be deferred to a
>   	 * safe context.
>   	 */
> -	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
> +	local_lock(&eventfd_wake_lock);
> +	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count))) {
> +		local_unlock(&eventfd_wake_lock);
>   		return 0;
> +	}
>   
>   	spin_lock_irqsave(&ctx->wqh.lock, flags);
>   	this_cpu_inc(eventfd_wake_count);
> @@ -83,6 +88,7 @@ __u64 eventfd_signal(struct eventfd_ctx *ctx, __u64 n)
>   		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
>   	this_cpu_dec(eventfd_wake_count);
>   	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
> +	local_unlock(&eventfd_wake_lock);

Yes, that cures it, but if you think about what this wants to prevent,
then having the recursion counter per CPU is at least suboptimal.

Something like the untested below perhaps?

Thanks,

        tglx
---
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_que
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -25,8 +25,6 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
-DEFINE_PER_CPU(int, eventfd_wake_count);
-
 static DEFINE_IDA(eventfd_ida);
 
 struct eventfd_ctx {
@@ -67,21 +65,21 @@ struct eventfd_ctx {
 	 * Deadlock or stack overflow issues can happen if we recurse here
 	 * through waitqueue wakeup handlers. If the caller users potentially
 	 * nested waitqueues with custom wakeup handlers, then it should
-	 * check eventfd_signal_count() before calling this function. If
-	 * it returns true, the eventfd_signal() call should be deferred to a
+	 * check eventfd_signal_allowed() before calling this function. If
+	 * it returns false, the eventfd_signal() call should be deferred to a
 	 * safe context.
 	 */
-	if (WARN_ON_ONCE(this_cpu_read(eventfd_wake_count)))
+	if (WARN_ON_ONCE(current->in_eventfd_signal))
 		return 0;
 
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
-	this_cpu_inc(eventfd_wake_count);
+	current->in_eventfd_signal = 1;
 	if (ULLONG_MAX - ctx->count < n)
 		n = ULLONG_MAX - ctx->count;
 	ctx->count += n;
 	if (waitqueue_active(&ctx->wqh))
 		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	this_cpu_dec(eventfd_wake_count);
+	current->in_eventfd_signal = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return n;
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -43,11 +43,9 @@ int eventfd_ctx_remove_wait_queue(struct
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
-DECLARE_PER_CPU(int, eventfd_wake_count);
-
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return this_cpu_read(eventfd_wake_count);
+	return !current->in_eventfd_signal;
 }
 
 #else /* CONFIG_EVENTFD */
@@ -78,9 +76,9 @@ static inline int eventfd_ctx_remove_wai
 	return -ENOSYS;
 }
 
-static inline bool eventfd_signal_count(void)
+static inline bool eventfd_signal_allowed(void)
 {
-	return false;
+	return true;
 }
 
 static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -863,6 +863,8 @@ struct task_struct {
 	/* Used by page_owner=on to detect recursion in page tracking. */
 	unsigned			in_page_owner:1;
 #endif
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 

