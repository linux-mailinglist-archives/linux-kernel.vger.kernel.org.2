Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08A53DA1B3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 13:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236619AbhG2LCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 07:02:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbhG2LCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 07:02:04 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627556520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jea+JilQ4LYbkStER9HIYYbF4dLzWTuNm7ZgrNoo+Gc=;
        b=h3Z+54J+A81GsKr9ygo5MiWdvXpyQNRvhFAZ+tZuVgBvX/UgzBC51L5kgqv6v1/6gtCE7X
        SJWzr4pAlOookmrhPDniM3y/Aw/eOrMvqrHnOTHm08yiwKdzwRXk9mWMKDSITcj6NAuTRr
        zanRs7MrTxAZkv4mp3gLaY9db+YDNPPIbX5+9cruygJol6vAPz7uwsxEpBUpFMWGlw2KyE
        CzLsSgj4BZGtP4Sb7589gTUmvsCTv0DYGY3vqQkSF+VznqmBvzTVOgNxsNBtlCyArD9hzc
        rWQ6VCBcsJR8bvK3UC/3nHwYDIbCyv3Mp4J0/08i3gYltZsb6r4+WD/0FUwaOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627556520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jea+JilQ4LYbkStER9HIYYbF4dLzWTuNm7ZgrNoo+Gc=;
        b=7nyfNKZKDuOcPLuEzvioYxB1M5l2KLwxHkJPuRzdM0F6YjIW/DABMnK2ZIMdKSnpl76WsP
        LaaLPdfcfh6fiAAg==
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        He Zhe <zhe.he@windriver.com>, Jens Axboe <axboe@fb.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] eventfd: Make signal recursion protection a task bit
In-Reply-To: <875ywujlzx.ffs@tglx>
References: <df278db6-1fc0-3d42-9c0e-f5a085c6351e@redhat.com>
 <8dfc0ee9-b97a-8ca8-d057-31c8cad3f5b6@redhat.com>
 <f0254740-944d-201b-9a66-9db1fe480ca6@redhat.com>
 <475f84e2-78ee-1a24-ef57-b16c1f2651ed@redhat.com>
 <87pmv23lru.ffs@nanos.tec.linutronix.de>
 <810e01ef-9b71-5b44-8498-b8a377d4e51b@redhat.com> <875ywujlzx.ffs@tglx>
Date:   Thu, 29 Jul 2021 13:01:59 +0200
Message-ID: <87wnp9idso.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recursion protection for eventfd_signal() is based on a per CPU
variable and relies on the !RT semantics of spin_lock_irqsave() for
protecting this per CPU variable. On RT kernels spin_lock_irqsave() neither
disables preemption nor interrupts which allows the spin lock held section
to be preempted. If the preempting task invokes eventfd_signal() as well,
then the recursion warning triggers.

Paolo suggested to protect the per CPU variable with a local lock, but
that's heavyweight and actually not necessary. The goal of this protection
is to prevent the task stack from overflowing, which can be achieved with a
per task recursion protection as well.

Replace the per CPU variable with a per task bit similar to other recursion
protection bits like task_struct::in_page_owner. This works on both !RT and
RT kernels and removes as a side effect the extra per CPU storage.

No functional change for !RT kernels.

Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/aio.c                |    2 +-
 fs/eventfd.c            |   12 +++++-------
 include/linux/eventfd.h |   11 +++++------
 include/linux/sched.h   |    4 ++++
 4 files changed, 15 insertions(+), 14 deletions(-)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_que
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd && eventfd_signal_allowed()) {
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
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/percpu-defs.h>
 #include <linux/percpu.h>
+#include <linux/sched.h>
 
 /*
  * CAREFUL: Check include/uapi/asm-generic/fcntl.h when defining
@@ -43,11 +44,9 @@ int eventfd_ctx_remove_wait_queue(struct
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
@@ -78,9 +77,9 @@ static inline int eventfd_ctx_remove_wai
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
@@ -863,6 +863,10 @@ struct task_struct {
 	/* Used by page_owner=on to detect recursion in page tracking. */
 	unsigned			in_page_owner:1;
 #endif
+#ifdef CONFIG_EVENTFD
+	/* Recursion prevention for eventfd_signal() */
+	unsigned			in_eventfd_signal:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
