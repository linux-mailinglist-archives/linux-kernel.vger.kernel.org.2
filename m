Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B717A3776D6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 15:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhEINzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 09:55:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEINzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 09:55:33 -0400
Date:   Sun, 09 May 2021 13:38:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620568469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tO4NrAYjLlpeQ43o3g8lAh+bCtHbdmQXNEcIkLaJf0c=;
        b=Y/F7xkHGlrRXtw1+nnXSGZSdu/LipLuT/GTtXhSZaYIN2ABgr5pjtfP3iIi7ONJd2q5MVT
        6nJIM5XZ7TWabSiBSganSS9LOQtVV1r3oNHaWLUsCuiLdpNvt/CSifsbpvEZMAjlKKeukW
        SsTomBi5ewEHUMBET4F45CywJPfJg3JIqJtPIMgOcGC9GTFjl2SE2zxBY1brQGWF9gIu3K
        pCWqvKYGxFt7PmSN81BS+hULMagys6Z/hW/NTOtcFSCU/PO5giN2E+oL19WMz4I7zBn4IP
        +2L0z7jrfT0ez+aakmLoDmDzBYzsFSpSOUs4kcjnyesdZn7Tmy8hsL709hkXqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620568469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tO4NrAYjLlpeQ43o3g8lAh+bCtHbdmQXNEcIkLaJf0c=;
        b=CVTY+cA/5kFJZYbgjyYM8x/nztiboyQZTG/JI9oBMUTviSbT4eWilnScQN+nULRiTHCfRG
        qnfjBf2MZcv0kIAA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/urgent for v5.13-rc1
Message-ID: <162056748544.14888.14677703647311034371.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2021-05-09

up to:  51cf94d16860: futex: Make syscall entry points less convoluted


A set of locking related fixes and updates:

  - Two fixes for the futex syscall related to the timeout handling.

    FUTEX_LOCK_PI does not support the FUTEX_CLOCK_REALTIME bit and because
    it's not set the time namespace adjustment for clock MONOTONIC is
    applied wrongly.

    FUTEX_WAIT cannot support the FUTEX_CLOCK_REALTIME bit because its
    always a relative timeout.

  - Cleanups in the futex syscall entry points which became obvious when
    the two timeout handling bugs were fixed.

  - Cleanup of queued_write_lock_slowpath() as suggested by Linus

  - Fixup of the smp_call_function_single_async() prototype

Thanks,

	tglx

------------------>
Arnd Bergmann (1):
      smp: Fix smp_call_function_single_async prototype

Thomas Gleixner (4):
      Revert 337f13046ff0 ("futex: Allow FUTEX_CLOCK_REALTIME with FUTEX_WAIT op")
      futex: Do not apply time namespace adjustment on FUTEX_LOCK_PI
      futex: Get rid of the val2 conditional dance
      futex: Make syscall entry points less convoluted

Waiman Long (1):
      locking/qrwlock: Cleanup queued_write_lock_slowpath()


 include/linux/smp.h      |  2 +-
 kernel/futex.c           | 82 +++++++++++++++++++++++-------------------------
 kernel/locking/qrwlock.c |  6 ++--
 kernel/smp.c             | 26 +++++++--------
 kernel/up.c              |  2 +-
 5 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 84a0b4828f66..f0d3ef654207 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,7 +53,7 @@ int smp_call_function_single(int cpuid, smp_call_func_t func, void *info,
 void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
 			   void *info, bool wait, const struct cpumask *mask);
 
