Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0383F7359
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhHYKeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:34:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53402 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhHYKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:33:59 -0400
Message-ID: <20210825102453.981720644@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629887593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xZVC8GIfMUdVYAKKo0GJV44oAzqzVytz7bZY0+FiN58=;
        b=UZCp1w0n3uxCKkUzoNRYlx/9FWn7XheOaQoOf3pPBLj7rxTAtbnWZAxieuWtrdP+Q6G6+z
        34pZ6QToYyLZBur430osrEJjuLRHi4uHFzGoEAOghWUbku4QMb2OimqiDdxn3ILzTn4IEM
        fV5+ne4PR6ehwtpKZoXn2RuPJroGtkfliRkfqUbJVgjP02jjYe5sbp+fEkGgcmY6f8xUUd
        pAQ+kPOdPQDN7OBPQPbKhmAzyvEgoGLmMbnVyoP1doPBbsH7Rfevv+0QCAxtB5s1yreTm5
        HF/xHywVklSw48tfgIuw42Ckk03kb4hsG0AMo7HW3hFI6PxraY8HRB9tLSohrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629887593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xZVC8GIfMUdVYAKKo0GJV44oAzqzVytz7bZY0+FiN58=;
        b=+yWURWkcwi1rQ0orcO2p1JpEc9pTS/sWsXAUalR3k7E/SWsVx/TgqIotrGjorfu/iHZv04
        b7XBiDtv5Jhz9kCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [patch 1/2] locking/rtmutex: Dont dereference waiter lockless
References: <20210825101857.420032248@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 25 Aug 2021 12:33:12 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new rt_mutex_spin_on_onwer() loop checks whether the spinning waiter is
still the top waiter on the lock by utilizing rt_mutex_top_waiter(), which
is broken because that function contains a sanity check which dereferences
the top waiter pointer to check whether the waiter belongs to the
lock. That's wrong in the lockless spinwait case:

 CPU 0							CPU 1
 rt_mutex_lock(lock)					rt_mutex_lock(lock);
   queue(waiter0)
   waiter0 == rt_mutex_top_waiter(lock)
   rt_mutex_spin_on_onwer(lock, waiter0) {		queue(waiter1)
   					 		waiter1 == rt_mutex_top_waiter(lock)
   							...
     top_waiter = rt_mutex_top_waiter(lock)
       leftmost = rb_first_cached(&lock->waiters);
							-> signal
							dequeue(waiter1)
							destroy(waiter1)
       w = rb_entry(leftmost, ....)
       BUG_ON(w->lock != lock)	 <- UAF

The BUG_ON() is correct for the case where the caller holds lock->wait_lock
which guarantees that the leftmost waiter entry cannot vanish. For the
lockless spinwait case it's broken.

Create a new helper function which avoids the pointer dereference and just
compares the leftmost entry pointer with current's waiter pointer to
validate that currrent is still elegible for spinning.

Fixes: 992caf7f1724 ("locking/rtmutex: Add adaptive spinwait mechanism")
Reported-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/locking/rtmutex.c        |    5 +++--
 kernel/locking/rtmutex_common.h |   13 +++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1329,8 +1329,9 @@ static bool rtmutex_spin_on_owner(struct
 		 *    for CONFIG_PREEMPT_RCU=y)
 		 *  - the VCPU on which owner runs is preempted
 		 */
-		if (!owner->on_cpu || waiter != rt_mutex_top_waiter(lock) ||
-		    need_resched() || vcpu_is_preempted(task_cpu(owner))) {
+		if (!owner->on_cpu || need_resched() ||
+		    rt_mutex_waiter_is_top_waiter(lock, waiter) ||
+		    vcpu_is_preempted(task_cpu(owner))) {
 			res = false;
 			break;
 		}
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -95,6 +95,19 @@ static inline int rt_mutex_has_waiters(s
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
 
+/*
+ * Lockless speculative check whether @waiter is still the top waiter on
+ * @lock. This is solely comparing pointers and not derefencing the
+ * leftmost entry which might be about to vanish.
+ */
+static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
+						 struct rt_mutex_waiter *waiter)
+{
+	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
+
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) == waiter;
+}
+
 static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_base *lock)
 {
 	struct rb_node *leftmost = rb_first_cached(&lock->waiters);

