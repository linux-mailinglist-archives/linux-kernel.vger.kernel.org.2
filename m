Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0D3ECB1C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 23:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbhHOV2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 17:28:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhHOV2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 17:28:10 -0400
Message-ID: <20210815211302.031014562@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629062859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JXsNkJk7R4N0Lh9k0DBTwr/IDLf9fp3cgQVRCvKLhVg=;
        b=Zv6uIegTIlZ7xilJUeqVpoza3QyJ2epHmPktqGiUSk/THOERKB2CHEXKkdoOKlJGgUWaSC
        /jvZR6HzU5mZcNTnLz5lDGPPlP+HHWbdWI/+QqjjMBI56xHqepkv0c8Ex/9rB/+/XWIvQZ
        FZ+84+ppPKgzOR5vxAwTwFMR13yyhoOBIRKVTTOcBqSXRpYc2FOWoOf85BfyMdMPpeyw0/
        IPGGRcZndBSOzjQ1/Ock+y71bj99jrgSBpKpIyt7I1+z4rrDxtAPdQp5CaV1fYnY4b1JjU
        VOXcp6cPLl1H1qXlQ/sjrTj+JL9faDE2/440GSkE1q4DWv6JakbJqy8ixmXMhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629062859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=JXsNkJk7R4N0Lh9k0DBTwr/IDLf9fp3cgQVRCvKLhVg=;
        b=BaGXB/2FJRR204vIjdCdSHgIZiVWcAtth+4t7qjMAEL4IVX7995FWn/8JLtbM16q5n+H6I
        pONIqZD6BQjPCkCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V5 02/72] locking/rtmutex: Set proper wait context for lockdep
References: <20210815203225.710392609@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Sun, 15 Aug 2021 23:27:38 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RT mutexes belong to the LD_WAIT_SLEEP class. Make them so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 include/linux/rtmutex.h  |   19 ++++++++++++-------
 kernel/locking/rtmutex.c |    2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -52,17 +52,22 @@ do { \
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
-	, .dep_map = { .name = #mutexname }
+#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
+	.dep_map = {					\
+		.name = #mutexname,			\
+		.wait_type_inner = LD_WAIT_SLEEP,	\
+	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
 
-#define __RT_MUTEX_INITIALIZER(mutexname) \
-	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
-	, .waiters = RB_ROOT_CACHED \
-	, .owner = NULL \
-	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)}
+#define __RT_MUTEX_INITIALIZER(mutexname)				\
+{									\
+	.wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock),	\
+	.waiters = RB_ROOT_CACHED,					\
+	.owner = NULL,							\
+	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)			\
+}
 
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1556,7 +1556,7 @@ void __sched __rt_mutex_init(struct rt_m
 		     struct lock_class_key *key)
 {
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
 
 	__rt_mutex_basic_init(lock);
 }

