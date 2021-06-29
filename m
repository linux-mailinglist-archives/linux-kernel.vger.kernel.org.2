Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928D73B7922
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 22:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhF2UOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 16:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234853AbhF2UOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 16:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624997533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=4UTtGrNsrdZvwFyy7cNQy5nuzdIX59uOhbFVCkxu6q8=;
        b=ICy+3yuxcaV8oQ6PQ94jwZbjPtxoAycQhX8slAIRNMYYt4xK+scR/2pIGoVNuoUXGPomwW
        BNi8N/1rIkI8anO6MYFSY1CPVl0r0Kxh+lugxi7lpLPakObC004pj7jTueNxWKZtzdvWH6
        tpzV/6cjPQtG/WYQvE8poz1fvRckdlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-6qCz2CitNTOpN9wyuRZ5-Q-1; Tue, 29 Jun 2021 16:12:12 -0400
X-MC-Unique: 6qCz2CitNTOpN9wyuRZ5-Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B281835AC3;
        Tue, 29 Jun 2021 20:12:11 +0000 (UTC)
Received: from llong.com (ovpn-118-17.rdu2.redhat.com [10.10.118.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B416A60843;
        Tue, 29 Jun 2021 20:12:06 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Xu, Yanfei" <yanfei.xu@windriver.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/mutex: Reduce chance of setting HANDOFF bit on unlocked mutex
Date:   Tue, 29 Jun 2021 16:11:38 -0400
Message-Id: <20210629201138.31507-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current mutex code may set the HANDOFF bit right after wakeup
without checking if the mutex is unlocked.  The chance of setting the
HANDOFF bit on an unlocked mutex can be relatively high. In this case,
it doesn't really block other waiters from acquiring the lock thus
wasting an unnecessary atomic operation.

To reduce the chance, do a trylock first before setting the HANDOFF bit.
In addition, optimistic spinning on the mutex will only be done if the
HANDOFF bit is set on a locked mutex to guarantee that no one else can
steal it.

Reported-by: Xu, Yanfei <yanfei.xu@windriver.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/mutex.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d2df5e68b503..472ab21b5b8e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -118,9 +118,9 @@ static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *lock)
 		}
 
 		/*
-		 * We set the HANDOFF bit, we must make sure it doesn't live
-		 * past the point where we acquire it. This would be possible
-		 * if we (accidentally) set the bit on an unlocked mutex.
+		 * Always clear the HANDOFF bit before acquiring the lock.
+		 * Note that if the bit is accidentally set on an unlocked
+		 * mutex, anyone can acquire it.
 		 */
 		flags &= ~MUTEX_FLAG_HANDOFF;
 
@@ -180,6 +180,11 @@ static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
 	atomic_long_or(flag, &lock->owner);
 }
 
+static inline long __mutex_fetch_set_flag(struct mutex *lock, unsigned long flag)
+{
+	return atomic_long_fetch_or_relaxed(flag, &lock->owner);
+}
+
 static inline void __mutex_clear_flag(struct mutex *lock, unsigned long flag)
 {
 	atomic_long_andnot(flag, &lock->owner);
@@ -1007,6 +1012,8 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	set_current_state(state);
 	for (;;) {
+		long owner = 0L;
+
 		/*
 		 * Once we hold wait_lock, we're serialized against
 		 * mutex_unlock() handing the lock off to us, do a trylock
@@ -1035,24 +1042,33 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 		spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
+		/*
+		 * Here we order against unlock; we must either see it change
+		 * state back to RUNNING and fall through the next schedule(),
+		 * or we must see its unlock and acquire.
+		 */
+		if (__mutex_trylock(lock))
+			break;
+
+		set_current_state(state);
+
 		/*
 		 * ww_mutex needs to always recheck its position since its waiter
 		 * list is not FIFO ordered.
 		 */
-		if (ww_ctx || !first) {
+		if (ww_ctx || !first)
 			first = __mutex_waiter_is_first(lock, &waiter);
-			if (first)
-				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
-		}
 
-		set_current_state(state);
+		if (first)
+			owner = __mutex_fetch_set_flag(lock, MUTEX_FLAG_HANDOFF);
+
 		/*
-		 * Here we order against unlock; we must either see it change
-		 * state back to RUNNING and fall through the next schedule(),
-		 * or we must see its unlock and acquire.
+		 * If a lock holder is present with HANDOFF bit set, it will
+		 * guarantee that no one else can steal the lock. We may spin
+		 * on the lock to acquire it earlier.
 		 */
-		if (__mutex_trylock(lock) ||
-		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
+		if ((owner & ~MUTEX_FLAGS) &&
+		     mutex_optimistic_spin(lock, ww_ctx, &waiter))
 			break;
 
 		spin_lock(&lock->wait_lock);
-- 
2.18.1

