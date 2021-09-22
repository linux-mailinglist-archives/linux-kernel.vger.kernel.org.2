Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DE41508B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbhIVTiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 15:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229918AbhIVTiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 15:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632339441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lXf5kp88ByplDo+A69LcTnTRj8dAVkkTmdY+l70PGDQ=;
        b=FYBwg8+/PESso3F5fE90DJKOsERMXsaue1IANsngjvxbWQHI9Ov1LMPvO7CR8T3mSdZCXV
        nunSaDBTDBKnL7YB6DChPTGat5X+Xws8455gcqPFtI+l5df4FgGSiHKFL6+7d3OnqtxAwL
        AQf/RRuaThZVCIUfL2Vl6n77YcoWehc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-DboPpqjCMVu8Tz1IX3DQSQ-1; Wed, 22 Sep 2021 15:37:19 -0400
X-MC-Unique: DboPpqjCMVu8Tz1IX3DQSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AD4DCC624;
        Wed, 22 Sep 2021 19:37:18 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E92B60843;
        Wed, 22 Sep 2021 19:37:14 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] locking/rwsem: Add upgrade_read()
Date:   Wed, 22 Sep 2021 15:36:57 -0400
Message-Id: <20210922193657.29461-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there are about 12 instances in the kernel where an up_read()
is immediately followed by a down_write() of the same lock. For example,

  drivers/tty/n_tty.c:		up_read(&tty->termios_rwsem);
  drivers/tty/n_tty.c-		down_write(&tty->termios_rwsem);

Since we have already provided a downgrade_write() function, we may as
well provide an upgrade_read() function to make the code easier to read
and the intention clearer.

If the current task is the only reader, the upgrade can be done by a
single atomic operation. If not, the upgrade will have to be done by a
separate up_read() call followed by a down_write(). In the former case,
the handoff bit is not considered and the waiter will have to wait a
bit longer to acquire the lock.

The new upgrade_read() function returns a value of 0 for safe upgrade
where rwsem protected data won't change. Otherwise a value of 1 is
returned to indicate unsafe upgrade where rwsem protected data may
change during the upgrade process.

For PREEMPT_RT, it falls back to up_read() followed by down_write()
for simplicity.

Some uses of down_write() with long lock hold time may be changed
to the following format in the future:

	down_read()
	/* check data */
	if (upgrade_read()) {
		/* unsafe upgrade, recheck data */
	}
	/* update data */
	up_write();

As long as the "recheck data" and "update data" parts are relatively
short compared with the "check data" part, this conversion may help to
improve parallelism and reduce lock contention.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/rwsem.h  |  5 ++++
 kernel/locking/rwsem.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 352c6127cb90..8ece58224f25 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -207,6 +207,11 @@ extern void up_write(struct rw_semaphore *sem);
  */
 extern void downgrade_write(struct rw_semaphore *sem);
 
+/*
+ * upgrade read lock to write lock
+ */
+extern int upgrade_read(struct rw_semaphore *sem);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
  * nested locking. NOTE: rwsems are not allowed to recurse
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5a2884..aeb5b0668304 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1203,6 +1203,29 @@ static struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem)
 	return sem;
 }
 
+/*
+ * Try to upgrade read lock to write lock
+ */
+static inline int __try_upgrade_read(struct rw_semaphore *sem)
+{
+	long count = atomic_long_read(&sem->count);
+
+	WARN_ON_ONCE(count & RWSEM_WRITER_LOCKED);
+
+	/*
+	 * When upgrading from shared to exclusive ownership,
+	 * anything inside the write-locked region cannot leak
+	 * into the read side. Use an ACQUIRE semantics.
+	 */
+	if (((count & RWSEM_READER_MASK) == RWSEM_READER_BIAS) &&
+	     atomic_long_try_cmpxchg_acquire(&sem->count, &count,
+			count - RWSEM_READER_BIAS + RWSEM_WRITER_LOCKED)) {
+		rwsem_set_owner(sem);
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * lock for reading
  */
@@ -1438,6 +1461,11 @@ static inline void __downgrade_write(struct rw_semaphore *sem)
 	rwbase_write_downgrade(&sem->rwbase);
 }
 
+static inline int __try_upgrade_read(struct rw_semaphore *sem)
+{
+	return 0;
+}
+
 /* Debug stubs for the common API */
 #define DEBUG_RWSEMS_WARN_ON(c, sem)
 
@@ -1581,6 +1609,31 @@ void downgrade_write(struct rw_semaphore *sem)
 }
 EXPORT_SYMBOL(downgrade_write);
 
+/*
+ * Upgrade read lock to write lock
+ *
+ * Return: 0 when upgrade is safe, i.e. rwsem protected data do not change;
+ *         1 when upgrade is unsafe as rwsem protected data may have changed.
+ */
+int upgrade_read(struct rw_semaphore *sem)
+{
+	if (__try_upgrade_read(sem)) {
+		rwsem_release(&sem->dep_map, _RET_IP_);
+		rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+		return 0;
+	}
+
+	/*
+	 * We cannot directly upgrade to the write lock, just do a regular
+	 * up_read() and down_write() sequence. The data protected by the
+	 * rwsem may have changed before the write lock is acquired.
+	 */
+	down_read(sem);
+	up_write(sem);
+	return 1;
+}
+EXPORT_SYMBOL(upgrade_read);
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 void down_read_nested(struct rw_semaphore *sem, int subclass)
-- 
2.18.1

