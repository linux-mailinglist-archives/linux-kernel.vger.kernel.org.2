Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021CC44E622
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 13:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhKLMOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 07:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKLMOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 07:14:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F09C061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 04:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mrO6Vk+ZDP4ypzvOoD44zPlK2Rq03EYv/6Z+b3RSppM=; b=YQtTkkhSST4wzfDyxt6cK34rcz
        g+myHZmN9rM6PWGQ7ilOuFg7vYkljUEoMw/faRSHvqeskCwkcaYm5MxclRZlrAjET4ldS3s5ZtPob
        kAnGBg5y/9bef2deuuCi607WGNsFGnOT+rsKdhdoy0OvP8+jdjCIl9zFXUdEhcD385GMo3Uw2iZ2U
        Te/M7dtIOL+vae/XYoQX9sDilIyKPD3XaLaCllcj/SargMFJXdoj/7lnZnXq5K8ZzEEYsksetygKB
        eX2Rfj1c/7X6W30RNpfzT99gfzR0neeo3Zkh0hfw6MXmKYDfk5/XQt0c+6GzNPlhVE/ZkQV29gCGB
        GfAHPdZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlVOX-00Fcld-O9; Fri, 12 Nov 2021 12:11:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDF0D300024;
        Fri, 12 Nov 2021 13:10:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE41020BE2265; Fri, 12 Nov 2021 13:10:59 +0100 (CET)
Date:   Fri, 12 Nov 2021 13:10:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Maria Yu <quic_aiquny@quicinc.com>
Subject: Re: [PATCH v4] locking/rwsem: Make handoff bit handling more
 consistent
Message-ID: <YY5Z009P2jJ4X484@hirez.programming.kicks-ass.net>
References: <20211112040753.389380-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112040753.389380-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:07:53PM -0500, Waiman Long wrote:
> @@ -889,6 +892,20 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>  }
>  #endif
>  
> +/*
> + * Common code to handle rwsem flags in out_nolock path with wait_lock held.
> + * If there is more than one waiter in the queue and the HANDOFF bit is set,
> + * the next waiter will inherit it if the first waiter is removed.
> + */
> +static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
> +						struct rwsem_waiter *waiter)

I'm going to rename that, it doesn't just clear flags, it dequeues the
waiter.

Argh, rwsem_mark_wake() doesn't clear HANDOFF when list_empty(), and
write_slowpath() is *far* too clever about all of this.


> +{
> +	list_del(&waiter->list);
	if (list_empty(&sem->wait_list)) {
> +		atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS,
> +				   &sem->count);
	}
> +}



> @@ -1098,7 +1110,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
>  		 * In this case, we attempt to acquire the lock again
>  		 * without sleeping.
>  		 */
> -		if (wstate == WRITER_HANDOFF) {
> +		if (waiter.handoff_set) {

I'm thinking this wants to be something like:

		if (rwsem_first_waiter(sem) == &waiter && waiter.handoff_set) {

>  			enum owner_state owner_state;
>  
>  			preempt_disable();

How's this (on top) then?

---
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -104,11 +104,10 @@
  * atomic_long_fetch_add() is used to obtain reader lock, whereas
  * atomic_long_cmpxchg() will be used to obtain writer lock.
  *
- * There are four places where the lock handoff bit may be set or cleared.
- * 1) rwsem_mark_wake() for readers            -- set, clear
- * 2) rwsem_try_write_lock() for writers       -- set, clear
- * 3) Error path of rwsem_down_write_slowpath() -- clear
- * 4) Error path of rwsem_down_read_slowpath()  -- clear
+ * There are three places where the lock handoff bit may be set or cleared.
+ * 1) rwsem_mark_wake() for readers		-- set, clear
+ * 2) rwsem_try_write_lock() for writers	-- set, clear
+ * 3) rwsem_del_waiter()			-- clear
  *
  * For all the above cases, wait_lock will be held. A writer must also
  * be the first one in the wait_list to be eligible for setting the handoff
