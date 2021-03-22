Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BF93451FC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCVVnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:43:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCVVnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:43:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B585619A3;
        Mon, 22 Mar 2021 21:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616449394;
        bh=qHSD2yK2wbiN+WHRKMw2v1ylAqK2TU+eDvdCF9rCKm8=;
        h=From:To:Cc:Subject:Date:From;
        b=hPtiq9M+0n+d+4Lo2M8zVNrUTuj+obsIM96E5Gd7of5qLfV6wnEftLAmK0888M/cL
         kg6E6FmiqtP61+Pz5ReGRljsx7tstT6M9vgaqNPwypu08qSRZRWSacUhkz/mbiuVp+
         A/3lNNEFkoD6VMk6FvdIx5JprKLla9bwz6Snbz6wagnNXYm2ZPGWLJTNNQh7uZEIhC
         XSNd0vcyQ8Nt7U/exAy8chz5/hbhU/KAIHJp8IKJQSnEzgqrCZ+E50k4VJDJFt878o
         EIiIUEwaXfhKrH7vEStLS9iU7UijFXWjGrpt1c+nLiwzyXrjSTcvcWQwGspGsCXC5e
         xYxhgvITAgmMg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] static_call: fix function type mismatch
Date:   Mon, 22 Mar 2021 22:42:24 +0100
Message-Id: <20210322214309.730556-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The __static_call_return0() function is declared to return a 'long',
while it aliases a couple of functions that all return 'int'. When
building with 'make W=1', gcc warns about this:

kernel/sched/core.c:5420:37: error: cast between incompatible function types from 'long int (*)(void)' to 'int (*)(void)' [-Werror=cast-function-type]
 5420 |   static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);

Change all these function to return 'long' as well, but remove the cast to
ensure we get a warning if any of the types ever change.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: standardize on 'long' return type instead of 'int'.
    still undecided whether to change the return type of
    __cond_resched_{lock,rwlock_read,rwlock_write} as well,
    went with it for consistency rather than necessity.
---
 include/linux/kernel.h |  4 ++--
 include/linux/sched.h  | 14 +++++++-------
 kernel/sched/core.c    |  8 ++++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b7ed6dc99ac..db24f8c9147a 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -82,12 +82,12 @@ struct user;
 
 #ifdef CONFIG_PREEMPT_VOLUNTARY
 
-extern int __cond_resched(void);
+extern long __cond_resched(void);
 # define might_resched() __cond_resched()
 
 #elif defined(CONFIG_PREEMPT_DYNAMIC)
 
-extern int __cond_resched(void);
+extern long __cond_resched(void);
 
 DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ef00bb22164c..b08080d8223c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1875,20 +1875,20 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-extern int __cond_resched(void);
+extern long __cond_resched(void);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
-static __always_inline int _cond_resched(void)
+static __always_inline long _cond_resched(void)
 {
 	return static_call_mod(cond_resched)();
 }
 
 #else
 
-static inline int _cond_resched(void)
+static inline long _cond_resched(void)
 {
 	return __cond_resched();
 }
@@ -1897,7 +1897,7 @@ static inline int _cond_resched(void)
 
 #else
 
-static inline int _cond_resched(void) { return 0; }
+static inline long _cond_resched(void) { return 0; }
 
 #endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
@@ -1906,9 +1906,9 @@ static inline int _cond_resched(void) { return 0; }
 	_cond_resched();			\
 })
 
-extern int __cond_resched_lock(spinlock_t *lock);
-extern int __cond_resched_rwlock_read(rwlock_t *lock);
-extern int __cond_resched_rwlock_write(rwlock_t *lock);
+extern long __cond_resched_lock(spinlock_t *lock);
+extern long __cond_resched_rwlock_read(rwlock_t *lock);
+extern long __cond_resched_rwlock_write(rwlock_t *lock);
 
 #define cond_resched_lock(lock) ({				\
 	___might_sleep(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3a36f0b0742e..04f6ed4ae891 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6979,7 +6979,7 @@ SYSCALL_DEFINE0(sched_yield)
 }
 
 #if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
-int __sched __cond_resched(void)
+long __sched __cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
@@ -7009,7 +7009,7 @@ EXPORT_STATIC_CALL_TRAMP(might_resched);
  * operations here to prevent schedule() from being called twice (once via
  * spin_unlock(), once by hand).
  */
-int __cond_resched_lock(spinlock_t *lock)
+long __cond_resched_lock(spinlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
@@ -7029,7 +7029,7 @@ int __cond_resched_lock(spinlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_lock);
 
-int __cond_resched_rwlock_read(rwlock_t *lock)
+long __cond_resched_rwlock_read(rwlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
@@ -7049,7 +7049,7 @@ int __cond_resched_rwlock_read(rwlock_t *lock)
 }
 EXPORT_SYMBOL(__cond_resched_rwlock_read);
 
-int __cond_resched_rwlock_write(rwlock_t *lock)
+long __cond_resched_rwlock_write(rwlock_t *lock)
 {
 	int resched = should_resched(PREEMPT_LOCK_OFFSET);
 	int ret = 0;
-- 
2.29.2

