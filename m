Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED9A3E4DC9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 22:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233901AbhHIU2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 16:28:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52578 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhHIU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 16:28:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C59A21F2A;
        Mon,  9 Aug 2021 20:28:14 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A5DE13AD4;
        Mon,  9 Aug 2021 20:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NVF4E9uPEWEEAwAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 20:28:11 +0000
Date:   Mon, 9 Aug 2021 13:28:06 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [patch V3 64/64] locking/rtmutex: Add adaptive spinwait mechanism
Message-ID: <20210809202806.whkrk6cvtejaxqcz@offworld>
References: <20210805151300.330412127@linutronix.de>
 <20210805153956.507589092@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210805153956.507589092@linutronix.de>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021, Thomas Gleixner wrote:

>+#ifdef CONFIG_SMP
>+/*
>+ * Note that owner is a speculative pointer and dereferencing relies
>+ * on rcu_read_lock() and the check against the lock owner.
>+ */

I think the description we have in mutex.c is better.

>+static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
>+				     struct task_struct *owner)

I realize that adaptive spinning is the original term from Greg Haskins,
but as Peter suggested, rt_mutex_spin_on_owner() would probably be a
better name upstream considering all our other sleeping locks.

>+{
>+	bool res = true;
>+
>+	rcu_read_lock();
>+	for (;;) {
>+		/* Owner changed. Trylock again */
>+		if (owner != rt_mutex_owner(lock))
>+			break;
>+		/*
>+		 * Ensure that owner->on_cpu is dereferenced _after_
>+		 * checking the above to be valid.
>+		 */
>+		barrier();
>+		if (!owner->on_cpu || need_resched() ||
>+		    vcpu_is_preempted(task_cpu(owner))) {

I'm thinking we should also check for if the spinning waiter is no
longer the top-waiter, which could have changed while busy waiting.

Thanks,
Davidlohr

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 7522c3abacb6..c6925ebb3c9f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1284,12 +1284,9 @@ static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
  }
  
  #ifdef CONFIG_SMP
-/*
- * Note that owner is a speculative pointer and dereferencing relies
- * on rcu_read_lock() and the check against the lock owner.
- */
  static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
+				   struct rt_mutex_waiter *waiter,
+				   struct task_struct *owner)
  {
  	bool res = true;
  
@@ -1299,11 +1296,18 @@ static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
  		if (owner != rt_mutex_owner(lock))
  			break;
  		/*
-		 * Ensure that owner->on_cpu is dereferenced _after_
-		 * checking the above to be valid.
+		 * Ensure we emit the owner->on_cpu, dereference _after_
+		 * checking lock->owner still matches owner. If that fails,
+		 * owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 *
+		 * Also account for changes in the lock's top-waiter, if
+		 * it's not us, it was updated while busy waiting.
  		 */
  		barrier();
+
  		if (!owner->on_cpu || need_resched() ||
+		    waiter != rt_mutex_top_waiter(lock) ||
  		    vcpu_is_preempted(task_cpu(owner))) {
  			res = false;
  			break;
@@ -1315,7 +1319,8 @@ static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
  }
  #else
  static bool rtmutex_adaptive_spinwait(struct rt_mutex_base *lock,
-				     struct task_struct *owner)
+				   struct rt_mutex_waiter *waiter,
+				   struct task_struct *owner)
  {
  	return false;
  }
@@ -1434,7 +1439,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
  			owner = NULL;
  		raw_spin_unlock_irq(&lock->wait_lock);
  
-		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+		if (!owner || !rtmutex_adaptive_spinwait(lock, waiter, owner))
  			schedule();
  
  		raw_spin_lock_irq(&lock->wait_lock);
@@ -1616,7 +1621,7 @@ static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
  			owner = NULL;
  		raw_spin_unlock_irq(&lock->wait_lock);
  
-		if (!owner || !rtmutex_adaptive_spinwait(lock, owner))
+		if (!owner || !rtmutex_adaptive_spinwait(lock, waiter, owner))
  			schedule_rtlock();
  
  		raw_spin_lock_irq(&lock->wait_lock);
