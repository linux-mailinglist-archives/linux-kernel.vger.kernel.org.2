Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BBC32667C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 18:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhBZRv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 12:51:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:54770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZRvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 12:51:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1CC8EAC6E;
        Fri, 26 Feb 2021 17:51:02 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, peterz@infradead.org, dvhart@infradead.org,
        dave@stgolabs.net, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/4] kernel/futex: Kill rt_mutex_next_owner()
Date:   Fri, 26 Feb 2021 09:50:26 -0800
Message-Id: <20210226175029.50335-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update wake_futex_pi() and kill the call altogether. This is possible because:

(i) The case of fixup_owner() in which the pi_mutex was stolen from the
signaled enqueued top-waiter which fails to trylock and doesn't see a
current owner of the rtmutex but needs to acknowledge an non-enqueued
higher priority waiter, which is the other alternative. This used to be
handled by rt_mutex_next_owner(), which guaranteed fixup_pi_state_owner('newowner')
never to be nil. Nowadays the logic is handled by an EAGAIN loop, without
the need of rt_mutex_next_owner(). Specifically:

    c1e2f0eaf015 (futex: Avoid violating the 10th rule of futex)
    9f5d1c336a10 (futex: Handle transient "ownerless" rtmutex state correctly)

(ii) rt_mutex_next_owner() and rt_mutex_top_waiter() are semantically
equivalent, as of:

    c28d62cf52d7 (locking/rtmutex: Handle non enqueued waiters gracefully in remove_waiter())

So instead of keeping the call around, just use the good ole rt_mutex_top_waiter().
This patch implies no change in semantics.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/futex.c                  |  7 +++++--
 kernel/locking/rtmutex.c        | 20 --------------------
 kernel/locking/rtmutex_common.h |  1 -
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e68db7745039..db8002dbca7a 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1494,13 +1494,14 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
 {
 	u32 curval, newval;
+	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock = false;
 	DEFINE_WAKE_Q(wake_q);
 	int ret = 0;
 
-	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);
-	if (WARN_ON_ONCE(!new_owner)) {
+	top_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
+	if (WARN_ON_ONCE(!top_waiter)) {
 		/*
 		 * As per the comment in futex_unlock_pi() this should not happen.
 		 *
@@ -1513,6 +1514,8 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_
 		goto out_unlock;
 	}
 
+	new_owner = top_waiter->task;
+
 	/*
 	 * We pass it to the next owner. The WAITERS bit is always kept
 	 * enabled while there is PI state around. We cleanup the owner
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 03b21135313c..919391c604f1 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1792,26 +1792,6 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 	return ret;
 }
 
-/**
- * rt_mutex_next_owner - return the next owner of the lock
- *
- * @lock: the rt lock query
- *
- * Returns the next owner of the lock or NULL
- *
- * Caller has to serialize against other accessors to the lock
- * itself.
- *
- * Special API call for PI-futex support
- */
-struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock)
-{
-	if (!rt_mutex_has_waiters(lock))
-		return NULL;
-
-	return rt_mutex_top_waiter(lock)->task;
-}
-
 /**
  * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
  * @lock:		the rt_mutex we were woken on
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index ca6fb489007b..a5007f00c1b7 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -130,7 +130,6 @@ enum rtmutex_chainwalk {
 /*
  * PI-futex support (proxy locking functions, etc.):
  */
-extern struct task_struct *rt_mutex_next_owner(struct rt_mutex *lock);
 extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				       struct task_struct *proxy_owner);
 extern void rt_mutex_proxy_unlock(struct rt_mutex *lock);
-- 
2.26.2

