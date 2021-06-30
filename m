Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F543B7B3A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 03:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhF3Baf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 21:30:35 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:48094 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhF3Baf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 21:30:35 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jun 2021 18:28:07 -0700
X-QCInternal: smtphost
Received: from gurus-linux.qualcomm.com ([10.134.64.25])
  by ironmsg01-sd.qualcomm.com with ESMTP; 29 Jun 2021 18:28:07 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id E824D21182; Tue, 29 Jun 2021 18:28:06 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RFC PATCH] spinlock_debug: Save stacktrace at lock acquisition
Date:   Tue, 29 Jun 2021 18:28:05 -0700
Message-Id: <1625016485-32581-1-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of spinlock recursion bugs, knowing which entity acquired the
lock initially is key to debugging. Therefore, save the stack frames
when the lock is acquired and print them when spinlock recursion is
detected.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 include/linux/spinlock_types.h  | 3 +++
 kernel/locking/spinlock_debug.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index b981caa..8a68d55 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -22,6 +22,9 @@ typedef struct raw_spinlock {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	unsigned int magic, owner_cpu;
 	void *owner;
+#define MAX_STACK_LEN 16
+	int stack_len;
+	unsigned long stack_trace[MAX_STACK_LEN];
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index b9d9308..d34cccc 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -12,6 +12,7 @@
 #include <linux/debug_locks.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/stacktrace.h>
 
 void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 			  struct lock_class_key *key, short inner)
@@ -27,6 +28,7 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 	lock->magic = SPINLOCK_MAGIC;
 	lock->owner = SPINLOCK_OWNER_INIT;
 	lock->owner_cpu = -1;
+	lock->stack_len = 0;
 }
 
 EXPORT_SYMBOL(__raw_spin_lock_init);
@@ -65,6 +67,10 @@ static void spin_dump(raw_spinlock_t *lock, const char *msg)
 		owner ? task_pid_nr(owner) : -1,
 		READ_ONCE(lock->owner_cpu));
 	dump_stack();
+	if (!strcmp(msg, "recursion")) {
+		printk(KERN_EMERG "Stack at lock acquisition: \n");
+		stack_trace_print(lock->stack_trace, lock->stack_len, 0);
+	}
 }
 
 static void spin_bug(raw_spinlock_t *lock, const char *msg)
@@ -90,6 +96,8 @@ static inline void debug_spin_lock_after(raw_spinlock_t *lock)
 {
 	WRITE_ONCE(lock->owner_cpu, raw_smp_processor_id());
 	WRITE_ONCE(lock->owner, current);
+	lock->stack_len = stack_trace_save(lock->stack_trace,
+					   ARRAY_SIZE(lock->stack_trace), 0);
 }
 
 static inline void debug_spin_unlock(raw_spinlock_t *lock)
@@ -101,6 +109,7 @@ static inline void debug_spin_unlock(raw_spinlock_t *lock)
 							lock, "wrong CPU");
 	WRITE_ONCE(lock->owner, SPINLOCK_OWNER_INIT);
 	WRITE_ONCE(lock->owner_cpu, -1);
+	WRITE_ONCE(lock->stack_len, 0);
 }
 
 /*
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

