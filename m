Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0618B4048E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhIILFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbhIILFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:05:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA05C061575
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=HEAQV8cw3s94fNIlqXccLtXX8EcNZ0tXje0QER4MNNw=; b=VL2iJb1qxLq7rulJM5iRJlal1X
        H4Jl0ncWLxdEpOsC8Jb9HDoFM03ipsQWZoZaWA81gdpqGHCnGpJXIpKCYriEGnq2Y2hZgeYS/8MHr
        40yW02C1kuBfffkmGsD3oAHBTo+v+Bh9b22UWJ0exgnqwLDJbkOwjNiDPq0BMSAJDRxwoDk8uudOY
        QN6pkrWkrmaBERqbnMMHhDmiwVep3E7kmwPDBvGxgVHiZipkiRgdjp4N+E47Xl0/D4sr1V4+6oUr8
        Qj4JPGxmPnR5+jBJtAYk7bAF1XXlMKr3WScSOYEEyM3ZlGTFIyWhhRW2lzIplJ3lm15OaG8YkW5IQ
        V4ZUH/rA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOHqF-001rBC-LG; Thu, 09 Sep 2021 11:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3E12300130;
        Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BC0F02C3CBEF3; Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Message-ID: <20210909110203.953991276@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Sep 2021 12:59:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 4/4] locking/rwbase: Take care of ordering guarantee for fastpath reader
References: <20210909105915.757320973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

Readers of rwbase can lock and unlock without taking any inner lock, if
that happens, we need the ordering provided by atomic operations to
satisfy the ordering semantics of lock/unlock. Without that, considering
the follow case:

	{ X = 0 initially }

	CPU 0			CPU 1
	=====			=====
				rt_write_lock();
				X = 1
				rt_write_unlock():
				  atomic_add(READER_BIAS - WRITER_BIAS, ->readers);
				  // ->readers is READER_BIAS.
	rt_read_lock():
	  if ((r = atomic_read(->readers)) < 0) // True
	    atomic_try_cmpxchg(->readers, r, r + 1); // succeed.
	  <acquire the read lock via fast path>

	r1 = X;	// r1 may be 0, because nothing prevent the reordering
	        // of "X=1" and atomic_add() on CPU 1.

Therefore audit every usage of atomic operations that may happen in a
fast path, and add necessary barriers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwbase_rt.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

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
 
@@ -53,6 +59,7 @@ static __always_inline int rwbase_read_t
 	 * set.
 	 */
 	for (r = atomic_read(&rwb->readers); r < 0;) {
+		/* Fully-ordered if cmpxchg() succeeds, provides ACQUIRE */
 		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
 			return 1;
 	}
@@ -162,6 +169,8 @@ static __always_inline void rwbase_read_
 	/*
 	 * rwb->readers can only hit 0 when a writer is waiting for the
 	 * active readers to leave the critical section.
+	 *
+	 * dec_and_test() is fully ordered, provides RELEASE.
 	 */
 	if (unlikely(atomic_dec_and_test(&rwb->readers)))
 		__rwbase_read_unlock(rwb, state);
@@ -172,7 +181,11 @@ static inline void __rwbase_write_unlock
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 
-	atomic_add(READER_BIAS - bias, &rwb->readers);
+	/*
+	 * _release() is needed in case that reader is in fast path, pairing
+	 * with atomic_try_cmpxchg() in rwbase_read_trylock(), provides RELEASE
+	 */
+	(void)atomic_add_return_release(READER_BIAS - bias, &rwb->readers);
 	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 	rwbase_rtmutex_unlock(rtm);
 }
@@ -201,7 +214,11 @@ static inline bool __rwbase_write_tryloc
 	/* Can do without CAS because we're serialized by wait_lock. */
 	lockdep_assert_held(&rwb->rtmutex.wait_lock);
 
-	if (!atomic_read(&rwb->readers)) {
+ 	/*
+	 * _acquire is needed in case the reader is in the fast path, pairing
+	 * with rwbase_read_unlock(), provides ACQUIRE.
+	 */
+	if (!atomic_read_acquire(&rwb->readers)) {
 		atomic_set(&rwb->readers, WRITER_BIAS);
 		return 1;
 	}


