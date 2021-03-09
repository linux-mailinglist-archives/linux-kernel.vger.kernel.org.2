Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F65331CB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 03:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhCICAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 21:00:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:41410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhCICAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 21:00:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1017CAC54;
        Tue,  9 Mar 2021 02:00:03 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     npiggin@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/3] powerpc/spinlock: Define smp_mb__after_spinlock only once
Date:   Mon,  8 Mar 2021 17:59:48 -0800
Message-Id: <20210309015950.27688-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210309015950.27688-1-dave@stgolabs.net>
References: <20210309015950.27688-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of both queued and simple spinlocks doing it. Move
it into the arch's spinlock.h.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/powerpc/include/asm/qspinlock.h       | 2 --
 arch/powerpc/include/asm/simple_spinlock.h | 3 ---
 arch/powerpc/include/asm/spinlock.h        | 3 +++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/asm/qspinlock.h
index b752d34517b3..3ce1a0bee4fe 100644
--- a/arch/powerpc/include/asm/qspinlock.h
+++ b/arch/powerpc/include/asm/qspinlock.h
@@ -44,8 +44,6 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
 }
 #define queued_spin_lock queued_spin_lock
 
-#define smp_mb__after_spinlock()   smp_mb()
-
 static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
 {
 	/*
diff --git a/arch/powerpc/include/asm/simple_spinlock.h b/arch/powerpc/include/asm/simple_spinlock.h
index 9c3c30534333..3e87258f73b1 100644
--- a/arch/powerpc/include/asm/simple_spinlock.h
+++ b/arch/powerpc/include/asm/simple_spinlock.h
@@ -282,7 +282,4 @@ static inline void arch_write_unlock(arch_rwlock_t *rw)
 #define arch_read_relax(lock)	rw_yield(lock)
 #define arch_write_relax(lock)	rw_yield(lock)
 
-/* See include/linux/spinlock.h */
-#define smp_mb__after_spinlock()   smp_mb()
-
 #endif /* _ASM_POWERPC_SIMPLE_SPINLOCK_H */
diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 6ec72282888d..bd75872a6334 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -10,6 +10,9 @@
 #include <asm/simple_spinlock.h>
 #endif
 
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
 #ifndef CONFIG_PARAVIRT_SPINLOCKS
 static inline void pv_spinlocks_init(void) { }
 #endif
-- 
2.26.2