-int smp_call_function_single_async(int cpu, call_single_data_t *csd);
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd);
 
 /*
  * Call a function on all processors
diff --git a/kernel/futex.c b/kernel/futex.c
index c98b825da9cf..4938a00bc785 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3710,8 +3710,7 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 
 	if (op & FUTEX_CLOCK_REALTIME) {
 		flags |= FLAGS_CLOCKRT;
-		if (cmd != FUTEX_WAIT && cmd != FUTEX_WAIT_BITSET && \
-		    cmd != FUTEX_WAIT_REQUEUE_PI)
+		if (cmd != FUTEX_WAIT_BITSET &&	cmd != FUTEX_WAIT_REQUEUE_PI)
 			return -ENOSYS;
 	}
 
@@ -3758,42 +3757,52 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	return -ENOSYS;
 }
 
+static __always_inline bool futex_cmd_has_timeout(u32 cmd)
+{
+	switch (cmd) {
+	case FUTEX_WAIT:
+	case FUTEX_LOCK_PI:
+	case FUTEX_WAIT_BITSET:
+	case FUTEX_WAIT_REQUEUE_PI:
+		return true;
+	}
+	return false;
+}
+
+static __always_inline int
+futex_init_timeout(u32 cmd, u32 op, struct timespec64 *ts, ktime_t *t)
+{
+	if (!timespec64_valid(ts))
+		return -EINVAL;
+
+	*t = timespec64_to_ktime(*ts);
+	if (cmd == FUTEX_WAIT)
+		*t = ktime_add_safe(ktime_get(), *t);
+	else if (cmd != FUTEX_LOCK_PI && !(op & FUTEX_CLOCK_REALTIME))
+		*t = timens_ktime_to_host(CLOCK_MONOTONIC, *t);
+	return 0;
+}
 
 SYSCALL_DEFINE6(futex, u32 __user *, uaddr, int, op, u32, val,
 		const struct __kernel_timespec __user *, utime,
 		u32 __user *, uaddr2, u32, val3)
 {
-	struct timespec64 ts;
+	int ret, cmd = op & FUTEX_CMD_MASK;
 	ktime_t t, *tp = NULL;
-	u32 val2 = 0;
-	int cmd = op & FUTEX_CMD_MASK;
+	struct timespec64 ts;
 
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+	if (utime && futex_cmd_has_timeout(cmd)) {
 		if (unlikely(should_fail_futex(!(op & FUTEX_PRIVATE_FLAG))))
 			return -EFAULT;
 		if (get_timespec64(&ts, utime))
 			return -EFAULT;
-		if (!timespec64_valid(&ts))
-			return -EINVAL;
-
-		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		else if (!(op & FUTEX_CLOCK_REALTIME))
-			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
 		tp = &t;
 	}
-	/*
-	 * requeue parameter in 'utime' if cmd == FUTEX_*_REQUEUE_*.
-	 * number of waiters to wake in 'utime' if cmd == FUTEX_WAKE_OP.
-	 */
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (u32) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 
 #ifdef CONFIG_COMPAT
@@ -3959,31 +3968,20 @@ SYSCALL_DEFINE6(futex_time32, u32 __user *, uaddr, int, op, u32, val,
 		const struct old_timespec32 __user *, utime, u32 __user *, uaddr2,
 		u32, val3)
 {
-	struct timespec64 ts;
+	int ret, cmd = op & FUTEX_CMD_MASK;
 	ktime_t t, *tp = NULL;
-	int val2 = 0;
-	int cmd = op & FUTEX_CMD_MASK;
+	struct timespec64 ts;
 
-	if (utime && (cmd == FUTEX_WAIT || cmd == FUTEX_LOCK_PI ||
-		      cmd == FUTEX_WAIT_BITSET ||
-		      cmd == FUTEX_WAIT_REQUEUE_PI)) {
+	if (utime && futex_cmd_has_timeout(cmd)) {
 		if (get_old_timespec32(&ts, utime))
 			return -EFAULT;
-		if (!timespec64_valid(&ts))
-			return -EINVAL;
-
-		t = timespec64_to_ktime(ts);
-		if (cmd == FUTEX_WAIT)
-			t = ktime_add_safe(ktime_get(), t);
-		else if (!(op & FUTEX_CLOCK_REALTIME))
-			t = timens_ktime_to_host(CLOCK_MONOTONIC, t);
+		ret = futex_init_timeout(cmd, op, &ts, &t);
+		if (ret)
+			return ret;
 		tp = &t;
 	}
-	if (cmd == FUTEX_REQUEUE || cmd == FUTEX_CMP_REQUEUE ||
-	    cmd == FUTEX_CMP_REQUEUE_PI || cmd == FUTEX_WAKE_OP)
-		val2 = (int) (unsigned long) utime;
 
-	return do_futex(uaddr, op, val, tp, uaddr2, val2, val3);
+	return do_futex(uaddr, op, val, tp, uaddr2, (unsigned long)utime, val3);
 }
 #endif /* CONFIG_COMPAT_32BIT_TIME */
 
diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index b94f3831e963..ec36b73f4733 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -66,12 +66,12 @@ void queued_write_lock_slowpath(struct qrwlock *lock)
 	arch_spin_lock(&lock->wait_lock);
 
 	/* Try to acquire the lock directly if no reader is present */
-	if (!atomic_read(&lock->cnts) &&
-	    (atomic_cmpxchg_acquire(&lock->cnts, 0, _QW_LOCKED) == 0))
+	if (!(cnts = atomic_read(&lock->cnts)) &&
+	    atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED))
 		goto unlock;
 
 	/* Set the waiting flag to notify readers that a writer is pending */
