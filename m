Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9907D40B027
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhINODm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhINODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:03:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F3BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ikIcpvvxpz3lHW8UImkJMnAPIGaYfFUZqIxswpaNdgQ=; b=aNJ7XWDgkm0L1CF1btO9FfvG1e
        UBsNhuSzqGYkh8x+pslQAHRVA19nkv5D7TqtT5jJV9Sws1mKcNe4tjKlIFPiyXwJ9Nszj+Fj4pgAN
        KLuA6NjFUz+QcX1J30hSNRRAkKfnttr8mDvCkq1xiWXn4VRYa9rL1P5q+Kc+s6md4qZMm88dzAgqw
        vq7vlDpr/DgJ0k6MetIP0LsegF3omAcY3LUd5hArq8c9Ieiyy/gQNNmIxsf8MsiXOFU84CJeYiXhd
        9+x7uoCB5oMiPUENtGOMPjB/nrdz5U/MCmw1G1MvzGrDWWB6jkJdsj/MgdDks2WkW3F15IIEgLzKS
        yEiqXajw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQ8yc-00EiwU-Cr; Tue, 14 Sep 2021 14:00:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 72FCC300129;
        Tue, 14 Sep 2021 15:59:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BE62200C6C6A; Tue, 14 Sep 2021 15:59:56 +0200 (CEST)
Date:   Tue, 14 Sep 2021 15:59:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] locking/rwbase: Fix rwbase_write_lock() vs
 __rwbase_read_lock()
Message-ID: <YUCq3L+u44NDieEJ@hirez.programming.kicks-ass.net>
References: <20210909105915.757320973@infradead.org>
 <20210909110203.893845303@infradead.org>
 <87k0jjeh2v.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0jjeh2v.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 09:45:12AM +0200, Thomas Gleixner wrote:
> On Thu, Sep 09 2021 at 12:59, Peter Zijlstra wrote:
> 
> > Boqun noticed that the write-trylock sequence of load+set is broken in
> > rwbase_write_lock()'s wait-loop since they're not both under the same
> > wait_lock instance.
> 
> Confused.
> 
> lock(); A
> 
> for (; atomic_read(readers);) {
>    ...
>    unlock();
>    ..
>    lock(); B
> }
> 
> atomic_set();
> unlock(); A or B
> 
> The read/set is always in the same lock instance.

I really did make a mess of things didn't I :-/ It was some intermediate
state that was broken.

How's this then?

---
Subject: locking/rwbase: Extract __rwbase_write_trylock()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 09 Sep 2021 12:59:18 +0200

The code in rwbase_write_lock() is a little non-obvious vs the
read+set 'trylock', extract the sequence into a helper function to
clarify the code.

This also provides a single site to fix fast-path ordering.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rwbase_rt.c |   44 ++++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 18 deletions(-)

--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -196,6 +196,19 @@ static inline void rwbase_write_downgrad
 	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
 }
 
+static inline bool __rwbase_write_trylock(struct rwbase_rt *rwb)
+{
+	/* Can do without CAS because we're serialized by wait_lock. */
+	lockdep_assert_held(&rwb->rtmutex.wait_lock);
+
+	if (!atomic_read(&rwb->readers)) {
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
@@ -210,34 +223,30 @@ static int __sched rwbase_write_lock(str
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	/*
-	 * set_current_state() for rw_semaphore
-	 * current_save_and_set_rtlock_wait_state() for rwlock
-	 */
-	rwbase_set_and_save_current_state(state);
+	if (__rwbase_write_trylock(rwb))
+		goto out_unlock;
 
-	/* Block until all readers have left the critical section. */
-	for (; atomic_read(&rwb->readers);) {
+	rwbase_set_and_save_current_state(state);
+	for (;;) {
 		/* Optimized out for rwlocks */
 		if (rwbase_signal_pending_state(state, current)) {
 			rwbase_restore_current_state();
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
 
-		/*
-		 * Schedule and wait for the readers to leave the critical
-		 * section. The last reader leaving it wakes the waiter.
-		 */
-		if (atomic_read(&rwb->readers) != 0)
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
@@ -253,8 +262,7 @@ static inline int rwbase_write_trylock(s
 	atomic_sub(READER_BIAS, &rwb->readers);
 
 	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
-	if (!atomic_read(&rwb->readers)) {
-		atomic_set(&rwb->readers, WRITER_BIAS);
+	if (__rwbase_write_trylock(rwb)) {
 		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
 		return 1;
 	}