@@ -363,6 +362,31 @@ enum rwsem_wake_type {
  */
 #define MAX_READERS_WAKEUP	0x100
 
+static inline void
+rwsem_add_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	lockdep_assert_held(&sem->wait_lock);
+	list_add_tail(&waiter->list, &sem->wait_list);
+	/* caller will set RWSEM_FLAG_WAITERS */
+}
+
+/*
+ * Remove a waiter from the wait_list and clear flags.
+ *
+ * Both rwsem_mark_wake() and rwsem_try_write_lock() contain a full 'copy' of
+ * this function. Modify with care.
+ */
+static inline void
+rwsem_del_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter)
+{
+	lockdep_assert_held(&sem->wait_lock);
+	list_del(&waiter->list);
+	if (likely(!list_empty(&sem->wait_list)))
+		return;
+
+	atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS, &sem->count);
+}
+
 /*
  * handle the lock release when processes blocked on it that can now run
  * - if we come here from up_xxxx(), then the RWSEM_FLAG_WAITERS bit must
@@ -374,6 +398,8 @@ enum rwsem_wake_type {
  *   preferably when the wait_lock is released
  * - woken process blocks are discarded from the list after having task zeroed
  * - writers are only marked woken if downgrading is false
+ *
+ * Implies rwsem_del_waiter() for all woken readers.
  */
 static void rwsem_mark_wake(struct rw_semaphore *sem,
 			    enum rwsem_wake_type wake_type,
@@ -488,18 +514,25 @@ static void rwsem_mark_wake(struct rw_se
 
 	adjustment = woken * RWSEM_READER_BIAS - adjustment;
 	lockevent_cond_inc(rwsem_wake_reader, woken);
+
+	oldcount = atomic_long_read(&sem->count);
 	if (list_empty(&sem->wait_list)) {
-		/* hit end of list above */
+		/*
+		 * Combined with list_move_tail() above, this implies
+		 * rwsem_del_waiter().
+		 */
 		adjustment -= RWSEM_FLAG_WAITERS;
+		if (oldcount & RWSEM_FLAG_HANDOFF)
+			adjustment -= RWSEM_FLAG_HANDOFF;
+	} else if (woken) {
+		/*
+		 * When we've woken a reader, we no longer need to force
+		 * writers to give up the lock and we can clear HANDOFF.
+		 */
+		if (oldcount & RWSEM_FLAG_HANDOFF)
+			adjustment -= RWSEM_FLAG_HANDOFF;
 	}
 
-	/*
-	 * When we've woken a reader, we no longer need to force writers
-	 * to give up the lock and we can clear HANDOFF.
-	 */
-	if (woken && (atomic_long_read(&sem->count) & RWSEM_FLAG_HANDOFF))
-		adjustment -= RWSEM_FLAG_HANDOFF;
-
 	if (adjustment)
 		atomic_long_add(adjustment, &sem->count);
 
@@ -529,6 +562,8 @@ static void rwsem_mark_wake(struct rw_se
  * This function must be called with the sem->wait_lock held to prevent
  * race conditions between checking the rwsem wait list and setting the
  * sem->count accordingly.
+ *
+ * Implies rwsem_del_waiter() on success.
  */
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 					struct rwsem_waiter *waiter)
@@ -575,6 +610,11 @@ static inline bool rwsem_try_write_lock(
 		return false;
 	}
 
+	/*
+	 * Have rwsem_try_write_lock() fully imply rwsem_del_waiter() on
+	 * success.
+	 */
+	list_del(&waiter->list);
 	rwsem_set_owner(sem);
 	return true;
 }
@@ -893,20 +933,6 @@ rwsem_spin_on_owner(struct rw_semaphore
 #endif
 
 /*
- * Common code to handle rwsem flags in out_nolock path with wait_lock held.
- * If there is more than one waiter in the queue and the HANDOFF bit is set,
- * the next waiter will inherit it if the first waiter is removed.
- */
-static inline void rwsem_out_nolock_clear_flags(struct rw_semaphore *sem,
-						struct rwsem_waiter *waiter)
-{
-	list_del(&waiter->list);
-	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS,
-				   &sem->count);
-}
-
-/*
  * Wait for the read lock to be granted
  */
 static struct rw_semaphore __sched *
@@ -973,7 +999,7 @@ rwsem_down_read_slowpath(struct rw_semap
 		}
 		adjustment += RWSEM_FLAG_WAITERS;
 	}
-	list_add_tail(&waiter.list, &sem->wait_list);
+	rwsem_add_waiter(sem, &waiter);
 
 	/* we're now waiting on the lock, but no longer actively locking */
 	count = atomic_long_add_return(adjustment, &sem->count);
@@ -1019,7 +1045,7 @@ rwsem_down_read_slowpath(struct rw_semap
 	return sem;
 
 out_nolock:
-	rwsem_out_nolock_clear_flags(sem, &waiter);
+	rwsem_del_waiter(sem, &waiter);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -1034,7 +1060,6 @@ rwsem_down_write_slowpath(struct rw_sema
 {
 	long count;
 	struct rwsem_waiter waiter;
-	struct rw_semaphore *ret = sem;
 	DEFINE_WAKE_Q(wake_q);
 
 	/* do optimistic spinning and steal lock if possible */
@@ -1053,7 +1078,7 @@ rwsem_down_write_slowpath(struct rw_sema
 	waiter.handoff_set = false;
 
 	raw_spin_lock_irq(&sem->wait_lock);
-	list_add_tail(&waiter.list, &sem->wait_list);
+	rwsem_add_waiter(sem, &waiter);
 
 	/* we're now waiting on the lock */
 	if (rwsem_first_waiter(sem) != &waiter) {
@@ -1110,7 +1135,7 @@ rwsem_down_write_slowpath(struct rw_sema
 		 * In this case, we attempt to acquire the lock again
 		 * without sleeping.
 		 */
-		if (waiter.handoff_set) {
+		if (rwsem_first_waiter(sem) == &waiter && waiter.handoff_set) {
 			enum owner_state owner_state;
 
 			preempt_disable();
@@ -1128,16 +1153,14 @@ rwsem_down_write_slowpath(struct rw_sema
 		raw_spin_lock_irq(&sem->wait_lock);
 	}
 	__set_current_state(TASK_RUNNING);
-	list_del(&waiter.list);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	lockevent_inc(rwsem_wlock);
-
-	return ret;
+	return sem;
 
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
-	rwsem_out_nolock_clear_flags(sem, &waiter);
+	rwsem_del_waiter(sem, &waiter);
 	if (!list_empty(&sem->wait_list))
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