-	atomic_add(_QW_WAITING, &lock->cnts);
+	atomic_or(_QW_WAITING, &lock->cnts);
 
 	/* When no more readers or writers, set the locked flag */
 	do {
diff --git a/kernel/smp.c b/kernel/smp.c
index e21074900006..52bf159ec400 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -211,7 +211,7 @@ static u64 cfd_seq_inc(unsigned int src, unsigned int dst, unsigned int type)
 	} while (0)
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void __csd_lock_record(call_single_data_t *csd)
+static void __csd_lock_record(struct __call_single_data *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -226,13 +226,13 @@ static void __csd_lock_record(call_single_data_t *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline void csd_lock_record(call_single_data_t *csd)
+static __always_inline void csd_lock_record(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled))
 		__csd_lock_record(csd);
 }
 
-static int csd_lock_wait_getcpu(call_single_data_t *csd)
+static int csd_lock_wait_getcpu(struct __call_single_data *csd)
 {
 	unsigned int csd_type;
 
@@ -282,7 +282,7 @@ static const char *csd_lock_get_type(unsigned int type)
 	return (type >= ARRAY_SIZE(seq_type)) ? "?" : seq_type[type];
 }
 
-static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
+static void csd_lock_print_extended(struct __call_single_data *csd, int cpu)
 {
 	struct cfd_seq_local *seq = &per_cpu(cfd_seq_local, cpu);
 	unsigned int srccpu = csd->node.src;
@@ -321,7 +321,7 @@ static void csd_lock_print_extended(call_single_data_t *csd, int cpu)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -387,7 +387,7 @@ static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, in
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static void __csd_lock_wait(call_single_data_t *csd)
+static void __csd_lock_wait(struct __call_single_data *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -401,7 +401,7 @@ static void __csd_lock_wait(call_single_data_t *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	if (static_branch_unlikely(&csdlock_debug_enabled)) {
 		__csd_lock_wait(csd);
@@ -431,17 +431,17 @@ static void __smp_call_single_queue_debug(int cpu, struct llist_node *node)
 #else
 #define cfd_seq_store(var, src, dst, type)
 
-static void csd_lock_record(call_single_data_t *csd)
+static void csd_lock_record(struct __call_single_data *csd)
 {
 }
 
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static __always_inline void csd_lock_wait(struct __call_single_data *csd)
 {
 	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
 }
 #endif
 
-static __always_inline void csd_lock(call_single_data_t *csd)
+static __always_inline void csd_lock(struct __call_single_data *csd)
 {
 	csd_lock_wait(csd);
 	csd->node.u_flags |= CSD_FLAG_LOCK;
@@ -454,7 +454,7 @@ static __always_inline void csd_lock(call_single_data_t *csd)
 	smp_wmb();
 }
 
-static __always_inline void csd_unlock(call_single_data_t *csd)
+static __always_inline void csd_unlock(struct __call_single_data *csd)
 {
 	WARN_ON(!(csd->node.u_flags & CSD_FLAG_LOCK));
 
@@ -501,7 +501,7 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
  * for execution on the given CPU. data must already have
  * ->func, ->info, and ->flags set.
  */
-static int generic_exec_single(int cpu, call_single_data_t *csd)
+static int generic_exec_single(int cpu, struct __call_single_data *csd)
 {
 	if (cpu == smp_processor_id()) {
 		smp_call_func_t func = csd->func;
@@ -784,7 +784,7 @@ EXPORT_SYMBOL(smp_call_function_single);
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
  */
-int smp_call_function_single_async(int cpu, call_single_data_t *csd)
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
 	int err = 0;
 
diff --git a/kernel/up.c b/kernel/up.c
index bf20b4a9af60..c7321307923a 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -25,7 +25,7 @@ int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
 }
 EXPORT_SYMBOL(smp_call_function_single);
 
-int smp_call_function_single_async(int cpu, call_single_data_t *csd)
+int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
 	unsigned long flags;
 

