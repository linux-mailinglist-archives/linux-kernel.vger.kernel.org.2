Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0B03FEB95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343716AbhIBJuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 05:50:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42696 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245263AbhIBJtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 05:49:50 -0400
Message-ID: <20210902094414.676104881@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630576131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=098ABI2W5f/OLFge6G+Ew+8jnehp40BF5iRDK8McxKk=;
        b=m5scqruCwzIHJZTvqLxRcm0VwXyeY56H/XTGaL5zoDixW4bsUQIk7EpQ6WTl/WsmKcKajh
        PQk8DKL/aTXsr5AzotdiZ+/NFD9GGArB6LieokScZW8YnYhXp89Xra/euIpwZXlRZR4ccP
        j1/0AL7Km51GSI7z0+TyUb9ODAFnuFT2+ZOZA3xmCia9DG0MqlyJKb3u+1DffPGj8Mbm7q
        SHtt7a4J6ymZJ4105ECP11KKcrDqfldfZj+ULZIyye29ME4/6B14IgglJ8BI4/8Qr1JH8u
        o85k+YmzxvY6mdXT2qv5EJiL/WgK2ho8PQ8qZxLE5o5WVW8ZTkOfgY6JYTlkNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630576131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=098ABI2W5f/OLFge6G+Ew+8jnehp40BF5iRDK8McxKk=;
        b=5fuzENxLQzYTSVNh3w5DAiHOFysDgZmYJ2PXZjV0Ql26ZKHaH6sV7KnZgblmvJaJdY9a9Q
        mgiIs7ilPTXmFUAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Darren Hart <dvhart@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch 3/3] futex: Avoid redundant task lookup
References: <20210902093755.087908334@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Thu,  2 Sep 2021 11:48:51 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to do the full VPID based task lookup and validation of the top
waiter when the user space futex was acquired on it's behalf during the
requeue_pi operation. The task is known already and it cannot go away
before requeue_pi_wake_futex() has been invoked.

Split out the actual attach code from attach_pi_state_owner() and use that
instead of the full blown variant.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/futex.c |   67 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 30 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1263,6 +1263,36 @@ static int handle_exit_race(u32 __user *
 	return -ESRCH;
 }
 
+static void __attach_to_pi_owner(struct task_struct *p, union futex_key *key,
+				 struct futex_pi_state **ps)
+{
+	/*
+	 * No existing pi state. First waiter. [2]
+	 *
+	 * This creates pi_state, we have hb->lock held, this means nothing can
+	 * observe this state, wait_lock is irrelevant.
+	 */
+	struct futex_pi_state *pi_state = alloc_pi_state();
+
+	/*
+	 * Initialize the pi_mutex in locked state and make @p
+	 * the owner of it:
+	 */
+	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
+
+	/* Store the key for possible exit cleanups: */
+	pi_state->key = *key;
+
+	WARN_ON(!list_empty(&pi_state->list));
+	list_add(&pi_state->list, &p->pi_state_list);
+	/*
+	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
+	 * because there is no concurrency as the object is not published yet.
+	 */
+	pi_state->owner = p;
+
+	*ps = pi_state;
+}
 /*
  * Lookup the task for the TID provided from user space and attach to
  * it after doing proper sanity checks.
@@ -1272,7 +1302,6 @@ static int attach_to_pi_owner(u32 __user
 			      struct task_struct **exiting)
 {
 	pid_t pid = uval & FUTEX_TID_MASK;
-	struct futex_pi_state *pi_state;
 	struct task_struct *p;
 
 	/*
@@ -1324,36 +1353,11 @@ static int attach_to_pi_owner(u32 __user
 		return ret;
 	}
 
-	/*
-	 * No existing pi state. First waiter. [2]
-	 *
-	 * This creates pi_state, we have hb->lock held, this means nothing can
-	 * observe this state, wait_lock is irrelevant.
-	 */
-	pi_state = alloc_pi_state();
-
-	/*
-	 * Initialize the pi_mutex in locked state and make @p
-	 * the owner of it:
-	 */
-	rt_mutex_init_proxy_locked(&pi_state->pi_mutex, p);
-
-	/* Store the key for possible exit cleanups: */
-	pi_state->key = *key;
-
-	WARN_ON(!list_empty(&pi_state->list));
-	list_add(&pi_state->list, &p->pi_state_list);
-	/*
-	 * Assignment without holding pi_state->pi_mutex.wait_lock is safe
-	 * because there is no concurrency as the object is not published yet.
-	 */
-	pi_state->owner = p;
+	__attach_to_pi_owner(p, key, ps);
 	raw_spin_unlock_irq(&p->pi_lock);
 
 	put_task_struct(p);
 
-	*ps = pi_state;
-
 	return 0;
 }
 
@@ -1464,11 +1468,14 @@ static int futex_lock_pi_atomic(u32 __us
 		 * @task is guaranteed to be alive and it cannot be exiting
 		 * because it is either sleeping or waiting in
 		 * futex_requeue_pi_wakeup_sync().
+		 *
+		 * No need to do the full attach_to_pi_owner() exercise
+		 * because @task is known and valid.
 		 */
 		if (set_waiters) {
-			 ret = attach_to_pi_owner(uaddr, newval, key, ps,
-						  exiting);
-			 WARN_ON(ret);
+			raw_spin_lock_irq(&task->pi_lock);
+			__attach_to_pi_owner(task, key, ps);
+			raw_spin_unlock_irq(&task->pi_lock);
 		}
 		return 1;
 	}

