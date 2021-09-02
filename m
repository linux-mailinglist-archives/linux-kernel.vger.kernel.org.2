Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808B33FEB94
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343700AbhIBJuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:50:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42674 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242372AbhIBJtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:49:49 -0400
Message-ID: <20210902094414.558914045@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630576129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BhHQO/mglzWk4bCL/7pH5nr+iKtWRXDloQbGtGn3ULM=;
        b=Zmf1VI/+akCVC+V9yQwCzUQwBkrEfm6qzs6PNtgMdS1MyHu7ggr6k6XwWiYWBwAhUKQL5U
        go2ygfbYhE34Vo4ApVSG5cEjbawz12YewAndwJou/sY0HQ64YFmWJ8l6WgAHUm9YNWhidc
        nt+iEmOfezgWTn+AeQOiYrcYa/i7kMHG8AUdC+GlRTynvkP5mS8QeDD/AurgNMmMXPtHJ3
        kzgyTwBG3FU1YiVVjM0ayuCEhtiQFNbt7uH62eGsZQv9GPHHmoIzbVgudFb+vNMYt27xgU
        v6FjUWuKS8P5ctuyeQmHxHutJ5OQZ9OwiBQRazIG4oT5F+UXPP1jqezr0kkK1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630576129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BhHQO/mglzWk4bCL/7pH5nr+iKtWRXDloQbGtGn3ULM=;
        b=W+SUmV0P3CpL0RFD+80odPqYuwuxDCn3MHpCTuSx2K5UbcWJOvB5nAWc0i2LYCl2bRr0kr
        Hetxl06cRmiJWXDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com
Subject: [patch 1/3] futex: Prevent inconsistent state and exit race
References: <20210902093755.087908334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Thu,  2 Sep 2021 11:48:48 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent rework of the requeue PI code introduced a possibility for
going back to user space in inconsistent state:

CPU 0				CPU 1

