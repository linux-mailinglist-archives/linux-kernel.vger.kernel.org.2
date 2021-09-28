Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646DF41B27C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbhI1PBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:01:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241265AbhI1PBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:01:50 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632841210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2hSa7CruxRoNrTlOusFGprrCVI8XXwzDY321KZqRJM=;
        b=uHzUv0CJQS9uSSGyjUEEkayKbPFg4dVDZ10VXA9gUmjzCxc7kL2QebE5THG0gdPGzA2ers
        xVwvqnnztDFysox0KzAe2IPGlsRgfYJ+kZ9SEnFR/2Q51bAXu0kv9FOaVbnako0TyJ6qvm
        +KBkl9qTNucsv0nGDSw89sUEfWvgZpaepg1VRxPYz2RCrVsnM6i3J2+tPRzrMgY1/hFoz9
        Ig7jITpw+kVynAdsydztt1zGu9QLEdkVnXxSze7g2XFBPQaKGj6TCAbmsWx9atqpo94yCW
        RmkWSH4G4ptWfeKhiWVlQHJbPpIBmf3y2rUmo/p2tq0eJUOaiJBgw3P4m2x2gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632841210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2hSa7CruxRoNrTlOusFGprrCVI8XXwzDY321KZqRJM=;
        b=CmYl/huMtlIDbqetHJEK54AERdNsaJobn77mCu+Nn1u7qd1dAANlP2m160iJ5Z31Kl3488
        EePDaHXUg79GU9Cg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/2] rtmutex: Wake up the waiters lockless while dropping the read lock.
Date:   Tue, 28 Sep 2021 17:00:06 +0200
Message-Id: <20210928150006.597310-3-bigeasy@linutronix.de>
In-Reply-To: <20210928150006.597310-1-bigeasy@linutronix.de>
References: <20210928150006.597310-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The rw_semaphore and rwlock_t implementation both wake the waiter while
holding the rt_mutex_base::wait_lock acquired.
This can be optimized by waking the waiter lockless outside of the
locked section to avoid a needless contention on the
rt_mutex_base::wait_lock lock.

Extend rt_mutex_wake_q_add() to also accept task and state and use it in
__rwbase_read_unlock().

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c   | 23 +++++++++++++++--------
 kernel/locking/rwbase_rt.c |  6 +++++-
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cafc259ec59d3..0c6a48dfcecb3 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -446,17 +446,24 @@ static __always_inline void rt_mutex_adjust_prio(stru=
ct task_struct *p)
 }
=20
 /* RT mutex specific wake_q wrappers */
+static __always_inline void rt_mutex_wake_q_add_task(struct rt_wake_q_head=
 *wqh,
+						     struct task_struct *task,
+						     unsigned int wake_state)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wake_state =3D=3D TASK_RTLOCK_WAIT) {
+		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+			WARN_ON_ONCE(wqh->rtlock_task);
+		get_task_struct(task);
+		wqh->rtlock_task =3D task;
+	} else {
+		wake_q_add(&wqh->head, task);
+	}
+}
+
 static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
 						struct rt_mutex_waiter *w)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state =3D=3D TASK_RTLOCK_WAI=
T) {
-		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
-			WARN_ON_ONCE(wqh->rtlock_task);
-		get_task_struct(w->task);
-		wqh->rtlock_task =3D w->task;
-	} else {
-		wake_q_add(&wqh->head, w->task);
-	}
+	rt_mutex_wake_q_add_task(wqh, w->task, w->wake_state);
 }
=20
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 88191f6e252c3..15c81100f0e26 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -148,6 +148,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_=
rt *rwb,
 {
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
 	struct task_struct *owner;
+	DEFINE_RT_WAKE_Q(wqh);
=20
 	raw_spin_lock_irq(&rtm->wait_lock);
 	/*
@@ -158,9 +159,12 @@ static void __sched __rwbase_read_unlock(struct rwbase=
_rt *rwb,
 	 */
 	owner =3D rt_mutex_owner(rtm);
 	if (owner)
-		wake_up_state(owner, state);
+		rt_mutex_wake_q_add_task(&wqh, owner, state);
=20
+	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
+	preempt_disable();
 	raw_spin_unlock_irq(&rtm->wait_lock);
+	rt_mutex_wake_up_q(&wqh);
 }
=20
 static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
--=20
2.33.0

