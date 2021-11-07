Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C07AB447556
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235490AbhKGTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54289 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230364AbhKGTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636314358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mGNAkDLI13BGQh+Oy4Tj03Q65OY8atd0NjbjtwXb63w=;
        b=S181+HAChyOoeK8l4OAgy/cHQCXyfglnBwAKhZOS9knJxIUkNV0xwb72vfO0wBns2vTMwU
        ftGq49uw4g8PxkUvWQ1P06qN/Kj/tTKnaJ2GJJT/sqkpjzpn1RRAJueJXX1r4WB1ahwiZp
        W8pT0kzuQFMPsFa7f377I3dEqEhn79A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-wZoGfFhaMje3t6Q558zthQ-1; Sun, 07 Nov 2021 14:45:52 -0500
X-MC-Unique: wZoGfFhaMje3t6Q558zthQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A534ACC621;
        Sun,  7 Nov 2021 19:45:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BF2379455;
        Sun,  7 Nov 2021 19:45:28 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        mazhenhua <mazhenhua@xiaomi.com>,
        Hillf Danton <hdanton@sina.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] locking/rwsem: Handle handoff bit inheritance
Date:   Sun,  7 Nov 2021 14:45:04 -0500
Message-Id: <20211107194504.262998-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a queue head writer set the handoff bit, it will clear it when
the writer is being killed on its way out without acquiring the lock.
That is not the case for a queue head reader. The easy thing to do is
to let the next waiter inherit the handoff bit especially if the next
one is also a reader.

In the case of a writer inheriting the handoff bit, we need to make
sure that writer sets its state correctly to avoid leaving the handoff
bit dangling if it is killed or interrupted before getting the lock. We
also need to make sure that the handoff bit is always cleared when the
wait queue is empty to avoid having the handoff bit set with no waiter.

A new lock event is added to keep track of this writer handoff bit
inheritance.

Fixes: 4f23dbc1e657 ("locking/rwsem: Implement lock handoff to prevent lock starvation")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/rwsem.c            | 50 +++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 97fb6f3f840a..0eddfb2e6e74 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -67,3 +67,4 @@ LOCK_EVENT(rwsem_rlock_handoff)	/* # of read lock handoffs		*/
 LOCK_EVENT(rwsem_wlock)		/* # of write locks acquired		*/
 LOCK_EVENT(rwsem_wlock_fail)	/* # of failed write lock acquisitions	*/
 LOCK_EVENT(rwsem_wlock_handoff)	/* # of write lock handoffs		*/
+LOCK_EVENT(rwsem_inherit_handoff) /* # of handoff inheritance		*/
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c51387a43265..45373b9e09e3 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -536,7 +536,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
  * bit is set or the lock is acquired with handoff bit cleared.
  */
 static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
-					enum writer_wait_state wstate)
+					enum writer_wait_state *wstate)
 {
 	long count, new;
 
@@ -546,13 +546,21 @@ static inline bool rwsem_try_write_lock(struct rw_semaphore *sem,
 	do {
 		bool has_handoff = !!(count & RWSEM_FLAG_HANDOFF);
 
-		if (has_handoff && wstate == WRITER_NOT_FIRST)
-			return false;
+		if (has_handoff) {
+			if (*wstate == WRITER_NOT_FIRST)
+				return false;
+
+			/* Inherit a previously set handoff bit */
+			if (*wstate != WRITER_HANDOFF) {
+				*wstate = WRITER_HANDOFF;
+				lockevent_inc(rwsem_inherit_handoff);
+			}
+		}
 
 		new = count;
 
 		if (count & RWSEM_LOCK_MASK) {
-			if (has_handoff || (wstate != WRITER_HANDOFF))
+			if (has_handoff || (*wstate != WRITER_HANDOFF))
 				return false;
 
 			new |= RWSEM_FLAG_HANDOFF;
@@ -1007,6 +1015,10 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 		atomic_long_andnot(RWSEM_FLAG_WAITERS|RWSEM_FLAG_HANDOFF,
 				   &sem->count);
 	}
+	/*
+	 * If this reader was first in the queue, handoff bit set and queue
+	 * not empty, we will let the next waiter inherit the handoff bit.
+	 */
 	raw_spin_unlock_irq(&sem->wait_lock);
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock_fail);
@@ -1019,7 +1031,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 static struct rw_semaphore *
 rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 {
-	long count;
+	long count, bits_clear;
 	enum writer_wait_state wstate;
 	struct rwsem_waiter waiter;
 	struct rw_semaphore *ret = sem;
@@ -1083,7 +1095,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	/* wait until we successfully acquire the lock */
 	set_current_state(state);
 	for (;;) {
-		if (rwsem_try_write_lock(sem, wstate)) {
+		if (rwsem_try_write_lock(sem, &wstate)) {
 			/* rwsem_try_write_lock() implies ACQUIRE on success */
 			break;
 		}
@@ -1132,12 +1144,21 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 			if (!(count & RWSEM_LOCK_MASK))
 				break;
 
+			if (wstate != WRITER_FIRST)
+				continue;
+
+			if (count & RWSEM_FLAG_HANDOFF) {
+				/* Inherit previously set handoff bit */
+				wstate = WRITER_HANDOFF;
+				lockevent_inc(rwsem_inherit_handoff);
+				continue;
+			}
+
 			/*
 			 * The setting of the handoff bit is deferred
 			 * until rwsem_try_write_lock() is called.
 			 */
-			if ((wstate == WRITER_FIRST) && (rt_task(current) ||
-			    time_after(jiffies, waiter.timeout))) {
+			if (rt_task(current) || time_after(jiffies, waiter.timeout)) {
 				wstate = WRITER_HANDOFF;
 				lockevent_inc(rwsem_wlock_handoff);
 				break;
@@ -1157,13 +1178,16 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
 	list_del(&waiter.list);
+	bits_clear = 0;
+	if (list_empty(&sem->wait_list))
+		bits_clear = RWSEM_FLAG_HANDOFF | RWSEM_FLAG_WAITERS;
+	else if (wstate == WRITER_HANDOFF)
+		bits_clear = RWSEM_FLAG_HANDOFF;
 
-	if (unlikely(wstate == WRITER_HANDOFF))
-		atomic_long_add(-RWSEM_FLAG_HANDOFF,  &sem->count);
+	if (bits_clear)
+		atomic_long_andnot(bits_clear,  &sem->count);
 
-	if (list_empty(&sem->wait_list))
-		atomic_long_andnot(RWSEM_FLAG_WAITERS, &sem->count);
-	else
+	if (!list_empty(&sem->wait_list))
 		rwsem_mark_wake(sem, RWSEM_WAKE_ANY, &wake_q);
 	raw_spin_unlock_irq(&sem->wait_lock);
 	wake_up_q(&wake_q);
-- 
2.27.0

