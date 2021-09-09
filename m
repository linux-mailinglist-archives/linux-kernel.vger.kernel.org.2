Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E64048DF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 13:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhIILFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 07:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbhIILFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 07:05:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE24C061756
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=jh+fs4xoGFyV+30/UJk/QCfrqRTmFnmoLT8WuvoXSvs=; b=S+2mckeR6qhrWkzQE2OniejtkY
        pzyQZ6s4HQ4ZYFKJPwWx3KWD7CCX00Oou3fy8xX8uwuEJw0ZUFV6Icr7t+5N92qjd36C9H2Lw7rl/
        Tb6JSWc0nVPLIMJRMPbt32XF8qWkPEoi9Y5mpmri8CrYR80owHepUfwlnuKBr9iGxxwnZgJDf2zeF
        vppXj0C9hga3lCDB09ml/HbFXQ315s7yweZtLOq/KLAfaMU1Ms8iObWyFZUYf4joagg8gDuKtobq4
        oLPKXLHbT0wHF/8zr/+C1FysohJ7kOtz1F4reOECOX5li7X3PhbJXI0dUwsozFzKwYZvPE8Bax8Yt
        ze5HhL9Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOHqF-001rBA-KE; Thu, 09 Sep 2021 11:03:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D20D4300129;
        Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id B6CBE2C3CBEF1; Thu,  9 Sep 2021 13:03:37 +0200 (CEST)
Message-ID: <20210909110203.893845303@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 09 Sep 2021 12:59:18 +0200
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
Subject: [PATCH 3/4] locking/rwbase: Fix rwbase_write_lock() vs __rwbase_read_lock()
References: <20210909105915.757320973@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boqun noticed that the write-trylock sequence of load+set is broken in
rwbase_write_lock()'s wait-loop since they're not both under the same
wait_lock instance.

Restructure the code to make this more obvious and correct.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
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