requeue_futex()
  if (lock_pifutex_user()) {
      dequeue_waiter();
      wake_waiter(task);
				sched_in(task);
     				return_from_futex_syscall();

  ---> Inconsistent state because PI state is not established

It becomes worse if the woken up task immediately exits:

				sys_exit();
				
      attach_pistate(vpid);	<--- FAIL


Attach the pi state before dequeuing and waking the waiter. If the waiter
gets a spurious wakeup before the dequeue operation it will wait in
futex_requeue_pi_wakeup_sync() and therefore cannot return and exit.

Fixes: 07d91ef510fb ("futex: Prevent requeue_pi() lock nesting issue on RT")
Reported-by: syzbot+4d1bd0725ef09168e1a0@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   98 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1454,8 +1454,23 @@ static int futex_lock_pi_atomic(u32 __us
 			newval |= FUTEX_WAITERS;
 
 		ret = lock_pi_update_atomic(uaddr, uval, newval);
-		/* If the take over worked, return 1 */
-		return ret < 0 ? ret : 1;
+		if (ret)
+			return ret;
+
+		/*
+		 * If the waiter bit was requested the caller also needs PI
+		 * state attached to the new owner of the user space futex.
+		 *
+		 * @task is guaranteed to be alive and it cannot be exiting
+		 * because it is either sleeping or waiting in
+		 * futex_requeue_pi_wakeup_sync().
+		 */
+		if (set_waiters) {
+			 ret = attach_to_pi_owner(uaddr, newval, key, ps,
+						  exiting);
+			 WARN_ON(ret);
+		}
+		return 1;
 	}
 
 	/*
@@ -2036,17 +2051,24 @@ futex_proxy_trylock_atomic(u32 __user *p
 		return -EAGAIN;
 
 	/*
-	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit in
-	 * the contended case or if set_waiters is 1.  The pi_state is returned
-	 * in ps in contended cases.
+	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit
+	 * in the contended case or if @set_waiters is true.
+	 *
+	 * In the contended case PI state is attached to the lock owner. If
+	 * the user space lock can be acquired then PI state is attached to
+	 * the new owner (top_waiter->task) when @set_waiters is true.
 	 */
 	vpid = task_pid_vnr(top_waiter->task);
 	ret = futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret == 1) {
-		/* Dequeue, wake up and update top_waiter::requeue_state */
+		/*
+		 * Lock was acquired in user space and PI state was
+		 * attached to top_waiter->task. That means state is fully
+		 * consistent and the waiter can return to user space
+		 * immediately after the wakeup.
+		 */
 		requeue_pi_wake_futex(top_waiter, key2, hb2);
-		return vpid;
 	} else if (ret < 0) {
 		/* Rewind top_waiter::requeue_state */
 		futex_requeue_pi_complete(top_waiter, ret);
@@ -2208,19 +2230,26 @@ static int futex_requeue(u32 __user *uad
 						 &exiting, nr_requeue);
 
 		/*
-		 * At this point the top_waiter has either taken uaddr2 or is
-		 * waiting on it.  If the former, then the pi_state will not
-		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, @ret contains the
-		 * VPID of the top waiter task.
-		 * If the lock was not taken, we have pi_state and an initial
-		 * refcount on it. In case of an error we have nothing.
+		 * At this point the top_waiter has either taken uaddr2 or
+		 * is waiting on it. In both cases pi_state has been
+		 * established and an initial refcount on it. In case of an
+		 * error there's nothing.
 		 *
 		 * The top waiter's requeue_state is up to date:
 		 *
-		 *  - If the lock was acquired atomically (ret > 0), then
+		 *  - If the lock was acquired atomically (ret == 1), then
 		 *    the state is Q_REQUEUE_PI_LOCKED.
 		 *
+		 *    The top waiter has been dequeued and woken up and can
+		 *    return to user space immediately. The kernel/user
+		 *    space state is consistent. In case that there must be
+		 *    more waiters requeued the WAITERS bit in the user
+		 *    space futex is set so the top waiter task has to go
+		 *    into the syscall slowpath to unlock the futex. This
+		 *    will block until this requeue operation has been
+		 *    completed and the hash bucket locks have been
+		 *    dropped.
+		 *
 		 *  - If the trylock failed with an error (ret < 0) then
 		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
 		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
@@ -2234,36 +2263,20 @@ static int futex_requeue(u32 __user *uad
 		 *    the same sanity checks for requeue_pi as the loop
 		 *    below does.
 		 */
-		if (ret > 0) {
-			WARN_ON(pi_state);
-			task_count++;
-			/*
-			 * If futex_proxy_trylock_atomic() acquired the
-			 * user space futex, then the user space value
-			 * @uaddr2 has been set to the @hb1's top waiter
-			 * task VPID. This task is guaranteed to be alive
-			 * and cannot be exiting because it is either
-			 * sleeping or blocked on @hb2 lock.
-			 *
-			 * The @uaddr2 futex cannot have waiters either as
-			 * otherwise futex_proxy_trylock_atomic() would not
-			 * have succeeded.
-			 *
-			 * In order to requeue waiters to @hb2, pi state is
-			 * required. Hand in the VPID value (@ret) and
-			 * allocate PI state with an initial refcount on
-			 * it.
-			 */
-			ret = attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
-						 &exiting);
-			WARN_ON(ret);
-		}
-
 		switch (ret) {
 		case 0:
 			/* We hold a reference on the pi state. */
 			break;
 
+		case 1:
+			/*
+			 * futex_proxy_trylock_atomic() acquired the user space
+			 * futex. Adjust task_count.
+			 */
+			task_count++;
+			ret = 0;
+			break;
+
 		/*
 		 * If the above failed, then pi_state is NULL and
 		 * waiter::requeue_state is correct.
@@ -2395,9 +2408,8 @@ static int futex_requeue(u32 __user *uad
 	}
 
 	/*
-	 * We took an extra initial reference to the pi_state either in
-	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
-	 * to drop it here again.
+	 * We took an extra initial reference to the pi_state in
+	 * futex_proxy_trylock_atomic(). We need to drop it here again.
 	 */
 	put_pi_state(pi_state);
 

