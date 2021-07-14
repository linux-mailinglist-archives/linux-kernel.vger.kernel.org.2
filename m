Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726213C80DB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 10:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhGNJAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238784AbhGNJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:00:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F636C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 01:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nkUhubg5MkzLt/9301ljwbThMqUHJt6p4fJPil7sfkI=; b=kqSGHzXMdmkiuXaNNsdHUIjr12
        89IiRTKzdfpXQ+I1wkr5XVC/7g44iqMQTN+AWpFX9kpgMeHQGZ6btUlUSyq4FkAVDW7/ZDXSFlZ25
        towPbs5bZ/Zbn/xP0IhsYIQpkucEgY2RCFiqqS+lQWYqhHgAJ/fe2DxmTsdAD2wQ/T4QWKMQQmxcX
        Z60mUM8nW+OcLvFY74hpG7nOYcZ5PB0aSBnoyDLYxjti31RINu9ljZcJ3L4DILtfdTd7Oj1ATxcdz
        wyvw1IgLGXVI6FSie3wwI06LBsl1s3Fs7354wb0A6Lr2TEjbartzV+J6SQYOr+ZXVLILce2Ch//eC
        uXTzvYTw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3afd-0021fF-3l; Wed, 14 Jul 2021 08:55:21 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E909D98689D; Wed, 14 Jul 2021 10:55:07 +0200 (CEST)
Date:   Wed, 14 Jul 2021 10:55:07 +0200
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
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [patch 17/50] locking/rtmutex: Prepare RT rt_mutex_wake_q for RT
 locks
Message-ID: <20210714085507.GC2725@worktop.programming.kicks-ass.net>
References: <20210713151054.700719949@linutronix.de>
 <20210713160747.601687056@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713160747.601687056@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 05:11:11PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add a rtlock_task pointer to rt_mutex_wake_q which allows to handle the RT
> specific wakeup for spin/rwlock waiters. The pointer is just consuming 4/8
> bytes on stack so it is provided unconditionaly to avoid #ifdeffery all
> over the place.
> 
> No functional change for non-RT enabled kernels.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/locking/rtmutex.c        |   16 ++++++++++++++--
>  kernel/locking/rtmutex_common.h |    3 +++
>  2 files changed, 17 insertions(+), 2 deletions(-)
> ---
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -351,12 +351,24 @@ static __always_inline void rt_mutex_adj
>  static __always_inline void rt_mutex_wake_q_add(struct rt_mutex_wake_q_head *wqh,
>  						struct rt_mutex_waiter *w)
>  {
> -	wake_q_add(&wqh->head, w->task);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
> +		get_task_struct(w->task);
> +		wqh->rtlock_task = w->task;
> +	} else {
> +		wake_q_add(&wqh->head, w->task);
> +	}
>  }
>  
>  static __always_inline void rt_mutex_wake_up_q(struct rt_mutex_wake_q_head *wqh)
>  {
> -	wake_up_q(&wqh->head);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
> +		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
> +		put_task_struct(wqh->rtlock_task);
> +		wqh->rtlock_task = NULL;
> +	}
> +
> +	if (!wake_q_empty(&wqh->head))
> +		wake_up_q(&wqh->head);
>  
>  	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
>  	preempt_enable();
> --- a/kernel/locking/rtmutex_common.h
> +++ b/kernel/locking/rtmutex_common.h
> @@ -43,14 +43,17 @@ struct rt_mutex_waiter {
>   * rt_mutex_wake_q_head - Wrapper around regular wake_q_head to support
>   *			  "sleeping" spinlocks on RT
>   * @head:		The regular wake_q_head for sleeping lock variants
> + * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
>   */
>  struct rt_mutex_wake_q_head {
>  	struct wake_q_head	head;
> +	struct task_struct	*rtlock_task;
>  };
>  
>  #define DEFINE_RT_MUTEX_WAKE_Q_HEAD(name)				\
>  	struct rt_mutex_wake_q_head name = {				\
>  		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
> +		.rtlock_task	= NULL,					\
>  	}

This is a bit asymmetric, something like the below perhaps?

---

--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -61,6 +61,11 @@ static inline bool wake_q_empty(struct w
 
 extern void wake_q_add(struct wake_q_head *head, struct task_struct *task);
 extern void wake_q_add_safe(struct wake_q_head *head, struct task_struct *task);
-extern void wake_up_q(struct wake_q_head *head);
+extern void __wake_up_q(struct wake_q_head *head, unsigned int state);
+
+static inline void wake_up_q(struct wake_q_head *head)
+{
+	__wake_up_q(head, TASK_NORMAL);
+}
 
 #endif /* _LINUX_SCHED_WAKE_Q_H */
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -351,12 +351,20 @@ static __always_inline void rt_mutex_adj
 static __always_inline void rt_mutex_wake_q_add(struct rt_mutex_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	wake_q_add(&wqh->head, w->task);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state != TASK_NORMAL) {
+		wake_q_add(&wqh->rt_head, w->task);
+	} else {
+		wake_q_add(&wqh->head, w->task);
+	}
 }
 
 static __always_inline void rt_mutex_wake_up_q(struct rt_mutex_wake_q_head *wqh)
 {
-	wake_up_q(&wqh->head);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !wake_q_empty(&wqh->rt_head))
+		__wake_up_q(&wqh->rt_head, TASK_RTLOCK_WAIT);
+
+	if (!wake_q_empty(&wqh->head))
+		wake_up_q(&wqh->head);
 
 	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
 	preempt_enable();
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -43,14 +43,17 @@ struct rt_mutex_waiter {
  * rt_mutex_wake_q_head - Wrapper around regular wake_q_head to support
  *			  "sleeping" spinlocks on RT
  * @head:		The regular wake_q_head for sleeping lock variants
+ * @rt_head:		The wake_q_head for RT lock (spin/rwlock) variants
  */
 struct rt_mutex_wake_q_head {
 	struct wake_q_head	head;
+	struct wake_q_head	rt_head;
 };
 
 #define DEFINE_RT_MUTEX_WAKE_Q_HEAD(name)				\
 	struct rt_mutex_wake_q_head name = {				\
 		.head		= WAKE_Q_HEAD_INITIALIZER(name.head),	\
+		.rt_head	= WAKE_Q_HEAD_INITIALIZER(name.rt_head),\
 	}
 
 /*
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -916,7 +916,7 @@ void wake_q_add_safe(struct wake_q_head
 		put_task_struct(task);
 }
 
-void wake_up_q(struct wake_q_head *head)
+void __wake_up_q(struct wake_q_head *head, unsigned int state)
 {
 	struct wake_q_node *node = head->first;
 
@@ -932,7 +932,7 @@ void wake_up_q(struct wake_q_head *head)
 		 * wake_up_process() executes a full barrier, which pairs with
 		 * the queueing in wake_q_add() so as not to miss wakeups.
 		 */
-		wake_up_process(task);
+		wake_up_state(task, state);
 		put_task_struct(task);
 	}
 }
