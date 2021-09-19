Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD623410CE4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 20:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhISS3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 14:29:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37690 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhISS3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 14:29:35 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632076088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9fV8aUhuEEEY5uksFS3ma4yaXWvVvRSRvypPDwsKURg=;
        b=kxc85agu6WsDjNolZ8PrIvnOnclzVcpicc+WvAg2hqth9OMALvBYlT4FhPdyejH/hAld5/
        1Y6W2ouCLI5aCw8hIANVKrWAWIzOHRalj1VoL0YVCtQaIw8KVm5k3I9q4REeyHPmd6oc7O
        T0NrOeQWZFNMEwyJitYY8mJ+rdAW7TVwSJP/H+d9Dka0d2z7/VF6/MX+YJYBSG7WsS+1pv
        maPTR+eqWERK1GNQt8lEnsx8f1nEDBEsCTCAbi2V41zNevWoJvc4Fkr0mkJl7ngJM2sxRT
        9hogzODJzHVt0UFKW0OrVISY4qV4GBnwz+EqZy9EfdtVLIqAn2qoh+7ZkQWJYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632076088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9fV8aUhuEEEY5uksFS3ma4yaXWvVvRSRvypPDwsKURg=;
        b=o8z+3Q5Xwy7ujFKmXw0Y3oPeRaCCvpkol2cjokA5OE2qv3FAcElb4cWaW3J2uZYFC8gYx2
        o3RBXzayfADYBICg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.15-rc2
Message-ID: <163207602242.947088.16824174748243890514.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 19 Sep 2021 20:28:07 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2=
021-09-19

up to:  81121524f1c7: locking/rwbase: Take care of ordering guarantee for fas=
tpath reader


A set of updates for the RT specific reader/writer locking base code:

  - Make the fast path reader ordering guarantees correct.

  - Code reshuffling to make the fix simpler.

Thanks,

	tglx

------------------>
Boqun Feng (1):
      locking/rwbase: Take care of ordering guarantee for fastpath reader

Peter Zijlstra (2):
      locking/rwbase: Properly match set_and_save_state() to restore_state()
      locking/rwbase: Extract __rwbase_write_trylock()


 kernel/locking/rwbase_rt.c | 65 ++++++++++++++++++++++++++++++++------------=
--
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba15088e640..88191f6e252c 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -41,6 +41,12 @@
  * The risk of writer starvation is there, but the pathological use cases
  * which trigger it are not necessarily the typical RT workloads.
  *
+ * Fast-path orderings:
+ * The lock/unlock of readers can run in fast paths: lock and unlock are only
+ * atomic ops, and there is no inner lock to provide ACQUIRE and RELEASE
+ * semantics of rwbase_rt. Atomic ops should thus provide _acquire()
+ * and _release() (or stronger).
+ *
  * Common code shared between RT rw_semaphore and rwlock
  */
=20
@@ -53,6 +59,7 @@ static __always_inline int rwbase_read_trylock(struct rwbas=
e_rt *rwb)
 	 * set.
 	 */
 	for (r =3D atomic_read(&rwb->readers); r < 0;) {
+		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
@@ -162,6 +169,8 @@ static __always_inline void rwbase_read_unlock(struct rwb=
ase_rt *rwb,
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
 	 * active readers to leave the critical section.
+	 *
+	 * dec_and_test() is fully ordered, provides RELEASE.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock(struct rwbase_r=
t *rwb, int bias,
 {
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
=20
-	atomic_add(READER_BIAS - bias, &rwb->readers);
+	/*
+	 * _release() is needed in case that reader is in fast path, pairing
+	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 */
+	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rwbase_rtmutex_unlock(rtm);
 }
@@ -196,6 +209,23 @@ static inline void rwbase_write_downgrade(struct rwbase_=
rt *rwb)
 	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
 }
=20
+static inline bool __rwbase_write_trylock(struct rwbase_rt *rwb)
+{
+	/* Can do without CAS because we're serialized by wait_lock. */
+	lockdep_assert_held(&rwb->rtmutex.wait_lock);
+
+	/*
+	 * _acquire is needed in case the reader is in the fast path, pairing
+	 * with rwbase_read_unlock(), provides ACQUIRE.
+	 */
+	if (!atomic_read_acquire(&rwb->readers)) {
+		atomic_set(&rwb->readers, WRITER_BIAS);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
 				     unsigned int state)
 {
@@ -210,34 +240,30 @@ static int __sched rwbase_write_lock(struct rwbase_rt *=
rwb,
 	atomic_sub(READER_BIAS, &rwb->readers);
=20
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	/*
-	 * set_current_state() for rw_semaphore
-	 * current_save_and_set_rtlock_wait_state() for rwlock
-	 */
-	rwbase_set_and_save_current_state(state);
+	if (__rwbase_write_trylock(rwb))
+		goto out_unlock;
=20
-	/* Block until all readers have left the critical section. */
-	for (; atomic_read(&rwb->readers);) {
+	rwbase_set_and_save_current_state(state);
+	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
-			__set_current_state(TASK_RUNNING);
+			rwbase_restore_current_state();
 			__rwbase_write_unlock(rwb, 0, flags);
 			return -EINTR;
 		}
+
+		if (__rwbase_write_trylock(rwb))
+			break;
+
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+		rwbase_schedule();
+		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
=20
-		/*
-		 * Schedule and wait for the readers to leave the critical
-		 * section. The last reader leaving it wakes the waiter.
-		 */
-		if (atomic_read(&rwb->readers) !=3D 0)
-			rwbase_schedule();
 		set_current_state(state);
-		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
 	}
-
-	atomic_set(&rwb->readers, WRITER_BIAS);
 	rwbase_restore_current_state();
+
+out_unlock:
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	return 0;
 }
@@ -253,8 +279,7 @@ static inline int rwbase_write_trylock(struct rwbase_rt *=
rwb)
 	atomic_sub(READER_BIAS, &rwb->readers);
=20
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	if (!atomic_read(&rwb->readers)) {
-		atomic_set(&rwb->readers, WRITER_BIAS);
+	if (__rwbase_write_trylock(rwb)) {
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		return 1;
 	}

