Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9F3E2BEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhHFNtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 09:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhHFNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 09:49:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67EFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 06:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o3LuzAAwKTql0hjgvfHWlK5zedQzZOSd0RPaxZ6CyNI=; b=Hh8RExVQLZn3bebOksGJ8Nbi1x
        bUipFzIbP7yQk1Y+JsvfdCYChVAM6+iKQqKNwcAtitR6A2uMaEDhBD/m7I2FYH/9uWnuNTlZ5CotX
        SvYZ0zZwwntLbxOZNRJsRBtbWpGfp3xY/Mg+aT35HbYAKNw/zJzcXhrM1/Pu9Em2BfXIXuywoK2pQ
        YoxZEEJ+8bWwseiQ880WT3IhxGLNotG5qV56EiNo0S24DB37MCf+5goZuhI1/QhXYlIjqHdHErtGG
        YKX90CNllk1PA5Si6/Q/E3/k+BfHlMCseunwR4lRKb8TOxwyDy61G3tncbSd5BTTlruXDC/v3boMY
        G9C2bEBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC0Cp-008F1W-Ra; Fri, 06 Aug 2021 13:48:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1281430003A;
        Fri,  6 Aug 2021 15:48:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F3DAB2028AD52; Fri,  6 Aug 2021 15:48:09 +0200 (CEST)
Date:   Fri, 6 Aug 2021 15:48:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 50/64] locking/rtmutex: Extend the rtmutex core to
 support ww_mutex
Message-ID: <YQ09mREYoqt6YunQ@hirez.programming.kicks-ass.net>
References: <20210805151300.330412127@linutronix.de>
 <20210805153955.709189588@linutronix.de>
 <20210806110051.GF22037@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806110051.GF22037@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 01:00:51PM +0200, Peter Zijlstra wrote:
> Also, I found a note that said I had to check what this code does for
> !RT tasks, lemme go do that now.

Do we want something like the below?

AFAICT the existing RB-tree actually does FIFO for equal prio right. Per
rb_add_cached() we only go left for less, therefore equal goes right,
giving a tail-add for equal prio.

Furthermore, rt_mutex_adjust_prio_chain() is careful not to requeue when
the priority doesn't change, preserving this FIFO order (as is mandated
by SCHED_FIFO semantics IIRC).

Therefore, all that seems to be missing is to squash all !RT tasks to
the same prio to make sure they're all FIFO ordered.

---
Subject: locking/rtmutex: Squash !RT tasks to DEFAULT_PRIO

Ensure all !RT tasks have the same prio such that they end up in FIFO
order and aren't split up according to nice level.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rtmutex.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index b5d9bb5202c6..36e115c868a7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -223,11 +223,29 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
 }
 #endif
 
+static __always_inline int
+__waiter_prio(struct task_struct *task)
+{
+	int prio = task->prio;
+
+	if (!rt_prio(prio))
+		prio = DEFAULT_PRIO;
+
+	return prio;
+}
+
+static __always_inline void
+waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	waiter->prio = __waiter_prio(task);
+	waiter->deadline = task->dl.deadline;
+}
+
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 
 static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 						struct rt_mutex_waiter *right)
@@ -653,8 +671,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * serializes all pi_waiters access and rb_erase() does not care about
 	 * the values of the node being removed.
 	 */
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
@@ -924,8 +941,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
 	raw_spin_lock(&task->pi_lock);
 	waiter->task = task;
 	waiter->lock = lock;
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
