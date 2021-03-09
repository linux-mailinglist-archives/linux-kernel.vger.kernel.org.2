Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B6331CB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCICAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:00:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:41486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230161AbhCICAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:00:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A1F3AAC8C;
        Tue,  9 Mar 2021 02:00:06 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     npiggin@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dave@stgolabs.net,
        parri.andrea@gmail.com, pabeni@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/3] powerpc/spinlock: Unserialize spin_is_locked
Date:   Mon,  8 Mar 2021 17:59:49 -0800
Message-Id: <20210309015950.27688-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309015950.27688-1-dave@stgolabs.net>
References: <20210309015950.27688-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

c6f5d02b6a0f (locking/spinlocks/arm64: Remove smp_mb() from
arch_spin_is_locked()) made it pretty official that the call
semantics do not imply any sort of barriers, and any user that
gets creative must explicitly do any serialization.

This creativity, however, is nowadays pretty limited:

1. spin_unlock_wait() has been removed from the kernel in favor
of a lock/unlock combo. Furthermore, queued spinlocks have now
for a number of years no longer relied on _Q_LOCKED_VAL for the
call, but any non-zero value to indicate a locked state. There
were cases where the delayed locked store could lead to breaking
mutual exclusion with crossed locking; such as with sysv ipc and
netfilter being the most extreme.

2. The auditing Andrea did in verified that remaining spin_is_locked()
no longer rely on such semantics. Most callers just use it to assert
a lock is taken, in a debug nature. The only user that gets cute is
NOLOCK qdisc, as of:

   96009c7d500e (sched: replace __QDISC_STATE_RUNNING bit with a spin lock)

... which ironically went in the next day after c6f5d02b6a0f. This
change replaces test_bit() with spin_is_locked() to know whether
to take the busylock heuristic to reduce contention on the main
qdisc lock. So any races against spin_is_locked() for archs that
use LL/SC for spin_lock() will be benign and not break any mutual
exclusion; furthermore, both the seqlock and busylock have the same
scope.

Cc: parri.andrea@gmail.com
Cc: pabeni@redhat.com
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/powerpc/include/asm/qspinlock.h       | 12 ------------
 arch/powerpc/include/asm/simple_spinlock.h |  3 +--
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index 3ce1a0bee4fe..b052b0624816 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -44,18 +44,6 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 }
 #define queued_spin_lock queued_spin_lock
 
-static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
-{
-	/*
-	 * This barrier was added to simple spinlocks by commit 51d7d5205d338,
-	 * but it should now be possible to remove it, asm arm64 has done with
-	 * commit c6f5d02b6a0f.
-	 */
-	smp_mb();
-	return atomic_read(&lock->val);
-}
-#define queued_spin_is_locked queued_spin_is_locked
-
 #ifdef CONFIG_PARAVIRT_SPINLOCKS
 #define SPIN_THRESHOLD (1<<15) /* not tuned */
 
diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
index 3e87258f73b1..1b935396522a 100644
--- a/arch/powerpc/include/asm/simple_spinlock.h
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -38,8 +38,7 @@ static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
 
 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-	smp_mb();
-	return !arch_spin_value_unlocked(*lock);
+	return !arch_spin_value_unlocked(READ_ONCE(*lock));
 }
 
 /*
-- 
2.26.2

