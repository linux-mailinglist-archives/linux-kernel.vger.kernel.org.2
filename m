Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0BF377FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhEJJoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:44:22 -0400
Received: from foss.arm.com ([217.140.110.172]:51974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhEJJoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:44:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2CE715BF;
        Mon, 10 May 2021 02:43:10 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BEB793F73B;
        Mon, 10 May 2021 02:43:06 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org
Cc:     aou@eecs.berkeley.edu, arnd@arndb.de, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mark.rutland@arm.com, mattst88@gmail.com,
        monstr@monstr.eu, mpe@ellerman.id.au, nickhu@andestech.com,
        palmer@dabbelt.com, paulus@samba.org, paul.walmsley@sifive.com,
        rth@twiddle.net, shorne@gmail.com,
        stefan.kristiansson@saunalahti.fi, tsbogend@alpha.franken.de,
        vgupta@synopsys.com, ysato@users.sourceforge.jp
Subject: [PATCH 25/33] locking/atomic: openrisc: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:45 +0100
Message-Id: <20210510093753.40683-26-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like all architectures to convert to ARCH_ATOMIC, as once all
architectures are converted it will be possible to make significant
cleanups to the atomics headers, and this will make it much easier to
generically enable atomic functionality (e.g. debug logic in the
instrumented wrappers).

As a step towards that, this patch migrates openrisc to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Will Deacon <will@kernel.org>
---
 arch/openrisc/Kconfig               |  1 +
 arch/openrisc/include/asm/atomic.h  | 42 ++++++++++++++++++++-----------------
 arch/openrisc/include/asm/cmpxchg.h |  4 ++--
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index 591acc5990dc..8c50bc9674f5 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,7 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/openrisc/include/asm/atomic.h b/arch/openrisc/include/asm/atomic.h
index cb86970d3859..326167e4783a 100644
--- a/arch/openrisc/include/asm/atomic.h
+++ b/arch/openrisc/include/asm/atomic.h
@@ -13,7 +13,7 @@
 
 /* Atomically perform op with v->counter and i */
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	int tmp;							\
 									\
@@ -30,7 +30,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 
 /* Atomically perform op with v->counter and i, return the result */
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int tmp;							\
 									\
@@ -49,7 +49,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 
 /* Atomically perform op with v->counter and i, return orig v->counter */
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int tmp, old;							\
 									\
@@ -75,6 +75,8 @@ ATOMIC_FETCH_OP(and)
 ATOMIC_FETCH_OP(or)
 ATOMIC_FETCH_OP(xor)
 
+ATOMIC_OP(add)
+ATOMIC_OP(sub)
 ATOMIC_OP(and)
 ATOMIC_OP(or)
 ATOMIC_OP(xor)
@@ -83,16 +85,18 @@ ATOMIC_OP(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_add_return	atomic_add_return
-#define atomic_sub_return	atomic_sub_return
-#define atomic_fetch_add	atomic_fetch_add
-#define atomic_fetch_sub	atomic_fetch_sub
-#define atomic_fetch_and	atomic_fetch_and
-#define atomic_fetch_or		atomic_fetch_or
-#define atomic_fetch_xor	atomic_fetch_xor
-#define atomic_and	atomic_and
-#define atomic_or	atomic_or
-#define atomic_xor	atomic_xor
+#define arch_atomic_add_return	arch_atomic_add_return
+#define arch_atomic_sub_return	arch_atomic_sub_return
+#define arch_atomic_fetch_add	arch_atomic_fetch_add
+#define arch_atomic_fetch_sub	arch_atomic_fetch_sub
+#define arch_atomic_fetch_and	arch_atomic_fetch_and
+#define arch_atomic_fetch_or	arch_atomic_fetch_or
+#define arch_atomic_fetch_xor	arch_atomic_fetch_xor
+#define arch_atomic_add		arch_atomic_add
+#define arch_atomic_sub		arch_atomic_sub
+#define arch_atomic_and		arch_atomic_and
+#define arch_atomic_or		arch_atomic_or
+#define arch_atomic_xor		arch_atomic_xor
 
 /*
  * Atomically add a to v->counter as long as v is not already u.
@@ -100,7 +104,7 @@ ATOMIC_OP(xor)
  *
  * This is often used through atomic_inc_not_zero()
  */
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int old, tmp;
 
@@ -119,14 +123,14 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return old;
 }
-#define atomic_fetch_add_unless	atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless	arch_atomic_fetch_add_unless
 
-#define atomic_read(v)			READ_ONCE((v)->counter)
-#define atomic_set(v,i)			WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
 
 #include <asm/cmpxchg.h>
 
-#define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
-#define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
+#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
+#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
 
 #endif /* __ASM_OPENRISC_ATOMIC_H */
diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index f9cd43a39d72..79fd16162ccb 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -132,7 +132,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	}
 }
 
-#define cmpxchg(ptr, o, n)						\
+#define arch_cmpxchg(ptr, o, n)						\
 	({								\
 		(__typeof__(*(ptr))) __cmpxchg((ptr),			\
 					       (unsigned long)(o),	\
@@ -161,7 +161,7 @@ static inline unsigned long __xchg(volatile void *ptr, unsigned long with,
 	}
 }
 
-#define xchg(ptr, with) 						\
+#define arch_xchg(ptr, with) 						\
 	({								\
 		(__typeof__(*(ptr))) __xchg((ptr),			\
 					    (unsigned long)(with),	\
-- 
2.11.0

