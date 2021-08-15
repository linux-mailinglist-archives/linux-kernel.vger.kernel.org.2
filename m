Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CCC3ECB52
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhHOVca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:32:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48676 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbhHOV3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:29:41 -0400
Message-ID: <20210815211305.305142462@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GL0Akvx+J+4uTUYuRwUlXnL+P0pnSl80bsHAu0ZT1EU=;
        b=xlzMz3F2DS6GpOkoLtsrjuH+kAxn1/w9XvbVjhytDcVvxMFgf49LcOPKEUyvMlQTf1rNrX
        wlaAI80JX9UzfCFa3ZjZsk5m5P89tRtWiZZfXGsxaPPsV9ANTDz5MtBxllnqJMx1IuDXNw
        oW++oKA2VG3vx+xRZOf7KlnjE9erthBQ/PuMCpmqDCglCReQ5y/pZMSHgbGEANMavlSHPP
        mCijVimB8/XHNbbMqe8IVb1bkyAs266amWi229eN5XLH1PVWkGEdthn3gO0yGQLRzp4RLR
        1zRYWZCPOEu+2KriyIlrvJJWAES60fKHHQnc37HqXU0ytjjDTyt3b3DulYxzrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=GL0Akvx+J+4uTUYuRwUlXnL+P0pnSl80bsHAu0ZT1EU=;
        b=eJHIzT+/qxe1acMte7FgJ0NOvWR/23HC49d7FL7Jsuyj7coF6h1I2Sc6dzqohQrFAam8JN
        S+F28Ghczv8J/CBA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Subject: [patch V5 59/72] futex: Clarify futex_requeue() PI handling
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:29:07 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requeuing to a PI futex then the requeue code tries to trylock the PI
futex on behalf of the topmost waiter on the inner 'waitqueue' futex. If
that succeeds then PI state has to be allocated in order to requeue further
waiters to the PI futex.

The comment and the code are confusing as the PI state allocation uses
lookup_pi_state() which either attaches to an existing waiter or to the
owner. As the PI futex was just acquired, there cannot be a waiter on the
PI futex because the hash bucket lock is held.

Clarify the comment and use attach_to_pi_owner() directly. As the task on
which behalf the PI futex has been acquired is guaranteed to be alive and
not exiting, this call must succeed. Add a WARN_ON() in case that fails.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 kernel/futex.c |   61 +++++++++++++++++++++------------------------------------
 1 file changed, 23 insertions(+), 38 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1299,27 +1299,6 @@ static int attach_to_pi_owner(u32 __user
 	return 0;
 }
 
-static int lookup_pi_state(u32 __user *uaddr, u32 uval,
-			   struct futex_hash_bucket *hb,
-			   union futex_key *key, struct futex_pi_state **ps,
-			   struct task_struct **exiting)
-{
-	struct futex_q *top_waiter = futex_top_waiter(hb, key);
-
-	/*
-	 * If there is a waiter on that futex, validate it and
-	 * attach to the pi_state when the validation succeeds.
-	 */
-	if (top_waiter)
-		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
-
-	/*
-	 * We are the first waiter - try to look up the owner based on
-	 * @uval and attach to it.
-	 */
-	return attach_to_pi_owner(uaddr, uval, key, ps, exiting);
-}
-
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
@@ -2038,8 +2017,8 @@ static int futex_requeue(u32 __user *uad
 		 * At this point the top_waiter has either taken uaddr2 or is
 		 * waiting on it.  If the former, then the pi_state will not
 		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, ret contains the
-		 * vpid of the top waiter task.
+		 * reference to it. If the lock was taken, @ret contains the
+		 * VPID of the top waiter task.
 		 * If the lock was not taken, we have pi_state and an initial
 		 * refcount on it. In case of an error we have nothing.
 		 */
@@ -2047,19 +2026,25 @@ static int futex_requeue(u32 __user *uad
 			WARN_ON(pi_state);
 			task_count++;
 			/*
-			 * If we acquired the lock, then the user space value
-			 * of uaddr2 should be vpid. It cannot be changed by
-			 * the top waiter as it is blocked on hb2 lock if it
-			 * tries to do so. If something fiddled with it behind
-			 * our back the pi state lookup might unearth it. So
-			 * we rather use the known value than rereading and
-			 * handing potential crap to lookup_pi_state.
+			 * If futex_proxy_trylock_atomic() acquired the
+			 * user space futex, then the user space value
+			 * @uaddr2 has been set to the @hb1's top waiter
+			 * task VPID. This task is guaranteed to be alive
+			 * and cannot be exiting because it is either
+			 * sleeping or blocked on @hb2 lock.
+			 *
+			 * The @uaddr2 futex cannot have waiters either as
+			 * otherwise futex_proxy_trylock_atomic() would not
+			 * have succeeded.
 			 *
-			 * If that call succeeds then we have pi_state and an
-			 * initial refcount on it.
+			 * In order to requeue waiters to @hb2, pi state is
+			 * required. Hand in the VPID value (@ret) and
+			 * allocate PI state with an initial refcount on
+			 * it.
 			 */
-			ret = lookup_pi_state(uaddr2, ret, hb2, &key2,
-					      &pi_state, &exiting);
+			ret = attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
+						 &exiting);
+			WARN_ON(ret);
 		}
 
 		switch (ret) {
@@ -2183,9 +2168,9 @@ static int futex_requeue(u32 __user *uad
 	}
 
 	/*
-	 * We took an extra initial reference to the pi_state either
-	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
-	 * need to drop it here again.
+	 * We took an extra initial reference to the pi_state either in
+	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
+	 * to drop it here again.
 	 */
 	put_pi_state(pi_state);
 
@@ -2364,7 +2349,7 @@ static int __fixup_pi_state_owner(u32 __
 	 * Modifying pi_state _before_ the user space value would leave the
 	 * pi_state in an inconsistent state when we fault here, because we
 	 * need to drop the locks to handle the fault. This might be observed
-	 * in the PID check in lookup_pi_state.
+	 * in the PID checks when attaching to PI state .
 	 */
 retry:
 	if (!argowner) {

