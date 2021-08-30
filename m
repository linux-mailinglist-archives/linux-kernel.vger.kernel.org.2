Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C65B53FB401
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236377AbhH3Kpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:45:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50972 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236379AbhH3Kpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:39 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jlUo8uk8NolkS2RzxmEDuH1l9SUeqQJYqMEB/N4ndps=;
        b=o11KCL5U4QnSRULRNfUT9t43vVjE2C81bXYK6/An7ZXtp6XkHvJ4IDjFF7Ve7LOfdwQEz1
        Y6z9x2d8bVE9fAUPXwVdH9NSGIwityDYPOOvDHHtX7ESa8Y+F3t5uji8vthw+GTN6KjxnK
        dH2sg4S7l4hgYVbhu1GW28mfgguZ5J24s21lL5yvFsdfiaWXwmnBnNPjbpKQtEIK+MGmal
        TCV5qThvVQrWd7YBnmU+8J8v3EgaV8ZzKQqncyizRtZvly3ZDYO0L5r4MHbt64fKkttw8l
        M+ScumPNfhRNmz5HKpXCp4wQiaAg41V5+cgUgrCz/R/EdP0vcSPhULSF0RUJtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=jlUo8uk8NolkS2RzxmEDuH1l9SUeqQJYqMEB/N4ndps=;
        b=B84YDX3a6A4vxl6ghc/7luQrC4EEDUsR32eGjm6o8nimnDNAkWIVnKghzx1kRUEFW6BZV7
        uC2BKtfSta/mvJAg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/core for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993374.58256.622407503518554022.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:44 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest locking/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-202=
1-08-30

up to:  a055fcc132d4: locking/rtmutex: Return success on deadlock for ww_mute=
x waiters


Updates for locking and atomics:

The regular pile:

  - A few improvements to the mutex code

  - Documentation updates for atomics to clarify the difference between
    cmpxchg() and try_cmpxchg() and to explain the forward progress
    expectations.

  - Simplification of the atomics fallback generator

  - The addition of arch_atomic_long*() variants and generic arch_*()
    bitops based on them.

  - Add the missing might_sleep() invocations to the down*() operations of
    semaphores.

The PREEMPT_RT locking core:

  - Scheduler updates to support the state preserving mechanism for
    'sleeping' spin- and rwlocks on RT. This mechanism is carefully
    preserving the state of the task when blocking on a 'sleeping' spin- or
    rwlock and takes regular wake-ups targeted at the same task into
    account. The preserved or updated (via a regular wakeup) state is
    restored when the lock has been acquired.

  - Restructuring of the rtmutex code so it can be utilized and extended
    for the RT specific lock variants.

  - Restructuring of the ww_mutex code to allow sharing of the ww_mutex
    specific functionality for rtmutex based ww_mutexes.

  - Header file disentangling to allow substitution of the regular lock
    implementations with the PREEMPT_RT variants without creating an
    unmaintainable #ifdef mess.

  - Shared base code for the PREEMPT_RT specific rw_semaphore and rwlock
    implementations. Contrary to the regular rw_semaphores and rwlocks the
    PREEMPT_RT implementation is writer unfair because it is infeasible to
    do priority inheritance on multiple readers. Experience over the years
    has shown that real-time workloads are not the typical workloads which
    are sensitive to writer starvation. The alternative solution would be
    to allow only a single reader which has been tried and discarded as it
    is a major bottleneck especially for mmap_sem. Aside of that many of
    the writer starvation critical usage sites have been converted to a
    writer side mutex/spinlock and RCU read side protections in the past
    decade so that the issue is less prominent than it used to be.

  - The actual rtmutex based lock substitutions for PREEMPT_RT enabled
    kernels which affect mutex, ww_mutex, rw_semaphore, spinlock_t and
    rwlock_t. The spin/rw_lock*() functions disable migration across the
    critical section to preserve the existing semantics vs. per CPU
    variables.

  - Rework of the futex REQUEUE_PI mechanism to handle the case of early
    wake-ups which interleave with a re-queue operation to prevent the
    situation that a task would be blocked on both the rtmutex associated
    to the outer futex and the rtmutex based hash bucket spinlock.

    While this situation cannot happen on !RT enabled kernels the changes
    make the underlying concurrency problems easier to understand in
    general. As a result the difference between !RT and RT kernels is
    reduced to the handling of waiting for the critical section. !RT
    kernels simply spin-wait as before and RT kernels utilize rcu_wait().

  - The substitution of local_lock for PREEMPT_RT with a spinlock which
    protects the critical section while staying preemptible. The CPU
    locality is established by disabling migration.

  The underlying concepts of this code have been in use in PREEMPT_RT for
  way more than a decade. The code has been refactored several times over
  the years and this final incarnation has been optimized once again to be
  as non-intrusive as possible, i.e. the RT specific parts are mostly
  isolated.

  It has been extensively tested in the 5.14-rt patch series and it has
  been verified that !RT kernels are not affected by these changes.

Thanks,

	tglx

------------------>
Gregory Haskins (1):
      locking/rtmutex: Implement equal priority lock stealing

Mark Rutland (6):
      locking/atomic: simplify ifdef generation
      locking/atomic: remove ARCH_ATOMIC remanants
      locking/atomic: centralize generated headers
      locking/atomic: add arch_atomic_long*()
      locking/atomic: add generic arch_*() bitops
      locking/atomic: simplify non-atomic wrappers

Peter Zijlstra (25):
      locking/mutex: Use try_cmpxchg()
      locking/mutex: Fix HANDOFF condition
      locking/mutex: Introduce __mutex_trylock_or_handoff()
      locking/mutex: Add MUTEX_WARN_ON
      Documentation/atomic_t: Document cmpxchg() vs try_cmpxchg()
      Documentation/atomic_t: Document forward progress expectations
      media/atomisp: Use lockdep instead of *mutex_is_locked()
      locking/rtmutex: Remove rt_mutex_is_locked()
      locking/rtmutex: Split out the inner parts of 'struct rtmutex'
      locking/rtmutex: Squash !RT tasks to DEFAULT_PRIO
      locking/ww_mutex: Simplify lockdep annotations
      locking/ww_mutex: Gather mutex_waiter initialization
      locking/ww_mutex: Remove the __sched annotation from ww_mutex APIs
      locking/ww_mutex: Abstract out the waiter iteration
      locking/ww_mutex: Abstract out waiter enqueueing
      locking/ww_mutex: Abstract out mutex accessors
      locking/ww_mutex: Abstract out mutex types
      locking/ww_mutex: Implement rt_mutex accessors
      locking/ww_mutex: Add RT priority to W/W order
      locking/ww_mutex: Add rt_mutex based lock type and accessors
      locking/rtmutex: Extend the rtmutex core to support ww_mutex
      locking/ww_mutex: Implement rtmutex based ww_mutex API functions
      static_call: Update API documentation
      locking/rtmutex: Prevent spurious EDEADLK return caused by ww_mutexes
      locking/rtmutex: Return success on deadlock for ww_mutex waiters

Peter Zijlstra (Intel) (2):
      locking/ww_mutex: Split up ww_mutex_unlock()
      locking/ww_mutex: Split out the W/W implementation logic into kernel/lo=
cking/ww_mutex.h

Sebastian Andrzej Siewior (7):
      locking/rtmutex: Convert macros to inlines
      locking/rtmutex: Prevent future include recursion hell
      locking/lockdep: Reduce header dependencies in <linux/debug_locks.h>
      rbtree: Split out the rbtree type definitions into <linux/rbtree_types.=
h>
      locking/rtmutex: Reduce <linux/rtmutex.h> header dependencies, only inc=
lude <linux/rbtree_types.h>
      lib/test_lockup: Adapt to changed variables
      locking/ww_mutex: Initialize waiter.ww_ctx properly

Steven Rostedt (1):
      locking/rtmutex: Add adaptive spinwait mechanism

Thomas Gleixner (48):
      locking/local_lock: Add missing owner initialization
      locking/rtmutex: Set proper wait context for lockdep
      sched/wakeup: Split out the wakeup ->__state check
      sched/wakeup: Introduce the TASK_RTLOCK_WAIT state bit
      sched/wakeup: Reorganize the current::__state helpers
      sched/wakeup: Prepare for RT sleeping spin/rwlocks
      sched/core: Rework the __schedule() preempt argument
      sched/core: Provide a scheduling point for RT locks
      sched/wake_q: Provide WAKE_Q_HEAD_INITIALIZER()
      locking/rtmutex: Switch to from cmpxchg_*() to try_cmpxchg_*()
      locking/rtmutex: Split API from implementation
      locking/rtmutex: Provide rt_mutex_slowlock_locked()
      locking/rtmutex: Provide rt_mutex_base_is_locked()
      locking/rt: Add base code for RT rw_semaphore and rwlock
      locking/rwsem: Add rtmutex based R/W semaphore implementation
      locking/rtmutex: Add wake_state to rt_mutex_waiter
      locking/rtmutex: Provide rt_wake_q_head and helpers
      locking/rtmutex: Use rt_mutex_wake_q_head
      locking/rtmutex: Prepare RT rt_mutex_wake_q for RT locks
      locking/rtmutex: Guard regular sleeping locks specific functions
      locking/spinlock: Split the lock types header, and move the raw types i=
nto <linux/spinlock_types_raw.h>
      locking/spinlock: Provide RT specific spinlock_t
      locking/spinlock: Provide RT variant header: <linux/spinlock_rt.h>
      locking/rtmutex: Provide the spin/rwlock core lock function
      locking/spinlock: Provide RT variant
      locking/rwlock: Provide RT variant
      locking/mutex: Consolidate core headers, remove kernel/locking/mutex-de=
bug.h
      locking/mutex: Move the 'struct mutex_waiter' definition from <linux/mu=
tex.h> to the internal header
      locking/ww_mutex: Move the ww_mutex definitions from <linux/mutex.h> in=
to <linux/ww_mutex.h>
      locking/mutex: Make mutex::wait_lock raw
      locking/ww_mutex: Abstract out internal lock accesses
      locking/rtmutex: Add mutex variant for RT
      futex: Validate waiter correctly in futex_proxy_trylock_atomic()
      futex: Clean up stale comments
      futex: Clarify futex_requeue() PI handling
      futex: Remove bogus condition for requeue PI
      futex: Correct the number of requeued waiters for PI
      futex: Restructure futex_requeue()
      futex: Clarify comment in futex_requeue()
      futex: Reorder sanity checks in futex_requeue()
      futex: Simplify handle_early_requeue_pi_wakeup()
      futex: Prevent requeue_pi() lock nesting issue on RT
      locking/rtmutex: Prevent lockdep false positive with PI futexes
      preempt: Adjust PREEMPT_LOCK_OFFSET for RT
      locking/spinlock/rt: Prepare for RT local_lock
      locking/local_lock: Add PREEMPT_RT support
      locking/rtmutex: Dont dereference waiter lockless
      locking/rtmutex: Dequeue waiter on ww_mutex deadlock

Xiaoming Ni (1):
      locking/semaphore: Add might_sleep() to down_*() family

xuyehan (1):
      locking/rwsem: Remove an unused parameter of rwsem_wake()


 Documentation/atomic_t.txt                         |   94 ++
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |    4 +-
 include/asm-generic/atomic-long.h                  | 1014 -----------------
 include/asm-generic/bitops/atomic.h                |   32 +-
 include/asm-generic/bitops/lock.h                  |   39 +-
 include/asm-generic/bitops/non-atomic.h            |   39 +-
 include/linux/atomic.h                             |    7 +-
 include/linux/{ =3D> atomic}/atomic-arch-fallback.h  |    0
 .../atomic}/atomic-instrumented.h                  |  586 +++++++++-
 include/linux/atomic/atomic-long.h                 | 1014 +++++++++++++++++
 include/linux/debug_locks.h                        |    3 +-
 include/linux/local_lock_internal.h                |   86 +-
 include/linux/mutex.h                              |   92 +-
 include/linux/preempt.h                            |    4 +
 include/linux/rbtree.h                             |   31 +-
 include/linux/rbtree_types.h                       |   34 +
 include/linux/rtmutex.h                            |   63 +-
 include/linux/rwbase_rt.h                          |   39 +
 include/linux/rwlock_rt.h                          |  140 +++
 include/linux/rwlock_types.h                       |   53 +-
 include/linux/rwsem.h                              |   78 +-
 include/linux/sched.h                              |  119 +-
 include/linux/sched/wake_q.h                       |    7 +-
 include/linux/spinlock.h                           |   15 +-
 include/linux/spinlock_api_smp.h                   |    3 +
 include/linux/spinlock_rt.h                        |  159 +++
 include/linux/spinlock_types.h                     |   89 +-
 include/linux/spinlock_types_raw.h                 |   73 ++
 include/linux/static_call.h                        |   33 +
 include/linux/ww_mutex.h                           |   50 +-
 kernel/Kconfig.locks                               |    2 +-
 kernel/futex.c                                     |  556 ++++++---
 kernel/locking/Makefile                            |    3 +-
 kernel/locking/mutex-debug.c                       |    5 +-
 kernel/locking/mutex-debug.h                       |   29 -
 kernel/locking/mutex.c                             |  541 ++-------
 kernel/locking/mutex.h                             |   48 +-
 kernel/locking/rtmutex.c                           | 1192 +++++++++---------=
--
 kernel/locking/rtmutex_api.c                       |  590 ++++++++++
 kernel/locking/rtmutex_common.h                    |  135 ++-
 kernel/locking/rwbase_rt.c                         |  263 +++++
 kernel/locking/rwsem.c                             |  115 +-
 kernel/locking/semaphore.c                         |    4 +
 kernel/locking/spinlock.c                          |    7 +
 kernel/locking/spinlock_debug.c                    |    5 +
 kernel/locking/spinlock_rt.c                       |  263 +++++
 kernel/locking/ww_mutex.h                          |  569 ++++++++++
 kernel/locking/ww_rt_mutex.c                       |   76 ++
 kernel/rcu/tree_plugin.h                           |    6 +-
 kernel/sched/core.c                                |  109 +-
 lib/Kconfig.debug                                  |   11 +-
 lib/test_lockup.c                                  |    8 +-
 scripts/atomic/check-atomics.sh                    |    6 +-
 scripts/atomic/fallbacks/acquire                   |    4 +-
 scripts/atomic/fallbacks/add_negative              |    6 +-
 scripts/atomic/fallbacks/add_unless                |    6 +-
 scripts/atomic/fallbacks/andnot                    |    4 +-
 scripts/atomic/fallbacks/dec                       |    4 +-
 scripts/atomic/fallbacks/dec_and_test              |    6 +-
 scripts/atomic/fallbacks/dec_if_positive           |    6 +-
 scripts/atomic/fallbacks/dec_unless_positive       |    6 +-
 scripts/atomic/fallbacks/fence                     |    4 +-
 scripts/atomic/fallbacks/fetch_add_unless          |    8 +-
 scripts/atomic/fallbacks/inc                       |    4 +-
 scripts/atomic/fallbacks/inc_and_test              |    6 +-
 scripts/atomic/fallbacks/inc_not_zero              |    6 +-
 scripts/atomic/fallbacks/inc_unless_negative       |    6 +-
 scripts/atomic/fallbacks/read_acquire              |    2 +-
 scripts/atomic/fallbacks/release                   |    4 +-
 scripts/atomic/fallbacks/set_release               |    2 +-
 scripts/atomic/fallbacks/sub_and_test              |    6 +-
 scripts/atomic/fallbacks/try_cmpxchg               |    4 +-
 scripts/atomic/gen-atomic-fallback.sh              |   68 +-
 scripts/atomic/gen-atomic-instrumented.sh          |   11 +-
 scripts/atomic/gen-atomic-long.sh                  |   10 +-
 scripts/atomic/gen-atomics.sh                      |    6 +-
 76 files changed, 5941 insertions(+), 2791 deletions(-)
 delete mode 100644 include/asm-generic/atomic-long.h
 rename include/linux/{ =3D> atomic}/atomic-arch-fallback.h (100%)
 rename include/{asm-generic =3D> linux/atomic}/atomic-instrumented.h (68%)
 create mode 100644 include/linux/atomic/atomic-long.h
 create mode 100644 include/linux/rbtree_types.h
 create mode 100644 include/linux/rwbase_rt.h
 create mode 100644 include/linux/rwlock_rt.h
 create mode 100644 include/linux/spinlock_rt.h
 create mode 100644 include/linux/spinlock_types_raw.h
 delete mode 100644 kernel/locking/mutex-debug.h
 create mode 100644 kernel/locking/rtmutex_api.c
 create mode 100644 kernel/locking/rwbase_rt.c
 create mode 100644 kernel/locking/spinlock_rt.c
 create mode 100644 kernel/locking/ww_mutex.h
 create mode 100644 kernel/locking/ww_rt_mutex.c

diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
index 0f1fdedf36bb..0f1ffa03db09 100644
--- a/Documentation/atomic_t.txt
+++ b/Documentation/atomic_t.txt
@@ -271,3 +271,97 @@ WRITE_ONCE.  Thus:
 			SC *y, t;
=20
 is allowed.
+
+
+CMPXCHG vs TRY_CMPXCHG
+----------------------
+
+  int atomic_cmpxchg(atomic_t *ptr, int old, int new);
+  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new);
+
+Both provide the same functionality, but try_cmpxchg() can lead to more
+compact code. The functions relate like:
+
+  bool atomic_try_cmpxchg(atomic_t *ptr, int *oldp, int new)
+  {
+    int ret, old =3D *oldp;
+    ret =3D atomic_cmpxchg(ptr, old, new);
+    if (ret !=3D old)
+      *oldp =3D ret;
+    return ret =3D=3D old;
+  }
+
+and:
+
+  int atomic_cmpxchg(atomic_t *ptr, int old, int new)
+  {
+    (void)atomic_try_cmpxchg(ptr, &old, new);
+    return old;
+  }
+
+Usage:
+
+  old =3D atomic_read(&v);			old =3D atomic_read(&v);
+  for (;;) {					do {
+    new =3D func(old);				  new =3D func(old);
+    tmp =3D atomic_cmpxchg(&v, old, new);		} while (!atomic_try_cmpxchg(&v, =
&old, new));
+    if (tmp =3D=3D old)
+      break;
+    old =3D tmp;
+  }
+
+NB. try_cmpxchg() also generates better code on some platforms (notably x86)
+where the function more closely matches the hardware instruction.
+
+
+FORWARD PROGRESS
+----------------
+
+In general strong forward progress is expected of all unconditional atomic
+operations -- those in the Arithmetic and Bitwise classes and xchg(). However
+a fair amount of code also requires forward progress from the conditional
+atomic operations.
+
+Specifically 'simple' cmpxchg() loops are expected to not starve one another
+indefinitely. However, this is not evident on LL/SC architectures, because
+while an LL/SC architecure 'can/should/must' provide forward progress
+guarantees between competing LL/SC sections, such a guarantee does not
+transfer to cmpxchg() implemented using LL/SC. Consider:
+
+  old =3D atomic_read(&v);
+  do {
+    new =3D func(old);
+  } while (!atomic_try_cmpxchg(&v, &old, new));
+
+which on LL/SC becomes something like:
+
+  old =3D atomic_read(&v);
+  do {
+    new =3D func(old);
+  } while (!({
+    volatile asm ("1: LL  %[oldval], %[v]\n"
+                  "   CMP %[oldval], %[old]\n"
+                  "   BNE 2f\n"
+                  "   SC  %[new], %[v]\n"
+                  "   BNE 1b\n"
+                  "2:\n"
+                  : [oldval] "=3D&r" (oldval), [v] "m" (v)
+		  : [old] "r" (old), [new] "r" (new)
+                  : "memory");
+    success =3D (oldval =3D=3D old);
+    if (!success)
+      old =3D oldval;
+    success; }));
+
+However, even the forward branch from the failed compare can cause the LL/SC
+to fail on some architectures, let alone whatever the compiler makes of the C
+loop body. As a result there is no guarantee what so ever the cacheline
+containing @v will stay on the local CPU and progress is made.
+
+Even native CAS architectures can fail to provide forward progress for their
+primitive (See Sparc64 for an example).
+
+Such implementations are strongly encouraged to add exponential backoff loops
+to a failed CAS in order to ensure some progress. Affected architectures are
+also strongly encouraged to inspect/audit the atomic fallbacks, refcount_t a=
nd
+their locking primitives.
diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/stag=
ing/media/atomisp/pci/atomisp_ioctl.c
index 6f5fe5092154..c8a625667e81 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1904,8 +1904,8 @@ int __atomisp_streamoff(struct file *file, void *fh, en=
um v4l2_buf_type type)
 	dev_dbg(isp->dev, "Stop stream on pad %d for asd%d\n",
 		atomisp_subdev_source_pad(vdev), asd->index);
=20
-	BUG_ON(!rt_mutex_is_locked(&isp->mutex));
-	BUG_ON(!mutex_is_locked(&isp->streamoff_mutex));
+	lockdep_assert_held(&isp->mutex);
+	lockdep_assert_held(&isp->streamoff_mutex);
=20
 	if (type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE) {
 		dev_dbg(isp->dev, "unsupported v4l2 buf type\n");
diff --git a/include/asm-generic/atomic-long.h b/include/asm-generic/atomic-l=
ong.h
deleted file mode 100644
index 073cf40f431b..000000000000
--- a/include/asm-generic/atomic-long.h
+++ /dev/null
@@ -1,1014 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-// Generated by scripts/atomic/gen-atomic-long.sh
-// DO NOT MODIFY THIS FILE DIRECTLY
-
-#ifndef _ASM_GENERIC_ATOMIC_LONG_H
-#define _ASM_GENERIC_ATOMIC_LONG_H
-
-#include <linux/compiler.h>
-#include <asm/types.h>
-
-#ifdef CONFIG_64BIT
-typedef atomic64_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
-#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
-#else
-typedef atomic_t atomic_long_t;
-#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
-#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
-#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
-#endif
-
-#ifdef CONFIG_64BIT
-
-static __always_inline long
-atomic_long_read(const atomic_long_t *v)
-{
-	return atomic64_read(v);
-}
-
-static __always_inline long
-atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return atomic64_read_acquire(v);
-}
-
-static __always_inline void
-atomic_long_set(atomic_long_t *v, long i)
-{
-	atomic64_set(v, i);
-}
-
-static __always_inline void
-atomic_long_set_release(atomic_long_t *v, long i)
-{
-	atomic64_set_release(v, i);
-}
-
-static __always_inline void
-atomic_long_add(long i, atomic_long_t *v)
-{
-	atomic64_add(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return atomic64_add_return(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_add_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return atomic64_add_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_sub(long i, atomic_long_t *v)
-{
-	atomic64_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_inc(atomic_long_t *v)
-{
-	atomic64_inc(v);
-}
-
-static __always_inline long
-atomic_long_inc_return(atomic_long_t *v)
-{
-	return atomic64_inc_return(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return atomic64_inc_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return atomic64_inc_return_release(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return atomic64_inc_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return atomic64_fetch_inc(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return atomic64_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return atomic64_fetch_inc_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return atomic64_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_dec(atomic_long_t *v)
-{
-	atomic64_dec(v);
-}
-
-static __always_inline long
-atomic_long_dec_return(atomic_long_t *v)
-{
-	return atomic64_dec_return(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return atomic64_dec_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return atomic64_dec_return_release(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return atomic64_dec_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return atomic64_fetch_dec(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return atomic64_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return atomic64_fetch_dec_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return atomic64_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_and(long i, atomic_long_t *v)
-{
-	atomic64_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_andnot(long i, atomic_long_t *v)
-{
-	atomic64_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_or(long i, atomic_long_t *v)
-{
-	atomic64_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_xor(long i, atomic_long_t *v)
-{
-	atomic64_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return atomic64_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return atomic64_xchg(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return atomic64_xchg_acquire(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return atomic64_xchg_release(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return atomic64_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return atomic64_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg_release(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
-}
-
-static __always_inline bool
-atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return atomic64_sub_and_test(i, v);
-}
-
-static __always_inline bool
-atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return atomic64_dec_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return atomic64_inc_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return atomic64_add_negative(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic64_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic64_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return atomic64_inc_not_zero(v);
-}
-
-static __always_inline bool
-atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return atomic64_inc_unless_negative(v);
-}
-
-static __always_inline bool
-atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return atomic64_dec_unless_positive(v);
-}
-
-static __always_inline long
-atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return atomic64_dec_if_positive(v);
-}
-
-#else /* CONFIG_64BIT */
-
-static __always_inline long
-atomic_long_read(const atomic_long_t *v)
-{
-	return atomic_read(v);
-}
-
-static __always_inline long
-atomic_long_read_acquire(const atomic_long_t *v)
-{
-	return atomic_read_acquire(v);
-}
-
-static __always_inline void
-atomic_long_set(atomic_long_t *v, long i)
-{
-	atomic_set(v, i);
-}
-
-static __always_inline void
-atomic_long_set_release(atomic_long_t *v, long i)
-{
-	atomic_set_release(v, i);
-}
-
-static __always_inline void
-atomic_long_add(long i, atomic_long_t *v)
-{
-	atomic_add(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return(long i, atomic_long_t *v)
-{
-	return atomic_add_return(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic_add_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_release(long i, atomic_long_t *v)
-{
-	return atomic_add_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_add_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_add_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_add_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_sub(long i, atomic_long_t *v)
-{
-	atomic_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return(long i, atomic_long_t *v)
-{
-	return atomic_sub_return(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_acquire(long i, atomic_long_t *v)
-{
-	return atomic_sub_return_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_release(long i, atomic_long_t *v)
-{
-	return atomic_sub_return_release(i, v);
-}
-
-static __always_inline long
-atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_sub_return_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_sub_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_inc(atomic_long_t *v)
-{
-	atomic_inc(v);
-}
-
-static __always_inline long
-atomic_long_inc_return(atomic_long_t *v)
-{
-	return atomic_inc_return(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_acquire(atomic_long_t *v)
-{
-	return atomic_inc_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_release(atomic_long_t *v)
-{
-	return atomic_inc_return_release(v);
-}
-
-static __always_inline long
-atomic_long_inc_return_relaxed(atomic_long_t *v)
-{
-	return atomic_inc_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc(atomic_long_t *v)
-{
-	return atomic_fetch_inc(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_acquire(atomic_long_t *v)
-{
-	return atomic_fetch_inc_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_release(atomic_long_t *v)
-{
-	return atomic_fetch_inc_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_inc_relaxed(atomic_long_t *v)
-{
-	return atomic_fetch_inc_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_dec(atomic_long_t *v)
-{
-	atomic_dec(v);
-}
-
-static __always_inline long
-atomic_long_dec_return(atomic_long_t *v)
-{
-	return atomic_dec_return(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_acquire(atomic_long_t *v)
-{
-	return atomic_dec_return_acquire(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_release(atomic_long_t *v)
-{
-	return atomic_dec_return_release(v);
-}
-
-static __always_inline long
-atomic_long_dec_return_relaxed(atomic_long_t *v)
-{
-	return atomic_dec_return_relaxed(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec(atomic_long_t *v)
-{
-	return atomic_fetch_dec(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_acquire(atomic_long_t *v)
-{
-	return atomic_fetch_dec_acquire(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_release(atomic_long_t *v)
-{
-	return atomic_fetch_dec_release(v);
-}
-
-static __always_inline long
-atomic_long_fetch_dec_relaxed(atomic_long_t *v)
-{
-	return atomic_fetch_dec_relaxed(v);
-}
-
-static __always_inline void
-atomic_long_and(long i, atomic_long_t *v)
-{
-	atomic_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_and_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_andnot(long i, atomic_long_t *v)
-{
-	atomic_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_andnot_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_or(long i, atomic_long_t *v)
-{
-	atomic_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_or_relaxed(i, v);
-}
-
-static __always_inline void
-atomic_long_xor(long i, atomic_long_t *v)
-{
-	atomic_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor_acquire(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_release(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor_release(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
-{
-	return atomic_fetch_xor_relaxed(i, v);
-}
-
-static __always_inline long
-atomic_long_xchg(atomic_long_t *v, long i)
-{
-	return atomic_xchg(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_acquire(atomic_long_t *v, long i)
-{
-	return atomic_xchg_acquire(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_release(atomic_long_t *v, long i)
-{
-	return atomic_xchg_release(v, i);
-}
-
-static __always_inline long
-atomic_long_xchg_relaxed(atomic_long_t *v, long i)
-{
-	return atomic_xchg_relaxed(v, i);
-}
-
-static __always_inline long
-atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg_acquire(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg_release(v, old, new);
-}
-
-static __always_inline long
-atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
-{
-	return atomic_cmpxchg_relaxed(v, old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg_acquire(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg_release(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
-{
-	return atomic_try_cmpxchg_relaxed(v, (int *)old, new);
-}
-
-static __always_inline bool
-atomic_long_sub_and_test(long i, atomic_long_t *v)
-{
-	return atomic_sub_and_test(i, v);
-}
-
-static __always_inline bool
-atomic_long_dec_and_test(atomic_long_t *v)
-{
-	return atomic_dec_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_inc_and_test(atomic_long_t *v)
-{
-	return atomic_inc_and_test(v);
-}
-
-static __always_inline bool
-atomic_long_add_negative(long i, atomic_long_t *v)
-{
-	return atomic_add_negative(i, v);
-}
-
-static __always_inline long
-atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic_fetch_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_add_unless(atomic_long_t *v, long a, long u)
-{
-	return atomic_add_unless(v, a, u);
-}
-
-static __always_inline bool
-atomic_long_inc_not_zero(atomic_long_t *v)
-{
-	return atomic_inc_not_zero(v);
-}
-
-static __always_inline bool
-atomic_long_inc_unless_negative(atomic_long_t *v)
-{
-	return atomic_inc_unless_negative(v);
-}
-
-static __always_inline bool
-atomic_long_dec_unless_positive(atomic_long_t *v)
-{
-	return atomic_dec_unless_positive(v);
-}
-
-static __always_inline long
-atomic_long_dec_if_positive(atomic_long_t *v)
-{
-	return atomic_dec_if_positive(v);
-}
-
-#endif /* CONFIG_64BIT */
-#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
-// a624200981f552b2c6be4f32fe44da8289f30d87
diff --git a/include/asm-generic/bitops/atomic.h b/include/asm-generic/bitops=
/atomic.h
index 0e7316a86240..3096f086b5a3 100644
--- a/include/asm-generic/bitops/atomic.h
+++ b/include/asm-generic/bitops/atomic.h
@@ -11,25 +11,29 @@
  * See Documentation/atomic_bitops.txt for details.
  */
=20
-static __always_inline void set_bit(unsigned int nr, volatile unsigned long =
*p)
+static __always_inline void
+arch_set_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p +=3D BIT_WORD(nr);
-	atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_or(BIT_MASK(nr), (atomic_long_t *)p);
 }
=20
-static __always_inline void clear_bit(unsigned int nr, volatile unsigned lon=
g *p)
+static __always_inline void
+arch_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p +=3D BIT_WORD(nr);
-	atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_andnot(BIT_MASK(nr), (atomic_long_t *)p);
 }
=20
-static __always_inline void change_bit(unsigned int nr, volatile unsigned lo=
ng *p)
+static __always_inline void
+arch_change_bit(unsigned int nr, volatile unsigned long *p)
 {
 	p +=3D BIT_WORD(nr);
-	atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_xor(BIT_MASK(nr), (atomic_long_t *)p);
 }
=20
-static inline int test_and_set_bit(unsigned int nr, volatile unsigned long *=
p)
+static __always_inline int
+arch_test_and_set_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask =3D BIT_MASK(nr);
@@ -38,11 +42,12 @@ static inline int test_and_set_bit(unsigned int nr, volat=
ile unsigned long *p)
 	if (READ_ONCE(*p) & mask)
 		return 1;
=20
-	old =3D atomic_long_fetch_or(mask, (atomic_long_t *)p);
+	old =3D arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
=20
-static inline int test_and_clear_bit(unsigned int nr, volatile unsigned long=
 *p)
+static __always_inline int
+arch_test_and_clear_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask =3D BIT_MASK(nr);
@@ -51,18 +56,21 @@ static inline int test_and_clear_bit(unsigned int nr, vol=
atile unsigned long *p)
 	if (!(READ_ONCE(*p) & mask))
 		return 0;
=20
-	old =3D atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
+	old =3D arch_atomic_long_fetch_andnot(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
=20
-static inline int test_and_change_bit(unsigned int nr, volatile unsigned lon=
g *p)
+static __always_inline int
+arch_test_and_change_bit(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask =3D BIT_MASK(nr);
=20
 	p +=3D BIT_WORD(nr);
-	old =3D atomic_long_fetch_xor(mask, (atomic_long_t *)p);
+	old =3D arch_atomic_long_fetch_xor(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
=20
+#include <asm-generic/bitops/instrumented-atomic.h>
+
 #endif /* _ASM_GENERIC_BITOPS_ATOMIC_H */
diff --git a/include/asm-generic/bitops/lock.h b/include/asm-generic/bitops/l=
ock.h
index 3ae021368f48..630f2f6b9595 100644
--- a/include/asm-generic/bitops/lock.h
+++ b/include/asm-generic/bitops/lock.h
@@ -7,7 +7,7 @@
 #include <asm/barrier.h>
=20
 /**
- * test_and_set_bit_lock - Set a bit and return its old value, for lock
+ * arch_test_and_set_bit_lock - Set a bit and return its old value, for lock
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -15,8 +15,8 @@
  * the returned value is 0.
  * It can be used to implement bit locks.
  */
-static inline int test_and_set_bit_lock(unsigned int nr,
-					volatile unsigned long *p)
+static __always_inline int
+arch_test_and_set_bit_lock(unsigned int nr, volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask =3D BIT_MASK(nr);
@@ -25,26 +25,27 @@ static inline int test_and_set_bit_lock(unsigned int nr,
 	if (READ_ONCE(*p) & mask)
 		return 1;
=20
-	old =3D atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
+	old =3D arch_atomic_long_fetch_or_acquire(mask, (atomic_long_t *)p);
 	return !!(old & mask);
 }
=20
=20
 /**
- * clear_bit_unlock - Clear a bit in memory, for unlock
+ * arch_clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
  * This operation is atomic and provides release barrier semantics.
  */
-static inline void clear_bit_unlock(unsigned int nr, volatile unsigned long =
*p)
+static __always_inline void
+arch_clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 {
 	p +=3D BIT_WORD(nr);
-	atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
+	arch_atomic_long_fetch_andnot_release(BIT_MASK(nr), (atomic_long_t *)p);
 }
=20
 /**
- * __clear_bit_unlock - Clear a bit in memory, for unlock
+ * arch___clear_bit_unlock - Clear a bit in memory, for unlock
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -54,38 +55,40 @@ static inline void clear_bit_unlock(unsigned int nr, vola=
tile unsigned long *p)
  *
  * See for example x86's implementation.
  */
-static inline void __clear_bit_unlock(unsigned int nr,
-				      volatile unsigned long *p)
+static inline void
+arch___clear_bit_unlock(unsigned int nr, volatile unsigned long *p)
 {
 	unsigned long old;
=20
 	p +=3D BIT_WORD(nr);
 	old =3D READ_ONCE(*p);
 	old &=3D ~BIT_MASK(nr);
-	atomic_long_set_release((atomic_long_t *)p, old);
+	arch_atomic_long_set_release((atomic_long_t *)p, old);
 }
=20
 /**
- * clear_bit_unlock_is_negative_byte - Clear a bit in memory and test if bot=
tom
- *                                     byte is negative, for unlock.
+ * arch_clear_bit_unlock_is_negative_byte - Clear a bit in memory and test i=
f bottom
+ *                                          byte is negative, for unlock.
  * @nr: the bit to clear
  * @addr: the address to start counting from
  *
  * This is a bit of a one-trick-pony for the filemap code, which clears
  * PG_locked and tests PG_waiters,
  */
-#ifndef clear_bit_unlock_is_negative_byte
-static inline bool clear_bit_unlock_is_negative_byte(unsigned int nr,
-						     volatile unsigned long *p)
+#ifndef arch_clear_bit_unlock_is_negative_byte
+static inline bool arch_clear_bit_unlock_is_negative_byte(unsigned int nr,
+							  volatile unsigned long *p)
 {
 	long old;
 	unsigned long mask =3D BIT_MASK(nr);
=20
 	p +=3D BIT_WORD(nr);
-	old =3D atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
+	old =3D arch_atomic_long_fetch_andnot_release(mask, (atomic_long_t *)p);
 	return !!(old & BIT(7));
 }
-#define clear_bit_unlock_is_negative_byte clear_bit_unlock_is_negative_byte
+#define arch_clear_bit_unlock_is_negative_byte arch_clear_bit_unlock_is_nega=
tive_byte
 #endif
=20
+#include <asm-generic/bitops/instrumented-lock.h>
+
 #endif /* _ASM_GENERIC_BITOPS_LOCK_H_ */
diff --git a/include/asm-generic/bitops/non-atomic.h b/include/asm-generic/bi=
tops/non-atomic.h
index 7e10c4b50c5d..365377fb104b 100644
--- a/include/asm-generic/bitops/non-atomic.h
+++ b/include/asm-generic/bitops/non-atomic.h
@@ -5,7 +5,7 @@
 #include <asm/types.h>
=20
 /**
- * __set_bit - Set a bit in memory
+ * arch___set_bit - Set a bit in memory
  * @nr: the bit to set
  * @addr: the address to start counting from
  *
@@ -13,24 +13,28 @@
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __set_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask =3D BIT_MASK(nr);
 	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
=20
 	*p  |=3D mask;
 }
+#define __set_bit arch___set_bit
=20
-static inline void __clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline void
+arch___clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask =3D BIT_MASK(nr);
 	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
=20
 	*p &=3D ~mask;
 }
+#define __clear_bit arch___clear_bit
=20
 /**
- * __change_bit - Toggle a bit in memory
+ * arch___change_bit - Toggle a bit in memory
  * @nr: the bit to change
  * @addr: the address to start counting from
  *
@@ -38,16 +42,18 @@ static inline void __clear_bit(int nr, volatile unsigned =
long *addr)
  * If it's called on the same region of memory simultaneously, the effect
  * may be that only one operation succeeds.
  */
-static inline void __change_bit(int nr, volatile unsigned long *addr)
+static __always_inline
+void arch___change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask =3D BIT_MASK(nr);
 	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
=20
 	*p ^=3D mask;
 }
+#define __change_bit arch___change_bit
=20
 /**
- * __test_and_set_bit - Set a bit and return its old value
+ * arch___test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
  * @addr: Address to count from
  *
@@ -55,7 +61,8 @@ static inline void __change_bit(int nr, volatile unsigned l=
ong *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_set_bit(int nr, volatile unsigned long *addr)
+static __always_inline int
+arch___test_and_set_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask =3D BIT_MASK(nr);
 	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
@@ -64,9 +71,10 @@ static inline int __test_and_set_bit(int nr, volatile unsi=
gned long *addr)
 	*p =3D old | mask;
 	return (old & mask) !=3D 0;
 }
+#define __test_and_set_bit arch___test_and_set_bit
=20
 /**
- * __test_and_clear_bit - Clear a bit and return its old value
+ * arch___test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
  * @addr: Address to count from
  *
@@ -74,7 +82,8 @@ static inline int __test_and_set_bit(int nr, volatile unsig=
ned long *addr)
  * If two examples of this operation race, one can appear to succeed
  * but actually fail.  You must protect multiple accesses with a lock.
  */
-static inline int __test_and_clear_bit(int nr, volatile unsigned long *addr)
+static __always_inline int
+arch___test_and_clear_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask =3D BIT_MASK(nr);
 	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
@@ -83,10 +92,11 @@ static inline int __test_and_clear_bit(int nr, volatile u=
nsigned long *addr)
 	*p =3D old & ~mask;
 	return (old & mask) !=3D 0;
 }
+#define __test_and_clear_bit arch___test_and_clear_bit
=20
 /* WARNING: non atomic and it can be reordered! */
-static inline int __test_and_change_bit(int nr,
-					    volatile unsigned long *addr)
+static __always_inline int
+arch___test_and_change_bit(int nr, volatile unsigned long *addr)
 {
 	unsigned long mask =3D BIT_MASK(nr);
 	unsigned long *p =3D ((unsigned long *)addr) + BIT_WORD(nr);
@@ -95,15 +105,18 @@ static inline int __test_and_change_bit(int nr,
 	*p =3D old ^ mask;
 	return (old & mask) !=3D 0;
 }
+#define __test_and_change_bit arch___test_and_change_bit
=20
 /**
- * test_bit - Determine whether a bit is set
+ * arch_test_bit - Determine whether a bit is set
  * @nr: bit number to test
  * @addr: Address to start counting from
  */
-static inline int test_bit(int nr, const volatile unsigned long *addr)
+static __always_inline int
+arch_test_bit(int nr, const volatile unsigned long *addr)
 {
 	return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
 }
+#define test_bit arch_test_bit
=20
 #endif /* _ASM_GENERIC_BITOPS_NON_ATOMIC_H_ */
diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index ed1d3ffd5b9d..8dd57c3a99e9 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -77,9 +77,8 @@
 	__ret;								\
 })
=20
-#include <linux/atomic-arch-fallback.h>
-#include <asm-generic/atomic-instrumented.h>
-
-#include <asm-generic/atomic-long.h>
+#include <linux/atomic/atomic-arch-fallback.h>
+#include <linux/atomic/atomic-long.h>
+#include <linux/atomic/atomic-instrumented.h>
=20
 #endif /* _LINUX_ATOMIC_H */
diff --git a/include/linux/atomic-arch-fallback.h b/include/linux/atomic/atom=
ic-arch-fallback.h
similarity index 100%
rename from include/linux/atomic-arch-fallback.h
rename to include/linux/atomic/atomic-arch-fallback.h
diff --git a/include/asm-generic/atomic-instrumented.h b/include/linux/atomic=
/atomic-instrumented.h
similarity index 68%
rename from include/asm-generic/atomic-instrumented.h
rename to include/linux/atomic/atomic-instrumented.h
index bc45af52c93b..a0f654370da3 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/linux/atomic/atomic-instrumented.h
@@ -14,8 +14,8 @@
  * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
  * double instrumentation.
  */
-#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
=20
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
@@ -1177,6 +1177,584 @@ atomic64_dec_if_positive(atomic64_t *v)
 	return arch_atomic64_dec_if_positive(v);
 }
=20
+static __always_inline long
+atomic_long_read(const atomic_long_t *v)
+{
+	instrument_atomic_read(v, sizeof(*v));
+	return arch_atomic_long_read(v);
+}
+
+static __always_inline long
+atomic_long_read_acquire(const atomic_long_t *v)
+{
+	instrument_atomic_read(v, sizeof(*v));
+	return arch_atomic_long_read_acquire(v);
+}
+
+static __always_inline void
+atomic_long_set(atomic_long_t *v, long i)
+{
+	instrument_atomic_write(v, sizeof(*v));
+	arch_atomic_long_set(v, i);
+}
+
+static __always_inline void
+atomic_long_set_release(atomic_long_t *v, long i)
+{
+	instrument_atomic_write(v, sizeof(*v));
+	arch_atomic_long_set_release(v, i);
+}
+
+static __always_inline void
+atomic_long_add(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_add(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_add_return(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_add_return_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_add_return_release(i, v);
+}
+
+static __always_inline long
+atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_add_return_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_add(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_add_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_add_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_sub(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_sub(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_sub_return(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_sub_return_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_sub_return_release(i, v);
+}
+
+static __always_inline long
+atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_sub_return_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_sub(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_sub_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_sub_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_inc(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_inc(v);
+}
+
+static __always_inline long
+atomic_long_inc_return(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_return(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_acquire(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_return_acquire(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_release(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_return_release(v);
+}
+
+static __always_inline long
+atomic_long_inc_return_relaxed(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_return_relaxed(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_inc(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_acquire(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_inc_acquire(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_release(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_inc_release(v);
+}
+
+static __always_inline long
+atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+atomic_long_dec(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_dec(v);
+}
+
+static __always_inline long
+atomic_long_dec_return(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_return(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_acquire(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_return_acquire(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_release(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_return_release(v);
+}
+
+static __always_inline long
+atomic_long_dec_return_relaxed(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_return_relaxed(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_dec(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_acquire(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_dec_acquire(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_release(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_dec_release(v);
+}
+
+static __always_inline long
+atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+atomic_long_and(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_and(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_and(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_and_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_and_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_andnot(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_andnot(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_andnot(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_andnot_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_or(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_or(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_or(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_or_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_or_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+atomic_long_xor(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	arch_atomic_long_xor(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_xor(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_xor_acquire(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_xor_release(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline long
+atomic_long_xchg(atomic_long_t *v, long i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_xchg(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_acquire(atomic_long_t *v, long i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_xchg_acquire(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_release(atomic_long_t *v, long i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_xchg_release(v, i);
+}
+
+static __always_inline long
+atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_xchg_relaxed(v, i);
+}
+
+static __always_inline long
+atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_cmpxchg(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_cmpxchg_release(v, old, new);
+}
+
+static __always_inline long
+atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_long_try_cmpxchg(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_long_try_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_long_try_cmpxchg_release(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	instrument_atomic_read_write(old, sizeof(*old));
+	return arch_atomic_long_try_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+atomic_long_sub_and_test(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_sub_and_test(i, v);
+}
+
+static __always_inline bool
+atomic_long_dec_and_test(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_and_test(v);
+}
+
+static __always_inline bool
+atomic_long_inc_and_test(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_and_test(v);
+}
+
+static __always_inline bool
+atomic_long_add_negative(long i, atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_add_negative(i, v);
+}
+
+static __always_inline long
+atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_long_add_unless(atomic_long_t *v, long a, long u)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_add_unless(v, a, u);
+}
+
+static __always_inline bool
+atomic_long_inc_not_zero(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_not_zero(v);
+}
+
+static __always_inline bool
+atomic_long_inc_unless_negative(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_inc_unless_negative(v);
+}
+
+static __always_inline bool
+atomic_long_dec_unless_positive(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_unless_positive(v);
+}
+
+static __always_inline long
+atomic_long_dec_if_positive(atomic_long_t *v)
+{
+	instrument_atomic_read_write(v, sizeof(*v));
+	return arch_atomic_long_dec_if_positive(v);
+}
+
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr =3D (ptr); \
@@ -1333,5 +1911,5 @@ atomic64_dec_if_positive(atomic64_t *v)
 	arch_cmpxchg_double_local(__ai_ptr, __VA_ARGS__); \
 })
=20
-#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 1d7c3a25aca5c7fb031c307be4c3d24c7b48fcd5
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
+// 2a9553f0a9d5619f19151092df5cabbbf16ce835
diff --git a/include/linux/atomic/atomic-long.h b/include/linux/atomic/atomic=
-long.h
new file mode 100644
index 000000000000..800b8c35992d
--- /dev/null
+++ b/include/linux/atomic/atomic-long.h
@@ -0,0 +1,1014 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Generated by scripts/atomic/gen-atomic-long.sh
+// DO NOT MODIFY THIS FILE DIRECTLY
+
+#ifndef _LINUX_ATOMIC_LONG_H
+#define _LINUX_ATOMIC_LONG_H
+
+#include <linux/compiler.h>
+#include <asm/types.h>
+
+#ifdef CONFIG_64BIT
+typedef atomic64_t atomic_long_t;
+#define ATOMIC_LONG_INIT(i)		ATOMIC64_INIT(i)
+#define atomic_long_cond_read_acquire	atomic64_cond_read_acquire
+#define atomic_long_cond_read_relaxed	atomic64_cond_read_relaxed
+#else
+typedef atomic_t atomic_long_t;
+#define ATOMIC_LONG_INIT(i)		ATOMIC_INIT(i)
+#define atomic_long_cond_read_acquire	atomic_cond_read_acquire
+#define atomic_long_cond_read_relaxed	atomic_cond_read_relaxed
+#endif
+
+#ifdef CONFIG_64BIT
+
+static __always_inline long
+arch_atomic_long_read(const atomic_long_t *v)
+{
+	return arch_atomic64_read(v);
+}
+
+static __always_inline long
+arch_atomic_long_read_acquire(const atomic_long_t *v)
+{
+	return arch_atomic64_read_acquire(v);
+}
+
+static __always_inline void
+arch_atomic_long_set(atomic_long_t *v, long i)
+{
+	arch_atomic64_set(v, i);
+}
+
+static __always_inline void
+arch_atomic_long_set_release(atomic_long_t *v, long i)
+{
+	arch_atomic64_set_release(v, i);
+}
+
+static __always_inline void
+arch_atomic_long_add(long i, atomic_long_t *v)
+{
+	arch_atomic64_add(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return(long i, atomic_long_t *v)
+{
+	return arch_atomic64_add_return(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_add_return_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_add_return_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_add_return_relaxed(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_add(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_add_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_add_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_sub(long i, atomic_long_t *v)
+{
+	arch_atomic64_sub(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return(long i, atomic_long_t *v)
+{
+	return arch_atomic64_sub_return(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_sub_return_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_sub_return_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_sub_return_relaxed(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_sub(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_sub_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_sub_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_inc(atomic_long_t *v)
+{
+	arch_atomic64_inc(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return(atomic_long_t *v)
+{
+	return arch_atomic64_inc_return(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return_acquire(atomic_long_t *v)
+{
+	return arch_atomic64_inc_return_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return_release(atomic_long_t *v)
+{
+	return arch_atomic64_inc_return_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return_relaxed(atomic_long_t *v)
+{
+	return arch_atomic64_inc_return_relaxed(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_inc(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc_acquire(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_inc_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc_release(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_inc_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+arch_atomic_long_dec(atomic_long_t *v)
+{
+	arch_atomic64_dec(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return(atomic_long_t *v)
+{
+	return arch_atomic64_dec_return(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return_acquire(atomic_long_t *v)
+{
+	return arch_atomic64_dec_return_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return_release(atomic_long_t *v)
+{
+	return arch_atomic64_dec_return_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return_relaxed(atomic_long_t *v)
+{
+	return arch_atomic64_dec_return_relaxed(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_dec(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec_acquire(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_dec_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec_release(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_dec_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+{
+	return arch_atomic64_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+arch_atomic_long_and(long i, atomic_long_t *v)
+{
+	arch_atomic64_and(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_and(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_and_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_and_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_andnot(long i, atomic_long_t *v)
+{
+	arch_atomic64_andnot(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_andnot(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_andnot_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_or(long i, atomic_long_t *v)
+{
+	arch_atomic64_or(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_or(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_or_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_or_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_xor(long i, atomic_long_t *v)
+{
+	arch_atomic64_xor(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_xor(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_xor_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_xor_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic64_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_xchg(atomic_long_t *v, long i)
+{
+	return arch_atomic64_xchg(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_xchg_acquire(atomic_long_t *v, long i)
+{
+	return arch_atomic64_xchg_acquire(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_xchg_release(atomic_long_t *v, long i)
+{
+	return arch_atomic64_xchg_release(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+{
+	return arch_atomic64_xchg_relaxed(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic64_cmpxchg(v, old, new);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic64_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic64_cmpxchg_release(v, old, new);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic64_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic64_try_cmpxchg(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic64_try_cmpxchg_acquire(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic64_try_cmpxchg_release(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic64_try_cmpxchg_relaxed(v, (s64 *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_sub_and_test(long i, atomic_long_t *v)
+{
+	return arch_atomic64_sub_and_test(i, v);
+}
+
+static __always_inline bool
+arch_atomic_long_dec_and_test(atomic_long_t *v)
+{
+	return arch_atomic64_dec_and_test(v);
+}
+
+static __always_inline bool
+arch_atomic_long_inc_and_test(atomic_long_t *v)
+{
+	return arch_atomic64_inc_and_test(v);
+}
+
+static __always_inline bool
+arch_atomic_long_add_negative(long i, atomic_long_t *v)
+{
+	return arch_atomic64_add_negative(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+{
+	return arch_atomic64_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+arch_atomic_long_add_unless(atomic_long_t *v, long a, long u)
+{
+	return arch_atomic64_add_unless(v, a, u);
+}
+
+static __always_inline bool
+arch_atomic_long_inc_not_zero(atomic_long_t *v)
+{
+	return arch_atomic64_inc_not_zero(v);
+}
+
+static __always_inline bool
+arch_atomic_long_inc_unless_negative(atomic_long_t *v)
+{
+	return arch_atomic64_inc_unless_negative(v);
+}
+
+static __always_inline bool
+arch_atomic_long_dec_unless_positive(atomic_long_t *v)
+{
+	return arch_atomic64_dec_unless_positive(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_if_positive(atomic_long_t *v)
+{
+	return arch_atomic64_dec_if_positive(v);
+}
+
+#else /* CONFIG_64BIT */
+
+static __always_inline long
+arch_atomic_long_read(const atomic_long_t *v)
+{
+	return arch_atomic_read(v);
+}
+
+static __always_inline long
+arch_atomic_long_read_acquire(const atomic_long_t *v)
+{
+	return arch_atomic_read_acquire(v);
+}
+
+static __always_inline void
+arch_atomic_long_set(atomic_long_t *v, long i)
+{
+	arch_atomic_set(v, i);
+}
+
+static __always_inline void
+arch_atomic_long_set_release(atomic_long_t *v, long i)
+{
+	arch_atomic_set_release(v, i);
+}
+
+static __always_inline void
+arch_atomic_long_add(long i, atomic_long_t *v)
+{
+	arch_atomic_add(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return(long i, atomic_long_t *v)
+{
+	return arch_atomic_add_return(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_add_return_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_add_return_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_add_return_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_add_return_relaxed(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_add(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_add_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_add_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_add_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_sub(long i, atomic_long_t *v)
+{
+	arch_atomic_sub(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return(long i, atomic_long_t *v)
+{
+	return arch_atomic_sub_return(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_sub_return_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_sub_return_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_sub_return_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_sub_return_relaxed(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_sub(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_sub_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_sub_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_sub_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_sub_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_inc(atomic_long_t *v)
+{
+	arch_atomic_inc(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return(atomic_long_t *v)
+{
+	return arch_atomic_inc_return(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return_acquire(atomic_long_t *v)
+{
+	return arch_atomic_inc_return_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return_release(atomic_long_t *v)
+{
+	return arch_atomic_inc_return_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_inc_return_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_inc_return_relaxed(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc(atomic_long_t *v)
+{
+	return arch_atomic_fetch_inc(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc_acquire(atomic_long_t *v)
+{
+	return arch_atomic_fetch_inc_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc_release(atomic_long_t *v)
+{
+	return arch_atomic_fetch_inc_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_inc_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_fetch_inc_relaxed(v);
+}
+
+static __always_inline void
+arch_atomic_long_dec(atomic_long_t *v)
+{
+	arch_atomic_dec(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return(atomic_long_t *v)
+{
+	return arch_atomic_dec_return(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return_acquire(atomic_long_t *v)
+{
+	return arch_atomic_dec_return_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return_release(atomic_long_t *v)
+{
+	return arch_atomic_dec_return_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_return_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_dec_return_relaxed(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec(atomic_long_t *v)
+{
+	return arch_atomic_fetch_dec(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec_acquire(atomic_long_t *v)
+{
+	return arch_atomic_fetch_dec_acquire(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec_release(atomic_long_t *v)
+{
+	return arch_atomic_fetch_dec_release(v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_dec_relaxed(atomic_long_t *v)
+{
+	return arch_atomic_fetch_dec_relaxed(v);
+}
+
+static __always_inline void
+arch_atomic_long_and(long i, atomic_long_t *v)
+{
+	arch_atomic_and(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_and(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_and_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_and_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_and_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_and_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_andnot(long i, atomic_long_t *v)
+{
+	arch_atomic_andnot(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_andnot(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_andnot_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_andnot_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_andnot_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_andnot_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_or(long i, atomic_long_t *v)
+{
+	arch_atomic_or(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_or(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_or_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_or_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_or_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_or_relaxed(i, v);
+}
+
+static __always_inline void
+arch_atomic_long_xor(long i, atomic_long_t *v)
+{
+	arch_atomic_xor(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_xor(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor_acquire(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_xor_acquire(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor_release(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_xor_release(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_xor_relaxed(long i, atomic_long_t *v)
+{
+	return arch_atomic_fetch_xor_relaxed(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_xchg(atomic_long_t *v, long i)
+{
+	return arch_atomic_xchg(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_xchg_acquire(atomic_long_t *v, long i)
+{
+	return arch_atomic_xchg_acquire(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_xchg_release(atomic_long_t *v, long i)
+{
+	return arch_atomic_xchg_release(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_xchg_relaxed(atomic_long_t *v, long i)
+{
+	return arch_atomic_xchg_relaxed(v, i);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_cmpxchg(v, old, new);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg_acquire(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_cmpxchg_acquire(v, old, new);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg_release(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_cmpxchg_release(v, old, new);
+}
+
+static __always_inline long
+arch_atomic_long_cmpxchg_relaxed(atomic_long_t *v, long old, long new)
+{
+	return arch_atomic_cmpxchg_relaxed(v, old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_try_cmpxchg(v, (int *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg_acquire(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_try_cmpxchg_acquire(v, (int *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg_release(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_try_cmpxchg_release(v, (int *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_try_cmpxchg_relaxed(atomic_long_t *v, long *old, long new)
+{
+	return arch_atomic_try_cmpxchg_relaxed(v, (int *)old, new);
+}
+
+static __always_inline bool
+arch_atomic_long_sub_and_test(long i, atomic_long_t *v)
+{
+	return arch_atomic_sub_and_test(i, v);
+}
+
+static __always_inline bool
+arch_atomic_long_dec_and_test(atomic_long_t *v)
+{
+	return arch_atomic_dec_and_test(v);
+}
+
+static __always_inline bool
+arch_atomic_long_inc_and_test(atomic_long_t *v)
+{
+	return arch_atomic_inc_and_test(v);
+}
+
+static __always_inline bool
+arch_atomic_long_add_negative(long i, atomic_long_t *v)
+{
+	return arch_atomic_add_negative(i, v);
+}
+
+static __always_inline long
+arch_atomic_long_fetch_add_unless(atomic_long_t *v, long a, long u)
+{
+	return arch_atomic_fetch_add_unless(v, a, u);
+}
+
+static __always_inline bool
+arch_atomic_long_add_unless(atomic_long_t *v, long a, long u)
+{
+	return arch_atomic_add_unless(v, a, u);
+}
+
+static __always_inline bool
+arch_atomic_long_inc_not_zero(atomic_long_t *v)
+{
+	return arch_atomic_inc_not_zero(v);
+}
+
+static __always_inline bool
+arch_atomic_long_inc_unless_negative(atomic_long_t *v)
+{
+	return arch_atomic_inc_unless_negative(v);
+}
+
+static __always_inline bool
+arch_atomic_long_dec_unless_positive(atomic_long_t *v)
+{
+	return arch_atomic_dec_unless_positive(v);
+}
+
+static __always_inline long
+arch_atomic_long_dec_if_positive(atomic_long_t *v)
+{
+	return arch_atomic_dec_if_positive(v);
+}
+
+#endif /* CONFIG_64BIT */
+#endif /* _LINUX_ATOMIC_LONG_H */
+// e8f0e08ff072b74d180eabe2ad001282b38c2c88
diff --git a/include/linux/debug_locks.h b/include/linux/debug_locks.h
index edb5c186b0b7..3f49e65169c6 100644
--- a/include/linux/debug_locks.h
+++ b/include/linux/debug_locks.h
@@ -3,8 +3,7 @@
 #define __LINUX_DEBUG_LOCKING_H
=20
 #include <linux/atomic.h>
-#include <linux/bug.h>
-#include <linux/printk.h>
+#include <linux/cache.h>
=20
 struct task_struct;
=20
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_i=
nternal.h
index ded90b097e6e..975e33b793a7 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -6,6 +6,8 @@
 #include <linux/percpu-defs.h>
 #include <linux/lockdep.h>
=20
+#ifndef CONFIG_PREEMPT_RT
+
 typedef struct {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -14,29 +16,14 @@ typedef struct {
 } local_lock_t;
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define LL_DEP_MAP_INIT(lockname)			\
+# define LOCAL_LOCK_DEBUG_INIT(lockname)		\
 	.dep_map =3D {					\
 		.name =3D #lockname,			\
 		.wait_type_inner =3D LD_WAIT_CONFIG,	\
-		.lock_type =3D LD_LOCK_PERCPU,			\
-	}
-#else
-# define LL_DEP_MAP_INIT(lockname)
-#endif
-
-#define INIT_LOCAL_LOCK(lockname)	{ LL_DEP_MAP_INIT(lockname) }
-
-#define __local_lock_init(lock)					\
-do {								\
-	static struct lock_class_key __key;			\
-								\
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
-	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key, 0, \
-			      LD_WAIT_CONFIG, LD_WAIT_INV,	\
-			      LD_LOCK_PERCPU);			\
-} while (0)
+		.lock_type =3D LD_LOCK_PERCPU,		\
+	},						\
+	.owner =3D NULL,
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
 static inline void local_lock_acquire(local_lock_t *l)
 {
 	lock_map_acquire(&l->dep_map);
@@ -51,11 +38,30 @@ static inline void local_lock_release(local_lock_t *l)
 	lock_map_release(&l->dep_map);
 }
=20
+static inline void local_lock_debug_init(local_lock_t *l)
+{
+	l->owner =3D NULL;
+}
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
+# define LOCAL_LOCK_DEBUG_INIT(lockname)
 static inline void local_lock_acquire(local_lock_t *l) { }
 static inline void local_lock_release(local_lock_t *l) { }
+static inline void local_lock_debug_init(local_lock_t *l) { }
 #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
+#define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }
+
+#define __local_lock_init(lock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key,  \
+			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_PERCPU);			\
+	local_lock_debug_init(lock);				\
+} while (0)
+
 #define __local_lock(lock)					\
 	do {							\
 		preempt_disable();				\
@@ -91,3 +97,45 @@ static inline void local_lock_release(local_lock_t *l) { }
 		local_lock_release(this_cpu_ptr(lock));		\
 		local_irq_restore(flags);			\
 	} while (0)
+
+#else /* !CONFIG_PREEMPT_RT */
+
+/*
+ * On PREEMPT_RT local_lock maps to a per CPU spinlock, which protects the
+ * critical section while staying preemptible.
+ */
+typedef spinlock_t local_lock_t;
+
+#define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
+
+#define __local_lock_init(l)					\
+	do {							\
+		local_spin_lock_init((l));			\
+	} while (0)
+
+#define __local_lock(__lock)					\
+	do {							\
+		migrate_disable();				\
+		spin_lock(this_cpu_ptr((__lock)));		\
+	} while (0)
+
+#define __local_lock_irq(lock)			__local_lock(lock)
+
+#define __local_lock_irqsave(lock, flags)			\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags =3D 0;					\
+		__local_lock(lock);				\
+	} while (0)
+
+#define __local_unlock(__lock)					\
+	do {							\
+		spin_unlock(this_cpu_ptr((__lock)));		\
+		migrate_enable();				\
+	} while (0)
+
+#define __local_unlock_irq(lock)		__local_unlock(lock)
+
+#define __local_unlock_irqrestore(lock, flags)	__local_unlock(lock)
+
+#endif /* CONFIG_PREEMPT_RT */
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index e19323521f9c..8f226d460f51 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,8 +20,17 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
=20
-struct ww_class;
-struct ww_acquire_ctx;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
+		, .dep_map =3D {					\
+			.name =3D #lockname,			\
+			.wait_type_inner =3D LD_WAIT_SLEEP,	\
+		}
+#else
+# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
=20
 /*
  * Simple, straightforward mutexes with strict semantics:
@@ -53,7 +62,7 @@ struct ww_acquire_ctx;
  */
 struct mutex {
 	atomic_long_t		owner;
-	spinlock_t		wait_lock;
+	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	struct optimistic_spin_queue osq; /* Spinner MCS lock */
 #endif
@@ -66,27 +75,6 @@ struct mutex {
 #endif
 };
=20
-struct ww_mutex {
-	struct mutex base;
-	struct ww_acquire_ctx *ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	struct ww_class *ww_class;
-#endif
-};
-
-/*
- * This is the control structure for tasks blocked on mutex,
- * which resides on the blocked task's kernel stack:
- */
-struct mutex_waiter {
-	struct list_head	list;
-	struct task_struct	*task;
-	struct ww_acquire_ctx	*ww_ctx;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
=20
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
@@ -117,19 +105,9 @@ do {									\
 	__mutex_init((mutex), #mutex, &__key);				\
 } while (0)
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
-		, .dep_map =3D {					\
-			.name =3D #lockname,			\
-			.wait_type_inner =3D LD_WAIT_SLEEP,	\
-		}
-#else
-# define __DEP_MAP_MUTEX_INITIALIZER(lockname)
-#endif
-
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner =3D ATOMIC_LONG_INIT(0) \
-		, .wait_lock =3D __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
+		, .wait_lock =3D __RAW_SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list =3D LIST_HEAD_INIT(lockname.wait_list) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
 		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
@@ -148,6 +126,50 @@ extern void __mutex_init(struct mutex *lock, const char =
*name,
  */
 extern bool mutex_is_locked(struct mutex *lock);
=20
+#else /* !CONFIG_PREEMPT_RT */
+/*
+ * Preempt-RT variant based on rtmutexes.
+ */
+#include <linux/rtmutex.h>
+
+struct mutex {
+	struct rt_mutex_base	rtmutex;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __MUTEX_INITIALIZER(mutexname)					\
+{									\
+	.rtmutex =3D __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex)	\
+	__DEP_MAP_MUTEX_INITIALIZER(mutexname)				\
+}
+
+#define DEFINE_MUTEX(mutexname)						\
+	struct mutex mutexname =3D __MUTEX_INITIALIZER(mutexname)
+
+extern void __mutex_rt_init(struct mutex *lock, const char *name,
+			    struct lock_class_key *key);
+extern int mutex_trylock(struct mutex *lock);
+
+static inline void mutex_destroy(struct mutex *lock) { }
+
+#define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
+
+#define __mutex_init(mutex, name, key)			\
+do {							\
+	rt_mutex_base_init(&(mutex)->rtmutex);		\
+	__mutex_rt_init((mutex), name, key);		\
+} while (0)
+
+#define mutex_init(mutex)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	__mutex_init((mutex), #mutex, &__key);		\
+} while (0)
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.
  * Also see Documentation/locking/mutex-design.rst.
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 9881eac0698f..4d244e295e85 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -121,7 +121,11 @@
 /*
  * The preempt_count offset after spin_lock()
  */
+#if !defined(CONFIG_PREEMPT_RT)
 #define PREEMPT_LOCK_OFFSET	PREEMPT_DISABLE_OFFSET
+#else
+#define PREEMPT_LOCK_OFFSET	0
+#endif
=20
 /*
  * The preempt_count offset needed for things like:
diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index d31ecaf4fdd3..235047d7a1b5 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -17,24 +17,14 @@
 #ifndef	_LINUX_RBTREE_H
 #define	_LINUX_RBTREE_H
=20
+#include <linux/rbtree_types.h>
+
 #include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/rcupdate.h>
=20
-struct rb_node {
-	unsigned long  __rb_parent_color;
-	struct rb_node *rb_right;
-	struct rb_node *rb_left;
-} __attribute__((aligned(sizeof(long))));
-    /* The alignment might seem pointless, but allegedly CRIS needs it */
-
-struct rb_root {
-	struct rb_node *rb_node;
-};
-
 #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))
=20
-#define RB_ROOT	(struct rb_root) { NULL, }
 #define	rb_entry(ptr, type, member) container_of(ptr, type, member)
=20
 #define RB_EMPTY_ROOT(root)  (READ_ONCE((root)->rb_node) =3D=3D NULL)
@@ -112,23 +102,6 @@ static inline void rb_link_node_rcu(struct rb_node *node=
, struct rb_node *parent
 			typeof(*pos), field); 1; }); \
 	     pos =3D n)
=20
-/*
- * Leftmost-cached rbtrees.
- *
- * We do not cache the rightmost node based on footprint
- * size vs number of potential users that could benefit
- * from O(1) rb_last(). Just not worth it, users that want
- * this feature can always implement the logic explicitly.
- * Furthermore, users that want to cache both pointers may
- * find it a bit asymmetric, but that's ok.
- */
-struct rb_root_cached {
-	struct rb_root rb_root;
-	struct rb_node *rb_leftmost;
-};
-
-#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
-
 /* Same as rb_first(), but O(1) */
 #define rb_first_cached(root) (root)->rb_leftmost
=20
diff --git a/include/linux/rbtree_types.h b/include/linux/rbtree_types.h
new file mode 100644
index 000000000000..45b6ecde3665
--- /dev/null
+++ b/include/linux/rbtree_types.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _LINUX_RBTREE_TYPES_H
+#define _LINUX_RBTREE_TYPES_H
+
+struct rb_node {
+	unsigned long  __rb_parent_color;
+	struct rb_node *rb_right;
+	struct rb_node *rb_left;
+} __attribute__((aligned(sizeof(long))));
+/* The alignment might seem pointless, but allegedly CRIS needs it */
+
+struct rb_root {
+	struct rb_node *rb_node;
+};
+
+/*
+ * Leftmost-cached rbtrees.
+ *
+ * We do not cache the rightmost node based on footprint
+ * size vs number of potential users that could benefit
+ * from O(1) rb_last(). Just not worth it, users that want
+ * this feature can always implement the logic explicitly.
+ * Furthermore, users that want to cache both pointers may
+ * find it a bit asymmetric, but that's ok.
+ */
+struct rb_root_cached {
+	struct rb_root rb_root;
+	struct rb_node *rb_leftmost;
+};
+
+#define RB_ROOT (struct rb_root) { NULL, }
+#define RB_ROOT_CACHED (struct rb_root_cached) { {NULL, }, NULL }
+
+#endif
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index d1672de9ca89..9deedfeec2b1 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -13,12 +13,39 @@
 #ifndef __LINUX_RT_MUTEX_H
 #define __LINUX_RT_MUTEX_H
=20
+#include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <linux/rbtree.h>
-#include <linux/spinlock_types.h>
+#include <linux/rbtree_types.h>
+#include <linux/spinlock_types_raw.h>
=20
 extern int max_lock_depth; /* for sysctl */
=20
+struct rt_mutex_base {
+	raw_spinlock_t		wait_lock;
+	struct rb_root_cached   waiters;
+	struct task_struct	*owner;
+};
+
+#define __RT_MUTEX_BASE_INITIALIZER(rtbasename)				\
+{									\
+	.wait_lock =3D __RAW_SPIN_LOCK_UNLOCKED(rtbasename.wait_lock),	\
+	.waiters =3D RB_ROOT_CACHED,					\
+	.owner =3D NULL							\
+}
+
+/**
+ * rt_mutex_base_is_locked - is the rtmutex locked
+ * @lock: the mutex to be queried
+ *
+ * Returns true if the mutex is locked, false if unlocked.
+ */
+static inline bool rt_mutex_base_is_locked(struct rt_mutex_base *lock)
+{
+	return READ_ONCE(lock->owner) !=3D NULL;
+}
+
+extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
+
 /**
  * The rt_mutex structure
  *
@@ -28,9 +55,7 @@ extern int max_lock_depth; /* for sysctl */
  * @owner:	the mutex owner
  */
 struct rt_mutex {
-	raw_spinlock_t		wait_lock;
-	struct rb_root_cached   waiters;
-	struct task_struct	*owner;
+	struct rt_mutex_base	rtmutex;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
@@ -52,32 +77,24 @@ do { \
 } while (0)
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
-	, .dep_map =3D { .name =3D #mutexname }
+#define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
+	.dep_map =3D {					\
+		.name =3D #mutexname,			\
+		.wait_type_inner =3D LD_WAIT_SLEEP,	\
+	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
=20
-#define __RT_MUTEX_INITIALIZER(mutexname) \
-	{ .wait_lock =3D __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
-	, .waiters =3D RB_ROOT_CACHED \
-	, .owner =3D NULL \
-	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)}
+#define __RT_MUTEX_INITIALIZER(mutexname)				\
+{									\
+	.rtmutex =3D __RT_MUTEX_BASE_INITIALIZER(mutexname.rtmutex),	\
+	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)			\
+}
=20
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname =3D __RT_MUTEX_INITIALIZER(mutexname)
=20
-/**
- * rt_mutex_is_locked - is the mutex locked
- * @lock: the mutex to be queried
- *
- * Returns 1 if the mutex is locked, 0 if unlocked.
- */
-static inline int rt_mutex_is_locked(struct rt_mutex *lock)
-{
-	return lock->owner !=3D NULL;
-}
-
 extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct =
lock_class_key *key);
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/include/linux/rwbase_rt.h b/include/linux/rwbase_rt.h
new file mode 100644
index 000000000000..1d264dd08625
--- /dev/null
+++ b/include/linux/rwbase_rt.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef _LINUX_RWBASE_RT_H
+#define _LINUX_RWBASE_RT_H
+
+#include <linux/rtmutex.h>
+#include <linux/atomic.h>
+
+#define READER_BIAS		(1U << 31)
+#define WRITER_BIAS		(1U << 30)
+
+struct rwbase_rt {
+	atomic_t		readers;
+	struct rt_mutex_base	rtmutex;
+};
+
+#define __RWBASE_INITIALIZER(name)				\
+{								\
+	.readers =3D ATOMIC_INIT(READER_BIAS),			\
+	.rtmutex =3D __RT_MUTEX_BASE_INITIALIZER(name.rtmutex),	\
+}
+
+#define init_rwbase_rt(rwbase)					\
+	do {							\
+		rt_mutex_base_init(&(rwbase)->rtmutex);		\
+		atomic_set(&(rwbase)->readers, READER_BIAS);	\
+	} while (0)
+
+
+static __always_inline bool rw_base_is_locked(struct rwbase_rt *rwb)
+{
+	return atomic_read(&rwb->readers) !=3D READER_BIAS;
+}
+
+static __always_inline bool rw_base_is_contended(struct rwbase_rt *rwb)
+{
+	return atomic_read(&rwb->readers) > 0;
+}
+
+#endif /* _LINUX_RWBASE_RT_H */
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
new file mode 100644
index 000000000000..49c1f3842ed5
--- /dev/null
+++ b/include/linux/rwlock_rt.h
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __LINUX_RWLOCK_RT_H
+#define __LINUX_RWLOCK_RT_H
+
+#ifndef __LINUX_SPINLOCK_RT_H
+#error Do not #include directly. Use <linux/spinlock.h>.
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
+			     struct lock_class_key *key);
+#else
+static inline void __rt_rwlock_init(rwlock_t *rwlock, char *name,
+				    struct lock_class_key *key)
+{
+}
+#endif
+
+#define rwlock_init(rwl)				\
+do {							\
+	static struct lock_class_key __key;		\
+							\
+	init_rwbase_rt(&(rwl)->rwbase);			\
+	__rt_rwlock_init(rwl, #rwl, &__key);		\
+} while (0)
+
+extern void rt_read_lock(rwlock_t *rwlock);
+extern int rt_read_trylock(rwlock_t *rwlock);
+extern void rt_read_unlock(rwlock_t *rwlock);
+extern void rt_write_lock(rwlock_t *rwlock);
+extern int rt_write_trylock(rwlock_t *rwlock);
+extern void rt_write_unlock(rwlock_t *rwlock);
+
+static __always_inline void read_lock(rwlock_t *rwlock)
+{
+	rt_read_lock(rwlock);
+}
+
+static __always_inline void read_lock_bh(rwlock_t *rwlock)
+{
+	local_bh_disable();
+	rt_read_lock(rwlock);
+}
+
+static __always_inline void read_lock_irq(rwlock_t *rwlock)
+{
+	rt_read_lock(rwlock);
+}
+
+#define read_lock_irqsave(lock, flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		rt_read_lock(lock);			\
+		flags =3D 0;				\
+	} while (0)
+
+#define read_trylock(lock)	__cond_lock(lock, rt_read_trylock(lock))
+
+static __always_inline void read_unlock(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void read_unlock_bh(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+	local_bh_enable();
+}
+
+static __always_inline void read_unlock_irq(rwlock_t *rwlock)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void read_unlock_irqrestore(rwlock_t *rwlock,
+						   unsigned long flags)
+{
+	rt_read_unlock(rwlock);
+}
+
+static __always_inline void write_lock(rwlock_t *rwlock)
+{
+	rt_write_lock(rwlock);
+}
+
+static __always_inline void write_lock_bh(rwlock_t *rwlock)
+{
+	local_bh_disable();
+	rt_write_lock(rwlock);
+}
+
+static __always_inline void write_lock_irq(rwlock_t *rwlock)
+{
+	rt_write_lock(rwlock);
+}
+
+#define write_lock_irqsave(lock, flags)			\
+	do {						\
+		typecheck(unsigned long, flags);	\
+		rt_write_lock(lock);			\
+		flags =3D 0;				\
+	} while (0)
+
+#define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
+
+#define write_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags =3D 0;					\
+	__locked =3D write_trylock(lock);			\
+	__locked;					\
+})
+
+static __always_inline void write_unlock(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+}
+
+static __always_inline void write_unlock_bh(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+	local_bh_enable();
+}
+
+static __always_inline void write_unlock_irq(rwlock_t *rwlock)
+{
+	rt_write_unlock(rwlock);
+}
+
+static __always_inline void write_unlock_irqrestore(rwlock_t *rwlock,
+						    unsigned long flags)
+{
+	rt_write_unlock(rwlock);
+}
+
+#define rwlock_is_contended(lock)		(((void)(lock), 0))
+
+#endif /* __LINUX_RWLOCK_RT_H */
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 3bd03e18061c..1948442e7750 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -1,9 +1,23 @@
 #ifndef __LINUX_RWLOCK_TYPES_H
 #define __LINUX_RWLOCK_TYPES_H
=20
+#if !defined(__LINUX_SPINLOCK_TYPES_H)
+# error "Do not include directly, include spinlock_types.h"
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RW_DEP_MAP_INIT(lockname)					\
+	.dep_map =3D {							\
+		.name =3D #lockname,					\
+		.wait_type_inner =3D LD_WAIT_CONFIG,			\
+	}
+#else
+# define RW_DEP_MAP_INIT(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
 /*
- * include/linux/rwlock_types.h - generic rwlock type definitions
- *				  and initializers
+ * generic rwlock type definitions and initializers
  *
  * portions Copyright 2005, Red Hat, Inc., Ingo Molnar
  * Released under the General Public License (GPL).
@@ -21,16 +35,6 @@ typedef struct {
=20
 #define RWLOCK_MAGIC		0xdeaf1eed
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RW_DEP_MAP_INIT(lockname)					\
-	.dep_map =3D {							\
-		.name =3D #lockname,					\
-		.wait_type_inner =3D LD_WAIT_CONFIG,			\
-	}
-#else
-# define RW_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define __RW_LOCK_UNLOCKED(lockname)					\
 	(rwlock_t)	{	.raw_lock =3D __ARCH_RW_LOCK_UNLOCKED,	\
@@ -46,4 +50,29 @@ typedef struct {
=20
 #define DEFINE_RWLOCK(x)	rwlock_t x =3D __RW_LOCK_UNLOCKED(x)
=20
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+typedef struct {
+	struct rwbase_rt	rwbase;
+	atomic_t		readers;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} rwlock_t;
+
+#define __RWLOCK_RT_INITIALIZER(name)					\
+{									\
+	.rwbase =3D __RWBASE_INITIALIZER(name),				\
+	RW_DEP_MAP_INIT(name)						\
+}
+
+#define __RW_LOCK_UNLOCKED(name) __RWLOCK_RT_INITIALIZER(name)
+
+#define DEFINE_RWLOCK(name)						\
+	rwlock_t name =3D __RW_LOCK_UNLOCKED(name)
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #endif /* __LINUX_RWLOCK_TYPES_H */
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index a66038d88878..426e98e0b675 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,6 +16,19 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/err.h>
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define __RWSEM_DEP_MAP_INIT(lockname)			\
+	.dep_map =3D {					\
+		.name =3D #lockname,			\
+		.wait_type_inner =3D LD_WAIT_SLEEP,	\
+	},
+#else
+# define __RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 #include <linux/osq_lock.h>
 #endif
@@ -64,16 +77,6 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
=20
 /* Common initializer macros and functions */
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define __RWSEM_DEP_MAP_INIT(lockname)			\
-	.dep_map =3D {					\
-		.name =3D #lockname,			\
-		.wait_type_inner =3D LD_WAIT_SLEEP,	\
-	},
-#else
-# define __RWSEM_DEP_MAP_INIT(lockname)
-#endif
-
 #ifdef CONFIG_DEBUG_RWSEMS
 # define __RWSEM_DEBUG_INIT(lockname) .magic =3D &lockname,
 #else
@@ -119,6 +122,61 @@ static inline int rwsem_is_contended(struct rw_semaphore=
 *sem)
 	return !list_empty(&sem->wait_list);
 }
=20
+#else /* !CONFIG_PREEMPT_RT */
+
+#include <linux/rwbase_rt.h>
+
+struct rw_semaphore {
+	struct rwbase_rt	rwbase;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#define __RWSEM_INITIALIZER(name)				\
+	{							\
+		.rwbase =3D __RWBASE_INITIALIZER(name),		\
+		__RWSEM_DEP_MAP_INIT(name)			\
+	}
+
+#define DECLARE_RWSEM(lockname) \
+	struct rw_semaphore lockname =3D __RWSEM_INITIALIZER(lockname)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void  __rwsem_init(struct rw_semaphore *rwsem, const char *name,
+			  struct lock_class_key *key);
+#else
+static inline void  __rwsem_init(struct rw_semaphore *rwsem, const char *nam=
e,
+				 struct lock_class_key *key)
+{
+}
+#endif
+
+#define init_rwsem(sem)						\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	init_rwbase_rt(&(sem)->rwbase);			\
+	__rwsem_init((sem), #sem, &__key);			\
+} while (0)
+
+static __always_inline int rwsem_is_locked(struct rw_semaphore *sem)
+{
+	return rw_base_is_locked(&sem->rwbase);
+}
+
+static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
+{
+	return rw_base_is_contended(&sem->rwbase);
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
+/*
+ * The functions below are the same for all rwsem implementations including
+ * the RT specific variant.
+ */
+
 /*
  * lock for reading
  */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ec8d07d88641..746dfc06a35c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -95,7 +95,9 @@ struct task_group;
 #define TASK_WAKING			0x0200
 #define TASK_NOLOAD			0x0400
 #define TASK_NEW			0x0800
-#define TASK_STATE_MAX			0x1000
+/* RT specific auxilliary flag to mark RT lock waiters */
+#define TASK_RTLOCK_WAIT		0x1000
+#define TASK_STATE_MAX			0x2000
=20
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
@@ -121,8 +123,6 @@ struct task_group;
=20
 #define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK=
_STOPPED | __TASK_TRACED)) !=3D 0)
=20
-#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-
 /*
  * Special states are those that do not use the normal wait-loop pattern. See
  * the comment with set_special_state().
@@ -130,30 +130,37 @@ struct task_group;
 #define is_special_task_state(state)				\
 	((state) & (__TASK_STOPPED | __TASK_TRACED | TASK_PARKED | TASK_DEAD))
=20
-#define __set_current_state(state_value)			\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->task_state_change =3D _THIS_IP_;		\
-		WRITE_ONCE(current->__state, (state_value));	\
-	} while (0)
-
-#define set_current_state(state_value)				\
-	do {							\
-		WARN_ON_ONCE(is_special_task_state(state_value));\
-		current->task_state_change =3D _THIS_IP_;		\
-		smp_store_mb(current->__state, (state_value));	\
+#ifdef CONFIG_DEBUG_ATOMIC_SLEEP
+# define debug_normal_state_change(state_value)				\
+	do {								\
+		WARN_ON_ONCE(is_special_task_state(state_value));	\
+		current->task_state_change =3D _THIS_IP_;			\
 	} while (0)
=20
-#define set_special_state(state_value)					\
+# define debug_special_state_change(state_value)			\
 	do {								\
-		unsigned long flags; /* may shadow */			\
 		WARN_ON_ONCE(!is_special_task_state(state_value));	\
-		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
 		current->task_state_change =3D _THIS_IP_;			\
-		WRITE_ONCE(current->__state, (state_value));		\
-		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
+
+# define debug_rtlock_wait_set_state()					\
+	do {								 \
+		current->saved_state_change =3D current->task_state_change;\
+		current->task_state_change =3D _THIS_IP_;			 \
+	} while (0)
+
+# define debug_rtlock_wait_restore_state()				\
+	do {								 \
+		current->task_state_change =3D current->saved_state_change;\
+	} while (0)
+
 #else
+# define debug_normal_state_change(cond)	do { } while (0)
+# define debug_special_state_change(cond)	do { } while (0)
+# define debug_rtlock_wait_set_state()		do { } while (0)
+# define debug_rtlock_wait_restore_state()	do { } while (0)
+#endif
+
 /*
  * set_current_state() includes a barrier so that the write of current->state
  * is correctly serialised wrt the caller's subsequent test of whether to
@@ -192,26 +199,77 @@ struct task_group;
  * Also see the comments of try_to_wake_up().
  */
 #define __set_current_state(state_value)				\
-	WRITE_ONCE(current->__state, (state_value))
+	do {								\
+		debug_normal_state_change((state_value));		\
+		WRITE_ONCE(current->__state, (state_value));		\
+	} while (0)
=20
 #define set_current_state(state_value)					\
-	smp_store_mb(current->__state, (state_value))
+	do {								\
+		debug_normal_state_change((state_value));		\
+		smp_store_mb(current->__state, (state_value));		\
+	} while (0)
=20
 /*
  * set_special_state() should be used for those states when the blocking task
  * can not use the regular condition based wait-loop. In that case we must
- * serialize against wakeups such that any possible in-flight TASK_RUNNING s=
tores
- * will not collide with our state change.
+ * serialize against wakeups such that any possible in-flight TASK_RUNNING
+ * stores will not collide with our state change.
  */
 #define set_special_state(state_value)					\
 	do {								\
 		unsigned long flags; /* may shadow */			\
+									\
 		raw_spin_lock_irqsave(&current->pi_lock, flags);	\
+		debug_special_state_change((state_value));		\
 		WRITE_ONCE(current->__state, (state_value));		\
 		raw_spin_unlock_irqrestore(&current->pi_lock, flags);	\
 	} while (0)
=20
-#endif
+/*
+ * PREEMPT_RT specific variants for "sleeping" spin/rwlocks
+ *
+ * RT's spin/rwlock substitutions are state preserving. The state of the
+ * task when blocking on the lock is saved in task_struct::saved_state and
+ * restored after the lock has been acquired.  These operations are
+ * serialized by task_struct::pi_lock against try_to_wake_up(). Any non RT
+ * lock related wakeups while the task is blocked on the lock are
+ * redirected to operate on task_struct::saved_state to ensure that these
+ * are not dropped. On restore task_struct::saved_state is set to
+ * TASK_RUNNING so any wakeup attempt redirected to saved_state will fail.
+ *
+ * The lock operation looks like this:
+ *
+ *	current_save_and_set_rtlock_wait_state();
+ *	for (;;) {
+ *		if (try_lock())
+ *			break;
+ *		raw_spin_unlock_irq(&lock->wait_lock);
+ *		schedule_rtlock();
+ *		raw_spin_lock_irq(&lock->wait_lock);
+ *		set_current_state(TASK_RTLOCK_WAIT);
+ *	}
+ *	current_restore_rtlock_saved_state();
+ */
+#define current_save_and_set_rtlock_wait_state()			\
+	do {								\
+		lockdep_assert_irqs_disabled();				\
+		raw_spin_lock(&current->pi_lock);			\
+		current->saved_state =3D current->__state;		\
+		debug_rtlock_wait_set_state();				\
+		WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT);		\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
+
+#define current_restore_rtlock_saved_state()				\
+	do {								\
+		lockdep_assert_irqs_disabled();				\
+		raw_spin_lock(&current->pi_lock);			\
+		debug_rtlock_wait_restore_state();			\
+		WRITE_ONCE(current->__state, current->saved_state);	\
+		current->saved_state =3D TASK_RUNNING;			\
+		raw_spin_unlock(&current->pi_lock);			\
+	} while (0);
=20
 #define get_current_state()	READ_ONCE(current->__state)
=20
@@ -230,6 +288,9 @@ extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
+#ifdef CONFIG_PREEMPT_RT
+ extern void schedule_rtlock(void);
+#endif
=20
 extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
@@ -668,6 +729,11 @@ struct task_struct {
 #endif
 	unsigned int			__state;
=20
+#ifdef CONFIG_PREEMPT_RT
+	/* saved state for "spinlock sleepers" */
+	unsigned int			saved_state;
+#endif
+
 	/*
 	 * This begins the randomizable portion of task_struct. Only
 	 * scheduling-critical items should be added above here.
@@ -1357,6 +1423,9 @@ struct task_struct {
 	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
+# ifdef CONFIG_PREEMPT_RT
+	unsigned long			saved_state_change;
+# endif
 #endif
 	int				pagefault_disabled;
 #ifdef CONFIG_MMU
diff --git a/include/linux/sched/wake_q.h b/include/linux/sched/wake_q.h
index 26a2013ac39c..06cd8fb2f409 100644
--- a/include/linux/sched/wake_q.h
+++ b/include/linux/sched/wake_q.h
@@ -42,8 +42,11 @@ struct wake_q_head {
=20
 #define WAKE_Q_TAIL ((struct wake_q_node *) 0x01)
=20
-#define DEFINE_WAKE_Q(name)				\
-	struct wake_q_head name =3D { WAKE_Q_TAIL, &name.first }
+#define WAKE_Q_HEAD_INITIALIZER(name)				\
+	{ WAKE_Q_TAIL, &name.first }
+
+#define DEFINE_WAKE_Q(name)					\
+	struct wake_q_head name =3D WAKE_Q_HEAD_INITIALIZER(name)
=20
 static inline void wake_q_init(struct wake_q_head *head)
 {
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 79897841a2cc..45310ea1b1d7 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -12,6 +12,8 @@
  *  asm/spinlock_types.h: contains the arch_spinlock_t/arch_rwlock_t and the
  *                        initializers
  *
+ *  linux/spinlock_types_raw:
+ *			  The raw types and initializers
  *  linux/spinlock_types.h:
  *                        defines the generic type and initializers
  *
@@ -31,6 +33,8 @@
  *                        contains the generic, simplified UP spinlock type.
  *                        (which is an empty structure on non-debug builds)
  *
+ *  linux/spinlock_types_raw:
+ *			  The raw RT types and initializers
  *  linux/spinlock_types.h:
  *                        defines the generic type and initializers
  *
@@ -308,8 +312,10 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lo=
ck) __releases(lock)
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
=20
-/* Include rwlock functions */
+#ifndef CONFIG_PREEMPT_RT
+/* Include rwlock functions for !RT */
 #include <linux/rwlock.h>
+#endif
=20
 /*
  * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
@@ -320,6 +326,9 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *loc=
k) __releases(lock)
 # include <linux/spinlock_api_up.h>
 #endif
=20
+/* Non PREEMPT_RT kernel, map to raw spinlocks: */
+#ifndef CONFIG_PREEMPT_RT
+
 /*
  * Map the spin_lock functions to the raw variants for PREEMPT_RT=3Dn
  */
@@ -454,6 +463,10 @@ static __always_inline int spin_is_contended(spinlock_t =
*lock)
=20
 #define assert_spin_locked(lock)	assert_raw_spin_locked(&(lock)->rlock)
=20
+#else  /* !CONFIG_PREEMPT_RT */
+# include <linux/spinlock_rt.h>
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * Pull the atomic_t declaration:
  * (asm-mips/atomic.h needs above definitions)
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_sm=
p.h
index 19a9be9d97ee..6b8e1a0b137b 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -187,6 +187,9 @@ static inline int __raw_spin_trylock_bh(raw_spinlock_t *l=
ock)
 	return 0;
 }
=20
+/* PREEMPT_RT has its own rwlock implementation */
+#ifndef CONFIG_PREEMPT_RT
 #include <linux/rwlock_api_smp.h>
+#endif
=20
 #endif /* __LINUX_SPINLOCK_API_SMP_H */
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
new file mode 100644
index 000000000000..835aedaf68ac
--- /dev/null
+++ b/include/linux/spinlock_rt.h
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef __LINUX_SPINLOCK_RT_H
+#define __LINUX_SPINLOCK_RT_H
+
+#ifndef __LINUX_SPINLOCK_H
+#error Do not include directly. Use spinlock.h
+#endif
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+				struct lock_class_key *key, bool percpu);
+#else
+static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+				struct lock_class_key *key, bool percpu)
+{
+}
+#endif
+
+#define spin_lock_init(slock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, false);	\
+} while (0)
+
+#define local_spin_lock_init(slock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	rt_mutex_base_init(&(slock)->lock);			\
+	__rt_spin_lock_init(slock, #slock, &__key, true);	\
+} while (0)
+
+extern void rt_spin_lock(spinlock_t *lock);
+extern void rt_spin_lock_nested(spinlock_t *lock, int subclass);
+extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nes=
t_lock);
+extern void rt_spin_unlock(spinlock_t *lock);
+extern void rt_spin_lock_unlock(spinlock_t *lock);
+extern int rt_spin_trylock_bh(spinlock_t *lock);
+extern int rt_spin_trylock(spinlock_t *lock);
+
+static __always_inline void spin_lock(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
+#ifdef CONFIG_LOCKDEP
+# define __spin_lock_nested(lock, subclass)				\
+	rt_spin_lock_nested(lock, subclass)
+
+# define __spin_lock_nest_lock(lock, nest_lock)				\
+	do {								\
+		typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
+		rt_spin_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+	} while (0)
+# define __spin_lock_irqsave_nested(lock, flags, subclass)	\
+	do {							\
+		typecheck(unsigned long, flags);		\
+		flags =3D 0;					\
+		__spin_lock_nested(lock, subclass);		\
+	} while (0)
+
+#else
+ /*
+  * Always evaluate the 'subclass' argument to avoid that the compiler
+  * warns about set-but-not-used variables when building with
+  * CONFIG_DEBUG_LOCK_ALLOC=3Dn and with W=3D1.
+  */
+# define __spin_lock_nested(lock, subclass)	spin_lock(((void)(subclass), (lo=
ck)))
+# define __spin_lock_nest_lock(lock, subclass)	spin_lock(((void)(subclass), =
(lock)))
+# define __spin_lock_irqsave_nested(lock, flags, subclass)	\
+	spin_lock_irqsave(((void)(subclass), (lock)), flags)
+#endif
+
+#define spin_lock_nested(lock, subclass)		\
+	__spin_lock_nested(lock, subclass)
+
+#define spin_lock_nest_lock(lock, nest_lock)		\
+	__spin_lock_nest_lock(lock, nest_lock)
+
+#define spin_lock_irqsave_nested(lock, flags, subclass)	\
+	__spin_lock_irqsave_nested(lock, flags, subclass)
+
+static __always_inline void spin_lock_bh(spinlock_t *lock)
+{
+	/* Investigate: Drop bh when blocking ? */
+	local_bh_disable();
+	rt_spin_lock(lock);
+}
+
+static __always_inline void spin_lock_irq(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
+#define spin_lock_irqsave(lock, flags)			 \
+	do {						 \
+		typecheck(unsigned long, flags);	 \
+		flags =3D 0;				 \
+		spin_lock(lock);			 \
+	} while (0)
+
+static __always_inline void spin_unlock(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
+static __always_inline void spin_unlock_bh(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+	local_bh_enable();
+}
+
+static __always_inline void spin_unlock_irq(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
+static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
+						   unsigned long flags)
+{
+	rt_spin_unlock(lock);
+}
+
+#define spin_trylock(lock)				\
+	__cond_lock(lock, rt_spin_trylock(lock))
+
+#define spin_trylock_bh(lock)				\
+	__cond_lock(lock, rt_spin_trylock_bh(lock))
+
+#define spin_trylock_irq(lock)				\
+	__cond_lock(lock, rt_spin_trylock(lock))
+
+#define __spin_trylock_irqsave(lock, flags)		\
+({							\
+	int __locked;					\
+							\
+	typecheck(unsigned long, flags);		\
+	flags =3D 0;					\
+	__locked =3D spin_trylock(lock);			\
+	__locked;					\
+})
+
+#define spin_trylock_irqsave(lock, flags)		\
+	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
+
+#define spin_is_contended(lock)		(((void)(lock), 0))
+
+static inline int spin_is_locked(spinlock_t *lock)
+{
+	return rt_mutex_base_is_locked(&lock->lock);
+}
+
+#define assert_spin_locked(lock) BUG_ON(!spin_is_locked(lock))
+
+#include <linux/rwlock_rt.h>
+
+#endif
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index b981caafe8bf..2dfa35ffec76 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -9,65 +9,11 @@
  * Released under the General Public License (GPL).
  */
=20
-#if defined(CONFIG_SMP)
-# include <asm/spinlock_types.h>
-#else
-# include <linux/spinlock_types_up.h>
-#endif
-
-#include <linux/lockdep_types.h>
+#include <linux/spinlock_types_raw.h>
=20
-typedef struct raw_spinlock {
-	arch_spinlock_t raw_lock;
-#ifdef CONFIG_DEBUG_SPINLOCK
-	unsigned int magic, owner_cpu;
-	void *owner;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} raw_spinlock_t;
-
-#define SPINLOCK_MAGIC		0xdead4ead
-
-#define SPINLOCK_OWNER_INIT	((void *)-1L)
-
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
-	.dep_map =3D {					\
-		.name =3D #lockname,			\
-		.wait_type_inner =3D LD_WAIT_SPIN,	\
-	}
-# define SPIN_DEP_MAP_INIT(lockname)			\
-	.dep_map =3D {					\
-		.name =3D #lockname,			\
-		.wait_type_inner =3D LD_WAIT_CONFIG,	\
-	}
-#else
-# define RAW_SPIN_DEP_MAP_INIT(lockname)
-# define SPIN_DEP_MAP_INIT(lockname)
-#endif
-
-#ifdef CONFIG_DEBUG_SPINLOCK
-# define SPIN_DEBUG_INIT(lockname)		\
-	.magic =3D SPINLOCK_MAGIC,		\
-	.owner_cpu =3D -1,			\
-	.owner =3D SPINLOCK_OWNER_INIT,
-#else
-# define SPIN_DEBUG_INIT(lockname)
-#endif
-
-#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
-	{					\
-	.raw_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,	\
-	SPIN_DEBUG_INIT(lockname)		\
-	RAW_SPIN_DEP_MAP_INIT(lockname) }
-
-#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
-
-#define DEFINE_RAW_SPINLOCK(x)	raw_spinlock_t x =3D __RAW_SPIN_LOCK_UNLOCKED=
(x)
+#ifndef CONFIG_PREEMPT_RT
=20
+/* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
 typedef struct spinlock {
 	union {
 		struct raw_spinlock rlock;
@@ -96,6 +42,35 @@ typedef struct spinlock {
=20
 #define DEFINE_SPINLOCK(x)	spinlock_t x =3D __SPIN_LOCK_UNLOCKED(x)
=20
+#else /* !CONFIG_PREEMPT_RT */
+
+/* PREEMPT_RT kernels map spinlock to rt_mutex */
+#include <linux/rtmutex.h>
+
+typedef struct spinlock {
+	struct rt_mutex_base	lock;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+} spinlock_t;
+
+#define __SPIN_LOCK_UNLOCKED(name)				\
+	{							\
+		.lock =3D __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		SPIN_DEP_MAP_INIT(name)				\
+	}
+
+#define __LOCAL_SPIN_LOCK_UNLOCKED(name)			\
+	{							\
+		.lock =3D __RT_MUTEX_BASE_INITIALIZER(name.lock),	\
+		LOCAL_SPIN_DEP_MAP_INIT(name)			\
+	}
+
+#define DEFINE_SPINLOCK(name)					\
+	spinlock_t name =3D __SPIN_LOCK_UNLOCKED(name)
+
+#endif /* CONFIG_PREEMPT_RT */
+
 #include <linux/rwlock_types.h>
=20
 #endif /* __LINUX_SPINLOCK_TYPES_H */
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_type=
s_raw.h
new file mode 100644
index 000000000000..91cb36b65a17
--- /dev/null
+++ b/include/linux/spinlock_types_raw.h
@@ -0,0 +1,73 @@
+#ifndef __LINUX_SPINLOCK_TYPES_RAW_H
+#define __LINUX_SPINLOCK_TYPES_RAW_H
+
+#include <linux/types.h>
+
+#if defined(CONFIG_SMP)
+# include <asm/spinlock_types.h>
+#else
+# include <linux/spinlock_types_up.h>
+#endif
+
+#include <linux/lockdep_types.h>
+
+typedef struct raw_spinlock {
+	arch_spinlock_t raw_lock;
+#ifdef CONFIG_DEBUG_SPINLOCK
+	unsigned int magic, owner_cpu;
+	void *owner;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} raw_spinlock_t;
+
+#define SPINLOCK_MAGIC		0xdead4ead
+
+#define SPINLOCK_OWNER_INIT	((void *)-1L)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define RAW_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map =3D {					\
+		.name =3D #lockname,			\
+		.wait_type_inner =3D LD_WAIT_SPIN,	\
+	}
+# define SPIN_DEP_MAP_INIT(lockname)			\
+	.dep_map =3D {					\
+		.name =3D #lockname,			\
+		.wait_type_inner =3D LD_WAIT_CONFIG,	\
+	}
+
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
+	.dep_map =3D {					\
+		.name =3D #lockname,			\
+		.wait_type_inner =3D LD_WAIT_CONFIG,	\
+		.lock_type =3D LD_LOCK_PERCPU,		\
+	}
+#else
+# define RAW_SPIN_DEP_MAP_INIT(lockname)
+# define SPIN_DEP_MAP_INIT(lockname)
+# define LOCAL_SPIN_DEP_MAP_INIT(lockname)
+#endif
+
+#ifdef CONFIG_DEBUG_SPINLOCK
+# define SPIN_DEBUG_INIT(lockname)		\
+	.magic =3D SPINLOCK_MAGIC,		\
+	.owner_cpu =3D -1,			\
+	.owner =3D SPINLOCK_OWNER_INIT,
+#else
+# define SPIN_DEBUG_INIT(lockname)
+#endif
+
+#define __RAW_SPIN_LOCK_INITIALIZER(lockname)	\
+{						\
+	.raw_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,	\
+	SPIN_DEBUG_INIT(lockname)		\
+	RAW_SPIN_DEP_MAP_INIT(lockname) }
+
+#define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
+	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
+
+#define DEFINE_RAW_SPINLOCK(x)  raw_spinlock_t x =3D __RAW_SPIN_LOCK_UNLOCKE=
D(x)
+
+#endif /* __LINUX_SPINLOCK_TYPES_RAW_H */
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index fc94faa53b5b..3e56a9751c06 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -17,11 +17,17 @@
  *   DECLARE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL(name, func);
  *   DEFINE_STATIC_CALL_NULL(name, typename);
+ *   DEFINE_STATIC_CALL_RET0(name, typename);
+ *
+ *   __static_call_return0;
+ *
  *   static_call(name)(args...);
  *   static_call_cond(name)(args...);
  *   static_call_update(name, func);
  *   static_call_query(name);
  *
+ *   EXPORT_STATIC_CALL{,_TRAMP}{,_GPL}()
+ *
  * Usage example:
  *
  *   # Start with the following functions (with identical prototypes):
@@ -96,6 +102,33 @@
  *   To query which function is currently set to be called, use:
  *
  *   func =3D static_call_query(name);
+ *
+ *
+ * DEFINE_STATIC_CALL_RET0 / __static_call_return0:
+ *
+ *   Just like how DEFINE_STATIC_CALL_NULL() / static_call_cond() optimize t=
he
+ *   conditional void function call, DEFINE_STATIC_CALL_RET0 /
+ *   __static_call_return0 optimize the do nothing return 0 function.
+ *
+ *   This feature is strictly UB per the C standard (since it casts a functi=
on
+ *   pointer to a different signature) and relies on the architecture ABI to
+ *   make things work. In particular it relies on Caller Stack-cleanup and t=
he
+ *   whole return register being clobbered for short return values. All norm=
al
+ *   CDECL style ABIs conform.
+ *
+ *   In particular the x86_64 implementation replaces the 5 byte CALL
+ *   instruction at the callsite with a 5 byte clear of the RAX register,
+ *   completely eliding any function call overhead.
+ *
+ *   Notably argument setup is unconditional.
+ *
+ *
+ * EXPORT_STATIC_CALL() vs EXPORT_STATIC_CALL_TRAMP():
+ *
+ *   The difference is that the _TRAMP variant tries to only export the
+ *   trampoline with the result that a module can use static_call{,_cond}() =
but
+ *   not static_call_update().
+ *
  */
=20
 #include <linux/types.h>
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index b77f39f319ad..29db736af86d 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -18,6 +18,24 @@
 #define __LINUX_WW_MUTEX_H
=20
 #include <linux/mutex.h>
+#include <linux/rtmutex.h>
+
+#if defined(CONFIG_DEBUG_MUTEXES) || \
+   (defined(CONFIG_PREEMPT_RT) && defined(CONFIG_DEBUG_RT_MUTEXES))
+#define DEBUG_WW_MUTEXES
+#endif
+
+#ifndef CONFIG_PREEMPT_RT
+#define WW_MUTEX_BASE			mutex
+#define ww_mutex_base_init(l,n,k)	__mutex_init(l,n,k)
+#define ww_mutex_base_trylock(l)	mutex_trylock(l)
+#define ww_mutex_base_is_locked(b)	mutex_is_locked((b))
+#else
+#define WW_MUTEX_BASE			rt_mutex
+#define ww_mutex_base_init(l,n,k)	__rt_mutex_init(l,n,k)
+#define ww_mutex_base_trylock(l)	rt_mutex_trylock(l)
+#define ww_mutex_base_is_locked(b)	rt_mutex_base_is_locked(&(b)->rtmutex)
+#endif
=20
 struct ww_class {
 	atomic_long_t stamp;
@@ -28,16 +46,24 @@ struct ww_class {
 	unsigned int is_wait_die;
 };
=20
+struct ww_mutex {
+	struct WW_MUTEX_BASE base;
+	struct ww_acquire_ctx *ctx;
+#ifdef DEBUG_WW_MUTEXES
+	struct ww_class *ww_class;
+#endif
+};
+
 struct ww_acquire_ctx {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned int acquired;
 	unsigned short wounded;
 	unsigned short is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	unsigned int done_acquire;
 	struct ww_class *ww_class;
-	struct ww_mutex *contending_lock;
+	void *contending_lock;
 #endif
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
@@ -74,9 +100,9 @@ struct ww_acquire_ctx {
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
 {
-	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
+	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx =3D NULL;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lock->ww_class =3D ww_class;
 #endif
 }
@@ -113,7 +139,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx =
*ctx,
 	ctx->acquired =3D 0;
 	ctx->wounded =3D false;
 	ctx->is_wait_die =3D ww_class->is_wait_die;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	ctx->ww_class =3D ww_class;
 	ctx->done_acquire =3D 0;
 	ctx->contending_lock =3D NULL;
@@ -143,7 +169,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx =
*ctx,
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
=20
 	DEBUG_LOCKS_WARN_ON(ctx->done_acquire);
@@ -163,7 +189,7 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx =
*ctx)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->dep_map, _THIS_IP_);
 #endif
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
 		/*
@@ -269,7 +295,7 @@ static inline void
 ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	int ret;
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	ret =3D ww_mutex_lock(lock, ctx);
@@ -305,7 +331,7 @@ static inline int __must_check
 ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 				 struct ww_acquire_ctx *ctx)
 {
-#ifdef CONFIG_DEBUG_MUTEXES
+#ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
 #endif
 	return ww_mutex_lock_interruptible(lock, ctx);
@@ -322,7 +348,7 @@ extern void ww_mutex_unlock(struct ww_mutex *lock);
  */
 static inline int __must_check ww_mutex_trylock(struct ww_mutex *lock)
 {
-	return mutex_trylock(&lock->base);
+	return ww_mutex_base_trylock(&lock->base);
 }
=20
 /***
@@ -335,7 +361,9 @@ static inline int __must_check ww_mutex_trylock(struct ww=
_mutex *lock)
  */
 static inline void ww_mutex_destroy(struct ww_mutex *lock)
 {
+#ifndef CONFIG_PREEMPT_RT
 	mutex_destroy(&lock->base);
+#endif
 }
=20
 /**
@@ -346,7 +374,7 @@ static inline void ww_mutex_destroy(struct ww_mutex *lock)
  */
 static inline bool ww_mutex_is_locked(struct ww_mutex *lock)
 {
-	return mutex_is_locked(&lock->base);
+	return ww_mutex_base_is_locked(&lock->base);
 }
=20
 #endif
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..4198f0273ecd 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,7 +251,7 @@ config ARCH_USE_QUEUED_RWLOCKS
=20
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
-	depends on SMP
+	depends on SMP && !PREEMPT_RT
=20
 config ARCH_HAS_MMIOWB
 	bool
diff --git a/kernel/futex.c b/kernel/futex.c
index 2ecb07575055..e7b4c6121da4 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -179,7 +179,7 @@ struct futex_pi_state {
 	/*
 	 * The PI object:
 	 */
-	struct rt_mutex pi_mutex;
+	struct rt_mutex_base pi_mutex;
=20
 	struct task_struct *owner;
 	refcount_t refcount;
@@ -197,6 +197,8 @@ struct futex_pi_state {
  * @rt_waiter:		rt_waiter storage for use with requeue_pi
  * @requeue_pi_key:	the requeue_pi target futex key
  * @bitset:		bitset for the optional bitmasked wakeup
+ * @requeue_state:	State field for futex_requeue_pi()
+ * @requeue_wait:	RCU wait for futex_requeue_pi() (RT only)
  *
  * We use this hashed waitqueue, instead of a normal wait_queue_entry_t, so
  * we can wake only the relevant ones (hashed queues may be shared).
@@ -219,12 +221,68 @@ struct futex_q {
 	struct rt_mutex_waiter *rt_waiter;
 	union futex_key *requeue_pi_key;
 	u32 bitset;
+	atomic_t requeue_state;
+#ifdef CONFIG_PREEMPT_RT
+	struct rcuwait requeue_wait;
+#endif
 } __randomize_layout;
=20
+/*
+ * On PREEMPT_RT, the hash bucket lock is a 'sleeping' spinlock with an
+ * underlying rtmutex. The task which is about to be requeued could have
+ * just woken up (timeout, signal). After the wake up the task has to
+ * acquire hash bucket lock, which is held by the requeue code.  As a task
+ * can only be blocked on _ONE_ rtmutex at a time, the proxy lock blocking
+ * and the hash bucket lock blocking would collide and corrupt state.
+ *
+ * On !PREEMPT_RT this is not a problem and everything could be serialized
+ * on hash bucket lock, but aside of having the benefit of common code,
+ * this allows to avoid doing the requeue when the task is already on the
+ * way out and taking the hash bucket lock of the original uaddr1 when the
+ * requeue has been completed.
+ *
+ * The following state transitions are valid:
+ *
+ * On the waiter side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_IGNORE
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_WAIT
+ *
+ * On the requeue side:
+ *   Q_REQUEUE_PI_NONE		-> Q_REQUEUE_PI_INPROGRESS
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_IN_PROGRESS	-> Q_REQUEUE_PI_NONE (requeue failed)
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_DONE/LOCKED
+ *   Q_REQUEUE_PI_WAIT		-> Q_REQUEUE_PI_IGNORE (requeue failed)
+ *
+ * The requeue side ignores a waiter with state Q_REQUEUE_PI_IGNORE as this
+ * signals that the waiter is already on the way out. It also means that
+ * the waiter is still on the 'wait' futex, i.e. uaddr1.
+ *
+ * The waiter side signals early wakeup to the requeue side either through
+ * setting state to Q_REQUEUE_PI_IGNORE or to Q_REQUEUE_PI_WAIT depending
+ * on the current state. In case of Q_REQUEUE_PI_IGNORE it can immediately
+ * proceed to take the hash bucket lock of uaddr1. If it set state to WAIT,
+ * which means the wakeup is interleaving with a requeue in progress it has
+ * to wait for the requeue side to change the state. Either to DONE/LOCKED
+ * or to IGNORE. DONE/LOCKED means the waiter q is now on the uaddr2 futex
+ * and either blocked (DONE) or has acquired it (LOCKED). IGNORE is set by
+ * the requeue side when the requeue attempt failed via deadlock detection
+ * and therefore the waiter q is still on the uaddr1 futex.
+ */
+enum {
+	Q_REQUEUE_PI_NONE		=3D  0,
+	Q_REQUEUE_PI_IGNORE,
+	Q_REQUEUE_PI_IN_PROGRESS,
+	Q_REQUEUE_PI_WAIT,
+	Q_REQUEUE_PI_DONE,
+	Q_REQUEUE_PI_LOCKED,
+};
+
 static const struct futex_q futex_q_init =3D {
 	/* list gets initialized in queue_me()*/
-	.key =3D FUTEX_KEY_INIT,
-	.bitset =3D FUTEX_BITSET_MATCH_ANY
+	.key		=3D FUTEX_KEY_INIT,
+	.bitset		=3D FUTEX_BITSET_MATCH_ANY,
+	.requeue_state	=3D ATOMIC_INIT(Q_REQUEUE_PI_NONE),
 };
=20
 /*
@@ -1299,27 +1357,6 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 u=
val, union futex_key *key,
 	return 0;
 }
=20
-static int lookup_pi_state(u32 __user *uaddr, u32 uval,
-			   struct futex_hash_bucket *hb,
-			   union futex_key *key, struct futex_pi_state **ps,
-			   struct task_struct **exiting)
-{
-	struct futex_q *top_waiter =3D futex_top_waiter(hb, key);
-
-	/*
-	 * If there is a waiter on that futex, validate it and
-	 * attach to the pi_state when the validation succeeds.
-	 */
-	if (top_waiter)
-		return attach_to_pi_state(uaddr, uval, top_waiter->pi_state, ps);
-
-	/*
-	 * We are the first waiter - try to look up the owner based on
-	 * @uval and attach to it.
-	 */
-	return attach_to_pi_owner(uaddr, uval, key, ps, exiting);
-}
-
 static int lock_pi_update_atomic(u32 __user *uaddr, u32 uval, u32 newval)
 {
 	int err;
@@ -1354,7 +1391,7 @@ static int lock_pi_update_atomic(u32 __user *uaddr, u32=
 uval, u32 newval)
  *  -  1 - acquired the lock;
  *  - <0 - error
  *
- * The hb->lock and futex_key refs shall be held by the caller.
+ * The hb->lock must be held by the caller.
  *
  * @exiting is only set when the return value is -EBUSY. If so, this holds
  * a refcount on the exiting task on return and the caller needs to drop it
@@ -1493,11 +1530,11 @@ static void mark_wake_futex(struct wake_q_head *wake_=
q, struct futex_q *q)
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state =
*pi_state)
 {
-	u32 curval, newval;
 	struct rt_mutex_waiter *top_waiter;
 	struct task_struct *new_owner;
 	bool postunlock =3D false;
-	DEFINE_WAKE_Q(wake_q);
+	DEFINE_RT_WAKE_Q(wqh);
+	u32 curval, newval;
 	int ret =3D 0;
=20
 	top_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
@@ -1549,14 +1586,14 @@ static int wake_futex_pi(u32 __user *uaddr, u32 uval,=
 struct futex_pi_state *pi_
 		 * not fail.
 		 */
 		pi_state_update_owner(pi_state, new_owner);
-		postunlock =3D __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wake_q);
+		postunlock =3D __rt_mutex_futex_unlock(&pi_state->pi_mutex, &wqh);
 	}
=20
 out_unlock:
 	raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
=20
 	if (postunlock)
-		rt_mutex_postunlock(&wake_q);
+		rt_mutex_postunlock(&wqh);
=20
 	return ret;
 }
@@ -1793,6 +1830,108 @@ void requeue_futex(struct futex_q *q, struct futex_ha=
sh_bucket *hb1,
 	q->key =3D *key2;
 }
=20
+static inline bool futex_requeue_pi_prepare(struct futex_q *q,
+					    struct futex_pi_state *pi_state)
+{
+	int old, new;
+
+	/*
+	 * Set state to Q_REQUEUE_PI_IN_PROGRESS unless an early wakeup has
+	 * already set Q_REQUEUE_PI_IGNORE to signal that requeue should
+	 * ignore the waiter.
+	 */
+	old =3D atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old =3D=3D Q_REQUEUE_PI_IGNORE)
+			return false;
+
+		/*
+		 * futex_proxy_trylock_atomic() might have set it to
+		 * IN_PROGRESS and a interleaved early wake to WAIT.
+		 *
+		 * It was considered to have an extra state for that
+		 * trylock, but that would just add more conditionals
+		 * all over the place for a dubious value.
+		 */
+		if (old !=3D Q_REQUEUE_PI_NONE)
+			break;
+
+		new =3D Q_REQUEUE_PI_IN_PROGRESS;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	q->pi_state =3D pi_state;
+	return true;
+}
+
+static inline void futex_requeue_pi_complete(struct futex_q *q, int locked)
+{
+	int old, new;
+
+	old =3D atomic_read_acquire(&q->requeue_state);
+	do {
+		if (old =3D=3D Q_REQUEUE_PI_IGNORE)
+			return;
+
+		if (locked >=3D 0) {
+			/* Requeue succeeded. Set DONE or LOCKED */
+			WARN_ON_ONCE(old !=3D Q_REQUEUE_PI_IN_PROGRESS &&
+				     old !=3D Q_REQUEUE_PI_WAIT);
+			new =3D Q_REQUEUE_PI_DONE + locked;
+		} else if (old =3D=3D Q_REQUEUE_PI_IN_PROGRESS) {
+			/* Deadlock, no early wakeup interleave */
+			new =3D Q_REQUEUE_PI_NONE;
+		} else {
+			/* Deadlock, early wakeup interleave. */
+			WARN_ON_ONCE(old !=3D Q_REQUEUE_PI_WAIT);
+			new =3D Q_REQUEUE_PI_IGNORE;
+		}
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+#ifdef CONFIG_PREEMPT_RT
+	/* If the waiter interleaved with the requeue let it know */
+	if (unlikely(old =3D=3D Q_REQUEUE_PI_WAIT))
+		rcuwait_wake_up(&q->requeue_wait);
+#endif
+}
+
+static inline int futex_requeue_pi_wakeup_sync(struct futex_q *q)
+{
+	int old, new;
+
+	old =3D atomic_read_acquire(&q->requeue_state);
+	do {
+		/* Is requeue done already? */
+		if (old >=3D Q_REQUEUE_PI_DONE)
+			return old;
+
+		/*
+		 * If not done, then tell the requeue code to either ignore
+		 * the waiter or to wake it up once the requeue is done.
+		 */
+		new =3D Q_REQUEUE_PI_WAIT;
+		if (old =3D=3D Q_REQUEUE_PI_NONE)
+			new =3D Q_REQUEUE_PI_IGNORE;
+	} while (!atomic_try_cmpxchg(&q->requeue_state, &old, new));
+
+	/* If the requeue was in progress, wait for it to complete */
+	if (old =3D=3D Q_REQUEUE_PI_IN_PROGRESS) {
+#ifdef CONFIG_PREEMPT_RT
+		rcuwait_wait_event(&q->requeue_wait,
+				   atomic_read(&q->requeue_state) !=3D Q_REQUEUE_PI_WAIT,
+				   TASK_UNINTERRUPTIBLE);
+#else
+		(void)atomic_cond_read_relaxed(&q->requeue_state, VAL !=3D Q_REQUEUE_PI_WA=
IT);
+#endif
+	}
+
+	/*
+	 * Requeue is now either prohibited or complete. Reread state
+	 * because during the wait above it might have changed. Nothing
+	 * will modify q->requeue_state after this point.
+	 */
+	return atomic_read(&q->requeue_state);
+}
+
 /**
  * requeue_pi_wake_futex() - Wake a task that acquired the lock during reque=
ue
  * @q:		the futex_q
@@ -1820,6 +1959,8 @@ void requeue_pi_wake_futex(struct futex_q *q, union fut=
ex_key *key,
=20
 	q->lock_ptr =3D &hb->lock;
=20
+	/* Signal locked state to the waiter */
+	futex_requeue_pi_complete(q, 1);
 	wake_up_state(q->task, TASK_NORMAL);
 }
=20
@@ -1879,10 +2020,21 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struc=
t futex_hash_bucket *hb1,
 	if (!top_waiter)
 		return 0;
=20
+	/*
+	 * Ensure that this is a waiter sitting in futex_wait_requeue_pi()
+	 * and waiting on the 'waitqueue' futex which is always !PI.
+	 */
+	if (!top_waiter->rt_waiter || top_waiter->pi_state)
+		ret =3D -EINVAL;
+
 	/* Ensure we requeue to the expected futex. */
 	if (!match_futex(top_waiter->requeue_pi_key, key2))
 		return -EINVAL;
=20
+	/* Ensure that this does not race against an early wakeup */
+	if (!futex_requeue_pi_prepare(top_waiter, NULL))
+		return -EAGAIN;
+
 	/*
 	 * Try to take the lock for top_waiter.  Set the FUTEX_WAITERS bit in
 	 * the contended case or if set_waiters is 1.  The pi_state is returned
@@ -1892,8 +2044,22 @@ futex_proxy_trylock_atomic(u32 __user *pifutex, struct=
 futex_hash_bucket *hb1,
 	ret =3D futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
 				   exiting, set_waiters);
 	if (ret =3D=3D 1) {
+		/* Dequeue, wake up and update top_waiter::requeue_state */
 		requeue_pi_wake_futex(top_waiter, key2, hb2);
 		return vpid;
+	} else if (ret < 0) {
+		/* Rewind top_waiter::requeue_state */
+		futex_requeue_pi_complete(top_waiter, ret);
+	} else {
+		/*
+		 * futex_lock_pi_atomic() did not acquire the user space
+		 * futex, but managed to establish the proxy lock and pi
+		 * state. top_waiter::requeue_state cannot be fixed up here
+		 * because the waiter is not enqueued on the rtmutex
+		 * yet. This is handled at the callsite depending on the
+		 * result of rt_mutex_start_proxy_lock() which is
+		 * guaranteed to be reached with this function returning 0.
+		 */
 	}
 	return ret;
 }
@@ -1947,24 +2113,36 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 		if (uaddr1 =3D=3D uaddr2)
 			return -EINVAL;
=20
+		/*
+		 * futex_requeue() allows the caller to define the number
+		 * of waiters to wake up via the @nr_wake argument. With
+		 * REQUEUE_PI, waking up more than one waiter is creating
+		 * more problems than it solves. Waking up a waiter makes
+		 * only sense if the PI futex @uaddr2 is uncontended as
+		 * this allows the requeue code to acquire the futex
+		 * @uaddr2 before waking the waiter. The waiter can then
+		 * return to user space without further action. A secondary
+		 * wakeup would just make the futex_wait_requeue_pi()
+		 * handling more complex, because that code would have to
+		 * look up pi_state and do more or less all the handling
+		 * which the requeue code has to do for the to be requeued
+		 * waiters. So restrict the number of waiters to wake to
+		 * one, and only wake it up when the PI futex is
+		 * uncontended. Otherwise requeue it and let the unlock of
+		 * the PI futex handle the wakeup.
+		 *
+		 * All REQUEUE_PI users, e.g. pthread_cond_signal() and
+		 * pthread_cond_broadcast() must use nr_wake=3D1.
+		 */
+		if (nr_wake !=3D 1)
+			return -EINVAL;
+
 		/*
 		 * requeue_pi requires a pi_state, try to allocate it now
 		 * without any locks in case it fails.
 		 */
 		if (refill_pi_state_cache())
 			return -ENOMEM;
-		/*
-		 * requeue_pi must wake as many tasks as it can, up to nr_wake
-		 * + nr_requeue, since it acquires the rt_mutex prior to
-		 * returning to userspace, so as to not leave the rt_mutex with
-		 * waiters and no owner.  However, second and third wake-ups
-		 * cannot be predicted as they involve race conditions with the
-		 * first wake and a fault while looking up the pi_state.  Both
-		 * pthread_cond_signal() and pthread_cond_broadcast() should
-		 * use nr_wake=3D1.
-		 */
-		if (nr_wake !=3D 1)
-			return -EINVAL;
 	}
=20
 retry:
@@ -2014,7 +2192,7 @@ static int futex_requeue(u32 __user *uaddr1, unsigned i=
nt flags,
 		}
 	}
=20
-	if (requeue_pi && (task_count - nr_wake < nr_requeue)) {
+	if (requeue_pi) {
 		struct task_struct *exiting =3D NULL;
=20
 		/*
@@ -2022,6 +2200,8 @@ static int futex_requeue(u32 __user *uaddr1, unsigned i=
nt flags,
 		 * intend to requeue waiters, force setting the FUTEX_WAITERS
 		 * bit.  We force this here where we are able to easily handle
 		 * faults rather in the requeue loop below.
+		 *
+		 * Updates topwaiter::requeue_state if a top waiter exists.
 		 */
 		ret =3D futex_proxy_trylock_atomic(uaddr2, hb1, hb2, &key1,
 						 &key2, &pi_state,
@@ -2031,28 +2211,52 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 		 * At this point the top_waiter has either taken uaddr2 or is
 		 * waiting on it.  If the former, then the pi_state will not
 		 * exist yet, look it up one more time to ensure we have a
-		 * reference to it. If the lock was taken, ret contains the
-		 * vpid of the top waiter task.
+		 * reference to it. If the lock was taken, @ret contains the
+		 * VPID of the top waiter task.
 		 * If the lock was not taken, we have pi_state and an initial
 		 * refcount on it. In case of an error we have nothing.
+		 *
+		 * The top waiter's requeue_state is up to date:
+		 *
+		 *  - If the lock was acquired atomically (ret > 0), then
+		 *    the state is Q_REQUEUE_PI_LOCKED.
+		 *
+		 *  - If the trylock failed with an error (ret < 0) then
+		 *    the state is either Q_REQUEUE_PI_NONE, i.e. "nothing
+		 *    happened", or Q_REQUEUE_PI_IGNORE when there was an
+		 *    interleaved early wakeup.
+		 *
+		 *  - If the trylock did not succeed (ret =3D=3D 0) then the
+		 *    state is either Q_REQUEUE_PI_IN_PROGRESS or
+		 *    Q_REQUEUE_PI_WAIT if an early wakeup interleaved.
+		 *    This will be cleaned up in the loop below, which
+		 *    cannot fail because futex_proxy_trylock_atomic() did
+		 *    the same sanity checks for requeue_pi as the loop
+		 *    below does.
 		 */
 		if (ret > 0) {
 			WARN_ON(pi_state);
 			task_count++;
 			/*
-			 * If we acquired the lock, then the user space value
-			 * of uaddr2 should be vpid. It cannot be changed by
-			 * the top waiter as it is blocked on hb2 lock if it
-			 * tries to do so. If something fiddled with it behind
-			 * our back the pi state lookup might unearth it. So
-			 * we rather use the known value than rereading and
-			 * handing potential crap to lookup_pi_state.
+			 * If futex_proxy_trylock_atomic() acquired the
+			 * user space futex, then the user space value
+			 * @uaddr2 has been set to the @hb1's top waiter
+			 * task VPID. This task is guaranteed to be alive
+			 * and cannot be exiting because it is either
+			 * sleeping or blocked on @hb2 lock.
+			 *
+			 * The @uaddr2 futex cannot have waiters either as
+			 * otherwise futex_proxy_trylock_atomic() would not
+			 * have succeeded.
 			 *
-			 * If that call succeeds then we have pi_state and an
-			 * initial refcount on it.
+			 * In order to requeue waiters to @hb2, pi state is
+			 * required. Hand in the VPID value (@ret) and
+			 * allocate PI state with an initial refcount on
+			 * it.
 			 */
-			ret =3D lookup_pi_state(uaddr2, ret, hb2, &key2,
-					      &pi_state, &exiting);
+			ret =3D attach_to_pi_owner(uaddr2, ret, &key2, &pi_state,
+						 &exiting);
+			WARN_ON(ret);
 		}
=20
 		switch (ret) {
@@ -2060,7 +2264,10 @@ static int futex_requeue(u32 __user *uaddr1, unsigned =
int flags,
 			/* We hold a reference on the pi state. */
 			break;
=20
-			/* If the above failed, then pi_state is NULL */
+		/*
+		 * If the above failed, then pi_state is NULL and
+		 * waiter::requeue_state is correct.
+		 */
 		case -EFAULT:
 			double_unlock_hb(hb1, hb2);
 			hb_waiters_dec(hb2);
@@ -2112,18 +2319,17 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 			break;
 		}
=20
-		/*
-		 * Wake nr_wake waiters.  For requeue_pi, if we acquired the
-		 * lock, we already woke the top_waiter.  If not, it will be
-		 * woken by futex_unlock_pi().
-		 */
-		if (++task_count <=3D nr_wake && !requeue_pi) {
-			mark_wake_futex(&wake_q, this);
+		/* Plain futexes just wake or requeue and are done */
+		if (!requeue_pi) {
+			if (++task_count <=3D nr_wake)
+				mark_wake_futex(&wake_q, this);
+			else
+				requeue_futex(this, hb1, hb2, &key2);
 			continue;
 		}
=20
 		/* Ensure we requeue to the expected futex for requeue_pi. */
-		if (requeue_pi && !match_futex(this->requeue_pi_key, &key2)) {
+		if (!match_futex(this->requeue_pi_key, &key2)) {
 			ret =3D -EINVAL;
 			break;
 		}
@@ -2131,54 +2337,67 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 		/*
 		 * Requeue nr_requeue waiters and possibly one more in the case
 		 * of requeue_pi if we couldn't acquire the lock atomically.
+		 *
+		 * Prepare the waiter to take the rt_mutex. Take a refcount
+		 * on the pi_state and store the pointer in the futex_q
+		 * object of the waiter.
 		 */
-		if (requeue_pi) {
+		get_pi_state(pi_state);
+
+		/* Don't requeue when the waiter is already on the way out. */
+		if (!futex_requeue_pi_prepare(this, pi_state)) {
 			/*
-			 * Prepare the waiter to take the rt_mutex. Take a
-			 * refcount on the pi_state and store the pointer in
-			 * the futex_q object of the waiter.
+			 * Early woken waiter signaled that it is on the
+			 * way out. Drop the pi_state reference and try the
+			 * next waiter. @this->pi_state is still NULL.
 			 */
-			get_pi_state(pi_state);
-			this->pi_state =3D pi_state;
-			ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
-							this->rt_waiter,
-							this->task);
-			if (ret =3D=3D 1) {
-				/*
-				 * We got the lock. We do neither drop the
-				 * refcount on pi_state nor clear
-				 * this->pi_state because the waiter needs the
-				 * pi_state for cleaning up the user space
-				 * value. It will drop the refcount after
-				 * doing so.
-				 */
-				requeue_pi_wake_futex(this, &key2, hb2);
-				continue;
-			} else if (ret) {
-				/*
-				 * rt_mutex_start_proxy_lock() detected a
-				 * potential deadlock when we tried to queue
-				 * that waiter. Drop the pi_state reference
-				 * which we took above and remove the pointer
-				 * to the state from the waiters futex_q
-				 * object.
-				 */
-				this->pi_state =3D NULL;
-				put_pi_state(pi_state);
-				/*
-				 * We stop queueing more waiters and let user
-				 * space deal with the mess.
-				 */
-				break;
-			}
+			put_pi_state(pi_state);
+			continue;
+		}
+
+		ret =3D rt_mutex_start_proxy_lock(&pi_state->pi_mutex,
+						this->rt_waiter,
+						this->task);
+
+		if (ret =3D=3D 1) {
+			/*
+			 * We got the lock. We do neither drop the refcount
+			 * on pi_state nor clear this->pi_state because the
+			 * waiter needs the pi_state for cleaning up the
+			 * user space value. It will drop the refcount
+			 * after doing so. this::requeue_state is updated
+			 * in the wakeup as well.
+			 */
+			requeue_pi_wake_futex(this, &key2, hb2);
+			task_count++;
+		} else if (!ret) {
+			/* Waiter is queued, move it to hb2 */
+			requeue_futex(this, hb1, hb2, &key2);
+			futex_requeue_pi_complete(this, 0);
+			task_count++;
+		} else {
+			/*
+			 * rt_mutex_start_proxy_lock() detected a potential
+			 * deadlock when we tried to queue that waiter.
+			 * Drop the pi_state reference which we took above
+			 * and remove the pointer to the state from the
+			 * waiters futex_q object.
+			 */
+			this->pi_state =3D NULL;
+			put_pi_state(pi_state);
+			futex_requeue_pi_complete(this, ret);
+			/*
+			 * We stop queueing more waiters and let user space
+			 * deal with the mess.
+			 */
+			break;
 		}
-		requeue_futex(this, hb1, hb2, &key2);
 	}
=20
 	/*
-	 * We took an extra initial reference to the pi_state either
-	 * in futex_proxy_trylock_atomic() or in lookup_pi_state(). We
-	 * need to drop it here again.
+	 * We took an extra initial reference to the pi_state either in
+	 * futex_proxy_trylock_atomic() or in attach_to_pi_owner(). We need
+	 * to drop it here again.
 	 */
 	put_pi_state(pi_state);
=20
@@ -2357,7 +2576,7 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, st=
ruct futex_q *q,
 	 * Modifying pi_state _before_ the user space value would leave the
 	 * pi_state in an inconsistent state when we fault here, because we
 	 * need to drop the locks to handle the fault. This might be observed
-	 * in the PID check in lookup_pi_state.
+	 * in the PID checks when attaching to PI state .
 	 */
 retry:
 	if (!argowner) {
@@ -2614,8 +2833,7 @@ static void futex_wait_queue_me(struct futex_hash_bucke=
t *hb, struct futex_q *q,
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
- * Return with the hb lock held and a q.key reference on success, and unlock=
ed
- * with no q.key reference on failure.
+ * Return with the hb lock held on success, and unlocked on failure.
  *
  * Return:
  *  -  0 - uaddr contains val and hb has been locked;
@@ -2693,8 +2911,8 @@ static int futex_wait(u32 __user *uaddr, unsigned int f=
lags, u32 val,
 			       current->timer_slack_ns);
 retry:
 	/*
-	 * Prepare to wait on uaddr. On success, holds hb lock and increments
-	 * q.key refs.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -2705,7 +2923,6 @@ static int futex_wait(u32 __user *uaddr, unsigned int f=
lags, u32 val,
=20
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	ret =3D 0;
-	/* unqueue_me() drops q.key ref */
 	if (!unqueue_me(&q))
 		goto out;
 	ret =3D -ETIMEDOUT;
@@ -3072,27 +3289,22 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigne=
d int flags)
 }
=20
 /**
- * handle_early_requeue_pi_wakeup() - Detect early wakeup on the initial fut=
ex
+ * handle_early_requeue_pi_wakeup() - Handle early wakeup on the initial fut=
ex
  * @hb:		the hash_bucket futex_q was original enqueued on
  * @q:		the futex_q woken while waiting to be requeued
- * @key2:	the futex_key of the requeue target futex
  * @timeout:	the timeout associated with the wait (NULL if none)
  *
- * Detect if the task was woken on the initial futex as opposed to the reque=
ue
- * target futex.  If so, determine if it was a timeout or a signal that caus=
ed
- * the wakeup and return the appropriate error code to the caller.  Must be
- * called with the hb lock held.
+ * Determine the cause for the early wakeup.
  *
  * Return:
- *  -  0 =3D no early wakeup detected;
- *  - <0 =3D -ETIMEDOUT or -ERESTARTNOINTR
+ *  -EWOULDBLOCK or -ETIMEDOUT or -ERESTARTNOINTR
  */
 static inline
 int handle_early_requeue_pi_wakeup(struct futex_hash_bucket *hb,
-				   struct futex_q *q, union futex_key *key2,
+				   struct futex_q *q,
 				   struct hrtimer_sleeper *timeout)
 {
-	int ret =3D 0;
+	int ret;
=20
 	/*
 	 * With the hb lock held, we avoid races while we process the wakeup.
@@ -3101,22 +3313,21 @@ int handle_early_requeue_pi_wakeup(struct futex_hash_=
bucket *hb,
 	 * It can't be requeued from uaddr2 to something else since we don't
 	 * support a PI aware source futex for requeue.
 	 */
-	if (!match_futex(&q->key, key2)) {
-		WARN_ON(q->lock_ptr && (&hb->lock !=3D q->lock_ptr));
-		/*
-		 * We were woken prior to requeue by a timeout or a signal.
-		 * Unqueue the futex_q and determine which it was.
-		 */
-		plist_del(&q->list, &hb->chain);
-		hb_waiters_dec(hb);
+	WARN_ON_ONCE(&hb->lock !=3D q->lock_ptr);
=20
-		/* Handle spurious wakeups gracefully */
-		ret =3D -EWOULDBLOCK;
-		if (timeout && !timeout->task)
-			ret =3D -ETIMEDOUT;
-		else if (signal_pending(current))
-			ret =3D -ERESTARTNOINTR;
-	}
+	/*
+	 * We were woken prior to requeue by a timeout or a signal.
+	 * Unqueue the futex_q and determine which it was.
+	 */
+	plist_del(&q->list, &hb->chain);
+	hb_waiters_dec(hb);
+
+	/* Handle spurious wakeups gracefully */
+	ret =3D -EWOULDBLOCK;
+	if (timeout && !timeout->task)
+		ret =3D -ETIMEDOUT;
+	else if (signal_pending(current))
+		ret =3D -ERESTARTNOINTR;
 	return ret;
 }
=20
@@ -3169,6 +3380,7 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, uns=
igned int flags,
 	struct futex_hash_bucket *hb;
 	union futex_key key2 =3D FUTEX_KEY_INIT;
 	struct futex_q q =3D futex_q_init;
+	struct rt_mutex_base *pi_mutex;
 	int res, ret;
=20
 	if (!IS_ENABLED(CONFIG_FUTEX_PI))
@@ -3198,8 +3410,8 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, uns=
igned int flags,
 	q.requeue_pi_key =3D &key2;
=20
 	/*
-	 * Prepare to wait on uaddr. On success, increments q.key (key1) ref
-	 * count.
+	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
+	 * is initialized.
 	 */
 	ret =3D futex_wait_setup(uaddr, val, flags, &q, &hb);
 	if (ret)
@@ -3218,32 +3430,22 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, u=
nsigned int flags,
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
 	futex_wait_queue_me(hb, &q, to);
=20
-	spin_lock(&hb->lock);
-	ret =3D handle_early_requeue_pi_wakeup(hb, &q, &key2, to);
-	spin_unlock(&hb->lock);
-	if (ret)
-		goto out;
-
-	/*
-	 * In order for us to be here, we know our q.key =3D=3D key2, and since
-	 * we took the hb->lock above, we also know that futex_requeue() has
-	 * completed and we no longer have to concern ourselves with a wakeup
-	 * race with the atomic proxy lock acquisition by the requeue code. The
-	 * futex_requeue dropped our key1 reference and incremented our key2
-	 * reference count.
-	 */
+	switch (futex_requeue_pi_wakeup_sync(&q)) {
+	case Q_REQUEUE_PI_IGNORE:
+		/* The waiter is still on uaddr1 */
+		spin_lock(&hb->lock);
+		ret =3D handle_early_requeue_pi_wakeup(hb, &q, to);
+		spin_unlock(&hb->lock);
+		break;
=20
-	/*
-	 * Check if the requeue code acquired the second futex for us and do
-	 * any pertinent fixup.
-	 */
-	if (!q.rt_waiter) {
+	case Q_REQUEUE_PI_LOCKED:
+		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner !=3D current)) {
 			spin_lock(q.lock_ptr);
 			ret =3D fixup_owner(uaddr2, &q, true);
 			/*
-			 * Drop the reference to the pi state which
-			 * the requeue_pi() code acquired for us.
+			 * Drop the reference to the pi state which the
+			 * requeue_pi() code acquired for us.
 			 */
 			put_pi_state(q.pi_state);
 			spin_unlock(q.lock_ptr);
@@ -3253,18 +3455,14 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, u=
nsigned int flags,
 			 */
 			ret =3D ret < 0 ? ret : 0;
 		}
-	} else {
-		struct rt_mutex *pi_mutex;
+		break;
=20
-		/*
-		 * We have been woken up by futex_unlock_pi(), a timeout, or a
-		 * signal.  futex_unlock_pi() will not destroy the lock_ptr nor
-		 * the pi_state.
-		 */
-		WARN_ON(!q.pi_state);
+	case Q_REQUEUE_PI_DONE:
+		/* Requeue completed. Current is 'pi_blocked_on' the rtmutex */
 		pi_mutex =3D &q.pi_state->pi_mutex;
 		ret =3D rt_mutex_wait_proxy_lock(pi_mutex, to, &rt_waiter);
=20
+		/* Current is not longer pi_blocked_on */
 		spin_lock(q.lock_ptr);
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret =3D 0;
@@ -3284,17 +3482,21 @@ static int futex_wait_requeue_pi(u32 __user *uaddr, u=
nsigned int flags,
=20
 		unqueue_me_pi(&q);
 		spin_unlock(q.lock_ptr);
-	}
=20
-	if (ret =3D=3D -EINTR) {
-		/*
-		 * We've already been requeued, but cannot restart by calling
-		 * futex_lock_pi() directly. We could restart this syscall, but
-		 * it would detect that the user space "val" changed and return
-		 * -EWOULDBLOCK.  Save the overhead of the restart and return
-		 * -EWOULDBLOCK directly.
-		 */
-		ret =3D -EWOULDBLOCK;
+		if (ret =3D=3D -EINTR) {
+			/*
+			 * We've already been requeued, but cannot restart
+			 * by calling futex_lock_pi() directly. We could
+			 * restart this syscall, but it would detect that
+			 * the user space "val" changed and return
+			 * -EWOULDBLOCK.  Save the overhead of the restart
+			 * and return -EWOULDBLOCK directly.
+			 */
+			ret =3D -EWOULDBLOCK;
+		}
+		break;
+	default:
+		BUG();
 	}
=20
 out:
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 3572808223e4..d51cabf28f38 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -24,7 +24,8 @@ obj-$(CONFIG_SMP) +=3D spinlock.o
 obj-$(CONFIG_LOCK_SPIN_ON_OWNER) +=3D osq_lock.o
 obj-$(CONFIG_PROVE_LOCKING) +=3D spinlock.o
 obj-$(CONFIG_QUEUED_SPINLOCKS) +=3D qspinlock.o
-obj-$(CONFIG_RT_MUTEXES) +=3D rtmutex.o
+obj-$(CONFIG_RT_MUTEXES) +=3D rtmutex_api.o
+obj-$(CONFIG_PREEMPT_RT) +=3D spinlock_rt.o ww_rt_mutex.o
 obj-$(CONFIG_DEBUG_SPINLOCK) +=3D spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) +=3D spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) +=3D qrwlock.o
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index db9301591e3f..bc8abb8549d2 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -1,6 +1,4 @@
 /*
- * kernel/mutex-debug.c
- *
  * Debugging code for mutexes
  *
  * Started by Ingo Molnar:
@@ -22,7 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/debug_locks.h>
=20
-#include "mutex-debug.h"
+#include "mutex.h"
=20
 /*
  * Must be called with lock->wait_lock held.
@@ -32,6 +30,7 @@ void debug_mutex_lock_common(struct mutex *lock, struct mut=
ex_waiter *waiter)
 	memset(waiter, MUTEX_DEBUG_INIT, sizeof(*waiter));
 	waiter->magic =3D waiter;
 	INIT_LIST_HEAD(&waiter->list);
+	waiter->ww_ctx =3D MUTEX_POISON_WW_CTX;
 }
=20
 void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
deleted file mode 100644
index 53e631e1d76d..000000000000
--- a/kernel/locking/mutex-debug.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Mutexes: blocking mutual exclusion locks
- *
- * started by Ingo Molnar:
- *
- *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.=
com>
- *
- * This file contains mutex debugging related internal declarations,
- * prototypes and inline functions, for the CONFIG_DEBUG_MUTEXES case.
- * More details are in kernel/mutex-debug.c.
- */
-
-/*
- * This must be called with lock->wait_lock held.
- */
-extern void debug_mutex_lock_common(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_wake_waiter(struct mutex *lock,
-				    struct mutex_waiter *waiter);
-extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
-extern void debug_mutex_add_waiter(struct mutex *lock,
-				   struct mutex_waiter *waiter,
-				   struct task_struct *task);
-extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waite=
r *waiter,
-				struct task_struct *task);
-extern void debug_mutex_unlock(struct mutex *lock);
-extern void debug_mutex_init(struct mutex *lock, const char *name,
-			     struct lock_class_key *key);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d2df5e68b503..d456579d0952 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -30,17 +30,20 @@
 #include <linux/debug_locks.h>
 #include <linux/osq_lock.h>
=20
+#ifndef CONFIG_PREEMPT_RT
+#include "mutex.h"
+
 #ifdef CONFIG_DEBUG_MUTEXES
-# include "mutex-debug.h"
+# define MUTEX_WARN_ON(cond) DEBUG_LOCKS_WARN_ON(cond)
 #else
-# include "mutex.h"
+# define MUTEX_WARN_ON(cond)
 #endif
=20
 void
 __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *ke=
y)
 {
 	atomic_long_set(&lock->owner, 0);
-	spin_lock_init(&lock->wait_lock);
+	raw_spin_lock_init(&lock->wait_lock);
 	INIT_LIST_HEAD(&lock->wait_list);
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
@@ -91,55 +94,56 @@ static inline unsigned long __owner_flags(unsigned long o=
wner)
 	return owner & MUTEX_FLAGS;
 }
=20
-/*
- * Trylock variant that returns the owning task on failure.
- */
-static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *loc=
k)
+static inline struct task_struct *__mutex_trylock_common(struct mutex *lock,=
 bool handoff)
 {
 	unsigned long owner, curr =3D (unsigned long)current;
=20
 	owner =3D atomic_long_read(&lock->owner);
 	for (;;) { /* must loop, can race against a flag */
-		unsigned long old, flags =3D __owner_flags(owner);
+		unsigned long flags =3D __owner_flags(owner);
 		unsigned long task =3D owner & ~MUTEX_FLAGS;
=20
 		if (task) {
-			if (likely(task !=3D curr))
-				break;
-
-			if (likely(!(flags & MUTEX_FLAG_PICKUP)))
+			if (flags & MUTEX_FLAG_PICKUP) {
+				if (task !=3D curr)
+					break;
+				flags &=3D ~MUTEX_FLAG_PICKUP;
+			} else if (handoff) {
+				if (flags & MUTEX_FLAG_HANDOFF)
+					break;
+				flags |=3D MUTEX_FLAG_HANDOFF;
+			} else {
 				break;
-
-			flags &=3D ~MUTEX_FLAG_PICKUP;
+			}
 		} else {
-#ifdef CONFIG_DEBUG_MUTEXES
-			DEBUG_LOCKS_WARN_ON(flags & MUTEX_FLAG_PICKUP);
-#endif
+			MUTEX_WARN_ON(flags & (MUTEX_FLAG_HANDOFF | MUTEX_FLAG_PICKUP));
+			task =3D curr;
 		}
=20
-		/*
-		 * We set the HANDOFF bit, we must make sure it doesn't live
-		 * past the point where we acquire it. This would be possible
-		 * if we (accidentally) set the bit on an unlocked mutex.
-		 */
-		flags &=3D ~MUTEX_FLAG_HANDOFF;
-
-		old =3D atomic_long_cmpxchg_acquire(&lock->owner, owner, curr | flags);
-		if (old =3D=3D owner)
-			return NULL;
-
-		owner =3D old;
+		if (atomic_long_try_cmpxchg_acquire(&lock->owner, &owner, task | flags)) {
+			if (task =3D=3D curr)
+				return NULL;
+			break;
+		}
 	}
=20
 	return __owner_task(owner);
 }
=20
+/*
+ * Trylock or set HANDOFF
+ */
+static inline bool __mutex_trylock_or_handoff(struct mutex *lock, bool hando=
ff)
+{
+	return !__mutex_trylock_common(lock, handoff);
+}
+
 /*
  * Actual trylock that will work on any unlocked state.
  */
 static inline bool __mutex_trylock(struct mutex *lock)
 {
-	return !__mutex_trylock_or_owner(lock);
+	return !__mutex_trylock_common(lock, false);
 }
=20
 #ifndef CONFIG_DEBUG_LOCK_ALLOC
@@ -168,10 +172,7 @@ static __always_inline bool __mutex_unlock_fast(struct m=
utex *lock)
 {
 	unsigned long curr =3D (unsigned long)current;
=20
-	if (atomic_long_cmpxchg_release(&lock->owner, curr, 0UL) =3D=3D curr)
-		return true;
-
-	return false;
+	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
 #endif
=20
@@ -226,23 +227,18 @@ static void __mutex_handoff(struct mutex *lock, struct =
task_struct *task)
 	unsigned long owner =3D atomic_long_read(&lock->owner);
=20
 	for (;;) {
-		unsigned long old, new;
+		unsigned long new;
=20
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(__owner_task(owner) !=3D current);
-		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-#endif
+		MUTEX_WARN_ON(__owner_task(owner) !=3D current);
+		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
=20
 		new =3D (owner & MUTEX_FLAG_WAITERS);
 		new |=3D (unsigned long)task;
 		if (task)
 			new |=3D MUTEX_FLAG_PICKUP;
=20
-		old =3D atomic_long_cmpxchg_release(&lock->owner, owner, new);
-		if (old =3D=3D owner)
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, new))
 			break;
-
-		owner =3D old;
 	}
 }
=20
@@ -286,218 +282,18 @@ void __sched mutex_lock(struct mutex *lock)
 EXPORT_SYMBOL(mutex_lock);
 #endif
=20
-/*
- * Wait-Die:
- *   The newer transactions are killed when:
- *     It (the new transaction) makes a request for a lock being held
- *     by an older transaction.
- *
- * Wound-Wait:
- *   The newer transactions are wounded when:
- *     An older transaction makes a request for a lock being held by
- *     the newer transaction.
- */
-
-/*
- * Associate the ww_mutex @ww with the context @ww_ctx under which we acquir=
ed
- * it.
- */
-static __always_inline void
-ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
-{
-#ifdef CONFIG_DEBUG_MUTEXES
-	/*
-	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
-	 * but released with a normal mutex_unlock in this call.
-	 *
-	 * This should never happen, always use ww_mutex_unlock.
-	 */
-	DEBUG_LOCKS_WARN_ON(ww->ctx);
-
-	/*
-	 * Not quite done after calling ww_acquire_done() ?
-	 */
-	DEBUG_LOCKS_WARN_ON(ww_ctx->done_acquire);
+#include "ww_mutex.h"
=20
-	if (ww_ctx->contending_lock) {
-		/*
-		 * After -EDEADLK you tried to
-		 * acquire a different ww_mutex? Bad!
-		 */
-		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock !=3D ww);
-
-		/*
-		 * You called ww_mutex_lock after receiving -EDEADLK,
-		 * but 'forgot' to unlock everything else first?
-		 */
-		DEBUG_LOCKS_WARN_ON(ww_ctx->acquired > 0);
-		ww_ctx->contending_lock =3D NULL;
-	}
-
-	/*
-	 * Naughty, using a different class will lead to undefined behavior!
-	 */
-	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class !=3D ww->ww_class);
-#endif
-	ww_ctx->acquired++;
-	ww->ctx =3D ww_ctx;
-}
-
-/*
- * Determine if context @a is 'after' context @b. IOW, @a is a younger
- * transaction than @b and depending on algorithm either needs to wait for
- * @b or die.
- */
-static inline bool __sched
-__ww_ctx_stamp_after(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
-{
-
-	return (signed long)(a->stamp - b->stamp) > 0;
-}
-
-/*
- * Wait-Die; wake a younger waiter context (when locks held) such that it can
- * die.
- *
- * Among waiters with context, only the first one can have other locks acqui=
red
- * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
- * __ww_mutex_check_kill() wake any but the earliest context.
- */
-static bool __sched
-__ww_mutex_die(struct mutex *lock, struct mutex_waiter *waiter,
-	       struct ww_acquire_ctx *ww_ctx)
-{
-	if (!ww_ctx->is_wait_die)
-		return false;
-
-	if (waiter->ww_ctx->acquired > 0 &&
-			__ww_ctx_stamp_after(waiter->ww_ctx, ww_ctx)) {
-		debug_mutex_wake_waiter(lock, waiter);
-		wake_up_process(waiter->task);
-	}
-
-	return true;
-}
-
-/*
- * Wound-Wait; wound a younger @hold_ctx if it holds the lock.
- *
- * Wound the lock holder if there are waiters with older transactions than
- * the lock holders. Even if multiple waiters may wound the lock holder,
- * it's sufficient that only one does.
- */
-static bool __ww_mutex_wound(struct mutex *lock,
-			     struct ww_acquire_ctx *ww_ctx,
-			     struct ww_acquire_ctx *hold_ctx)
-{
-	struct task_struct *owner =3D __mutex_owner(lock);
-
-	lockdep_assert_held(&lock->wait_lock);
-
-	/*
-	 * Possible through __ww_mutex_add_waiter() when we race with
-	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
-	 * through __ww_mutex_check_waiters().
-	 */
-	if (!hold_ctx)
-		return false;
-
-	/*
-	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
-	 * it cannot go away because we'll have FLAG_WAITERS set and hold
-	 * wait_lock.
-	 */
-	if (!owner)
-		return false;
-
-	if (ww_ctx->acquired > 0 && __ww_ctx_stamp_after(hold_ctx, ww_ctx)) {
-		hold_ctx->wounded =3D 1;
-
-		/*
-		 * wake_up_process() paired with set_current_state()
-		 * inserts sufficient barriers to make sure @owner either sees
-		 * it's wounded in __ww_mutex_check_kill() or has a
-		 * wakeup pending to re-read the wounded state.
-		 */
-		if (owner !=3D current)
-			wake_up_process(owner);
-
-		return true;
-	}
-
-	return false;
-}
-
-/*
- * We just acquired @lock under @ww_ctx, if there are later contexts waiting
- * behind us on the wait-list, check if they need to die, or wound us.
- *
- * See __ww_mutex_add_waiter() for the list-order construction; basically the
- * list is ordered by stamp, smallest (oldest) first.
- *
- * This relies on never mixing wait-die/wound-wait on the same wait-list;
- * which is currently ensured by that being a ww_class property.
- *
- * The current task must not be on the wait list.
- */
-static void __sched
-__ww_mutex_check_waiters(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
-{
-	struct mutex_waiter *cur;
-
-	lockdep_assert_held(&lock->wait_lock);
-
-	list_for_each_entry(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		if (__ww_mutex_die(lock, cur, ww_ctx) ||
-		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
-			break;
-	}
-}
+#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
=20
 /*
- * After acquiring lock with fastpath, where we do not hold wait_lock, set c=
tx
- * and wake up any waiters so they can recheck.
+ * Trylock variant that returns the owning task on failure.
  */
-static __always_inline void
-ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *=
ctx)
+static inline struct task_struct *__mutex_trylock_or_owner(struct mutex *loc=
k)
 {
-	ww_mutex_lock_acquired(lock, ctx);
-
-	/*
-	 * The lock->ctx update should be visible on all cores before
-	 * the WAITERS check is done, otherwise contended waiters might be
-	 * missed. The contended waiters will either see ww_ctx =3D=3D NULL
-	 * and keep spinning, or it will acquire wait_lock, add itself
-	 * to waiter list and sleep.
-	 */
-	smp_mb(); /* See comments above and below. */
-
-	/*
-	 * [W] ww->ctx =3D ctx	    [W] MUTEX_FLAG_WAITERS
-	 *     MB		        MB
-	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
-	 *
-	 * The memory barrier above pairs with the memory barrier in
-	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
-	 * and/or !empty list.
-	 */
-	if (likely(!(atomic_long_read(&lock->base.owner) & MUTEX_FLAG_WAITERS)))
-		return;
-
-	/*
-	 * Uh oh, we raced in fastpath, check if any of the waiters need to
-	 * die or wound us.
-	 */
-	spin_lock(&lock->base.wait_lock);
-	__ww_mutex_check_waiters(&lock->base, ctx);
-	spin_unlock(&lock->base.wait_lock);
+	return __mutex_trylock_common(lock, false);
 }
=20
-#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
-
 static inline
 bool ww_mutex_spin_on_owner(struct mutex *lock, struct ww_acquire_ctx *ww_ct=
x,
 			    struct mutex_waiter *waiter)
@@ -754,171 +550,11 @@ EXPORT_SYMBOL(mutex_unlock);
  */
 void __sched ww_mutex_unlock(struct ww_mutex *lock)
 {
-	/*
-	 * The unlocking fastpath is the 0->1 transition from 'locked'
-	 * into 'unlocked' state:
-	 */
-	if (lock->ctx) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
-#endif
-		if (lock->ctx->acquired > 0)
-			lock->ctx->acquired--;
-		lock->ctx =3D NULL;
-	}
-
+	__ww_mutex_unlock(lock);
 	mutex_unlock(&lock->base);
 }
 EXPORT_SYMBOL(ww_mutex_unlock);
=20
-
-static __always_inline int __sched
-__ww_mutex_kill(struct mutex *lock, struct ww_acquire_ctx *ww_ctx)
-{
-	if (ww_ctx->acquired > 0) {
-#ifdef CONFIG_DEBUG_MUTEXES
-		struct ww_mutex *ww;
-
-		ww =3D container_of(lock, struct ww_mutex, base);
-		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
-		ww_ctx->contending_lock =3D ww;
-#endif
-		return -EDEADLK;
-	}
-
-	return 0;
-}
-
-
-/*
- * Check the wound condition for the current lock acquire.
- *
- * Wound-Wait: If we're wounded, kill ourself.
- *
- * Wait-Die: If we're trying to acquire a lock already held by an older
- *           context, kill ourselves.
- *
- * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have=
 to
- * look at waiters before us in the wait-list.
- */
-static inline int __sched
-__ww_mutex_check_kill(struct mutex *lock, struct mutex_waiter *waiter,
-		      struct ww_acquire_ctx *ctx)
-{
-	struct ww_mutex *ww =3D container_of(lock, struct ww_mutex, base);
-	struct ww_acquire_ctx *hold_ctx =3D READ_ONCE(ww->ctx);
-	struct mutex_waiter *cur;
-
-	if (ctx->acquired =3D=3D 0)
-		return 0;
-
-	if (!ctx->is_wait_die) {
-		if (ctx->wounded)
-			return __ww_mutex_kill(lock, ctx);
-
-		return 0;
-	}
-
-	if (hold_ctx && __ww_ctx_stamp_after(ctx, hold_ctx))
-		return __ww_mutex_kill(lock, ctx);
-
-	/*
-	 * If there is a waiter in front of us that has a context, then its
-	 * stamp is earlier than ours and we must kill ourself.
-	 */
-	cur =3D waiter;
-	list_for_each_entry_continue_reverse(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		return __ww_mutex_kill(lock, ctx);
-	}
-
-	return 0;
-}
-
-/*
- * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smalle=
st
- * first. Such that older contexts are preferred to acquire the lock over
- * younger contexts.
- *
- * Waiters without context are interspersed in FIFO order.
- *
- * Furthermore, for Wait-Die kill ourself immediately when possible (there a=
re
- * older contexts already waiting) to avoid unnecessary waiting and for
- * Wound-Wait ensure we wound the owning context when it is younger.
- */
-static inline int __sched
-__ww_mutex_add_waiter(struct mutex_waiter *waiter,
-		      struct mutex *lock,
-		      struct ww_acquire_ctx *ww_ctx)
-{
-	struct mutex_waiter *cur;
-	struct list_head *pos;
-	bool is_wait_die;
-
-	if (!ww_ctx) {
-		__mutex_add_waiter(lock, waiter, &lock->wait_list);
-		return 0;
-	}
-
-	is_wait_die =3D ww_ctx->is_wait_die;
-
-	/*
-	 * Add the waiter before the first waiter with a higher stamp.
-	 * Waiters without a context are skipped to avoid starving
-	 * them. Wait-Die waiters may die here. Wound-Wait waiters
-	 * never die here, but they are sorted in stamp order and
-	 * may wound the lock holder.
-	 */
-	pos =3D &lock->wait_list;
-	list_for_each_entry_reverse(cur, &lock->wait_list, list) {
-		if (!cur->ww_ctx)
-			continue;
-
-		if (__ww_ctx_stamp_after(ww_ctx, cur->ww_ctx)) {
-			/*
-			 * Wait-Die: if we find an older context waiting, there
-			 * is no point in queueing behind it, as we'd have to
-			 * die the moment it would acquire the lock.
-			 */
-			if (is_wait_die) {
-				int ret =3D __ww_mutex_kill(lock, ww_ctx);
-
-				if (ret)
-					return ret;
-			}
-
-			break;
-		}
-
-		pos =3D &cur->list;
-
-		/* Wait-Die: ensure younger waiters die. */
-		__ww_mutex_die(lock, cur, ww_ctx);
-	}
-
-	__mutex_add_waiter(lock, waiter, pos);
-
-	/*
-	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
-	 * wound that such that we might proceed.
-	 */
-	if (!is_wait_die) {
-		struct ww_mutex *ww =3D container_of(lock, struct ww_mutex, base);
-
-		/*
-		 * See ww_mutex_set_context_fastpath(). Orders setting
-		 * MUTEX_FLAG_WAITERS vs the ww->ctx load,
-		 * such that either we or the fastpath will wound @ww->ctx.
-		 */
-		smp_mb();
-		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
-	}
-
-	return 0;
-}
-
 /*
  * Lock a mutex (possibly interruptible), slowpath:
  */
@@ -928,7 +564,6 @@ __mutex_lock_common(struct mutex *lock, unsigned int stat=
e, unsigned int subclas
 		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
 {
 	struct mutex_waiter waiter;
-	bool first =3D false;
 	struct ww_mutex *ww;
 	int ret;
=20
@@ -937,9 +572,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int stat=
e, unsigned int subclas
=20
 	might_sleep();
=20
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock);
-#endif
+	MUTEX_WARN_ON(lock->magic !=3D lock);
=20
 	ww =3D container_of(lock, struct ww_mutex, base);
 	if (ww_ctx) {
@@ -953,6 +586,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int sta=
te, unsigned int subclas
 		 */
 		if (ww_ctx->acquired =3D=3D 0)
 			ww_ctx->wounded =3D 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock =3D &ww_ctx->dep_map;
+#endif
 	}
=20
 	preempt_disable();
@@ -968,7 +605,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int stat=
e, unsigned int subclas
 		return 0;
 	}
=20
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	/*
 	 * After waiting to acquire the wait_lock, try again.
 	 */
@@ -980,17 +617,15 @@ __mutex_lock_common(struct mutex *lock, unsigned int st=
ate, unsigned int subclas
 	}
=20
 	debug_mutex_lock_common(lock, &waiter);
+	waiter.task =3D current;
+	if (use_ww_ctx)
+		waiter.ww_ctx =3D ww_ctx;
=20
 	lock_contended(&lock->dep_map, ip);
=20
 	if (!use_ww_ctx) {
 		/* add waiting tasks to the end of the waitqueue (FIFO): */
 		__mutex_add_waiter(lock, &waiter, &lock->wait_list);
-
-
-#ifdef CONFIG_DEBUG_MUTEXES
-		waiter.ww_ctx =3D MUTEX_POISON_WW_CTX;
-#endif
 	} else {
 		/*
 		 * Add in stamp order, waking up waiters that must kill
@@ -999,14 +634,12 @@ __mutex_lock_common(struct mutex *lock, unsigned int st=
ate, unsigned int subclas
 		ret =3D __ww_mutex_add_waiter(&waiter, lock, ww_ctx);
 		if (ret)
 			goto err_early_kill;
-
-		waiter.ww_ctx =3D ww_ctx;
 	}
=20
-	waiter.task =3D current;
-
 	set_current_state(state);
 	for (;;) {
+		bool first;
+
 		/*
 		 * Once we hold wait_lock, we're serialized against
 		 * mutex_unlock() handing the lock off to us, do a trylock
@@ -1032,18 +665,10 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 				goto err;
 		}
=20
-		spin_unlock(&lock->wait_lock);
+		raw_spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
=20
-		/*
-		 * ww_mutex needs to always recheck its position since its waiter
-		 * list is not FIFO ordered.
-		 */
-		if (ww_ctx || !first) {
-			first =3D __mutex_waiter_is_first(lock, &waiter);
-			if (first)
-				__mutex_set_flag(lock, MUTEX_FLAG_HANDOFF);
-		}
+		first =3D __mutex_waiter_is_first(lock, &waiter);
=20
 		set_current_state(state);
 		/*
@@ -1051,13 +676,13 @@ __mutex_lock_common(struct mutex *lock, unsigned int s=
tate, unsigned int subclas
 		 * state back to RUNNING and fall through the next schedule(),
 		 * or we must see its unlock and acquire.
 		 */
-		if (__mutex_trylock(lock) ||
+		if (__mutex_trylock_or_handoff(lock, first) ||
 		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
 			break;
=20
-		spin_lock(&lock->wait_lock);
+		raw_spin_lock(&lock->wait_lock);
 	}
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 acquired:
 	__set_current_state(TASK_RUNNING);
=20
@@ -1082,7 +707,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int sta=
te, unsigned int subclas
 	if (ww_ctx)
 		ww_mutex_lock_acquired(ww, ww_ctx);
=20
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	preempt_enable();
 	return 0;
=20
@@ -1090,7 +715,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int sta=
te, unsigned int subclas
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
 	preempt_enable();
@@ -1106,10 +731,9 @@ __mutex_lock(struct mutex *lock, unsigned int state, un=
signed int subclass,
=20
 static int __sched
 __ww_mutex_lock(struct mutex *lock, unsigned int state, unsigned int subclas=
s,
-		struct lockdep_map *nest_lock, unsigned long ip,
-		struct ww_acquire_ctx *ww_ctx)
+		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, tr=
ue);
+	return __mutex_lock_common(lock, state, subclass, NULL, ip, ww_ctx, true);
 }
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1189,8 +813,7 @@ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_c=
tx *ctx)
=20
 	might_sleep();
 	ret =3D  __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE,
-			       0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			       ctx);
+			       0, _RET_IP_, ctx);
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
=20
@@ -1205,8 +828,7 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, struc=
t ww_acquire_ctx *ctx)
=20
 	might_sleep();
 	ret =3D __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE,
-			      0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
-			      ctx);
+			      0, _RET_IP_, ctx);
=20
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
@@ -1237,29 +859,21 @@ static noinline void __sched __mutex_unlock_slowpath(s=
truct mutex *lock, unsigne
 	 */
 	owner =3D atomic_long_read(&lock->owner);
 	for (;;) {
-		unsigned long old;
-
-#ifdef CONFIG_DEBUG_MUTEXES
-		DEBUG_LOCKS_WARN_ON(__owner_task(owner) !=3D current);
-		DEBUG_LOCKS_WARN_ON(owner & MUTEX_FLAG_PICKUP);
-#endif
+		MUTEX_WARN_ON(__owner_task(owner) !=3D current);
+		MUTEX_WARN_ON(owner & MUTEX_FLAG_PICKUP);
=20
 		if (owner & MUTEX_FLAG_HANDOFF)
 			break;
=20
-		old =3D atomic_long_cmpxchg_release(&lock->owner, owner,
-						  __owner_flags(owner));
-		if (old =3D=3D owner) {
+		if (atomic_long_try_cmpxchg_release(&lock->owner, &owner, __owner_flags(ow=
ner))) {
 			if (owner & MUTEX_FLAG_WAITERS)
 				break;
=20
 			return;
 		}
-
-		owner =3D old;
 	}
=20
-	spin_lock(&lock->wait_lock);
+	raw_spin_lock(&lock->wait_lock);
 	debug_mutex_unlock(lock);
 	if (!list_empty(&lock->wait_list)) {
 		/* get the first entry from the wait-list: */
@@ -1276,7 +890,7 @@ static noinline void __sched __mutex_unlock_slowpath(str=
uct mutex *lock, unsigne
 	if (owner & MUTEX_FLAG_HANDOFF)
 		__mutex_handoff(lock, next);
=20
-	spin_unlock(&lock->wait_lock);
+	raw_spin_unlock(&lock->wait_lock);
=20
 	wake_up_q(&wake_q);
 }
@@ -1380,7 +994,7 @@ __mutex_lock_interruptible_slowpath(struct mutex *lock)
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
=20
@@ -1388,7 +1002,7 @@ static noinline int __sched
 __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 					    struct ww_acquire_ctx *ctx)
 {
-	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0, NULL,
+	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0,
 			       _RET_IP_, ctx);
 }
=20
@@ -1412,9 +1026,7 @@ int __sched mutex_trylock(struct mutex *lock)
 {
 	bool locked;
=20
-#ifdef CONFIG_DEBUG_MUTEXES
-	DEBUG_LOCKS_WARN_ON(lock->magic !=3D lock);
-#endif
+	MUTEX_WARN_ON(lock->magic !=3D lock);
=20
 	locked =3D __mutex_trylock(lock);
 	if (locked)
@@ -1455,7 +1067,8 @@ ww_mutex_lock_interruptible(struct ww_mutex *lock, stru=
ct ww_acquire_ctx *ctx)
 }
 EXPORT_SYMBOL(ww_mutex_lock_interruptible);
=20
-#endif
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+#endif /* !CONFIG_PREEMPT_RT */
=20
 /**
  * atomic_dec_and_mutex_lock - return holding mutex if we dec to 0
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index f0c710b1d192..0b2a79c4013b 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -5,19 +5,41 @@
  * started by Ingo Molnar:
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.=
com>
- *
- * This file contains mutex debugging related internal prototypes, for the
- * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
=20
-#define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
-#define debug_mutex_free_waiter(waiter)			do { } while (0)
-#define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
-#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
-#define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name, key)		do { } while (0)
+/*
+ * This is the control structure for tasks blocked on mutex, which resides
+ * on the blocked task's kernel stack:
+ */
+struct mutex_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+	struct ww_acquire_ctx	*ww_ctx;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+};
=20
-static inline void
-debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
-{
-}
+#ifdef CONFIG_DEBUG_MUTEXES
+extern void debug_mutex_lock_common(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_wake_waiter(struct mutex *lock,
+				    struct mutex_waiter *waiter);
+extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
+extern void debug_mutex_add_waiter(struct mutex *lock,
+				   struct mutex_waiter *waiter,
+				   struct task_struct *task);
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waite=
r *waiter,
+				      struct task_struct *task);
+extern void debug_mutex_unlock(struct mutex *lock);
+extern void debug_mutex_init(struct mutex *lock, const char *name,
+			     struct lock_class_key *key);
+#else /* CONFIG_DEBUG_MUTEXES */
+# define debug_mutex_lock_common(lock, waiter)		do { } while (0)
+# define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
+# define debug_mutex_free_waiter(waiter)		do { } while (0)
+# define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_remove_waiter(lock, waiter, ti)	do { } while (0)
+# define debug_mutex_unlock(lock)			do { } while (0)
+# define debug_mutex_init(lock, name, key)		do { } while (0)
+#endif /* !CONFIG_DEBUG_MUTEXES */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ad0db322ed3b..8eabdc79602b 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -8,20 +8,58 @@
  *  Copyright (C) 2005-2006 Timesys Corp., Thomas Gleixner <tglx@timesys.com>
  *  Copyright (C) 2005 Kihon Technologies Inc., Steven Rostedt
  *  Copyright (C) 2006 Esben Nielsen
+ * Adaptive Spinlocks:
+ *  Copyright (C) 2008 Novell, Inc., Gregory Haskins, Sven Dietrich,
+ *				     and Peter Morreale,
+ * Adaptive Spinlocks simplification:
+ *  Copyright (C) 2008 Red Hat, Inc., Steven Rostedt <srostedt@redhat.com>
  *
  *  See Documentation/locking/rt-mutex-design.rst for details.
  */
-#include <linux/spinlock.h>
-#include <linux/export.h>
+#include <linux/sched.h>
+#include <linux/sched/debug.h>
+#include <linux/sched/deadline.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/rt.h>
-#include <linux/sched/deadline.h>
 #include <linux/sched/wake_q.h>
-#include <linux/sched/debug.h>
-#include <linux/timer.h>
+#include <linux/ww_mutex.h>
=20
 #include "rtmutex_common.h"
=20
+#ifndef WW_RT
+# define build_ww_mutex()	(false)
+# define ww_container_of(rtm)	NULL
+
+static inline int __ww_mutex_add_waiter(struct rt_mutex_waiter *waiter,
+					struct rt_mutex *lock,
+					struct ww_acquire_ctx *ww_ctx)
+{
+	return 0;
+}
+
+static inline void __ww_mutex_check_waiters(struct rt_mutex *lock,
+					    struct ww_acquire_ctx *ww_ctx)
+{
+}
+
+static inline void ww_mutex_lock_acquired(struct ww_mutex *lock,
+					  struct ww_acquire_ctx *ww_ctx)
+{
+}
+
+static inline int __ww_mutex_check_kill(struct rt_mutex *lock,
+					struct rt_mutex_waiter *waiter,
+					struct ww_acquire_ctx *ww_ctx)
+{
+	return 0;
+}
+
+#else
+# define build_ww_mutex()	(true)
+# define ww_container_of(rtm)	container_of(rtm, struct ww_mutex, base)
+# include "ww_mutex.h"
+#endif
+
 /*
  * lock->owner state tracking:
  *
@@ -50,7 +88,7 @@
  */
=20
 static __always_inline void
-rt_mutex_set_owner(struct rt_mutex *lock, struct task_struct *owner)
+rt_mutex_set_owner(struct rt_mutex_base *lock, struct task_struct *owner)
 {
 	unsigned long val =3D (unsigned long)owner;
=20
@@ -60,13 +98,13 @@ rt_mutex_set_owner(struct rt_mutex *lock, struct task_str=
uct *owner)
 	WRITE_ONCE(lock->owner, (struct task_struct *)val);
 }
=20
-static __always_inline void clear_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void clear_rt_mutex_waiters(struct rt_mutex_base *loc=
k)
 {
 	lock->owner =3D (struct task_struct *)
 			((unsigned long)lock->owner & ~RT_MUTEX_HAS_WAITERS);
 }
=20
-static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void fixup_rt_mutex_waiters(struct rt_mutex_base *loc=
k)
 {
 	unsigned long owner, *p =3D (unsigned long *) &lock->owner;
=20
@@ -141,15 +179,26 @@ static __always_inline void fixup_rt_mutex_waiters(stru=
ct rt_mutex *lock)
  * set up.
  */
 #ifndef CONFIG_DEBUG_RT_MUTEXES
-# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) =
=3D=3D c)
-# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) =
=3D=3D c)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *l=
ock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return try_cmpxchg_acquire(&lock->owner, &old, new);
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *l=
ock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return try_cmpxchg_release(&lock->owner, &old, new);
+}
=20
 /*
  * Callers must hold the ->wait_lock -- which is the whole purpose as we for=
ce
  * all future threads that attempt to [Rmw] the lock to the slowpath. As such
  * relaxed semantics suffice.
  */
-static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	unsigned long owner, *p =3D (unsigned long *) &lock->owner;
=20
@@ -165,7 +214,7 @@ static __always_inline void mark_rt_mutex_waiters(struct =
rt_mutex *lock)
  * 2) Drop lock->wait_lock
  * 3) Try to unlock the lock with cmpxchg
  */
-static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
@@ -201,10 +250,22 @@ static __always_inline bool unlock_rt_mutex_safe(struct=
 rt_mutex *lock,
 }
=20
 #else
-# define rt_mutex_cmpxchg_acquire(l,c,n)	(0)
-# define rt_mutex_cmpxchg_release(l,c,n)	(0)
+static __always_inline bool rt_mutex_cmpxchg_acquire(struct rt_mutex_base *l=
ock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+
+}
+
+static __always_inline bool rt_mutex_cmpxchg_release(struct rt_mutex_base *l=
ock,
+						     struct task_struct *old,
+						     struct task_struct *new)
+{
+	return false;
+}
=20
-static __always_inline void mark_rt_mutex_waiters(struct rt_mutex *lock)
+static __always_inline void mark_rt_mutex_waiters(struct rt_mutex_base *lock)
 {
 	lock->owner =3D (struct task_struct *)
 			((unsigned long)lock->owner | RT_MUTEX_HAS_WAITERS);
@@ -213,7 +274,7 @@ static __always_inline void mark_rt_mutex_waiters(struct =
rt_mutex *lock)
 /*
  * Simple slow path only version: lock->owner is protected by lock->wait_loc=
k.
  */
-static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex *lock,
+static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 						 unsigned long flags)
 	__releases(lock->wait_lock)
 {
@@ -223,11 +284,28 @@ static __always_inline bool unlock_rt_mutex_safe(struct=
 rt_mutex *lock,
 }
 #endif
=20
+static __always_inline int __waiter_prio(struct task_struct *task)
+{
+	int prio =3D task->prio;
+
+	if (!rt_prio(prio))
+		return DEFAULT_PRIO;
+
+	return prio;
+}
+
+static __always_inline void
+waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	waiter->prio =3D __waiter_prio(task);
+	waiter->deadline =3D task->dl.deadline;
+}
+
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio =3D (p)->prio, .deadline =3D (p)->dl.deadl=
ine }
+	&(struct rt_mutex_waiter){ .prio =3D __waiter_prio(p), .deadline =3D (p)->d=
l.deadline }
=20
 static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 						struct rt_mutex_waiter *right)
@@ -265,22 +343,63 @@ static __always_inline int rt_mutex_waiter_equal(struct=
 rt_mutex_waiter *left,
 	return 1;
 }
=20
+static inline bool rt_mutex_steal(struct rt_mutex_waiter *waiter,
+				  struct rt_mutex_waiter *top_waiter)
+{
+	if (rt_mutex_waiter_less(waiter, top_waiter))
+		return true;
+
+#ifdef RT_MUTEX_BUILD_SPINLOCKS
+	/*
+	 * Note that RT tasks are excluded from same priority (lateral)
+	 * steals to prevent the introduction of an unbounded latency.
+	 */
+	if (rt_prio(waiter->prio) || dl_prio(waiter->prio))
+		return false;
+
+	return rt_mutex_waiter_equal(waiter, top_waiter);
+#else
+	return false;
+#endif
+}
+
 #define __node_2_waiter(node) \
 	rb_entry((node), struct rt_mutex_waiter, tree_entry)
=20
 static __always_inline bool __waiter_less(struct rb_node *a, const struct rb=
_node *b)
 {
-	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));
+	struct rt_mutex_waiter *aw =3D __node_2_waiter(a);
+	struct rt_mutex_waiter *bw =3D __node_2_waiter(b);
+
+	if (rt_mutex_waiter_less(aw, bw))
+		return 1;
+
+	if (!build_ww_mutex())
+		return 0;
+
+	if (rt_mutex_waiter_less(bw, aw))
+		return 0;
+
+	/* NOTE: relies on waiter->ww_ctx being set before insertion */
+	if (aw->ww_ctx) {
+		if (!bw->ww_ctx)
+			return 1;
+
+		return (signed long)(aw->ww_ctx->stamp -
+				     bw->ww_ctx->stamp) < 0;
+	}
+
+	return 0;
 }
=20
 static __always_inline void
-rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+rt_mutex_enqueue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
 	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
 }
=20
 static __always_inline void
-rt_mutex_dequeue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
+rt_mutex_dequeue(struct rt_mutex_base *lock, struct rt_mutex_waiter *waiter)
 {
 	if (RB_EMPTY_NODE(&waiter->tree_entry))
 		return;
@@ -326,6 +445,35 @@ static __always_inline void rt_mutex_adjust_prio(struct =
task_struct *p)
 	rt_mutex_setprio(p, pi_task);
 }
=20
+/* RT mutex specific wake_q wrappers */
+static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
+						struct rt_mutex_waiter *w)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state !=3D TASK_NORMAL) {
+		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
+			WARN_ON_ONCE(wqh->rtlock_task);
+		get_task_struct(w->task);
+		wqh->rtlock_task =3D w->task;
+	} else {
+		wake_q_add(&wqh->head, w->task);
+	}
+}
+
+static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
+		wake_up_state(wqh->rtlock_task, TASK_RTLOCK_WAIT);
+		put_task_struct(wqh->rtlock_task);
+		wqh->rtlock_task =3D NULL;
+	}
+
+	if (!wake_q_empty(&wqh->head))
+		wake_up_q(&wqh->head);
+
+	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
+	preempt_enable();
+}
+
 /*
  * Deadlock detection is conditional:
  *
@@ -348,12 +496,7 @@ rt_mutex_cond_detect_deadlock(struct rt_mutex_waiter *wa=
iter,
 	return chwalk =3D=3D RT_MUTEX_FULL_CHAINWALK;
 }
=20
-/*
- * Max number of times we'll walk the boosting chain:
- */
-int max_lock_depth =3D 1024;
-
-static __always_inline struct rt_mutex *task_blocked_on_lock(struct task_str=
uct *p)
+static __always_inline struct rt_mutex_base *task_blocked_on_lock(struct tas=
k_struct *p)
 {
 	return p->pi_blocked_on ? p->pi_blocked_on->lock : NULL;
 }
@@ -423,15 +566,15 @@ static __always_inline struct rt_mutex *task_blocked_on=
_lock(struct task_struct
  */
 static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 					      enum rtmutex_chainwalk chwalk,
-					      struct rt_mutex *orig_lock,
-					      struct rt_mutex *next_lock,
+					      struct rt_mutex_base *orig_lock,
+					      struct rt_mutex_base *next_lock,
 					      struct rt_mutex_waiter *orig_waiter,
 					      struct task_struct *top_task)
 {
 	struct rt_mutex_waiter *waiter, *top_waiter =3D orig_waiter;
 	struct rt_mutex_waiter *prerequeue_top_waiter;
 	int ret =3D 0, depth =3D 0;
-	struct rt_mutex *lock;
+	struct rt_mutex_base *lock;
 	bool detect_deadlock;
 	bool requeue =3D true;
=20
@@ -513,6 +656,31 @@ static int __sched rt_mutex_adjust_prio_chain(struct tas=
k_struct *task,
 	if (next_lock !=3D waiter->lock)
 		goto out_unlock_pi;
=20
+	/*
+	 * There could be 'spurious' loops in the lock graph due to ww_mutex,
+	 * consider:
+	 *
+	 *   P1: A, ww_A, ww_B
+	 *   P2: ww_B, ww_A
+	 *   P3: A
+	 *
+	 * P3 should not return -EDEADLK because it gets trapped in the cycle
+	 * created by P1 and P2 (which will resolve -- and runs into
+	 * max_lock_depth above). Therefore disable detect_deadlock such that
+	 * the below termination condition can trigger once all relevant tasks
+	 * are boosted.
+	 *
+	 * Even when we start with ww_mutex we can disable deadlock detection,
+	 * since we would supress a ww_mutex induced deadlock at [6] anyway.
+	 * Supressing it here however is not sufficient since we might still
+	 * hit [6] due to adjustment driven iteration.
+	 *
+	 * NOTE: if someone were to create a deadlock between 2 ww_classes we'd
+	 * utterly fail to report it; lockdep should.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && waiter->ww_ctx && detect_deadlock)
+		detect_deadlock =3D false;
+
 	/*
 	 * Drop out, when the task has no waiters. Note,
 	 * top_waiter can be NULL, when we are in the deboosting
@@ -574,8 +742,21 @@ static int __sched rt_mutex_adjust_prio_chain(struct tas=
k_struct *task,
 	 * walk, we detected a deadlock.
 	 */
 	if (lock =3D=3D orig_lock || rt_mutex_owner(lock) =3D=3D top_task) {
-		raw_spin_unlock(&lock->wait_lock);
 		ret =3D -EDEADLK;
+
+		/*
+		 * When the deadlock is due to ww_mutex; also see above. Don't
+		 * report the deadlock and instead let the ww_mutex wound/die
+		 * logic pick which of the contending threads gets -EDEADLK.
+		 *
+		 * NOTE: assumes the cycle only contains a single ww_class; any
+		 * other configuration and we fail to report; also, see
+		 * lockdep.
+		 */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && orig_waiter->ww_ctx)
+			ret =3D 0;
+
+		raw_spin_unlock(&lock->wait_lock);
 		goto out_unlock_pi;
 	}
=20
@@ -653,8 +834,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task=
_struct *task,
 	 * serializes all pi_waiters access and rb_erase() does not care about
 	 * the values of the node being removed.
 	 */
-	waiter->prio =3D task->prio;
-	waiter->deadline =3D task->dl.deadline;
+	waiter_update_prio(waiter, task);
=20
 	rt_mutex_enqueue(lock, waiter);
=20
@@ -676,7 +856,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task=
_struct *task,
 		 * to get the lock.
 		 */
 		if (prerequeue_top_waiter !=3D rt_mutex_top_waiter(lock))
-			wake_up_process(rt_mutex_top_waiter(lock)->task);
+			wake_up_state(waiter->task, waiter->wake_state);
 		raw_spin_unlock_irq(&lock->wait_lock);
 		return 0;
 	}
@@ -779,7 +959,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task=
_struct *task,
  *	    callsite called task_blocked_on_lock(), otherwise NULL
  */
 static int __sched
-try_to_take_rt_mutex(struct rt_mutex *lock, struct task_struct *task,
+try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 		     struct rt_mutex_waiter *waiter)
 {
 	lockdep_assert_held(&lock->wait_lock);
@@ -815,19 +995,21 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct task=
_struct *task,
 	 * trylock attempt.
 	 */
 	if (waiter) {
-		/*
-		 * If waiter is not the highest priority waiter of
-		 * @lock, give up.
-		 */
-		if (waiter !=3D rt_mutex_top_waiter(lock))
-			return 0;
+		struct rt_mutex_waiter *top_waiter =3D rt_mutex_top_waiter(lock);
=20
 		/*
-		 * We can acquire the lock. Remove the waiter from the
-		 * lock waiters tree.
+		 * If waiter is the highest priority waiter of @lock,
+		 * or allowed to steal it, take it over.
 		 */
-		rt_mutex_dequeue(lock, waiter);
-
+		if (waiter =3D=3D top_waiter || rt_mutex_steal(waiter, top_waiter)) {
+			/*
+			 * We can acquire the lock. Remove the waiter from the
+			 * lock waiters tree.
+			 */
+			rt_mutex_dequeue(lock, waiter);
+		} else {
+			return 0;
+		}
 	} else {
 		/*
 		 * If the lock has waiters already we check whether @task is
@@ -838,13 +1020,9 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct task=
_struct *task,
 		 * not need to be dequeued.
 		 */
 		if (rt_mutex_has_waiters(lock)) {
-			/*
-			 * If @task->prio is greater than or equal to
-			 * the top waiter priority (kernel view),
-			 * @task lost.
-			 */
-			if (!rt_mutex_waiter_less(task_to_waiter(task),
-						  rt_mutex_top_waiter(lock)))
+			/* Check whether the trylock can steal it. */
+			if (!rt_mutex_steal(task_to_waiter(task),
+					    rt_mutex_top_waiter(lock)))
 				return 0;
=20
 			/*
@@ -897,14 +1075,15 @@ try_to_take_rt_mutex(struct rt_mutex *lock, struct tas=
k_struct *task,
  *
  * This must be called with lock->wait_lock held and interrupts disabled
  */
-static int __sched task_blocks_on_rt_mutex(struct rt_mutex *lock,
+static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 					   struct rt_mutex_waiter *waiter,
 					   struct task_struct *task,
+					   struct ww_acquire_ctx *ww_ctx,
 					   enum rtmutex_chainwalk chwalk)
 {
 	struct task_struct *owner =3D rt_mutex_owner(lock);
 	struct rt_mutex_waiter *top_waiter =3D waiter;
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
 	int chain_walk =3D 0, res;
=20
 	lockdep_assert_held(&lock->wait_lock);
@@ -924,8 +1103,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mut=
ex *lock,
 	raw_spin_lock(&task->pi_lock);
 	waiter->task =3D task;
 	waiter->lock =3D lock;
-	waiter->prio =3D task->prio;
-	waiter->deadline =3D task->dl.deadline;
+	waiter_update_prio(waiter, task);
=20
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
@@ -936,6 +1114,21 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mu=
tex *lock,
=20
 	raw_spin_unlock(&task->pi_lock);
=20
+	if (build_ww_mutex() && ww_ctx) {
+		struct rt_mutex *rtm;
+
+		/* Check whether the waiter should back out immediately */
+		rtm =3D container_of(lock, struct rt_mutex, rtmutex);
+		res =3D __ww_mutex_add_waiter(waiter, rtm, ww_ctx);
+		if (res) {
+			raw_spin_lock(&task->pi_lock);
+			rt_mutex_dequeue(lock, waiter);
+			task->pi_blocked_on =3D NULL;
+			raw_spin_unlock(&task->pi_lock);
+			return res;
+		}
+	}
+
 	if (!owner)
 		return 0;
=20
@@ -986,8 +1179,8 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mut=
ex *lock,
  *
  * Called with lock->wait_lock held and interrupts disabled.
  */
-static void __sched mark_wakeup_next_waiter(struct wake_q_head *wake_q,
-					    struct rt_mutex *lock)
+static void __sched mark_wakeup_next_waiter(struct rt_wake_q_head *wqh,
+					    struct rt_mutex_base *lock)
 {
 	struct rt_mutex_waiter *waiter;
=20
@@ -1023,25 +1216,201 @@ static void __sched mark_wakeup_next_waiter(struct w=
ake_q_head *wake_q,
 	 * deboost but before waking our donor task, hence the preempt_disable()
 	 * before unlock.
 	 *
-	 * Pairs with preempt_enable() in rt_mutex_postunlock();
+	 * Pairs with preempt_enable() in rt_mutex_wake_up_q();
 	 */
 	preempt_disable();
-	wake_q_add(wake_q, waiter->task);
+	rt_mutex_wake_q_add(wqh, waiter);
 	raw_spin_unlock(&current->pi_lock);
 }
=20
+static int __sched __rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+{
+	int ret =3D try_to_take_rt_mutex(lock, current, NULL);
+
+	/*
+	 * try_to_take_rt_mutex() sets the lock waiters bit
+	 * unconditionally. Clean this up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
+	return ret;
+}
+
+/*
+ * Slow path try-lock function:
+ */
+static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
+{
+	unsigned long flags;
+	int ret;
+
+	/*
+	 * If the lock already has an owner we fail to get the lock.
+	 * This can be done without taking the @lock->wait_lock as
+	 * it is only being read, and this is a trylock anyway.
+	 */
+	if (rt_mutex_owner(lock))
+		return 0;
+
+	/*
+	 * The mutex has currently no owner. Lock the wait lock and try to
+	 * acquire the lock. We use irqsave here to support early boot calls.
+	 */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	ret =3D __rt_mutex_slowtrylock(lock);
+
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	return ret;
+}
+
+static __always_inline int __rt_mutex_trylock(struct rt_mutex_base *lock)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(lock);
+}
+
+/*
+ * Slow path to release a rt-mutex.
+ */
+static void __sched rt_mutex_slowunlock(struct rt_mutex_base *lock)
+{
+	DEFINE_RT_WAKE_Q(wqh);
+	unsigned long flags;
+
+	/* irqsave required to support early boot calls */
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+
+	debug_rt_mutex_unlock(lock);
+
+	/*
+	 * We must be careful here if the fast path is enabled. If we
+	 * have no waiters queued we cannot set owner to NULL here
+	 * because of:
+	 *
+	 * foo->lock->owner =3D NULL;
+	 *			rtmutex_lock(foo->lock);   <- fast path
+	 *			free =3D atomic_dec_and_test(foo->refcnt);
+	 *			rtmutex_unlock(foo->lock); <- fast path
+	 *			if (free)
+	 *				kfree(foo);
+	 * raw_spin_unlock(foo->lock->wait_lock);
+	 *
+	 * So for the fastpath enabled kernel:
+	 *
+	 * Nothing can set the waiters bit as long as we hold
+	 * lock->wait_lock. So we do the following sequence:
+	 *
+	 *	owner =3D rt_mutex_owner(lock);
+	 *	clear_rt_mutex_waiters(lock);
+	 *	raw_spin_unlock(&lock->wait_lock);
+	 *	if (cmpxchg(&lock->owner, owner, 0) =3D=3D owner)
+	 *		return;
+	 *	goto retry;
+	 *
+	 * The fastpath disabled variant is simple as all access to
+	 * lock->owner is serialized by lock->wait_lock:
+	 *
+	 *	lock->owner =3D NULL;
+	 *	raw_spin_unlock(&lock->wait_lock);
+	 */
+	while (!rt_mutex_has_waiters(lock)) {
+		/* Drops lock->wait_lock ! */
+		if (unlock_rt_mutex_safe(lock, flags) =3D=3D true)
+			return;
+		/* Relock the rtmutex and try again */
+		raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	}
+
+	/*
+	 * The wakeup next waiter path does not suffer from the above
+	 * race. See the comments there.
+	 *
+	 * Queue the next waiter for wakeup once we release the wait_lock.
+	 */
+	mark_wakeup_next_waiter(&wqh, lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	rt_mutex_wake_up_q(&wqh);
+}
+
+static __always_inline void __rt_mutex_unlock(struct rt_mutex_base *lock)
+{
+	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(lock);
+}
+
+#ifdef CONFIG_SMP
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
+{
+	bool res =3D true;
+
+	rcu_read_lock();
+	for (;;) {
+		/* If owner changed, trylock again. */
+		if (owner !=3D rt_mutex_owner(lock))
+			break;
+		/*
+		 * Ensure that @owner is dereferenced after checking that
+		 * the lock owner still matches @owner. If that fails,
+		 * @owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 */
+		barrier();
+		/*
+		 * Stop spinning when:
+		 *  - the lock owner has been scheduled out
+		 *  - current is not longer the top waiter
+		 *  - current is requested to reschedule (redundant
+		 *    for CONFIG_PREEMPT_RCU=3Dy)
+		 *  - the VCPU on which owner runs is preempted
+		 */
+		if (!owner->on_cpu || need_resched() ||
+		    rt_mutex_waiter_is_top_waiter(lock, waiter) ||
+		    vcpu_is_preempted(task_cpu(owner))) {
+			res =3D false;
+			break;
+		}
+		cpu_relax();
+	}
+	rcu_read_unlock();
+	return res;
+}
+#else
+static bool rtmutex_spin_on_owner(struct rt_mutex_base *lock,
+				  struct rt_mutex_waiter *waiter,
+				  struct task_struct *owner)
+{
+	return false;
+}
+#endif
+
+#ifdef RT_MUTEX_BUILD_MUTEX
+/*
+ * Functions required for:
+ *	- rtmutex, futex on all kernels
+ *	- mutex and rwsem substitutions on RT kernels
+ */
+
 /*
  * Remove a waiter from a lock and give up
  *
- * Must be called with lock->wait_lock held and interrupts disabled. I must
+ * Must be called with lock->wait_lock held and interrupts disabled. It must
  * have just failed to try_to_take_rt_mutex().
  */
-static void __sched remove_waiter(struct rt_mutex *lock,
+static void __sched remove_waiter(struct rt_mutex_base *lock,
 				  struct rt_mutex_waiter *waiter)
 {
 	bool is_top_waiter =3D (waiter =3D=3D rt_mutex_top_waiter(lock));
 	struct task_struct *owner =3D rt_mutex_owner(lock);
-	struct rt_mutex *next_lock;
+	struct rt_mutex_base *next_lock;
=20
 	lockdep_assert_held(&lock->wait_lock);
=20
@@ -1089,56 +1458,25 @@ static void __sched remove_waiter(struct rt_mutex *lo=
ck,
 	raw_spin_lock_irq(&lock->wait_lock);
 }
=20
-/*
- * Recheck the pi chain, in case we got a priority setting
+/**
+ * rt_mutex_slowlock_block() - Perform the wait-wake-try-to-take loop
+ * @lock:		 the rt_mutex to take
+ * @ww_ctx:		 WW mutex context pointer
+ * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
+ *			 or TASK_UNINTERRUPTIBLE)
+ * @timeout:		 the pre-initialized and started timer, or NULL for none
+ * @waiter:		 the pre-initialized rt_mutex_waiter
  *
- * Called from sched_setscheduler
+ * Must be called with lock->wait_lock held and interrupts disabled
  */
-void __sched rt_mutex_adjust_pi(struct task_struct *task)
-{
-	struct rt_mutex_waiter *waiter;
-	struct rt_mutex *next_lock;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&task->pi_lock, flags);
-
-	waiter =3D task->pi_blocked_on;
-	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
-		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-		return;
-	}
-	next_lock =3D waiter->lock;
-	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
-
-	/* gets dropped in rt_mutex_adjust_prio_chain()! */
-	get_task_struct(task);
-
-	rt_mutex_adjust_prio_chain(task, RT_MUTEX_MIN_CHAINWALK, NULL,
-				   next_lock, NULL, task);
-}
-
-void __sched rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
-{
-	debug_rt_mutex_init_waiter(waiter);
-	RB_CLEAR_NODE(&waiter->pi_tree_entry);
-	RB_CLEAR_NODE(&waiter->tree_entry);
-	waiter->task =3D NULL;
-}
-
-/**
- * __rt_mutex_slowlock() - Perform the wait-wake-try-to-take loop
- * @lock:		 the rt_mutex to take
- * @state:		 the state the task should block in (TASK_INTERRUPTIBLE
- *			 or TASK_UNINTERRUPTIBLE)
- * @timeout:		 the pre-initialized and started timer, or NULL for none
- * @waiter:		 the pre-initialized rt_mutex_waiter
- *
- * Must be called with lock->wait_lock held and interrupts disabled
- */
-static int __sched __rt_mutex_slowlock(struct rt_mutex *lock, unsigned int s=
tate,
-				       struct hrtimer_sleeper *timeout,
-				       struct rt_mutex_waiter *waiter)
+static int __sched rt_mutex_slowlock_block(struct rt_mutex_base *lock,
+					   struct ww_acquire_ctx *ww_ctx,
+					   unsigned int state,
+					   struct hrtimer_sleeper *timeout,
+					   struct rt_mutex_waiter *waiter)
 {
+	struct rt_mutex *rtm =3D container_of(lock, struct rt_mutex, rtmutex);
+	struct task_struct *owner;
 	int ret =3D 0;
=20
 	for (;;) {
@@ -1155,9 +1493,20 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex=
 *lock, unsigned int state
 			break;
 		}
=20
+		if (build_ww_mutex() && ww_ctx) {
+			ret =3D __ww_mutex_check_kill(rtm, waiter, ww_ctx);
+			if (ret)
+				break;
+		}
+
+		if (waiter =3D=3D rt_mutex_top_waiter(lock))
+			owner =3D rt_mutex_owner(lock);
+		else
+			owner =3D NULL;
 		raw_spin_unlock_irq(&lock->wait_lock);
=20
-		schedule();
+		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
+			schedule();
=20
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1177,6 +1526,9 @@ static void __sched rt_mutex_handle_deadlock(int res, i=
nt detect_deadlock,
 	if (res !=3D -EDEADLOCK || detect_deadlock)
 		return;
=20
+	if (build_ww_mutex() && w->ww_ctx)
+		return;
+
 	/*
 	 * Yell loudly and stop the task right here.
 	 */
@@ -1187,51 +1539,52 @@ static void __sched rt_mutex_handle_deadlock(int res,=
 int detect_deadlock,
 	}
 }
=20
-/*
- * Slow path lock function:
+/**
+ * __rt_mutex_slowlock - Locking slowpath invoked with lock::wait_lock held
+ * @lock:	The rtmutex to block lock
+ * @ww_ctx:	WW mutex context pointer
+ * @state:	The task state for sleeping
+ * @chwalk:	Indicator whether full or partial chainwalk is requested
+ * @waiter:	Initializer waiter for blocking
  */
-static int __sched rt_mutex_slowlock(struct rt_mutex *lock, unsigned int sta=
te,
-				     struct hrtimer_sleeper *timeout,
-				     enum rtmutex_chainwalk chwalk)
+static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
+				       struct ww_acquire_ctx *ww_ctx,
+				       unsigned int state,
+				       enum rtmutex_chainwalk chwalk,
+				       struct rt_mutex_waiter *waiter)
 {
-	struct rt_mutex_waiter waiter;
-	unsigned long flags;
-	int ret =3D 0;
-
-	rt_mutex_init_waiter(&waiter);
+	struct rt_mutex *rtm =3D container_of(lock, struct rt_mutex, rtmutex);
+	struct ww_mutex *ww =3D ww_container_of(rtm);
+	int ret;
=20
-	/*
-	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
-	 * be called in early boot if the cmpxchg() fast path is disabled
-	 * (debug, no architecture support). In this case we will acquire the
-	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
-	 * enable interrupts in that early boot case. So we need to use the
-	 * irqsave/restore variants.
-	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	lockdep_assert_held(&lock->wait_lock);
=20
 	/* Try to acquire the lock again: */
 	if (try_to_take_rt_mutex(lock, current, NULL)) {
-		raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+		if (build_ww_mutex() && ww_ctx) {
+			__ww_mutex_check_waiters(rtm, ww_ctx);
+			ww_mutex_lock_acquired(ww, ww_ctx);
+		}
 		return 0;
 	}
=20
 	set_current_state(state);
=20
-	/* Setup the timer, when timeout !=3D NULL */
-	if (unlikely(timeout))
-		hrtimer_start_expires(&timeout->timer, HRTIMER_MODE_ABS);
-
-	ret =3D task_blocks_on_rt_mutex(lock, &waiter, current, chwalk);
-
+	ret =3D task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
 	if (likely(!ret))
-		/* sleep on the mutex */
-		ret =3D __rt_mutex_slowlock(lock, state, timeout, &waiter);
-
-	if (unlikely(ret)) {
+		ret =3D rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
+
+	if (likely(!ret)) {
+		/* acquired the lock */
+		if (build_ww_mutex() && ww_ctx) {
+			if (!ww_ctx->is_wait_die)
+				__ww_mutex_check_waiters(rtm, ww_ctx);
+			ww_mutex_lock_acquired(ww, ww_ctx);
+		}
+	} else {
 		__set_current_state(TASK_RUNNING);
-		remove_waiter(lock, &waiter);
-		rt_mutex_handle_deadlock(ret, chwalk, &waiter);
+		remove_waiter(lock, waiter);
+		rt_mutex_handle_deadlock(ret, chwalk, waiter);
 	}
=20
 	/*
@@ -1239,547 +1592,126 @@ static int __sched rt_mutex_slowlock(struct rt_mute=
x *lock, unsigned int state,
 	 * unconditionally. We might have to fix that up.
 	 */
 	fixup_rt_mutex_waiters(lock);
-
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	/* Remove pending timer: */
-	if (unlikely(timeout))
-		hrtimer_cancel(&timeout->timer);
-
-	debug_rt_mutex_free_waiter(&waiter);
-
 	return ret;
 }
=20
-static int __sched __rt_mutex_slowtrylock(struct rt_mutex *lock)
+static inline int __rt_mutex_slowlock_locked(struct rt_mutex_base *lock,
+					     struct ww_acquire_ctx *ww_ctx,
+					     unsigned int state)
 {
-	int ret =3D try_to_take_rt_mutex(lock, current, NULL);
+	struct rt_mutex_waiter waiter;
+	int ret;
=20
-	/*
-	 * try_to_take_rt_mutex() sets the lock waiters bit
-	 * unconditionally. Clean this up.
-	 */
-	fixup_rt_mutex_waiters(lock);
+	rt_mutex_init_waiter(&waiter);
+	waiter.ww_ctx =3D ww_ctx;
+
+	ret =3D __rt_mutex_slowlock(lock, ww_ctx, state, RT_MUTEX_MIN_CHAINWALK,
+				  &waiter);
=20
+	debug_rt_mutex_free_waiter(&waiter);
 	return ret;
 }
=20
 /*
- * Slow path try-lock function:
+ * rt_mutex_slowlock - Locking slowpath invoked when fast path fails
+ * @lock:	The rtmutex to block lock
+ * @ww_ctx:	WW mutex context pointer
+ * @state:	The task state for sleeping
  */
-static int __sched rt_mutex_slowtrylock(struct rt_mutex *lock)
+static int __sched rt_mutex_slowlock(struct rt_mutex_base *lock,
+				     struct ww_acquire_ctx *ww_ctx,
+				     unsigned int state)
 {
 	unsigned long flags;
 	int ret;
=20
 	/*
-	 * If the lock already has an owner we fail to get the lock.
-	 * This can be done without taking the @lock->wait_lock as
-	 * it is only being read, and this is a trylock anyway.
-	 */
-	if (rt_mutex_owner(lock))
-		return 0;
-
-	/*
-	 * The mutex has currently no owner. Lock the wait lock and try to
-	 * acquire the lock. We use irqsave here to support early boot calls.
+	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
+	 * be called in early boot if the cmpxchg() fast path is disabled
+	 * (debug, no architecture support). In this case we will acquire the
+	 * rtmutex with lock->wait_lock held. But we cannot unconditionally
+	 * enable interrupts in that early boot case. So we need to use the
+	 * irqsave/restore variants.
 	 */
 	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	ret =3D __rt_mutex_slowtrylock(lock);
-
+	ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
=20
 	return ret;
 }
=20
-/*
- * Performs the wakeup of the top-waiter and re-enables preemption.
- */
-void __sched rt_mutex_postunlock(struct wake_q_head *wake_q)
-{
-	wake_up_q(wake_q);
-
-	/* Pairs with preempt_disable() in mark_wakeup_next_waiter() */
-	preempt_enable();
-}
-
-/*
- * Slow path to release a rt-mutex.
- *
- * Return whether the current task needs to call rt_mutex_postunlock().
- */
-static void __sched rt_mutex_slowunlock(struct rt_mutex *lock)
-{
-	DEFINE_WAKE_Q(wake_q);
-	unsigned long flags;
-
-	/* irqsave required to support early boot calls */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-
-	debug_rt_mutex_unlock(lock);
-
-	/*
-	 * We must be careful here if the fast path is enabled. If we
-	 * have no waiters queued we cannot set owner to NULL here
-	 * because of:
-	 *
-	 * foo->lock->owner =3D NULL;
-	 *			rtmutex_lock(foo->lock);   <- fast path
-	 *			free =3D atomic_dec_and_test(foo->refcnt);
-	 *			rtmutex_unlock(foo->lock); <- fast path
-	 *			if (free)
-	 *				kfree(foo);
-	 * raw_spin_unlock(foo->lock->wait_lock);
-	 *
-	 * So for the fastpath enabled kernel:
-	 *
-	 * Nothing can set the waiters bit as long as we hold
-	 * lock->wait_lock. So we do the following sequence:
-	 *
-	 *	owner =3D rt_mutex_owner(lock);
-	 *	clear_rt_mutex_waiters(lock);
-	 *	raw_spin_unlock(&lock->wait_lock);
-	 *	if (cmpxchg(&lock->owner, owner, 0) =3D=3D owner)
-	 *		return;
-	 *	goto retry;
-	 *
-	 * The fastpath disabled variant is simple as all access to
-	 * lock->owner is serialized by lock->wait_lock:
-	 *
-	 *	lock->owner =3D NULL;
-	 *	raw_spin_unlock(&lock->wait_lock);
-	 */
-	while (!rt_mutex_has_waiters(lock)) {
-		/* Drops lock->wait_lock ! */
-		if (unlock_rt_mutex_safe(lock, flags) =3D=3D true)
-			return;
-		/* Relock the rtmutex and try again */
-		raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	}
-
-	/*
-	 * The wakeup next waiter path does not suffer from the above
-	 * race. See the comments there.
-	 *
-	 * Queue the next waiter for wakeup once we release the wait_lock.
-	 */
-	mark_wakeup_next_waiter(&wake_q, lock);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	rt_mutex_postunlock(&wake_q);
-}
-
-/*
- * debug aware fast / slowpath lock,trylock,unlock
- *
- * The atomic acquire/release ops are compiled away, when either the
- * architecture does not support cmpxchg or when debugging is enabled.
- */
-static __always_inline int __rt_mutex_lock(struct rt_mutex *lock, long state,
-					   unsigned int subclass)
+static __always_inline int __rt_mutex_lock(struct rt_mutex_base *lock,
+					   unsigned int state)
 {
-	int ret;
-
-	might_sleep();
-	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
-
 	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
 		return 0;
=20
-	ret =3D rt_mutex_slowlock(lock, state, NULL, RT_MUTEX_MIN_CHAINWALK);
-	if (ret)
-		mutex_release(&lock->dep_map, _RET_IP_);
-	return ret;
+	return rt_mutex_slowlock(lock, NULL, state);
 }
+#endif /* RT_MUTEX_BUILD_MUTEX */
=20
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-/**
- * rt_mutex_lock_nested - lock a rt_mutex
- *
- * @lock: the rt_mutex to be locked
- * @subclass: the lockdep subclass
- */
-void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subcla=
ss)
-{
-	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass);
-}
-EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
-
-#else /* !CONFIG_DEBUG_LOCK_ALLOC */
-
-/**
- * rt_mutex_lock - lock a rt_mutex
- *
- * @lock: the rt_mutex to be locked
- */
-void __sched rt_mutex_lock(struct rt_mutex *lock)
-{
-	__rt_mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0);
-}
-EXPORT_SYMBOL_GPL(rt_mutex_lock);
-#endif
-
-/**
- * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
- *
- * @lock:		the rt_mutex to be locked
- *
- * Returns:
- *  0		on success
- * -EINTR	when interrupted by a signal
- */
-int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
-{
-	return __rt_mutex_lock(lock, TASK_INTERRUPTIBLE, 0);
-}
-EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
-
-/**
- * rt_mutex_trylock - try to lock a rt_mutex
- *
- * @lock:	the rt_mutex to be locked
- *
- * This function can only be called in thread context. It's safe to call it
- * from atomic regions, but not from hard or soft interrupt context.
- *
- * Returns:
- *  1 on success
- *  0 on contention
- */
-int __sched rt_mutex_trylock(struct rt_mutex *lock)
-{
-	int ret;
-
-	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
-		return 0;
-
-	/*
-	 * No lockdep annotation required because lockdep disables the fast
-	 * path.
-	 */
-	if (likely(rt_mutex_cmpxchg_acquire(lock, NULL, current)))
-		return 1;
-
-	ret =3D rt_mutex_slowtrylock(lock);
-	if (ret)
-		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rt_mutex_trylock);
-
-/**
- * rt_mutex_unlock - unlock a rt_mutex
- *
- * @lock: the rt_mutex to be unlocked
- */
-void __sched rt_mutex_unlock(struct rt_mutex *lock)
-{
-	mutex_release(&lock->dep_map, _RET_IP_);
-	if (likely(rt_mutex_cmpxchg_release(lock, current, NULL)))
-		return;
-
-	rt_mutex_slowunlock(lock);
-}
-EXPORT_SYMBOL_GPL(rt_mutex_unlock);
-
+#ifdef RT_MUTEX_BUILD_SPINLOCKS
 /*
- * Futex variants, must not use fastpath.
+ * Functions required for spin/rw_lock substitution on RT kernels
  */
-int __sched rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return rt_mutex_slowtrylock(lock);
-}
-
-int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
-{
-	return __rt_mutex_slowtrylock(lock);
-}
=20
 /**
- * __rt_mutex_futex_unlock - Futex variant, that since futex variants
- * do not use the fast-path, can be simple and will not need to retry.
- *
- * @lock:	The rt_mutex to be unlocked
- * @wake_q:	The wake queue head from which to get the next lock waiter
+ * rtlock_slowlock_locked - Slow path lock acquisition for RT locks
+ * @lock:	The underlying RT mutex
  */
-bool __sched __rt_mutex_futex_unlock(struct rt_mutex *lock,
-				     struct wake_q_head *wake_q)
+static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
 {
-	lockdep_assert_held(&lock->wait_lock);
-
-	debug_rt_mutex_unlock(lock);
-
-	if (!rt_mutex_has_waiters(lock)) {
-		lock->owner =3D NULL;
-		return false; /* done */
-	}
-
-	/*
-	 * We've already deboosted, mark_wakeup_next_waiter() will
-	 * retain preempt_disabled when we drop the wait_lock, to
-	 * avoid inversion prior to the wakeup.  preempt_disable()
-	 * therein pairs with rt_mutex_postunlock().
-	 */
-	mark_wakeup_next_waiter(wake_q, lock);
-
-	return true; /* call postunlock() */
-}
-
-void __sched rt_mutex_futex_unlock(struct rt_mutex *lock)
-{
-	DEFINE_WAKE_Q(wake_q);
-	unsigned long flags;
-	bool postunlock;
-
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
-	postunlock =3D __rt_mutex_futex_unlock(lock, &wake_q);
-	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
-
-	if (postunlock)
-		rt_mutex_postunlock(&wake_q);
-}
+	struct rt_mutex_waiter waiter;
+	struct task_struct *owner;
=20
-/**
- * __rt_mutex_init - initialize the rt_mutex
- *
- * @lock:	The rt_mutex to be initialized
- * @name:	The lock name used for debugging
- * @key:	The lock class key used for debugging
- *
- * Initialize the rt_mutex to unlocked state.
- *
- * Initializing of a locked rt_mutex is not allowed
- */
-void __sched __rt_mutex_init(struct rt_mutex *lock, const char *name,
-		     struct lock_class_key *key)
-{
-	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
-	lockdep_init_map(&lock->dep_map, name, key, 0);
+	lockdep_assert_held(&lock->wait_lock);
=20
-	__rt_mutex_basic_init(lock);
-}
-EXPORT_SYMBOL_GPL(__rt_mutex_init);
+	if (try_to_take_rt_mutex(lock, current, NULL))
+		return;
=20
-/**
- * rt_mutex_init_proxy_locked - initialize and lock a rt_mutex on behalf of a
- *				proxy owner
- *
- * @lock:	the rt_mutex to be locked
- * @proxy_owner:the task to set as owner
- *
- * No locking. Caller has to do serializing itself
- *
- * Special API call for PI-futex support. This initializes the rtmutex and
- * assigns it to @proxy_owner. Concurrent operations on the rtmutex are not
- * possible at this point because the pi_state which contains the rtmutex
- * is not yet visible to other tasks.
- */
-void __sched rt_mutex_init_proxy_locked(struct rt_mutex *lock,
-					struct task_struct *proxy_owner)
-{
-	__rt_mutex_basic_init(lock);
-	rt_mutex_set_owner(lock, proxy_owner);
-}
+	rt_mutex_init_rtlock_waiter(&waiter);
=20
-/**
- * rt_mutex_proxy_unlock - release a lock on behalf of owner
- *
- * @lock:	the rt_mutex to be locked
- *
- * No locking. Caller has to do serializing itself
- *
- * Special API call for PI-futex support. This merrily cleans up the rtmutex
- * (debugging) state. Concurrent operations on this rt_mutex are not
- * possible because it belongs to the pi_state which is about to be freed
- * and it is not longer visible to other tasks.
- */
-void __sched rt_mutex_proxy_unlock(struct rt_mutex *lock)
-{
-	debug_rt_mutex_proxy_unlock(lock);
-	rt_mutex_set_owner(lock, NULL);
-}
+	/* Save current state and set state to TASK_RTLOCK_WAIT */
+	current_save_and_set_rtlock_wait_state();
=20
-/**
- * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
- * @lock:		the rt_mutex to take
- * @waiter:		the pre-initialized rt_mutex_waiter
- * @task:		the task to prepare
- *
- * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
- * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
- *
- * NOTE: does _NOT_ remove the @waiter on failure; must either call
- * rt_mutex_wait_proxy_lock() or rt_mutex_cleanup_proxy_lock() after this.
- *
- * Returns:
- *  0 - task blocked on lock
- *  1 - acquired the lock for task, caller should wake it up
- * <0 - error
- *
- * Special API call for PI-futex support.
- */
-int __sched __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
-					struct rt_mutex_waiter *waiter,
-					struct task_struct *task)
-{
-	int ret;
+	task_blocks_on_rt_mutex(lock, &waiter, current, NULL, RT_MUTEX_MIN_CHAINWAL=
K);
=20
-	lockdep_assert_held(&lock->wait_lock);
+	for (;;) {
+		/* Try to acquire the lock again */
+		if (try_to_take_rt_mutex(lock, current, &waiter))
+			break;
=20
-	if (try_to_take_rt_mutex(lock, task, NULL))
-		return 1;
+		if (&waiter =3D=3D rt_mutex_top_waiter(lock))
+			owner =3D rt_mutex_owner(lock);
+		else
+			owner =3D NULL;
+		raw_spin_unlock_irq(&lock->wait_lock);
=20
-	/* We enforce deadlock detection for futexes */
-	ret =3D task_blocks_on_rt_mutex(lock, waiter, task,
-				      RT_MUTEX_FULL_CHAINWALK);
+		if (!owner || !rtmutex_spin_on_owner(lock, &waiter, owner))
+			schedule_rtlock();
=20
-	if (ret && !rt_mutex_owner(lock)) {
-		/*
-		 * Reset the return value. We might have
-		 * returned with -EDEADLK and the owner
-		 * released the lock while we were walking the
-		 * pi chain.  Let the waiter sort it out.
-		 */
-		ret =3D 0;
+		raw_spin_lock_irq(&lock->wait_lock);
+		set_current_state(TASK_RTLOCK_WAIT);
 	}
=20
-	return ret;
-}
-
-/**
- * rt_mutex_start_proxy_lock() - Start lock acquisition for another task
- * @lock:		the rt_mutex to take
- * @waiter:		the pre-initialized rt_mutex_waiter
- * @task:		the task to prepare
- *
- * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
- * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
- *
- * NOTE: unlike __rt_mutex_start_proxy_lock this _DOES_ remove the @waiter
- * on failure.
- *
- * Returns:
- *  0 - task blocked on lock
- *  1 - acquired the lock for task, caller should wake it up
- * <0 - error
- *
- * Special API call for PI-futex support.
- */
-int __sched rt_mutex_start_proxy_lock(struct rt_mutex *lock,
-				      struct rt_mutex_waiter *waiter,
-				      struct task_struct *task)
-{
-	int ret;
-
-	raw_spin_lock_irq(&lock->wait_lock);
-	ret =3D __rt_mutex_start_proxy_lock(lock, waiter, task);
-	if (unlikely(ret))
-		remove_waiter(lock, waiter);
-	raw_spin_unlock_irq(&lock->wait_lock);
-
-	return ret;
-}
-
-/**
- * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
- * @lock:		the rt_mutex we were woken on
- * @to:			the timeout, null if none. hrtimer should already have
- *			been started.
- * @waiter:		the pre-initialized rt_mutex_waiter
- *
- * Wait for the lock acquisition started on our behalf by
- * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
- * rt_mutex_cleanup_proxy_lock().
- *
- * Returns:
- *  0 - success
- * <0 - error, one of -EINTR, -ETIMEDOUT
- *
- * Special API call for PI-futex support
- */
-int __sched rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
-				     struct hrtimer_sleeper *to,
-				     struct rt_mutex_waiter *waiter)
-{
-	int ret;
+	/* Restore the task state */
+	current_restore_rtlock_saved_state();
=20
-	raw_spin_lock_irq(&lock->wait_lock);
-	/* sleep on the mutex */
-	set_current_state(TASK_INTERRUPTIBLE);
-	ret =3D __rt_mutex_slowlock(lock, TASK_INTERRUPTIBLE, to, waiter);
 	/*
-	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
-	 * have to fix that up.
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally.
+	 * We might have to fix that up:
 	 */
 	fixup_rt_mutex_waiters(lock);
-	raw_spin_unlock_irq(&lock->wait_lock);
-
-	return ret;
+	debug_rt_mutex_free_waiter(&waiter);
 }
=20
-/**
- * rt_mutex_cleanup_proxy_lock() - Cleanup failed lock acquisition
- * @lock:		the rt_mutex we were woken on
- * @waiter:		the pre-initialized rt_mutex_waiter
- *
- * Attempt to clean up after a failed __rt_mutex_start_proxy_lock() or
- * rt_mutex_wait_proxy_lock().
- *
- * Unless we acquired the lock; we're still enqueued on the wait-list and can
- * in fact still be granted ownership until we're removed. Therefore we can
- * find we are in fact the owner and must disregard the
- * rt_mutex_wait_proxy_lock() failure.
- *
- * Returns:
- *  true  - did the cleanup, we done.
- *  false - we acquired the lock after rt_mutex_wait_proxy_lock() returned,
- *          caller should disregards its return value.
- *
- * Special API call for PI-futex support
- */
-bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
-					 struct rt_mutex_waiter *waiter)
+static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lo=
ck)
 {
-	bool cleanup =3D false;
-
-	raw_spin_lock_irq(&lock->wait_lock);
-	/*
-	 * Do an unconditional try-lock, this deals with the lock stealing
-	 * state where __rt_mutex_futex_unlock() -> mark_wakeup_next_waiter()
-	 * sets a NULL owner.
-	 *
-	 * We're not interested in the return value, because the subsequent
-	 * test on rt_mutex_owner() will infer that. If the trylock succeeded,
-	 * we will own the lock and it will have removed the waiter. If we
-	 * failed the trylock, we're still not owner and we need to remove
-	 * ourselves.
-	 */
-	try_to_take_rt_mutex(lock, current, waiter);
-	/*
-	 * Unless we're the owner; we're still enqueued on the wait_list.
-	 * So check if we became owner, if not, take us off the wait_list.
-	 */
-	if (rt_mutex_owner(lock) !=3D current) {
-		remove_waiter(lock, waiter);
-		cleanup =3D true;
-	}
-	/*
-	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
-	 * have to fix that up.
-	 */
-	fixup_rt_mutex_waiters(lock);
-
-	raw_spin_unlock_irq(&lock->wait_lock);
+	unsigned long flags;
=20
-	return cleanup;
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	rtlock_slowlock_locked(lock);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
 }
=20
-#ifdef CONFIG_DEBUG_RT_MUTEXES
-void rt_mutex_debug_task_free(struct task_struct *task)
-{
-	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
-	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
-}
-#endif
+#endif /* RT_MUTEX_BUILD_SPINLOCKS */
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
new file mode 100644
index 000000000000..5c9299aaabae
--- /dev/null
+++ b/kernel/locking/rtmutex_api.c
@@ -0,0 +1,590 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtmutex API
+ */
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define RT_MUTEX_BUILD_MUTEX
+#include "rtmutex.c"
+
+/*
+ * Max number of times we'll walk the boosting chain:
+ */
+int max_lock_depth =3D 1024;
+
+/*
+ * Debug aware fast / slowpath lock,trylock,unlock
+ *
+ * The atomic acquire/release ops are compiled away, when either the
+ * architecture does not support cmpxchg or when debugging is enabled.
+ */
+static __always_inline int __rt_mutex_lock_common(struct rt_mutex *lock,
+						  unsigned int state,
+						  unsigned int subclass)
+{
+	int ret;
+
+	might_sleep();
+	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	ret =3D __rt_mutex_lock(&lock->rtmutex, state);
+	if (ret)
+		mutex_release(&lock->dep_map, _RET_IP_);
+	return ret;
+}
+
+void rt_mutex_base_init(struct rt_mutex_base *rtb)
+{
+	__rt_mutex_base_init(rtb);
+}
+EXPORT_SYMBOL(rt_mutex_base_init);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+/**
+ * rt_mutex_lock_nested - lock a rt_mutex
+ *
+ * @lock: the rt_mutex to be locked
+ * @subclass: the lockdep subclass
+ */
+void __sched rt_mutex_lock_nested(struct rt_mutex *lock, unsigned int subcla=
ss)
+{
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_nested);
+
+#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+/**
+ * rt_mutex_lock - lock a rt_mutex
+ *
+ * @lock: the rt_mutex to be locked
+ */
+void __sched rt_mutex_lock(struct rt_mutex *lock)
+{
+	__rt_mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock);
+#endif
+
+/**
+ * rt_mutex_lock_interruptible - lock a rt_mutex interruptible
+ *
+ * @lock:		the rt_mutex to be locked
+ *
+ * Returns:
+ *  0		on success
+ * -EINTR	when interrupted by a signal
+ */
+int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
+{
+	return __rt_mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_lock_interruptible);
+
+/**
+ * rt_mutex_trylock - try to lock a rt_mutex
+ *
+ * @lock:	the rt_mutex to be locked
+ *
+ * This function can only be called in thread context. It's safe to call it
+ * from atomic regions, but not from hard or soft interrupt context.
+ *
+ * Returns:
+ *  1 on success
+ *  0 on contention
+ */
+int __sched rt_mutex_trylock(struct rt_mutex *lock)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
+		return 0;
+
+	ret =3D __rt_mutex_trylock(&lock->rtmutex);
+	if (ret)
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rt_mutex_trylock);
+
+/**
+ * rt_mutex_unlock - unlock a rt_mutex
+ *
+ * @lock: the rt_mutex to be unlocked
+ */
+void __sched rt_mutex_unlock(struct rt_mutex *lock)
+{
+	mutex_release(&lock->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&lock->rtmutex);
+}
+EXPORT_SYMBOL_GPL(rt_mutex_unlock);
+
+/*
+ * Futex variants, must not use fastpath.
+ */
+int __sched rt_mutex_futex_trylock(struct rt_mutex_base *lock)
+{
+	return rt_mutex_slowtrylock(lock);
+}
+
+int __sched __rt_mutex_futex_trylock(struct rt_mutex_base *lock)
+{
+	return __rt_mutex_slowtrylock(lock);
+}
+
+/**
+ * __rt_mutex_futex_unlock - Futex variant, that since futex variants
+ * do not use the fast-path, can be simple and will not need to retry.
+ *
+ * @lock:	The rt_mutex to be unlocked
+ * @wqh:	The wake queue head from which to get the next lock waiter
+ */
+bool __sched __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
+				     struct rt_wake_q_head *wqh)
+{
+	lockdep_assert_held(&lock->wait_lock);
+
+	debug_rt_mutex_unlock(lock);
+
+	if (!rt_mutex_has_waiters(lock)) {
+		lock->owner =3D NULL;
+		return false; /* done */
+	}
+
+	/*
+	 * We've already deboosted, mark_wakeup_next_waiter() will
+	 * retain preempt_disabled when we drop the wait_lock, to
+	 * avoid inversion prior to the wakeup.  preempt_disable()
+	 * therein pairs with rt_mutex_postunlock().
+	 */
+	mark_wakeup_next_waiter(wqh, lock);
+
+	return true; /* call postunlock() */
+}
+
+void __sched rt_mutex_futex_unlock(struct rt_mutex_base *lock)
+{
+	DEFINE_RT_WAKE_Q(wqh);
+	unsigned long flags;
+	bool postunlock;
+
+	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	postunlock =3D __rt_mutex_futex_unlock(lock, &wqh);
+	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
+
+	if (postunlock)
+		rt_mutex_postunlock(&wqh);
+}
+
+/**
+ * __rt_mutex_init - initialize the rt_mutex
+ *
+ * @lock:	The rt_mutex to be initialized
+ * @name:	The lock name used for debugging
+ * @key:	The lock class key used for debugging
+ *
+ * Initialize the rt_mutex to unlocked state.
+ *
+ * Initializing of a locked rt_mutex is not allowed
+ */
+void __sched __rt_mutex_init(struct rt_mutex *lock, const char *name,
+			     struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	__rt_mutex_base_init(&lock->rtmutex);
+	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL_GPL(__rt_mutex_init);
+
+/**
+ * rt_mutex_init_proxy_locked - initialize and lock a rt_mutex on behalf of a
+ *				proxy owner
+ *
+ * @lock:	the rt_mutex to be locked
+ * @proxy_owner:the task to set as owner
+ *
+ * No locking. Caller has to do serializing itself
+ *
+ * Special API call for PI-futex support. This initializes the rtmutex and
+ * assigns it to @proxy_owner. Concurrent operations on the rtmutex are not
+ * possible at this point because the pi_state which contains the rtmutex
+ * is not yet visible to other tasks.
+ */
+void __sched rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
+					struct task_struct *proxy_owner)
+{
+	static struct lock_class_key pi_futex_key;
+
+	__rt_mutex_base_init(lock);
+	/*
+	 * On PREEMPT_RT the futex hashbucket spinlock becomes 'sleeping'
+	 * and rtmutex based. That causes a lockdep false positive, because
+	 * some of the futex functions invoke spin_unlock(&hb->lock) with
+	 * the wait_lock of the rtmutex associated to the pi_futex held.
+	 * spin_unlock() in turn takes wait_lock of the rtmutex on which
+	 * the spinlock is based, which makes lockdep notice a lock
+	 * recursion. Give the futex/rtmutex wait_lock a separate key.
+	 */
+	lockdep_set_class(&lock->wait_lock, &pi_futex_key);
+	rt_mutex_set_owner(lock, proxy_owner);
+}
+
+/**
+ * rt_mutex_proxy_unlock - release a lock on behalf of owner
+ *
+ * @lock:	the rt_mutex to be locked
+ *
+ * No locking. Caller has to do serializing itself
+ *
+ * Special API call for PI-futex support. This just cleans up the rtmutex
+ * (debugging) state. Concurrent operations on this rt_mutex are not
+ * possible because it belongs to the pi_state which is about to be freed
+ * and it is not longer visible to other tasks.
+ */
+void __sched rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
+{
+	debug_rt_mutex_proxy_unlock(lock);
+	rt_mutex_set_owner(lock, NULL);
+}
+
+/**
+ * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
+ * @lock:		the rt_mutex to take
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ * @task:		the task to prepare
+ *
+ * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
+ * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
+ *
+ * NOTE: does _NOT_ remove the @waiter on failure; must either call
+ * rt_mutex_wait_proxy_lock() or rt_mutex_cleanup_proxy_lock() after this.
+ *
+ * Returns:
+ *  0 - task blocked on lock
+ *  1 - acquired the lock for task, caller should wake it up
+ * <0 - error
+ *
+ * Special API call for PI-futex support.
+ */
+int __sched __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
+					struct rt_mutex_waiter *waiter,
+					struct task_struct *task)
+{
+	int ret;
+
+	lockdep_assert_held(&lock->wait_lock);
+
+	if (try_to_take_rt_mutex(lock, task, NULL))
+		return 1;
+
+	/* We enforce deadlock detection for futexes */
+	ret =3D task_blocks_on_rt_mutex(lock, waiter, task, NULL,
+				      RT_MUTEX_FULL_CHAINWALK);
+
+	if (ret && !rt_mutex_owner(lock)) {
+		/*
+		 * Reset the return value. We might have
+		 * returned with -EDEADLK and the owner
+		 * released the lock while we were walking the
+		 * pi chain.  Let the waiter sort it out.
+		 */
+		ret =3D 0;
+	}
+
+	return ret;
+}
+
+/**
+ * rt_mutex_start_proxy_lock() - Start lock acquisition for another task
+ * @lock:		the rt_mutex to take
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ * @task:		the task to prepare
+ *
+ * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
+ * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
+ *
+ * NOTE: unlike __rt_mutex_start_proxy_lock this _DOES_ remove the @waiter
+ * on failure.
+ *
+ * Returns:
+ *  0 - task blocked on lock
+ *  1 - acquired the lock for task, caller should wake it up
+ * <0 - error
+ *
+ * Special API call for PI-futex support.
+ */
+int __sched rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
+				      struct rt_mutex_waiter *waiter,
+				      struct task_struct *task)
+{
+	int ret;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	ret =3D __rt_mutex_start_proxy_lock(lock, waiter, task);
+	if (unlikely(ret))
+		remove_waiter(lock, waiter);
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return ret;
+}
+
+/**
+ * rt_mutex_wait_proxy_lock() - Wait for lock acquisition
+ * @lock:		the rt_mutex we were woken on
+ * @to:			the timeout, null if none. hrtimer should already have
+ *			been started.
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ *
+ * Wait for the lock acquisition started on our behalf by
+ * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
+ * rt_mutex_cleanup_proxy_lock().
+ *
+ * Returns:
+ *  0 - success
+ * <0 - error, one of -EINTR, -ETIMEDOUT
+ *
+ * Special API call for PI-futex support
+ */
+int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
+				     struct hrtimer_sleeper *to,
+				     struct rt_mutex_waiter *waiter)
+{
+	int ret;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	/* sleep on the mutex */
+	set_current_state(TASK_INTERRUPTIBLE);
+	ret =3D rt_mutex_slowlock_block(lock, NULL, TASK_INTERRUPTIBLE, to, waiter);
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
+	 * have to fix that up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return ret;
+}
+
+/**
+ * rt_mutex_cleanup_proxy_lock() - Cleanup failed lock acquisition
+ * @lock:		the rt_mutex we were woken on
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ *
+ * Attempt to clean up after a failed __rt_mutex_start_proxy_lock() or
+ * rt_mutex_wait_proxy_lock().
+ *
+ * Unless we acquired the lock; we're still enqueued on the wait-list and can
+ * in fact still be granted ownership until we're removed. Therefore we can
+ * find we are in fact the owner and must disregard the
+ * rt_mutex_wait_proxy_lock() failure.
+ *
+ * Returns:
+ *  true  - did the cleanup, we done.
+ *  false - we acquired the lock after rt_mutex_wait_proxy_lock() returned,
+ *          caller should disregards its return value.
+ *
+ * Special API call for PI-futex support
+ */
+bool __sched rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
+					 struct rt_mutex_waiter *waiter)
+{
+	bool cleanup =3D false;
+
+	raw_spin_lock_irq(&lock->wait_lock);
+	/*
+	 * Do an unconditional try-lock, this deals with the lock stealing
+	 * state where __rt_mutex_futex_unlock() -> mark_wakeup_next_waiter()
+	 * sets a NULL owner.
+	 *
+	 * We're not interested in the return value, because the subsequent
+	 * test on rt_mutex_owner() will infer that. If the trylock succeeded,
+	 * we will own the lock and it will have removed the waiter. If we
+	 * failed the trylock, we're still not owner and we need to remove
+	 * ourselves.
+	 */
+	try_to_take_rt_mutex(lock, current, waiter);
+	/*
+	 * Unless we're the owner; we're still enqueued on the wait_list.
+	 * So check if we became owner, if not, take us off the wait_list.
+	 */
+	if (rt_mutex_owner(lock) !=3D current) {
+		remove_waiter(lock, waiter);
+		cleanup =3D true;
+	}
+	/*
+	 * try_to_take_rt_mutex() sets the waiter bit unconditionally. We might
+	 * have to fix that up.
+	 */
+	fixup_rt_mutex_waiters(lock);
+
+	raw_spin_unlock_irq(&lock->wait_lock);
+
+	return cleanup;
+}
+
+/*
+ * Recheck the pi chain, in case we got a priority setting
+ *
+ * Called from sched_setscheduler
+ */
+void __sched rt_mutex_adjust_pi(struct task_struct *task)
+{
+	struct rt_mutex_waiter *waiter;
+	struct rt_mutex_base *next_lock;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&task->pi_lock, flags);
+
+	waiter =3D task->pi_blocked_on;
+	if (!waiter || rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
+		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+		return;
+	}
+	next_lock =3D waiter->lock;
+	raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+	/* gets dropped in rt_mutex_adjust_prio_chain()! */
+	get_task_struct(task);
+
+	rt_mutex_adjust_prio_chain(task, RT_MUTEX_MIN_CHAINWALK, NULL,
+				   next_lock, NULL, task);
+}
+
+/*
+ * Performs the wakeup of the top-waiter and re-enables preemption.
+ */
+void __sched rt_mutex_postunlock(struct rt_wake_q_head *wqh)
+{
+	rt_mutex_wake_up_q(wqh);
+}
+
+#ifdef CONFIG_DEBUG_RT_MUTEXES
+void rt_mutex_debug_task_free(struct task_struct *task)
+{
+	DEBUG_LOCKS_WARN_ON(!RB_EMPTY_ROOT(&task->pi_waiters.rb_root));
+	DEBUG_LOCKS_WARN_ON(task->pi_blocked_on);
+}
+#endif
+
+#ifdef CONFIG_PREEMPT_RT
+/* Mutexes */
+void __mutex_rt_init(struct mutex *mutex, const char *name,
+		     struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
+	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(__mutex_rt_init);
+
+static __always_inline int __mutex_lock_common(struct mutex *lock,
+					       unsigned int state,
+					       unsigned int subclass,
+					       struct lockdep_map *nest_lock,
+					       unsigned long ip)
+{
+	int ret;
+
+	might_sleep();
+	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
+	ret =3D __rt_mutex_lock(&lock->rtmutex, state);
+	if (ret)
+		mutex_release(&lock->dep_map, ip);
+	else
+		lock_acquired(&lock->dep_map, ip);
+	return ret;
+}
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_nested);
+
+void __sched _mutex_lock_nest_lock(struct mutex *lock,
+				   struct lockdep_map *nest_lock)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, nest_lock, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(_mutex_lock_nest_lock);
+
+int __sched mutex_lock_interruptible_nested(struct mutex *lock,
+					    unsigned int subclass)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass, NULL, _RET_I=
P_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
+
+int __sched mutex_lock_killable_nested(struct mutex *lock,
+					    unsigned int subclass)
+{
+	return __mutex_lock_common(lock, TASK_KILLABLE, subclass, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
+
+void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
+{
+	int token;
+
+	might_sleep();
+
+	token =3D io_schedule_prepare();
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+	io_schedule_finish(token);
+}
+EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
+
+#else /* CONFIG_DEBUG_LOCK_ALLOC */
+
+void __sched mutex_lock(struct mutex *lock)
+{
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock);
+
+int __sched mutex_lock_interruptible(struct mutex *lock)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock_interruptible);
+
+int __sched mutex_lock_killable(struct mutex *lock)
+{
+	return __mutex_lock_common(lock, TASK_KILLABLE, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_lock_killable);
+
+void __sched mutex_lock_io(struct mutex *lock)
+{
+	int token =3D io_schedule_prepare();
+
+	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+	io_schedule_finish(token);
+}
+EXPORT_SYMBOL(mutex_lock_io);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+int __sched mutex_trylock(struct mutex *lock)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
+		return 0;
+
+	ret =3D __rt_mutex_trylock(&lock->rtmutex);
+	if (ret)
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+
+	return ret;
+}
+EXPORT_SYMBOL(mutex_trylock);
+
+void __sched mutex_unlock(struct mutex *lock)
+{
+	mutex_release(&lock->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&lock->rtmutex);
+}
+EXPORT_SYMBOL(mutex_unlock);
+
+#endif /* CONFIG_PREEMPT_RT */
diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index a90c22abdbca..c47e8361bfb5 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -25,29 +25,90 @@
  * @pi_tree_entry:	pi node to enqueue into the mutex owner waiters tree
  * @task:		task reference to the blocked task
  * @lock:		Pointer to the rt_mutex on which the waiter blocks
+ * @wake_state:		Wakeup state to use (TASK_NORMAL or TASK_RTLOCK_WAIT)
  * @prio:		Priority of the waiter
  * @deadline:		Deadline of the waiter if applicable
+ * @ww_ctx:		WW context pointer
  */
 struct rt_mutex_waiter {
 	struct rb_node		tree_entry;
 	struct rb_node		pi_tree_entry;
 	struct task_struct	*task;
-	struct rt_mutex		*lock;
+	struct rt_mutex_base	*lock;
+	unsigned int		wake_state;
 	int			prio;
 	u64			deadline;
+	struct ww_acquire_ctx	*ww_ctx;
 };
=20
+/**
+ * rt_wake_q_head - Wrapper around regular wake_q_head to support
+ *		    "sleeping" spinlocks on RT
+ * @head:		The regular wake_q_head for sleeping lock variants
+ * @rtlock_task:	Task pointer for RT lock (spin/rwlock) wakeups
+ */
+struct rt_wake_q_head {
+	struct wake_q_head	head;
+	struct task_struct	*rtlock_task;
+};
+
+#define DEFINE_RT_WAKE_Q(name)						\
+	struct rt_wake_q_head name =3D {					\
+		.head		=3D WAKE_Q_HEAD_INITIALIZER(name.head),	\
+		.rtlock_task	=3D NULL,					\
+	}
+
+/*
+ * PI-futex support (proxy locking functions, etc.):
+ */
+extern void rt_mutex_init_proxy_locked(struct rt_mutex_base *lock,
+				       struct task_struct *proxy_owner);
+extern void rt_mutex_proxy_unlock(struct rt_mutex_base *lock);
+extern int __rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
+				     struct rt_mutex_waiter *waiter,
+				     struct task_struct *task);
+extern int rt_mutex_start_proxy_lock(struct rt_mutex_base *lock,
+				     struct rt_mutex_waiter *waiter,
+				     struct task_struct *task);
+extern int rt_mutex_wait_proxy_lock(struct rt_mutex_base *lock,
+			       struct hrtimer_sleeper *to,
+			       struct rt_mutex_waiter *waiter);
+extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex_base *lock,
+				 struct rt_mutex_waiter *waiter);
+
+extern int rt_mutex_futex_trylock(struct rt_mutex_base *l);
+extern int __rt_mutex_futex_trylock(struct rt_mutex_base *l);
+
+extern void rt_mutex_futex_unlock(struct rt_mutex_base *lock);
+extern bool __rt_mutex_futex_unlock(struct rt_mutex_base *lock,
+				struct rt_wake_q_head *wqh);
+
+extern void rt_mutex_postunlock(struct rt_wake_q_head *wqh);
+
 /*
  * Must be guarded because this header is included from rcu/tree_plugin.h
  * unconditionally.
  */
 #ifdef CONFIG_RT_MUTEXES
-static inline int rt_mutex_has_waiters(struct rt_mutex *lock)
+static inline int rt_mutex_has_waiters(struct rt_mutex_base *lock)
 {
 	return !RB_EMPTY_ROOT(&lock->waiters.rb_root);
 }
=20
-static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex *l=
ock)
+/*
+ * Lockless speculative check whether @waiter is still the top waiter on
+ * @lock. This is solely comparing pointers and not derefencing the
+ * leftmost entry which might be about to vanish.
+ */
+static inline bool rt_mutex_waiter_is_top_waiter(struct rt_mutex_base *lock,
+						 struct rt_mutex_waiter *waiter)
+{
+	struct rb_node *leftmost =3D rb_first_cached(&lock->waiters);
+
+	return rb_entry(leftmost, struct rt_mutex_waiter, tree_entry) =3D=3D waiter;
+}
+
+static inline struct rt_mutex_waiter *rt_mutex_top_waiter(struct rt_mutex_ba=
se *lock)
 {
 	struct rb_node *leftmost =3D rb_first_cached(&lock->waiters);
 	struct rt_mutex_waiter *w =3D NULL;
@@ -72,19 +133,12 @@ static inline struct rt_mutex_waiter *task_top_pi_waiter=
(struct task_struct *p)
=20
 #define RT_MUTEX_HAS_WAITERS	1UL
=20
-static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 {
 	unsigned long owner =3D (unsigned long) READ_ONCE(lock->owner);
=20
 	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
 }
-#else /* CONFIG_RT_MUTEXES */
-/* Used in rcu/tree_plugin.h */
-static inline struct task_struct *rt_mutex_owner(struct rt_mutex *lock)
-{
-	return NULL;
-}
-#endif  /* !CONFIG_RT_MUTEXES */
=20
 /*
  * Constants for rt mutex functions which have a selectable deadlock
@@ -101,49 +155,21 @@ enum rtmutex_chainwalk {
 	RT_MUTEX_FULL_CHAINWALK,
 };
=20
-static inline void __rt_mutex_basic_init(struct rt_mutex *lock)
+static inline void __rt_mutex_base_init(struct rt_mutex_base *lock)
 {
-	lock->owner =3D NULL;
 	raw_spin_lock_init(&lock->wait_lock);
 	lock->waiters =3D RB_ROOT_CACHED;
+	lock->owner =3D NULL;
 }
=20
-/*
- * PI-futex support (proxy locking functions, etc.):
- */
-extern void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
-				       struct task_struct *proxy_owner);
-extern void rt_mutex_proxy_unlock(struct rt_mutex *lock);
-extern void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
-extern int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
-				     struct rt_mutex_waiter *waiter,
-				     struct task_struct *task);
-extern int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
-				     struct rt_mutex_waiter *waiter,
-				     struct task_struct *task);
-extern int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
-			       struct hrtimer_sleeper *to,
-			       struct rt_mutex_waiter *waiter);
-extern bool rt_mutex_cleanup_proxy_lock(struct rt_mutex *lock,
-				 struct rt_mutex_waiter *waiter);
-
-extern int rt_mutex_futex_trylock(struct rt_mutex *l);
-extern int __rt_mutex_futex_trylock(struct rt_mutex *l);
-
-extern void rt_mutex_futex_unlock(struct rt_mutex *lock);
-extern bool __rt_mutex_futex_unlock(struct rt_mutex *lock,
-				 struct wake_q_head *wqh);
-
-extern void rt_mutex_postunlock(struct wake_q_head *wake_q);
-
 /* Debug functions */
-static inline void debug_rt_mutex_unlock(struct rt_mutex *lock)
+static inline void debug_rt_mutex_unlock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) !=3D current);
 }
=20
-static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex *lock)
+static inline void debug_rt_mutex_proxy_unlock(struct rt_mutex_base *lock)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES))
 		DEBUG_LOCKS_WARN_ON(!rt_mutex_owner(lock));
@@ -161,4 +187,27 @@ static inline void debug_rt_mutex_free_waiter(struct rt_=
mutex_waiter *waiter)
 		memset(waiter, 0x22, sizeof(*waiter));
 }
=20
+static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
+{
+	debug_rt_mutex_init_waiter(waiter);
+	RB_CLEAR_NODE(&waiter->pi_tree_entry);
+	RB_CLEAR_NODE(&waiter->tree_entry);
+	waiter->wake_state =3D TASK_NORMAL;
+	waiter->task =3D NULL;
+}
+
+static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waite=
r)
+{
+	rt_mutex_init_waiter(waiter);
+	waiter->wake_state =3D TASK_RTLOCK_WAIT;
+}
+
+#else /* CONFIG_RT_MUTEXES */
+/* Used in rcu/tree_plugin.h */
+static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
+{
+	return NULL;
+}
+#endif  /* !CONFIG_RT_MUTEXES */
+
 #endif
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
new file mode 100644
index 000000000000..4ba15088e640
--- /dev/null
+++ b/kernel/locking/rwbase_rt.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * RT-specific reader/writer semaphores and reader/writer locks
+ *
+ * down_write/write_lock()
+ *  1) Lock rtmutex
+ *  2) Remove the reader BIAS to force readers into the slow path
+ *  3) Wait until all readers have left the critical section
+ *  4) Mark it write locked
+ *
+ * up_write/write_unlock()
+ *  1) Remove the write locked marker
+ *  2) Set the reader BIAS, so readers can use the fast path again
+ *  3) Unlock rtmutex, to release blocked readers
+ *
+ * down_read/read_lock()
+ *  1) Try fast path acquisition (reader BIAS is set)
+ *  2) Take tmutex::wait_lock, which protects the writelocked flag
+ *  3) If !writelocked, acquire it for read
+ *  4) If writelocked, block on tmutex
+ *  5) unlock rtmutex, goto 1)
+ *
+ * up_read/read_unlock()
+ *  1) Try fast path release (reader count !=3D 1)
+ *  2) Wake the writer waiting in down_write()/write_lock() #3
+ *
+ * down_read/read_lock()#3 has the consequence, that rw semaphores and rw
+ * locks on RT are not writer fair, but writers, which should be avoided in
+ * RT tasks (think mmap_sem), are subject to the rtmutex priority/DL
+ * inheritance mechanism.
+ *
+ * It's possible to make the rw primitives writer fair by keeping a list of
+ * active readers. A blocked writer would force all newly incoming readers
+ * to block on the rtmutex, but the rtmutex would have to be proxy locked
+ * for one reader after the other. We can't use multi-reader inheritance
+ * because there is no way to support that with SCHED_DEADLINE.
+ * Implementing the one by one reader boosting/handover mechanism is a
+ * major surgery for a very dubious value.
+ *
+ * The risk of writer starvation is there, but the pathological use cases
+ * which trigger it are not necessarily the typical RT workloads.
+ *
+ * Common code shared between RT rw_semaphore and rwlock
+ */
+
+static __always_inline int rwbase_read_trylock(struct rwbase_rt *rwb)
+{
+	int r;
+
+	/*
+	 * Increment reader count, if sem->readers < 0, i.e. READER_BIAS is
+	 * set.
+	 */
+	for (r =3D atomic_read(&rwb->readers); r < 0;) {
+		if (likely(atomic_try_cmpxchg(&rwb->readers, &r, r + 1)))
+			return 1;
+	}
+	return 0;
+}
+
+static int __sched __rwbase_read_lock(struct rwbase_rt *rwb,
+				      unsigned int state)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+	int ret;
+
+	raw_spin_lock_irq(&rtm->wait_lock);
+	/*
+	 * Allow readers, as long as the writer has not completely
+	 * acquired the semaphore for write.
+	 */
+	if (atomic_read(&rwb->readers) !=3D WRITER_BIAS) {
+		atomic_inc(&rwb->readers);
+		raw_spin_unlock_irq(&rtm->wait_lock);
+		return 0;
+	}
+
+	/*
+	 * Call into the slow lock path with the rtmutex->wait_lock
+	 * held, so this can't result in the following race:
+	 *
+	 * Reader1		Reader2		Writer
+	 *			down_read()
+	 *					down_write()
+	 *					rtmutex_lock(m)
+	 *					wait()
+	 * down_read()
+	 * unlock(m->wait_lock)
+	 *			up_read()
+	 *			wake(Writer)
+	 *					lock(m->wait_lock)
+	 *					sem->writelocked=3Dtrue
+	 *					unlock(m->wait_lock)
+	 *
+	 *					up_write()
+	 *					sem->writelocked=3Dfalse
+	 *					rtmutex_unlock(m)
+	 *			down_read()
+	 *					down_write()
+	 *					rtmutex_lock(m)
+	 *					wait()
+	 * rtmutex_lock(m)
+	 *
+	 * That would put Reader1 behind the writer waiting on
+	 * Reader2 to call up_read(), which might be unbound.
+	 */
+
+	/*
+	 * For rwlocks this returns 0 unconditionally, so the below
+	 * !ret conditionals are optimized out.
+	 */
+	ret =3D rwbase_rtmutex_slowlock_locked(rtm, state);
+
+	/*
+	 * On success the rtmutex is held, so there can't be a writer
+	 * active. Increment the reader count and immediately drop the
+	 * rtmutex again.
+	 *
+	 * rtmutex->wait_lock has to be unlocked in any case of course.
+	 */
+	if (!ret)
+		atomic_inc(&rwb->readers);
+	raw_spin_unlock_irq(&rtm->wait_lock);
+	if (!ret)
+		rwbase_rtmutex_unlock(rtm);
+	return ret;
+}
+
+static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
+					    unsigned int state)
+{
+	if (rwbase_read_trylock(rwb))
+		return 0;
+
+	return __rwbase_read_lock(rwb, state);
+}
+
+static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
+					 unsigned int state)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+	struct task_struct *owner;
+
+	raw_spin_lock_irq(&rtm->wait_lock);
+	/*
+	 * Wake the writer, i.e. the rtmutex owner. It might release the
+	 * rtmutex concurrently in the fast path (due to a signal), but to
+	 * clean up rwb->readers it needs to acquire rtm->wait_lock. The
+	 * worst case which can happen is a spurious wakeup.
+	 */
+	owner =3D rt_mutex_owner(rtm);
+	if (owner)
+		wake_up_state(owner, state);
+
+	raw_spin_unlock_irq(&rtm->wait_lock);
+}
+
+static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
+					       unsigned int state)
+{
+	/*
+	 * rwb->readers can only hit 0 when a writer is waiting for the
+	 * active readers to leave the critical section.
+	 */
+	if (unlikely(atomic_dec_and_test(&rwb->readers)))
+		__rwbase_read_unlock(rwb, state);
+}
+
+static inline void __rwbase_write_unlock(struct rwbase_rt *rwb, int bias,
+					 unsigned long flags)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+
+	atomic_add(READER_BIAS - bias, &rwb->readers);
+	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	rwbase_rtmutex_unlock(rtm);
+}
+
+static inline void rwbase_write_unlock(struct rwbase_rt *rwb)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	__rwbase_write_unlock(rwb, WRITER_BIAS, flags);
+}
+
+static inline void rwbase_write_downgrade(struct rwbase_rt *rwb)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	/* Release it and account current as reader */
+	__rwbase_write_unlock(rwb, WRITER_BIAS - 1, flags);
+}
+
+static int __sched rwbase_write_lock(struct rwbase_rt *rwb,
+				     unsigned int state)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+	unsigned long flags;
+
+	/* Take the rtmutex as a first step */
+	if (rwbase_rtmutex_lock_state(rtm, state))
+		return -EINTR;
+
+	/* Force readers into slow path */
+	atomic_sub(READER_BIAS, &rwb->readers);
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	/*
+	 * set_current_state() for rw_semaphore
+	 * current_save_and_set_rtlock_wait_state() for rwlock
+	 */
+	rwbase_set_and_save_current_state(state);
+
+	/* Block until all readers have left the critical section. */
+	for (; atomic_read(&rwb->readers);) {
+		/* Optimized out for rwlocks */
+		if (rwbase_signal_pending_state(state, current)) {
+			__set_current_state(TASK_RUNNING);
+			__rwbase_write_unlock(rwb, 0, flags);
+			return -EINTR;
+		}
+		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+
+		/*
+		 * Schedule and wait for the readers to leave the critical
+		 * section. The last reader leaving it wakes the waiter.
+		 */
+		if (atomic_read(&rwb->readers) !=3D 0)
+			rwbase_schedule();
+		set_current_state(state);
+		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	}
+
+	atomic_set(&rwb->readers, WRITER_BIAS);
+	rwbase_restore_current_state();
+	raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+	return 0;
+}
+
+static inline int rwbase_write_trylock(struct rwbase_rt *rwb)
+{
+	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
+	unsigned long flags;
+
+	if (!rwbase_rtmutex_trylock(rtm))
+		return 0;
+
+	atomic_sub(READER_BIAS, &rwb->readers);
+
+	raw_spin_lock_irqsave(&rtm->wait_lock, flags);
+	if (!atomic_read(&rwb->readers)) {
+		atomic_set(&rwb->readers, WRITER_BIAS);
+		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
+		return 1;
+	}
+	__rwbase_write_unlock(rwb, 0, flags);
+	return 0;
+}
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 16bfbb10c74d..9215b4d6a9de 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -28,6 +28,7 @@
 #include <linux/rwsem.h>
 #include <linux/atomic.h>
=20
+#ifndef CONFIG_PREEMPT_RT
 #include "lock_events.h"
=20
 /*
@@ -1165,7 +1166,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int=
 state)
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come he=
re
  */
-static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -1297,7 +1298,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) =3D=3D
 		      RWSEM_FLAG_WAITERS)) {
 		clear_nonspinnable(sem);
-		rwsem_wake(sem, tmp);
+		rwsem_wake(sem);
 	}
 }
=20
@@ -1319,7 +1320,7 @@ static inline void __up_write(struct rw_semaphore *sem)
 	rwsem_clear_owner(sem);
 	tmp =3D atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem, tmp);
+		rwsem_wake(sem);
 }
=20
 /*
@@ -1344,6 +1345,114 @@ static inline void __downgrade_write(struct rw_semaph=
ore *sem)
 		rwsem_downgrade_wake(sem);
 }
=20
+#else /* !CONFIG_PREEMPT_RT */
+
+#define RT_MUTEX_BUILD_MUTEX
+#include "rtmutex.c"
+
+#define rwbase_set_and_save_current_state(state)	\
+	set_current_state(state)
+
+#define rwbase_restore_current_state()			\
+	__set_current_state(TASK_RUNNING)
+
+#define rwbase_rtmutex_lock_state(rtm, state)		\
+	__rt_mutex_lock(rtm, state)
+
+#define rwbase_rtmutex_slowlock_locked(rtm, state)	\
+	__rt_mutex_slowlock_locked(rtm, NULL, state)
+
+#define rwbase_rtmutex_unlock(rtm)			\
+	__rt_mutex_unlock(rtm)
+
+#define rwbase_rtmutex_trylock(rtm)			\
+	__rt_mutex_trylock(rtm)
+
+#define rwbase_signal_pending_state(state, current)	\
+	signal_pending_state(state, current)
+
+#define rwbase_schedule()				\
+	schedule()
+
+#include "rwbase_rt.c"
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rwsem_init(struct rw_semaphore *sem, const char *name,
+		  struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map_wait(&sem->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(__rwsem_init);
+#endif
+
+static inline void __down_read(struct rw_semaphore *sem)
+{
+	rwbase_read_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __down_read_interruptible(struct rw_semaphore *sem)
+{
+	return rwbase_read_lock(&sem->rwbase, TASK_INTERRUPTIBLE);
+}
+
+static inline int __down_read_killable(struct rw_semaphore *sem)
+{
+	return rwbase_read_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
+static inline int __down_read_trylock(struct rw_semaphore *sem)
+{
+	return rwbase_read_trylock(&sem->rwbase);
+}
+
+static inline void __up_read(struct rw_semaphore *sem)
+{
+	rwbase_read_unlock(&sem->rwbase, TASK_NORMAL);
+}
+
+static inline void __sched __down_write(struct rw_semaphore *sem)
+{
+	rwbase_write_lock(&sem->rwbase, TASK_UNINTERRUPTIBLE);
+}
+
+static inline int __sched __down_write_killable(struct rw_semaphore *sem)
+{
+	return rwbase_write_lock(&sem->rwbase, TASK_KILLABLE);
+}
+
+static inline int __down_write_trylock(struct rw_semaphore *sem)
+{
+	return rwbase_write_trylock(&sem->rwbase);
+}
+
+static inline void __up_write(struct rw_semaphore *sem)
+{
+	rwbase_write_unlock(&sem->rwbase);
+}
+
+static inline void __downgrade_write(struct rw_semaphore *sem)
+{
+	rwbase_write_downgrade(&sem->rwbase);
+}
+
+/* Debug stubs for the common API */
+#define DEBUG_RWSEMS_WARN_ON(c, sem)
+
+static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
+					    struct task_struct *owner)
+{
+}
+
+static inline bool is_rwsem_reader_owned(struct rw_semaphore *sem)
+{
+	int count =3D atomic_read(&sem->rwbase.readers);
+
+	return count < 0 && count !=3D READER_BIAS;
+}
+
+#endif /* CONFIG_PREEMPT_RT */
+
 /*
  * lock for reading
  */
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9aa855a96c4a..9ee381e4d2a4 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -54,6 +54,7 @@ void down(struct semaphore *sem)
 {
 	unsigned long flags;
=20
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -77,6 +78,7 @@ int down_interruptible(struct semaphore *sem)
 	unsigned long flags;
 	int result =3D 0;
=20
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -103,6 +105,7 @@ int down_killable(struct semaphore *sem)
 	unsigned long flags;
 	int result =3D 0;
=20
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
@@ -157,6 +160,7 @@ int down_timeout(struct semaphore *sem, long timeout)
 	unsigned long flags;
 	int result =3D 0;
=20
+	might_sleep();
 	raw_spin_lock_irqsave(&sem->lock, flags);
 	if (likely(sem->count > 0))
 		sem->count--;
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index c8d7ad9fb9b2..c5830cfa379a 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -124,8 +124,11 @@ void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)=
		\
  *         __[spin|read|write]_lock_bh()
  */
 BUILD_LOCK_OPS(spin, raw_spinlock);
+
+#ifndef CONFIG_PREEMPT_RT
 BUILD_LOCK_OPS(read, rwlock);
 BUILD_LOCK_OPS(write, rwlock);
+#endif
=20
 #endif
=20
@@ -209,6 +212,8 @@ void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_unlock_bh);
 #endif
=20
+#ifndef CONFIG_PREEMPT_RT
+
 #ifndef CONFIG_INLINE_READ_TRYLOCK
 int __lockfunc _raw_read_trylock(rwlock_t *lock)
 {
@@ -353,6 +358,8 @@ void __lockfunc _raw_write_unlock_bh(rwlock_t *lock)
 EXPORT_SYMBOL(_raw_write_unlock_bh);
 #endif
=20
+#endif /* !CONFIG_PREEMPT_RT */
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
=20
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index b9d93087ee66..14235671a1a7 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -31,6 +31,7 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char =
*name,
=20
 EXPORT_SYMBOL(__raw_spin_lock_init);
=20
+#ifndef CONFIG_PREEMPT_RT
 void __rwlock_init(rwlock_t *lock, const char *name,
 		   struct lock_class_key *key)
 {
@@ -48,6 +49,7 @@ void __rwlock_init(rwlock_t *lock, const char *name,
 }
=20
 EXPORT_SYMBOL(__rwlock_init);
+#endif
=20
 static void spin_dump(raw_spinlock_t *lock, const char *msg)
 {
@@ -139,6 +141,7 @@ void do_raw_spin_unlock(raw_spinlock_t *lock)
 	arch_spin_unlock(&lock->raw_lock);
 }
=20
+#ifndef CONFIG_PREEMPT_RT
 static void rwlock_bug(rwlock_t *lock, const char *msg)
 {
 	if (!debug_locks_off())
@@ -228,3 +231,5 @@ void do_raw_write_unlock(rwlock_t *lock)
 	debug_write_unlock(lock);
 	arch_write_unlock(&lock->raw_lock);
 }
+
+#endif /* !CONFIG_PREEMPT_RT */
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
new file mode 100644
index 000000000000..d2912e44d61f
--- /dev/null
+++ b/kernel/locking/spinlock_rt.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * PREEMPT_RT substitution for spin/rw_locks
+ *
+ * spinlocks and rwlocks on RT are based on rtmutexes, with a few twists to
+ * resemble the non RT semantics:
+ *
+ * - Contrary to plain rtmutexes, spinlocks and rwlocks are state
+ *   preserving. The task state is saved before blocking on the underlying
+ *   rtmutex, and restored when the lock has been acquired. Regular wakeups
+ *   during that time are redirected to the saved state so no wake up is
+ *   missed.
+ *
+ * - Non RT spin/rwlocks disable preemption and eventually interrupts.
+ *   Disabling preemption has the side effect of disabling migration and
+ *   preventing RCU grace periods.
+ *
+ *   The RT substitutions explicitly disable migration and take
+ *   rcu_read_lock() across the lock held section.
+ */
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define RT_MUTEX_BUILD_SPINLOCKS
+#include "rtmutex.c"
+
+static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
+{
+	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		rtlock_slowlock(rtm);
+}
+
+static __always_inline void __rt_spin_lock(spinlock_t *lock)
+{
+	___might_sleep(__FILE__, __LINE__, 0);
+	rtlock_lock(&lock->lock);
+	rcu_read_lock();
+	migrate_disable();
+}
+
+void __sched rt_spin_lock(spinlock_t *lock)
+{
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	__rt_spin_lock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __sched rt_spin_lock_nested(spinlock_t *lock, int subclass)
+{
+	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	__rt_spin_lock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock_nested);
+
+void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
+				    struct lockdep_map *nest_lock)
+{
+	spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
+	__rt_spin_lock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock_nest_lock);
+#endif
+
+void __sched rt_spin_unlock(spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, _RET_IP_);
+	migrate_enable();
+	rcu_read_unlock();
+
+	if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL)))
+		rt_mutex_slowunlock(&lock->lock);
+}
+EXPORT_SYMBOL(rt_spin_unlock);
+
+/*
+ * Wait for the lock to get unlocked: instead of polling for an unlock
+ * (like raw spinlocks do), lock and unlock, to force the kernel to
+ * schedule if there's contention:
+ */
+void __sched rt_spin_lock_unlock(spinlock_t *lock)
+{
+	spin_lock(lock);
+	spin_unlock(lock);
+}
+EXPORT_SYMBOL(rt_spin_lock_unlock);
+
+static __always_inline int __rt_spin_trylock(spinlock_t *lock)
+{
+	int ret =3D 1;
+
+	if (unlikely(!rt_mutex_cmpxchg_acquire(&lock->lock, NULL, current)))
+		ret =3D rt_mutex_slowtrylock(&lock->lock);
+
+	if (ret) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+
+int __sched rt_spin_trylock(spinlock_t *lock)
+{
+	return __rt_spin_trylock(lock);
+}
+EXPORT_SYMBOL(rt_spin_trylock);
+
+int __sched rt_spin_trylock_bh(spinlock_t *lock)
+{
+	int ret;
+
+	local_bh_disable();
+	ret =3D __rt_spin_trylock(lock);
+	if (!ret)
+		local_bh_enable();
+	return ret;
+}
+EXPORT_SYMBOL(rt_spin_trylock_bh);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rt_spin_lock_init(spinlock_t *lock, const char *name,
+			 struct lock_class_key *key, bool percpu)
+{
+	u8 type =3D percpu ? LD_LOCK_PERCPU : LD_LOCK_NORMAL;
+
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
+	lockdep_init_map_type(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG,
+			      LD_WAIT_INV, type);
+}
+EXPORT_SYMBOL(__rt_spin_lock_init);
+#endif
+
+/*
+ * RT-specific reader/writer locks
+ */
+#define rwbase_set_and_save_current_state(state)	\
+	current_save_and_set_rtlock_wait_state()
+
+#define rwbase_restore_current_state()			\
+	current_restore_rtlock_saved_state()
+
+static __always_inline int
+rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, unsigned int state)
+{
+	if (unlikely(!rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		rtlock_slowlock(rtm);
+	return 0;
+}
+
+static __always_inline int
+rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int state)
+{
+	rtlock_slowlock_locked(rtm);
+	return 0;
+}
+
+static __always_inline void rwbase_rtmutex_unlock(struct rt_mutex_base *rtm)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(rtm, current, NULL)))
+		return;
+
+	rt_mutex_slowunlock(rtm);
+}
+
+static __always_inline int  rwbase_rtmutex_trylock(struct rt_mutex_base *rtm)
+{
+	if (likely(rt_mutex_cmpxchg_acquire(rtm, NULL, current)))
+		return 1;
+
+	return rt_mutex_slowtrylock(rtm);
+}
+
+#define rwbase_signal_pending_state(state, current)	(0)
+
+#define rwbase_schedule()				\
+	schedule_rtlock()
+
+#include "rwbase_rt.c"
+/*
+ * The common functions which get wrapped into the rwlock API.
+ */
+int __sched rt_read_trylock(rwlock_t *rwlock)
+{
+	int ret;
+
+	ret =3D rwbase_read_trylock(&rwlock->rwbase);
+	if (ret) {
+		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rt_read_trylock);
+
+int __sched rt_write_trylock(rwlock_t *rwlock)
+{
+	int ret;
+
+	ret =3D rwbase_write_trylock(&rwlock->rwbase);
+	if (ret) {
+		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rcu_read_lock();
+		migrate_disable();
+	}
+	return ret;
+}
+EXPORT_SYMBOL(rt_write_trylock);
+
+void __sched rt_read_lock(rwlock_t *rwlock)
+{
+	___might_sleep(__FILE__, __LINE__, 0);
+	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_read_lock);
+
+void __sched rt_write_lock(rwlock_t *rwlock)
+{
+	___might_sleep(__FILE__, __LINE__, 0);
+	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+	rcu_read_lock();
+	migrate_disable();
+}
+EXPORT_SYMBOL(rt_write_lock);
+
+void __sched rt_read_unlock(rwlock_t *rwlock)
+{
+	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	migrate_enable();
+	rcu_read_unlock();
+	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
+}
+EXPORT_SYMBOL(rt_read_unlock);
+
+void __sched rt_write_unlock(rwlock_t *rwlock)
+{
+	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	rcu_read_unlock();
+	migrate_enable();
+	rwbase_write_unlock(&rwlock->rwbase);
+}
+EXPORT_SYMBOL(rt_write_unlock);
+
+int __sched rt_rwlock_is_contended(rwlock_t *rwlock)
+{
+	return rw_base_is_contended(&rwlock->rwbase);
+}
+EXPORT_SYMBOL(rt_rwlock_is_contended);
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void __rt_rwlock_init(rwlock_t *rwlock, const char *name,
+		      struct lock_class_key *key)
+{
+	debug_check_no_locks_freed((void *)rwlock, sizeof(*rwlock));
+	lockdep_init_map_wait(&rwlock->dep_map, name, key, 0, LD_WAIT_CONFIG);
+}
+EXPORT_SYMBOL(__rt_rwlock_init);
+#endif
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
new file mode 100644
index 000000000000..56f139201f24
--- /dev/null
+++ b/kernel/locking/ww_mutex.h
@@ -0,0 +1,569 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef WW_RT
+
+#define MUTEX		mutex
+#define MUTEX_WAITER	mutex_waiter
+
+static inline struct mutex_waiter *
+__ww_waiter_first(struct mutex *lock)
+{
+	struct mutex_waiter *w;
+
+	w =3D list_first_entry(&lock->wait_list, struct mutex_waiter, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_next(struct mutex *lock, struct mutex_waiter *w)
+{
+	w =3D list_next_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_prev(struct mutex *lock, struct mutex_waiter *w)
+{
+	w =3D list_prev_entry(w, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline struct mutex_waiter *
+__ww_waiter_last(struct mutex *lock)
+{
+	struct mutex_waiter *w;
+
+	w =3D list_last_entry(&lock->wait_list, struct mutex_waiter, list);
+	if (list_entry_is_head(w, &lock->wait_list, list))
+		return NULL;
+
+	return w;
+}
+
+static inline void
+__ww_waiter_add(struct mutex *lock, struct mutex_waiter *waiter, struct mute=
x_waiter *pos)
+{
+	struct list_head *p =3D &lock->wait_list;
+	if (pos)
+		p =3D &pos->list;
+	__mutex_add_waiter(lock, waiter, p);
+}
+
+static inline struct task_struct *
+__ww_mutex_owner(struct mutex *lock)
+{
+	return __mutex_owner(lock);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct mutex *lock)
+{
+	return atomic_long_read(&lock->owner) & MUTEX_FLAG_WAITERS;
+}
+
+static inline void lock_wait_lock(struct mutex *lock)
+{
+	raw_spin_lock(&lock->wait_lock);
+}
+
+static inline void unlock_wait_lock(struct mutex *lock)
+{
+	raw_spin_unlock(&lock->wait_lock);
+}
+
+static inline void lockdep_assert_wait_lock_held(struct mutex *lock)
+{
+	lockdep_assert_held(&lock->wait_lock);
+}
+
+#else /* WW_RT */
+
+#define MUTEX		rt_mutex
+#define MUTEX_WAITER	rt_mutex_waiter
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_first(struct rt_mutex *lock)
+{
+	struct rb_node *n =3D rb_first(&lock->rtmutex.waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_next(struct rt_mutex *lock, struct rt_mutex_waiter *w)
+{
+	struct rb_node *n =3D rb_next(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_prev(struct rt_mutex *lock, struct rt_mutex_waiter *w)
+{
+	struct rb_node *n =3D rb_prev(&w->tree_entry);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline struct rt_mutex_waiter *
+__ww_waiter_last(struct rt_mutex *lock)
+{
+	struct rb_node *n =3D rb_last(&lock->rtmutex.waiters.rb_root);
+	if (!n)
+		return NULL;
+	return rb_entry(n, struct rt_mutex_waiter, tree_entry);
+}
+
+static inline void
+__ww_waiter_add(struct rt_mutex *lock, struct rt_mutex_waiter *waiter, struc=
t rt_mutex_waiter *pos)
+{
+	/* RT unconditionally adds the waiter first and then removes it on error */
+}
+
+static inline struct task_struct *
+__ww_mutex_owner(struct rt_mutex *lock)
+{
+	return rt_mutex_owner(&lock->rtmutex);
+}
+
+static inline bool
+__ww_mutex_has_waiters(struct rt_mutex *lock)
+{
+	return rt_mutex_has_waiters(&lock->rtmutex);
+}
+
+static inline void lock_wait_lock(struct rt_mutex *lock)
+{
+	raw_spin_lock(&lock->rtmutex.wait_lock);
+}
+
+static inline void unlock_wait_lock(struct rt_mutex *lock)
+{
+	raw_spin_unlock(&lock->rtmutex.wait_lock);
+}
+
+static inline void lockdep_assert_wait_lock_held(struct rt_mutex *lock)
+{
+	lockdep_assert_held(&lock->rtmutex.wait_lock);
+}
+
+#endif /* WW_RT */
+
+/*
+ * Wait-Die:
+ *   The newer transactions are killed when:
+ *     It (the new transaction) makes a request for a lock being held
+ *     by an older transaction.
+ *
+ * Wound-Wait:
+ *   The newer transactions are wounded when:
+ *     An older transaction makes a request for a lock being held by
+ *     the newer transaction.
+ */
+
+/*
+ * Associate the ww_mutex @ww with the context @ww_ctx under which we acquir=
ed
+ * it.
+ */
+static __always_inline void
+ww_mutex_lock_acquired(struct ww_mutex *ww, struct ww_acquire_ctx *ww_ctx)
+{
+#ifdef DEBUG_WW_MUTEXES
+	/*
+	 * If this WARN_ON triggers, you used ww_mutex_lock to acquire,
+	 * but released with a normal mutex_unlock in this call.
+	 *
+	 * This should never happen, always use ww_mutex_unlock.
+	 */
+	DEBUG_LOCKS_WARN_ON(ww->ctx);
+
+	/*
+	 * Not quite done after calling ww_acquire_done() ?
+	 */
+	DEBUG_LOCKS_WARN_ON(ww_ctx->done_acquire);
+
+	if (ww_ctx->contending_lock) {
+		/*
+		 * After -EDEADLK you tried to
+		 * acquire a different ww_mutex? Bad!
+		 */
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock !=3D ww);
+
+		/*
+		 * You called ww_mutex_lock after receiving -EDEADLK,
+		 * but 'forgot' to unlock everything else first?
+		 */
+		DEBUG_LOCKS_WARN_ON(ww_ctx->acquired > 0);
+		ww_ctx->contending_lock =3D NULL;
+	}
+
+	/*
+	 * Naughty, using a different class will lead to undefined behavior!
+	 */
+	DEBUG_LOCKS_WARN_ON(ww_ctx->ww_class !=3D ww->ww_class);
+#endif
+	ww_ctx->acquired++;
+	ww->ctx =3D ww_ctx;
+}
+
+/*
+ * Determine if @a is 'less' than @b. IOW, either @a is a lower priority task
+ * or, when of equal priority, a younger transaction than @b.
+ *
+ * Depending on the algorithm, @a will either need to wait for @b, or die.
+ */
+static inline bool
+__ww_ctx_less(struct ww_acquire_ctx *a, struct ww_acquire_ctx *b)
+{
+/*
+ * Can only do the RT prio for WW_RT, because task->prio isn't stable due to=
 PI,
+ * so the wait_list ordering will go wobbly. rt_mutex re-queues the waiter a=
nd
+ * isn't affected by this.
+ */
+#ifdef WW_RT
+	/* kernel prio; less is more */
+	int a_prio =3D a->task->prio;
+	int b_prio =3D b->task->prio;
+
+	if (rt_prio(a_prio) || rt_prio(b_prio)) {
+
+		if (a_prio > b_prio)
+			return true;
+
+		if (a_prio < b_prio)
+			return false;
+
+		/* equal static prio */
+
+		if (dl_prio(a_prio)) {
+			if (dl_time_before(b->task->dl.deadline,
+					   a->task->dl.deadline))
+				return true;
+
+			if (dl_time_before(a->task->dl.deadline,
+					   b->task->dl.deadline))
+				return false;
+		}
+
+		/* equal prio */
+	}
+#endif
+
+	/* FIFO order tie break -- bigger is younger */
+	return (signed long)(a->stamp - b->stamp) > 0;
+}
+
+/*
+ * Wait-Die; wake a lesser waiter context (when locks held) such that it can
+ * die.
+ *
+ * Among waiters with context, only the first one can have other locks acqui=
red
+ * already (ctx->acquired > 0), because __ww_mutex_add_waiter() and
+ * __ww_mutex_check_kill() wake any but the earliest context.
+ */
+static bool
+__ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
+	       struct ww_acquire_ctx *ww_ctx)
+{
+	if (!ww_ctx->is_wait_die)
+		return false;
+
+	if (waiter->ww_ctx->acquired > 0 && __ww_ctx_less(waiter->ww_ctx, ww_ctx)) {
+#ifndef WW_RT
+		debug_mutex_wake_waiter(lock, waiter);
+#endif
+		wake_up_process(waiter->task);
+	}
+
+	return true;
+}
+
+/*
+ * Wound-Wait; wound a lesser @hold_ctx if it holds the lock.
+ *
+ * Wound the lock holder if there are waiters with more important transactio=
ns
+ * than the lock holders. Even if multiple waiters may wound the lock holder,
+ * it's sufficient that only one does.
+ */
+static bool __ww_mutex_wound(struct MUTEX *lock,
+			     struct ww_acquire_ctx *ww_ctx,
+			     struct ww_acquire_ctx *hold_ctx)
+{
+	struct task_struct *owner =3D __ww_mutex_owner(lock);
+
+	lockdep_assert_wait_lock_held(lock);
+
+	/*
+	 * Possible through __ww_mutex_add_waiter() when we race with
+	 * ww_mutex_set_context_fastpath(). In that case we'll get here again
+	 * through __ww_mutex_check_waiters().
+	 */
+	if (!hold_ctx)
+		return false;
+
+	/*
+	 * Can have !owner because of __mutex_unlock_slowpath(), but if owner,
+	 * it cannot go away because we'll have FLAG_WAITERS set and hold
+	 * wait_lock.
+	 */
+	if (!owner)
+		return false;
+
+	if (ww_ctx->acquired > 0 && __ww_ctx_less(hold_ctx, ww_ctx)) {
+		hold_ctx->wounded =3D 1;
+
+		/*
+		 * wake_up_process() paired with set_current_state()
+		 * inserts sufficient barriers to make sure @owner either sees
+		 * it's wounded in __ww_mutex_check_kill() or has a
+		 * wakeup pending to re-read the wounded state.
+		 */
+		if (owner !=3D current)
+			wake_up_process(owner);
+
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * We just acquired @lock under @ww_ctx, if there are more important contexts
+ * waiting behind us on the wait-list, check if they need to die, or wound u=
s.
+ *
+ * See __ww_mutex_add_waiter() for the list-order construction; basically the
+ * list is ordered by stamp, smallest (oldest) first.
+ *
+ * This relies on never mixing wait-die/wound-wait on the same wait-list;
+ * which is currently ensured by that being a ww_class property.
+ *
+ * The current task must not be on the wait list.
+ */
+static void
+__ww_mutex_check_waiters(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	struct MUTEX_WAITER *cur;
+
+	lockdep_assert_wait_lock_held(lock);
+
+	for (cur =3D __ww_waiter_first(lock); cur;
+	     cur =3D __ww_waiter_next(lock, cur)) {
+
+		if (!cur->ww_ctx)
+			continue;
+
+		if (__ww_mutex_die(lock, cur, ww_ctx) ||
+		    __ww_mutex_wound(lock, cur->ww_ctx, ww_ctx))
+			break;
+	}
+}
+
+/*
+ * After acquiring lock with fastpath, where we do not hold wait_lock, set c=
tx
+ * and wake up any waiters so they can recheck.
+ */
+static __always_inline void
+ww_mutex_set_context_fastpath(struct ww_mutex *lock, struct ww_acquire_ctx *=
ctx)
+{
+	ww_mutex_lock_acquired(lock, ctx);
+
+	/*
+	 * The lock->ctx update should be visible on all cores before
+	 * the WAITERS check is done, otherwise contended waiters might be
+	 * missed. The contended waiters will either see ww_ctx =3D=3D NULL
+	 * and keep spinning, or it will acquire wait_lock, add itself
+	 * to waiter list and sleep.
+	 */
+	smp_mb(); /* See comments above and below. */
+
+	/*
+	 * [W] ww->ctx =3D ctx	    [W] MUTEX_FLAG_WAITERS
+	 *     MB		        MB
+	 * [R] MUTEX_FLAG_WAITERS   [R] ww->ctx
+	 *
+	 * The memory barrier above pairs with the memory barrier in
+	 * __ww_mutex_add_waiter() and makes sure we either observe ww->ctx
+	 * and/or !empty list.
+	 */
+	if (likely(!__ww_mutex_has_waiters(&lock->base)))
+		return;
+
+	/*
+	 * Uh oh, we raced in fastpath, check if any of the waiters need to
+	 * die or wound us.
+	 */
+	lock_wait_lock(&lock->base);
+	__ww_mutex_check_waiters(&lock->base, ctx);
+	unlock_wait_lock(&lock->base);
+}
+
+static __always_inline int
+__ww_mutex_kill(struct MUTEX *lock, struct ww_acquire_ctx *ww_ctx)
+{
+	if (ww_ctx->acquired > 0) {
+#ifdef DEBUG_WW_MUTEXES
+		struct ww_mutex *ww;
+
+		ww =3D container_of(lock, struct ww_mutex, base);
+		DEBUG_LOCKS_WARN_ON(ww_ctx->contending_lock);
+		ww_ctx->contending_lock =3D ww;
+#endif
+		return -EDEADLK;
+	}
+
+	return 0;
+}
+
+/*
+ * Check the wound condition for the current lock acquire.
+ *
+ * Wound-Wait: If we're wounded, kill ourself.
+ *
+ * Wait-Die: If we're trying to acquire a lock already held by an older
+ *           context, kill ourselves.
+ *
+ * Since __ww_mutex_add_waiter() orders the wait-list on stamp, we only have=
 to
+ * look at waiters before us in the wait-list.
+ */
+static inline int
+__ww_mutex_check_kill(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
+		      struct ww_acquire_ctx *ctx)
+{
+	struct ww_mutex *ww =3D container_of(lock, struct ww_mutex, base);
+	struct ww_acquire_ctx *hold_ctx =3D READ_ONCE(ww->ctx);
+	struct MUTEX_WAITER *cur;
+
+	if (ctx->acquired =3D=3D 0)
+		return 0;
+
+	if (!ctx->is_wait_die) {
+		if (ctx->wounded)
+			return __ww_mutex_kill(lock, ctx);
+
+		return 0;
+	}
+
+	if (hold_ctx && __ww_ctx_less(ctx, hold_ctx))
+		return __ww_mutex_kill(lock, ctx);
+
+	/*
+	 * If there is a waiter in front of us that has a context, then its
+	 * stamp is earlier than ours and we must kill ourself.
+	 */
+	for (cur =3D __ww_waiter_prev(lock, waiter); cur;
+	     cur =3D __ww_waiter_prev(lock, cur)) {
+
+		if (!cur->ww_ctx)
+			continue;
+
+		return __ww_mutex_kill(lock, ctx);
+	}
+
+	return 0;
+}
+
+/*
+ * Add @waiter to the wait-list, keep the wait-list ordered by stamp, smalle=
st
+ * first. Such that older contexts are preferred to acquire the lock over
+ * younger contexts.
+ *
+ * Waiters without context are interspersed in FIFO order.
+ *
+ * Furthermore, for Wait-Die kill ourself immediately when possible (there a=
re
+ * older contexts already waiting) to avoid unnecessary waiting and for
+ * Wound-Wait ensure we wound the owning context when it is younger.
+ */
+static inline int
+__ww_mutex_add_waiter(struct MUTEX_WAITER *waiter,
+		      struct MUTEX *lock,
+		      struct ww_acquire_ctx *ww_ctx)
+{
+	struct MUTEX_WAITER *cur, *pos =3D NULL;
+	bool is_wait_die;
+
+	if (!ww_ctx) {
+		__ww_waiter_add(lock, waiter, NULL);
+		return 0;
+	}
+
+	is_wait_die =3D ww_ctx->is_wait_die;
+
+	/*
+	 * Add the waiter before the first waiter with a higher stamp.
+	 * Waiters without a context are skipped to avoid starving
+	 * them. Wait-Die waiters may die here. Wound-Wait waiters
+	 * never die here, but they are sorted in stamp order and
+	 * may wound the lock holder.
+	 */
+	for (cur =3D __ww_waiter_last(lock); cur;
+	     cur =3D __ww_waiter_prev(lock, cur)) {
+
+		if (!cur->ww_ctx)
+			continue;
+
+		if (__ww_ctx_less(ww_ctx, cur->ww_ctx)) {
+			/*
+			 * Wait-Die: if we find an older context waiting, there
+			 * is no point in queueing behind it, as we'd have to
+			 * die the moment it would acquire the lock.
+			 */
+			if (is_wait_die) {
+				int ret =3D __ww_mutex_kill(lock, ww_ctx);
+
+				if (ret)
+					return ret;
+			}
+
+			break;
+		}
+
+		pos =3D cur;
+
+		/* Wait-Die: ensure younger waiters die. */
+		__ww_mutex_die(lock, cur, ww_ctx);
+	}
+
+	__ww_waiter_add(lock, waiter, pos);
+
+	/*
+	 * Wound-Wait: if we're blocking on a mutex owned by a younger context,
+	 * wound that such that we might proceed.
+	 */
+	if (!is_wait_die) {
+		struct ww_mutex *ww =3D container_of(lock, struct ww_mutex, base);
+
+		/*
+		 * See ww_mutex_set_context_fastpath(). Orders setting
+		 * MUTEX_FLAG_WAITERS vs the ww->ctx load,
+		 * such that either we or the fastpath will wound @ww->ctx.
+		 */
+		smp_mb();
+		__ww_mutex_wound(lock, ww_ctx, ww->ctx);
+	}
+
+	return 0;
+}
+
+static inline void __ww_mutex_unlock(struct ww_mutex *lock)
+{
+	if (lock->ctx) {
+#ifdef DEBUG_WW_MUTEXES
+		DEBUG_LOCKS_WARN_ON(!lock->ctx->acquired);
+#endif
+		if (lock->ctx->acquired > 0)
+			lock->ctx->acquired--;
+		lock->ctx =3D NULL;
+	}
+}
diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
new file mode 100644
index 000000000000..3f1fff7d2780
--- /dev/null
+++ b/kernel/locking/ww_rt_mutex.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * rtmutex API
+ */
+#include <linux/spinlock.h>
+#include <linux/export.h>
+
+#define RT_MUTEX_BUILD_MUTEX
+#define WW_RT
+#include "rtmutex.c"
+
+static int __sched
+__ww_rt_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx,
+		   unsigned int state, unsigned long ip)
+{
+	struct lockdep_map __maybe_unused *nest_lock =3D NULL;
+	struct rt_mutex *rtm =3D &lock->base;
+	int ret;
+
+	might_sleep();
+
+	if (ww_ctx) {
+		if (unlikely(ww_ctx =3D=3D READ_ONCE(lock->ctx)))
+			return -EALREADY;
+
+		/*
+		 * Reset the wounded flag after a kill. No other process can
+		 * race and wound us here, since they can't have a valid owner
+		 * pointer if we don't have any locks held.
+		 */
+		if (ww_ctx->acquired =3D=3D 0)
+			ww_ctx->wounded =3D 0;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+		nest_lock =3D &ww_ctx->dep_map;
+#endif
+	}
+	mutex_acquire_nest(&rtm->dep_map, 0, 0, nest_lock, ip);
+
+	if (likely(rt_mutex_cmpxchg_acquire(&rtm->rtmutex, NULL, current))) {
+		if (ww_ctx)
+			ww_mutex_set_context_fastpath(lock, ww_ctx);
+		return 0;
+	}
+
+	ret =3D rt_mutex_slowlock(&rtm->rtmutex, ww_ctx, state);
+
+	if (ret)
+		mutex_release(&rtm->dep_map, ip);
+	return ret;
+}
+
+int __sched
+ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+{
+	return __ww_rt_mutex_lock(lock, ctx, TASK_UNINTERRUPTIBLE, _RET_IP_);
+}
+EXPORT_SYMBOL(ww_mutex_lock);
+
+int __sched
+ww_mutex_lock_interruptible(struct ww_mutex *lock, struct ww_acquire_ctx *ct=
x)
+{
+	return __ww_rt_mutex_lock(lock, ctx, TASK_INTERRUPTIBLE, _RET_IP_);
+}
+EXPORT_SYMBOL(ww_mutex_lock_interruptible);
+
+void __sched ww_mutex_unlock(struct ww_mutex *lock)
+{
+	struct rt_mutex *rtm =3D &lock->base;
+
+	__ww_mutex_unlock(lock);
+
+	mutex_release(&rtm->dep_map, _RET_IP_);
+	__rt_mutex_unlock(&rtm->rtmutex);
+}
+EXPORT_SYMBOL(ww_mutex_unlock);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index de1dc3bb7f70..0ff5e4fb933e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -559,7 +559,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t,=
 unsigned long flags)
 			WRITE_ONCE(rnp->exp_tasks, np);
 		if (IS_ENABLED(CONFIG_RCU_BOOST)) {
 			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
-			drop_boost_mutex =3D rt_mutex_owner(&rnp->boost_mtx) =3D=3D t;
+			drop_boost_mutex =3D rt_mutex_owner(&rnp->boost_mtx.rtmutex) =3D=3D t;
 			if (&t->rcu_node_entry =3D=3D rnp->boost_tasks)
 				WRITE_ONCE(rnp->boost_tasks, np);
 		}
@@ -586,7 +586,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t,=
 unsigned long flags)
=20
 		/* Unboost if we were boosted. */
 		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
-			rt_mutex_futex_unlock(&rnp->boost_mtx);
+			rt_mutex_futex_unlock(&rnp->boost_mtx.rtmutex);
=20
 		/*
 		 * If this was the last task on the expedited lists,
@@ -1083,7 +1083,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * section.
 	 */
 	t =3D container_of(tb, struct task_struct, rcu_node_entry);
-	rt_mutex_init_proxy_locked(&rnp->boost_mtx, t);
+	rt_mutex_init_proxy_locked(&rnp->boost_mtx.rtmutex, t);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20ffcc044134..c89c1d45dd0b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3561,6 +3561,55 @@ static void ttwu_queue(struct task_struct *p, int cpu,=
 int wake_flags)
 	rq_unlock(rq, &rf);
 }
=20
+/*
+ * Invoked from try_to_wake_up() to check whether the task can be woken up.
+ *
+ * The caller holds p::pi_lock if p !=3D current or has preemption
+ * disabled when p =3D=3D current.
+ *
+ * The rules of PREEMPT_RT saved_state:
+ *
+ *   The related locking code always holds p::pi_lock when updating
+ *   p::saved_state, which means the code is fully serialized in both cases.
+ *
+ *   The lock wait and lock wakeups happen via TASK_RTLOCK_WAIT. No other
+ *   bits set. This allows to distinguish all wakeup scenarios.
+ */
+static __always_inline
+bool ttwu_state_match(struct task_struct *p, unsigned int state, int *succes=
s)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_PREEMPT)) {
+		WARN_ON_ONCE((state & TASK_RTLOCK_WAIT) &&
+			     state !=3D TASK_RTLOCK_WAIT);
+	}
+
+	if (READ_ONCE(p->__state) & state) {
+		*success =3D 1;
+		return true;
+	}
+
+#ifdef CONFIG_PREEMPT_RT
+	/*
+	 * Saved state preserves the task state across blocking on
+	 * an RT lock.  If the state matches, set p::saved_state to
+	 * TASK_RUNNING, but do not wake the task because it waits
+	 * for a lock wakeup. Also indicate success because from
+	 * the regular waker's point of view this has succeeded.
+	 *
+	 * After acquiring the lock the task will restore p::__state
+	 * from p::saved_state which ensures that the regular
+	 * wakeup is not lost. The restore will also set
+	 * p::saved_state to TASK_RUNNING so any further tests will
+	 * not result in false positives vs. @success
+	 */
+	if (p->saved_state & state) {
+		p->saved_state =3D TASK_RUNNING;
+		*success =3D 1;
+	}
+#endif
+	return false;
+}
+
 /*
  * Notes on Program-Order guarantees on SMP systems.
  *
@@ -3700,10 +3749,9 @@ try_to_wake_up(struct task_struct *p, unsigned int sta=
te, int wake_flags)
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
-		if (!(READ_ONCE(p->__state) & state))
+		if (!ttwu_state_match(p, state, &success))
 			goto out;
=20
-		success =3D 1;
 		trace_sched_waking(p);
 		WRITE_ONCE(p->__state, TASK_RUNNING);
 		trace_sched_wakeup(p);
@@ -3718,14 +3766,11 @@ try_to_wake_up(struct task_struct *p, unsigned int st=
ate, int wake_flags)
 	 */
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	smp_mb__after_spinlock();
-	if (!(READ_ONCE(p->__state) & state))
+	if (!ttwu_state_match(p, state, &success))
 		goto unlock;
=20
 	trace_sched_waking(p);
=20
-	/* We're going to change ->state: */
-	success =3D 1;
-
 	/*
 	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
 	 * be possible to, falsely, observe p->on_rq =3D=3D 0 and get stuck
@@ -5774,6 +5819,24 @@ pick_next_task(struct rq *rq, struct task_struct *prev=
, struct rq_flags *rf)
=20
 #endif /* CONFIG_SCHED_CORE */
=20
+/*
+ * Constants for the sched_mode argument of __schedule().
+ *
+ * The mode argument allows RT enabled kernels to differentiate a
+ * preemption from blocking on an 'sleeping' spin/rwlock. Note that
+ * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
+ * optimize the AND operation out and just check for zero.
+ */
+#define SM_NONE			0x0
+#define SM_PREEMPT		0x1
+#define SM_RTLOCK_WAIT		0x2
+
+#ifndef CONFIG_PREEMPT_RT
+# define SM_MASK_PREEMPT	(~0U)
+#else
+# define SM_MASK_PREEMPT	SM_PREEMPT
+#endif
+
 /*
  * __schedule() is the main scheduler function.
  *
@@ -5813,7 +5876,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev,=
 struct rq_flags *rf)
  *
  * WARNING: must be called with preemption disabled!
  */
-static void __sched notrace __schedule(bool preempt)
+static void __sched notrace __schedule(unsigned int sched_mode)
 {
 	struct task_struct *prev, *next;
 	unsigned long *switch_count;
@@ -5826,13 +5889,13 @@ static void __sched notrace __schedule(bool preempt)
 	rq =3D cpu_rq(cpu);
 	prev =3D rq->curr;
=20
-	schedule_debug(prev, preempt);
+	schedule_debug(prev, !!sched_mode);
=20
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
=20
 	local_irq_disable();
-	rcu_note_context_switch(preempt);
+	rcu_note_context_switch(!!sched_mode);
=20
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -5866,7 +5929,7 @@ static void __sched notrace __schedule(bool preempt)
 	 *  - ptrace_{,un}freeze_traced() can change ->state underneath us.
 	 */
 	prev_state =3D READ_ONCE(prev->__state);
-	if (!preempt && prev_state) {
+	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
 		if (signal_pending_state(prev_state, prev)) {
 			WRITE_ONCE(prev->__state, TASK_RUNNING);
 		} else {
@@ -5932,7 +5995,7 @@ static void __sched notrace __schedule(bool preempt)
 		migrate_disable_switch(rq, prev);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
=20
-		trace_sched_switch(preempt, prev, next);
+		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next);
=20
 		/* Also unlocks the rq: */
 		rq =3D context_switch(rq, prev, next, &rf);
@@ -5953,7 +6016,7 @@ void __noreturn do_task_dead(void)
 	/* Tell freezer to ignore us: */
 	current->flags |=3D PF_NOFREEZE;
=20
-	__schedule(false);
+	__schedule(SM_NONE);
 	BUG();
=20
 	/* Avoid "noreturn function does return" - but don't continue if BUG() is a=
 NOP: */
@@ -6014,7 +6077,7 @@ asmlinkage __visible void __sched schedule(void)
 	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(false);
+		__schedule(SM_NONE);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 	sched_update_worker(tsk);
@@ -6042,7 +6105,7 @@ void __sched schedule_idle(void)
 	 */
 	WARN_ON_ONCE(current->__state);
 	do {
-		__schedule(false);
+		__schedule(SM_NONE);
 	} while (need_resched());
 }
=20
@@ -6077,6 +6140,18 @@ void __sched schedule_preempt_disabled(void)
 	preempt_disable();
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+void __sched notrace schedule_rtlock(void)
+{
+	do {
+		preempt_disable();
+		__schedule(SM_RTLOCK_WAIT);
+		sched_preempt_enable_no_resched();
+	} while (need_resched());
+}
+NOKPROBE_SYMBOL(schedule_rtlock);
+#endif
+
 static void __sched notrace preempt_schedule_common(void)
 {
 	do {
@@ -6095,7 +6170,7 @@ static void __sched notrace preempt_schedule_common(voi=
d)
 		 */
 		preempt_disable_notrace();
 		preempt_latency_start(1);
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
=20
@@ -6174,7 +6249,7 @@ asmlinkage __visible void __sched notrace preempt_sched=
ule_notrace(void)
 		 * an infinite recursion.
 		 */
 		prev_ctx =3D exception_enter();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		exception_exit(prev_ctx);
=20
 		preempt_latency_stop(1);
@@ -6323,7 +6398,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(=
void)
 	do {
 		preempt_disable();
 		local_irq_enable();
-		__schedule(true);
+		__schedule(SM_PREEMPT);
 		local_irq_disable();
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5ddd575159fb..e5cdf98f50c2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1235,7 +1235,7 @@ config PROVE_LOCKING
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_RWSEMS
 	select DEBUG_WW_MUTEX_SLOWPATH
@@ -1299,7 +1299,7 @@ config LOCK_STAT
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select LOCKDEP
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select DEBUG_LOCK_ALLOC
 	default n
@@ -1335,7 +1335,7 @@ config DEBUG_SPINLOCK
=20
 config DEBUG_MUTEXES
 	bool "Mutex debugging: basic checks"
-	depends on DEBUG_KERNEL
+	depends on DEBUG_KERNEL && !PREEMPT_RT
 	help
 	 This feature allows mutex semantics violations to be detected and
 	 reported.
@@ -1345,7 +1345,8 @@ config DEBUG_WW_MUTEX_SLOWPATH
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_LOCK_ALLOC
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
+	select DEBUG_RT_MUTEXES if PREEMPT_RT
 	help
 	 This feature enables slowpath testing for w/w mutex users by
 	 injecting additional -EDEADLK wound/backoff cases. Together with
@@ -1368,7 +1369,7 @@ config DEBUG_LOCK_ALLOC
 	bool "Lock debugging: detect incorrect freeing of live locks"
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select DEBUG_SPINLOCK
-	select DEBUG_MUTEXES
+	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
 	select LOCKDEP
 	help
diff --git a/lib/test_lockup.c b/lib/test_lockup.c
index 864554e76973..906b598740a7 100644
--- a/lib/test_lockup.c
+++ b/lib/test_lockup.c
@@ -485,13 +485,13 @@ static int __init test_lockup_init(void)
 		       offsetof(spinlock_t, lock.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwlock_ptr,
-		       offsetof(rwlock_t, rtmutex.wait_lock.magic),
+		       offsetof(rwlock_t, rwbase.rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_mutex_ptr,
-		       offsetof(struct mutex, lock.wait_lock.magic),
+		       offsetof(struct mutex, rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwsem_ptr,
-		       offsetof(struct rw_semaphore, rtmutex.wait_lock.magic),
+		       offsetof(struct rw_semaphore, rwbase.rtmutex.wait_lock.magic),
 		       SPINLOCK_MAGIC))
 		return -EINVAL;
 #else
@@ -502,7 +502,7 @@ static int __init test_lockup_init(void)
 		       offsetof(rwlock_t, magic),
 		       RWLOCK_MAGIC) ||
 	    test_magic(lock_mutex_ptr,
-		       offsetof(struct mutex, wait_lock.rlock.magic),
+		       offsetof(struct mutex, wait_lock.magic),
 		       SPINLOCK_MAGIC) ||
 	    test_magic(lock_rwsem_ptr,
 		       offsetof(struct rw_semaphore, wait_lock.magic),
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
index 9c7fbd4bcbce..0e7bab3eb0d1 100755
--- a/scripts/atomic/check-atomics.sh
+++ b/scripts/atomic/check-atomics.sh
@@ -14,9 +14,9 @@ if [ $? -ne 0 ]; then
 fi
=20
 cat <<EOF |
-asm-generic/atomic-instrumented.h
-asm-generic/atomic-long.h
-linux/atomic-arch-fallback.h
+linux/atomic/atomic-instrumented.h
+linux/atomic/atomic-long.h
+linux/atomic/atomic-arch-fallback.h
 EOF
 while read header; do
 	OLDSUM=3D"$(tail -n 1 ${LINUXDIR}/include/${header})"
diff --git a/scripts/atomic/fallbacks/acquire b/scripts/atomic/fallbacks/acqu=
ire
index 59c00529dc7c..ef764085c79a 100755
--- a/scripts/atomic/fallbacks/acquire
+++ b/scripts/atomic/fallbacks/acquire
@@ -1,8 +1,8 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}${name}${sfx}_acquire(${params})
+arch_${atomic}_${pfx}${name}${sfx}_acquire(${params})
 {
-	${ret} ret =3D ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${ret} ret =3D arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_acquire_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/add_negative b/scripts/atomic/fallbacks=
/add_negative
index a66635bceefb..15caa2eb2371 100755
--- a/scripts/atomic/fallbacks/add_negative
+++ b/scripts/atomic/fallbacks/add_negative
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_add_negative - add and test if negative
+ * arch_${atomic}_add_negative - add and test if negative
  * @i: integer value to add
  * @v: pointer of type ${atomic}_t
  *
@@ -9,8 +9,8 @@ cat <<EOF
  * result is greater than or equal to zero.
  */
 static __always_inline bool
-${arch}${atomic}_add_negative(${int} i, ${atomic}_t *v)
+arch_${atomic}_add_negative(${int} i, ${atomic}_t *v)
 {
-	return ${arch}${atomic}_add_return(i, v) < 0;
+	return arch_${atomic}_add_return(i, v) < 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/add_unless b/scripts/atomic/fallbacks/a=
dd_unless
index 2ff598a3f9ec..9e5159c2ccfc 100755
--- a/scripts/atomic/fallbacks/add_unless
+++ b/scripts/atomic/fallbacks/add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${arch}${atomic}_add_unless - add unless the number is already a given va=
lue
+ * arch_${atomic}_add_unless - add unless the number is already a given value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -9,8 +9,8 @@ cat << EOF
  * Returns true if the addition was done.
  */
 static __always_inline bool
-${arch}${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+arch_${atomic}_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	return ${arch}${atomic}_fetch_add_unless(v, a, u) !=3D u;
+	return arch_${atomic}_fetch_add_unless(v, a, u) !=3D u;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/andnot b/scripts/atomic/fallbacks/andnot
index 3f18663dcefb..5a42f54a3595 100755
--- a/scripts/atomic/fallbacks/andnot
+++ b/scripts/atomic/fallbacks/andnot
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
+arch_${atomic}_${pfx}andnot${sfx}${order}(${int} i, ${atomic}_t *v)
 {
-	${retstmt}${arch}${atomic}_${pfx}and${sfx}${order}(~i, v);
+	${retstmt}arch_${atomic}_${pfx}and${sfx}${order}(~i, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec b/scripts/atomic/fallbacks/dec
index e2e01f0574bb..8c144c818e9e 100755
--- a/scripts/atomic/fallbacks/dec
+++ b/scripts/atomic/fallbacks/dec
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
+arch_${atomic}_${pfx}dec${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${arch}${atomic}_${pfx}sub${sfx}${order}(1, v);
+	${retstmt}arch_${atomic}_${pfx}sub${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_and_test b/scripts/atomic/fallbacks=
/dec_and_test
index e8a5e492eb5f..8549f359bd0e 100755
--- a/scripts/atomic/fallbacks/dec_and_test
+++ b/scripts/atomic/fallbacks/dec_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_dec_and_test - decrement and test
+ * arch_${atomic}_dec_and_test - decrement and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically decrements @v by 1 and
@@ -8,8 +8,8 @@ cat <<EOF
  * cases.
  */
 static __always_inline bool
-${arch}${atomic}_dec_and_test(${atomic}_t *v)
+arch_${atomic}_dec_and_test(${atomic}_t *v)
 {
-	return ${arch}${atomic}_dec_return(v) =3D=3D 0;
+	return arch_${atomic}_dec_return(v) =3D=3D 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/dec_if_positive b/scripts/atomic/fallba=
cks/dec_if_positive
index 527adec89c37..86bdced3428d 100755
--- a/scripts/atomic/fallbacks/dec_if_positive
+++ b/scripts/atomic/fallbacks/dec_if_positive
@@ -1,14 +1,14 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_dec_if_positive(${atomic}_t *v)
+arch_${atomic}_dec_if_positive(${atomic}_t *v)
 {
-	${int} dec, c =3D ${arch}${atomic}_read(v);
+	${int} dec, c =3D arch_${atomic}_read(v);
=20
 	do {
 		dec =3D c - 1;
 		if (unlikely(dec < 0))
 			break;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, dec));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, dec));
=20
 	return dec;
 }
diff --git a/scripts/atomic/fallbacks/dec_unless_positive b/scripts/atomic/fa=
llbacks/dec_unless_positive
index dcab6848ca1e..c531d5afecc4 100755
--- a/scripts/atomic/fallbacks/dec_unless_positive
+++ b/scripts/atomic/fallbacks/dec_unless_positive
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-${arch}${atomic}_dec_unless_positive(${atomic}_t *v)
+arch_${atomic}_dec_unless_positive(${atomic}_t *v)
 {
-	${int} c =3D ${arch}${atomic}_read(v);
+	${int} c =3D arch_${atomic}_read(v);
=20
 	do {
 		if (unlikely(c > 0))
 			return false;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c - 1));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, c - 1));
=20
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/fence b/scripts/atomic/fallbacks/fence
index 3764fc8ce945..07757d8e338e 100755
--- a/scripts/atomic/fallbacks/fence
+++ b/scripts/atomic/fallbacks/fence
@@ -1,10 +1,10 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}${name}${sfx}(${params})
+arch_${atomic}_${pfx}${name}${sfx}(${params})
 {
 	${ret} ret;
 	__atomic_pre_full_fence();
-	ret =3D ${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	ret =3D arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 	__atomic_post_full_fence();
 	return ret;
 }
diff --git a/scripts/atomic/fallbacks/fetch_add_unless b/scripts/atomic/fallb=
acks/fetch_add_unless
index 0e0b9aef1515..68ce13c8b9da 100755
--- a/scripts/atomic/fallbacks/fetch_add_unless
+++ b/scripts/atomic/fallbacks/fetch_add_unless
@@ -1,6 +1,6 @@
 cat << EOF
 /**
- * ${arch}${atomic}_fetch_add_unless - add unless the number is already a gi=
ven value
+ * arch_${atomic}_fetch_add_unless - add unless the number is already a give=
n value
  * @v: pointer of type ${atomic}_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -9,14 +9,14 @@ cat << EOF
  * Returns original value of @v
  */
 static __always_inline ${int}
-${arch}${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
+arch_${atomic}_fetch_add_unless(${atomic}_t *v, ${int} a, ${int} u)
 {
-	${int} c =3D ${arch}${atomic}_read(v);
+	${int} c =3D arch_${atomic}_read(v);
=20
 	do {
 		if (unlikely(c =3D=3D u))
 			break;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + a));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, c + a));
=20
 	return c;
 }
diff --git a/scripts/atomic/fallbacks/inc b/scripts/atomic/fallbacks/inc
index 15ec62946e8c..3c2c3739169e 100755
--- a/scripts/atomic/fallbacks/inc
+++ b/scripts/atomic/fallbacks/inc
@@ -1,7 +1,7 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
+arch_${atomic}_${pfx}inc${sfx}${order}(${atomic}_t *v)
 {
-	${retstmt}${arch}${atomic}_${pfx}add${sfx}${order}(1, v);
+	${retstmt}arch_${atomic}_${pfx}add${sfx}${order}(1, v);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_and_test b/scripts/atomic/fallbacks=
/inc_and_test
index cecc8322a21f..0cf23fe1efb8 100755
--- a/scripts/atomic/fallbacks/inc_and_test
+++ b/scripts/atomic/fallbacks/inc_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_inc_and_test - increment and test
+ * arch_${atomic}_inc_and_test - increment and test
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1
@@ -8,8 +8,8 @@ cat <<EOF
  * other cases.
  */
 static __always_inline bool
-${arch}${atomic}_inc_and_test(${atomic}_t *v)
+arch_${atomic}_inc_and_test(${atomic}_t *v)
 {
-	return ${arch}${atomic}_inc_return(v) =3D=3D 0;
+	return arch_${atomic}_inc_return(v) =3D=3D 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_not_zero b/scripts/atomic/fallbacks=
/inc_not_zero
index 50f2d4d48279..ed8a1f562667 100755
--- a/scripts/atomic/fallbacks/inc_not_zero
+++ b/scripts/atomic/fallbacks/inc_not_zero
@@ -1,14 +1,14 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_inc_not_zero - increment unless the number is zero
+ * arch_${atomic}_inc_not_zero - increment unless the number is zero
  * @v: pointer of type ${atomic}_t
  *
  * Atomically increments @v by 1, if @v is non-zero.
  * Returns true if the increment was done.
  */
 static __always_inline bool
-${arch}${atomic}_inc_not_zero(${atomic}_t *v)
+arch_${atomic}_inc_not_zero(${atomic}_t *v)
 {
-	return ${arch}${atomic}_add_unless(v, 1, 0);
+	return arch_${atomic}_add_unless(v, 1, 0);
 }
 EOF
diff --git a/scripts/atomic/fallbacks/inc_unless_negative b/scripts/atomic/fa=
llbacks/inc_unless_negative
index 87629e0d4a80..95d8ce48233f 100755
--- a/scripts/atomic/fallbacks/inc_unless_negative
+++ b/scripts/atomic/fallbacks/inc_unless_negative
@@ -1,13 +1,13 @@
 cat <<EOF
 static __always_inline bool
-${arch}${atomic}_inc_unless_negative(${atomic}_t *v)
+arch_${atomic}_inc_unless_negative(${atomic}_t *v)
 {
-	${int} c =3D ${arch}${atomic}_read(v);
+	${int} c =3D arch_${atomic}_read(v);
=20
 	do {
 		if (unlikely(c < 0))
 			return false;
-	} while (!${arch}${atomic}_try_cmpxchg(v, &c, c + 1));
+	} while (!arch_${atomic}_try_cmpxchg(v, &c, c + 1));
=20
 	return true;
 }
diff --git a/scripts/atomic/fallbacks/read_acquire b/scripts/atomic/fallbacks=
/read_acquire
index 341a88dccaa7..803ba7561076 100755
--- a/scripts/atomic/fallbacks/read_acquire
+++ b/scripts/atomic/fallbacks/read_acquire
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_read_acquire(const ${atomic}_t *v)
+arch_${atomic}_read_acquire(const ${atomic}_t *v)
 {
 	return smp_load_acquire(&(v)->counter);
 }
diff --git a/scripts/atomic/fallbacks/release b/scripts/atomic/fallbacks/rele=
ase
index f8906d537c0f..b46feb56d69c 100755
--- a/scripts/atomic/fallbacks/release
+++ b/scripts/atomic/fallbacks/release
@@ -1,8 +1,8 @@
 cat <<EOF
 static __always_inline ${ret}
-${arch}${atomic}_${pfx}${name}${sfx}_release(${params})
+arch_${atomic}_${pfx}${name}${sfx}_release(${params})
 {
 	__atomic_release_fence();
-	${retstmt}${arch}${atomic}_${pfx}${name}${sfx}_relaxed(${args});
+	${retstmt}arch_${atomic}_${pfx}${name}${sfx}_relaxed(${args});
 }
 EOF
diff --git a/scripts/atomic/fallbacks/set_release b/scripts/atomic/fallbacks/=
set_release
index 76068272d5f5..86ede759f24e 100755
--- a/scripts/atomic/fallbacks/set_release
+++ b/scripts/atomic/fallbacks/set_release
@@ -1,6 +1,6 @@
 cat <<EOF
 static __always_inline void
-${arch}${atomic}_set_release(${atomic}_t *v, ${int} i)
+arch_${atomic}_set_release(${atomic}_t *v, ${int} i)
 {
 	smp_store_release(&(v)->counter, i);
 }
diff --git a/scripts/atomic/fallbacks/sub_and_test b/scripts/atomic/fallbacks=
/sub_and_test
index c580f4c2136e..260f37341c88 100755
--- a/scripts/atomic/fallbacks/sub_and_test
+++ b/scripts/atomic/fallbacks/sub_and_test
@@ -1,6 +1,6 @@
 cat <<EOF
 /**
- * ${arch}${atomic}_sub_and_test - subtract value from variable and test res=
ult
+ * arch_${atomic}_sub_and_test - subtract value from variable and test result
  * @i: integer value to subtract
  * @v: pointer of type ${atomic}_t
  *
@@ -9,8 +9,8 @@ cat <<EOF
  * other cases.
  */
 static __always_inline bool
-${arch}${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
+arch_${atomic}_sub_and_test(${int} i, ${atomic}_t *v)
 {
-	return ${arch}${atomic}_sub_return(i, v) =3D=3D 0;
+	return arch_${atomic}_sub_return(i, v) =3D=3D 0;
 }
 EOF
diff --git a/scripts/atomic/fallbacks/try_cmpxchg b/scripts/atomic/fallbacks/=
try_cmpxchg
index 06db0f738e45..890f850ede37 100755
--- a/scripts/atomic/fallbacks/try_cmpxchg
+++ b/scripts/atomic/fallbacks/try_cmpxchg
@@ -1,9 +1,9 @@
 cat <<EOF
 static __always_inline bool
-${arch}${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
+arch_${atomic}_try_cmpxchg${order}(${atomic}_t *v, ${int} *old, ${int} new)
 {
 	${int} r, o =3D *old;
-	r =3D ${arch}${atomic}_cmpxchg${order}(v, o, new);
+	r =3D arch_${atomic}_cmpxchg${order}(v, o, new);
 	if (unlikely(r !=3D o))
 		*old =3D r;
 	return likely(r =3D=3D o);
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomi=
c-fallback.sh
index 317a6cec76e1..8e2da71f1d5f 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -2,11 +2,10 @@
 # SPDX-License-Identifier: GPL-2.0
=20
 ATOMICDIR=3D$(dirname $0)
-ARCH=3D$2
=20
 . ${ATOMICDIR}/atomic-tbl.sh
=20
-#gen_template_fallback(template, meta, pfx, name, sfx, order, arch, atomic, =
int, args...)
+#gen_template_fallback(template, meta, pfx, name, sfx, order, atomic, int, a=
rgs...)
 gen_template_fallback()
 {
 	local template=3D"$1"; shift
@@ -15,11 +14,10 @@ gen_template_fallback()
 	local name=3D"$1"; shift
 	local sfx=3D"$1"; shift
 	local order=3D"$1"; shift
-	local arch=3D"$1"; shift
 	local atomic=3D"$1"; shift
 	local int=3D"$1"; shift
=20
-	local atomicname=3D"${arch}${atomic}_${pfx}${name}${sfx}${order}"
+	local atomicname=3D"arch_${atomic}_${pfx}${name}${sfx}${order}"
=20
 	local ret=3D"$(gen_ret_type "${meta}" "${int}")"
 	local retstmt=3D"$(gen_ret_stmt "${meta}")"
@@ -34,7 +32,7 @@ gen_template_fallback()
 	fi
 }
=20
-#gen_proto_fallback(meta, pfx, name, sfx, order, arch, atomic, int, args...)
+#gen_proto_fallback(meta, pfx, name, sfx, order, atomic, int, args...)
 gen_proto_fallback()
 {
 	local meta=3D"$1"; shift
@@ -65,44 +63,26 @@ gen_proto_order_variant()
 	local name=3D"$1"; shift
 	local sfx=3D"$1"; shift
 	local order=3D"$1"; shift
-	local arch=3D"$1"
-	local atomic=3D"$2"
+	local atomic=3D"$1"
=20
-	local basename=3D"${arch}${atomic}_${pfx}${name}${sfx}"
+	local basename=3D"arch_${atomic}_${pfx}${name}${sfx}"
=20
-	printf "#define arch_${basename}${order} ${basename}${order}\n"
+	printf "#define ${basename}${order} ${basename}${order}\n"
 }
=20
-#gen_proto_order_variants(meta, pfx, name, sfx, arch, atomic, int, args...)
+#gen_proto_order_variants(meta, pfx, name, sfx, atomic, int, args...)
 gen_proto_order_variants()
 {
 	local meta=3D"$1"; shift
 	local pfx=3D"$1"; shift
 	local name=3D"$1"; shift
 	local sfx=3D"$1"; shift
-	local arch=3D"$1"
-	local atomic=3D"$2"
+	local atomic=3D"$1"
=20
-	local basename=3D"${arch}${atomic}_${pfx}${name}${sfx}"
+	local basename=3D"arch_${atomic}_${pfx}${name}${sfx}"
=20
 	local template=3D"$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${o=
rder}")"
=20
-	if [ -z "$arch" ]; then
-		gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
-
-		if meta_has_acquire "${meta}"; then
-			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" =
"$@"
-		fi
-		if meta_has_release "${meta}"; then
-			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_release" =
"$@"
-		fi
-		if meta_has_relaxed "${meta}"; then
-			gen_proto_order_variant "${meta}" "${pfx}" "${name}" "${sfx}" "_relaxed" =
"$@"
-		fi
-
-		echo ""
-	fi
-
 	# If we don't have relaxed atomics, then we don't bother with ordering fall=
backs
 	# read_acquire and set_release need to be templated, though
 	if ! meta_has_relaxed "${meta}"; then
@@ -128,7 +108,7 @@ gen_proto_order_variants()
 	gen_basic_fallbacks "${basename}"
=20
 	if [ ! -z "${template}" ]; then
-		printf "#endif /* ${arch}${atomic}_${pfx}${name}${sfx} */\n\n"
+		printf "#endif /* ${basename} */\n\n"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_acquire" "$@"
 		gen_proto_fallback "${meta}" "${pfx}" "${name}" "${sfx}" "_release" "$@"
@@ -187,38 +167,38 @@ gen_try_cmpxchg_fallback()
 	local order=3D"$1"; shift;
=20
 cat <<EOF
-#ifndef ${ARCH}try_cmpxchg${order}
-#define ${ARCH}try_cmpxchg${order}(_ptr, _oldp, _new) \\
+#ifndef arch_try_cmpxchg${order}
+#define arch_try_cmpxchg${order}(_ptr, _oldp, _new) \\
 ({ \\
 	typeof(*(_ptr)) *___op =3D (_oldp), ___o =3D *___op, ___r; \\
-	___r =3D ${ARCH}cmpxchg${order}((_ptr), ___o, (_new)); \\
+	___r =3D arch_cmpxchg${order}((_ptr), ___o, (_new)); \\
 	if (unlikely(___r !=3D ___o)) \\
 		*___op =3D ___r; \\
 	likely(___r =3D=3D ___o); \\
 })
-#endif /* ${ARCH}try_cmpxchg${order} */
+#endif /* arch_try_cmpxchg${order} */
=20
 EOF
 }
=20
 gen_try_cmpxchg_fallbacks()
 {
-	printf "#ifndef ${ARCH}try_cmpxchg_relaxed\n"
-	printf "#ifdef ${ARCH}try_cmpxchg\n"
+	printf "#ifndef arch_try_cmpxchg_relaxed\n"
+	printf "#ifdef arch_try_cmpxchg\n"
=20
-	gen_basic_fallbacks "${ARCH}try_cmpxchg"
+	gen_basic_fallbacks "arch_try_cmpxchg"
=20
-	printf "#endif /* ${ARCH}try_cmpxchg */\n\n"
+	printf "#endif /* arch_try_cmpxchg */\n\n"
=20
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_try_cmpxchg_fallback "${order}"
 	done
=20
-	printf "#else /* ${ARCH}try_cmpxchg_relaxed */\n"
+	printf "#else /* arch_try_cmpxchg_relaxed */\n"
=20
-	gen_order_fallbacks "${ARCH}try_cmpxchg"
+	gen_order_fallbacks "arch_try_cmpxchg"
=20
-	printf "#endif /* ${ARCH}try_cmpxchg_relaxed */\n\n"
+	printf "#endif /* arch_try_cmpxchg_relaxed */\n\n"
 }
=20
 cat << EOF
@@ -234,14 +214,14 @@ cat << EOF
=20
 EOF
=20
-for xchg in "${ARCH}xchg" "${ARCH}cmpxchg" "${ARCH}cmpxchg64"; do
+for xchg in "arch_xchg" "arch_cmpxchg" "arch_cmpxchg64"; do
 	gen_xchg_fallbacks "${xchg}"
 done
=20
 gen_try_cmpxchg_fallbacks
=20
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "${ARCH}" "atomic" "int" ${args}
+	gen_proto "${meta}" "${name}" "atomic" "int" ${args}
 done
=20
 cat <<EOF
@@ -252,7 +232,7 @@ cat <<EOF
 EOF
=20
 grep '^[a-z]' "$1" | while read name meta args; do
-	gen_proto "${meta}" "${name}" "${ARCH}" "atomic64" "s64" ${args}
+	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
=20
 cat <<EOF
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-a=
tomic-instrumented.sh
index b0c45aee19d7..035ceb4ee85c 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -121,8 +121,8 @@ cat << EOF
  * arch_ variants (i.e. arch_atomic_read()/arch_atomic_cmpxchg()) to avoid
  * double instrumentation.
  */
-#ifndef _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
-#define _ASM_GENERIC_ATOMIC_INSTRUMENTED_H
+#ifndef _LINUX_ATOMIC_INSTRUMENTED_H
+#define _LINUX_ATOMIC_INSTRUMENTED_H
=20
 #include <linux/build_bug.h>
 #include <linux/compiler.h>
@@ -138,6 +138,11 @@ grep '^[a-z]' "$1" | while read name meta args; do
 	gen_proto "${meta}" "${name}" "atomic64" "s64" ${args}
 done
=20
+grep '^[a-z]' "$1" | while read name meta args; do
+	gen_proto "${meta}" "${name}" "atomic_long" "long" ${args}
+done
+
+
 for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
 		gen_xchg "${xchg}${order}" ""
@@ -158,5 +163,5 @@ gen_xchg "cmpxchg_double_local" "2 * "
=20
 cat <<EOF
=20
-#endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
+#endif /* _LINUX_ATOMIC_INSTRUMENTED_H */
 EOF
diff --git a/scripts/atomic/gen-atomic-long.sh b/scripts/atomic/gen-atomic-lo=
ng.sh
index e318d3f92e53..eda89cea6e1d 100755
--- a/scripts/atomic/gen-atomic-long.sh
+++ b/scripts/atomic/gen-atomic-long.sh
@@ -47,9 +47,9 @@ gen_proto_order_variant()
=20
 cat <<EOF
 static __always_inline ${ret}
-atomic_long_${name}(${params})
+arch_atomic_long_${name}(${params})
 {
-	${retstmt}${atomic}_${name}(${argscast});
+	${retstmt}arch_${atomic}_${name}(${argscast});
 }
=20
 EOF
@@ -61,8 +61,8 @@ cat << EOF
 // Generated by $0
 // DO NOT MODIFY THIS FILE DIRECTLY
=20
-#ifndef _ASM_GENERIC_ATOMIC_LONG_H
-#define _ASM_GENERIC_ATOMIC_LONG_H
+#ifndef _LINUX_ATOMIC_LONG_H
+#define _LINUX_ATOMIC_LONG_H
=20
 #include <linux/compiler.h>
 #include <asm/types.h>
@@ -98,5 +98,5 @@ done
=20
 cat <<EOF
 #endif /* CONFIG_64BIT */
-#endif /* _ASM_GENERIC_ATOMIC_LONG_H */
+#endif /* _LINUX_ATOMIC_LONG_H */
 EOF
diff --git a/scripts/atomic/gen-atomics.sh b/scripts/atomic/gen-atomics.sh
index f776a574224d..5b98a8307693 100755
--- a/scripts/atomic/gen-atomics.sh
+++ b/scripts/atomic/gen-atomics.sh
@@ -8,9 +8,9 @@ ATOMICTBL=3D${ATOMICDIR}/atomics.tbl
 LINUXDIR=3D${ATOMICDIR}/../..
=20
 cat <<EOF |
-gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
-gen-atomic-long.sh              asm-generic/atomic-long.h
-gen-atomic-fallback.sh          linux/atomic-arch-fallback.h		arch_
+gen-atomic-instrumented.sh      linux/atomic/atomic-instrumented.h
+gen-atomic-long.sh              linux/atomic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic/atomic-arch-fallback.h
 EOF
 while read script header args; do
 	/bin/sh ${ATOMICDIR}/${script} ${ATOMICTBL} ${args} > ${LINUXDIR}/include/$=
{header}

