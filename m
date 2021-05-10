Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4426377FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhEJJnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:43:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230350AbhEJJnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 492131595;
        Mon, 10 May 2021 02:42:01 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1EFA03F73B;
        Mon, 10 May 2021 02:41:57 -0700 (PDT)
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
Subject: [PATCH 20/33] locking/atomic: m68k: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:40 +0100
Message-Id: <20210510093753.40683-21-mark.rutland@arm.com>
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

As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/m68k/Kconfig               |  1 +
 arch/m68k/include/asm/atomic.h  | 60 ++++++++++++++++++++---------------------
 arch/m68k/include/asm/cmpxchg.h | 10 +++----
 3 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 372e4e69c43a..d1d91ac47f51 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,6 +3,7 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
diff --git a/arch/m68k/include/asm/atomic.h b/arch/m68k/include/asm/atomic.h
index 756c5cc58f94..8637bf8a2f65 100644
--- a/arch/m68k/include/asm/atomic.h
+++ b/arch/m68k/include/asm/atomic.h
@@ -16,8 +16,8 @@
  * We do not have SMP m68k systems, so we don't have to deal with that.
  */
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
 
 /*
  * The ColdFire parts cannot do some immediate to memory operations,
@@ -30,7 +30,7 @@
 #endif
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	__asm__ __volatile__(#asm_op "l %1,%0" : "+m" (*v) : ASM_DI (i));\
 }									\
@@ -38,7 +38,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 #ifdef CONFIG_RMW_INSNS
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int t, tmp;							\
 									\
@@ -48,12 +48,12 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (atomic_read(v)));		\
+			: "g" (i), "2" (arch_atomic_read(v)));		\
 	return t;							\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int t, tmp;							\
 									\
@@ -63,14 +63,14 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 			"	casl %2,%1,%0\n"			\
 			"	jne 1b"					\
 			: "+m" (*v), "=&d" (t), "=&d" (tmp)		\
-			: "g" (i), "2" (atomic_read(v)));		\
+			: "g" (i), "2" (arch_atomic_read(v)));		\
 	return tmp;							\
 }
 
 #else
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t * v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 {									\
 	unsigned long flags;						\
 	int t;								\
@@ -83,7 +83,7 @@ static inline int atomic_##op##_return(int i, atomic_t * v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long flags;						\
 	int t;								\
@@ -120,27 +120,27 @@ ATOMIC_OPS(xor, ^=, eor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-static inline void atomic_inc(atomic_t *v)
+static inline void arch_atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__("addql #1,%0" : "+m" (*v));
 }
-#define atomic_inc atomic_inc
+#define arch_atomic_inc arch_atomic_inc
 
-static inline void atomic_dec(atomic_t *v)
+static inline void arch_atomic_dec(atomic_t *v)
 {
 	__asm__ __volatile__("subql #1,%0" : "+m" (*v));
 }
-#define atomic_dec atomic_dec
+#define arch_atomic_dec arch_atomic_dec
 
-static inline int atomic_dec_and_test(atomic_t *v)
+static inline int arch_atomic_dec_and_test(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("subql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
-#define atomic_dec_and_test atomic_dec_and_test
+#define arch_atomic_dec_and_test arch_atomic_dec_and_test
 
-static inline int atomic_dec_and_test_lt(atomic_t *v)
+static inline int arch_atomic_dec_and_test_lt(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__(
@@ -150,49 +150,49 @@ static inline int atomic_dec_and_test_lt(atomic_t *v)
 	return c != 0;
 }
 
-static inline int atomic_inc_and_test(atomic_t *v)
+static inline int arch_atomic_inc_and_test(atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("addql #1,%1; seq %0" : "=d" (c), "+m" (*v));
 	return c != 0;
 }
-#define atomic_inc_and_test atomic_inc_and_test
+#define arch_atomic_inc_and_test arch_atomic_inc_and_test
 
 #ifdef CONFIG_RMW_INSNS
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #else /* !CONFIG_RMW_INSNS */
 
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	unsigned long flags;
 	int prev;
 
 	local_irq_save(flags);
-	prev = atomic_read(v);
+	prev = arch_atomic_read(v);
 	if (prev == old)
-		atomic_set(v, new);
+		arch_atomic_set(v, new);
 	local_irq_restore(flags);
 	return prev;
 }
 
-static inline int atomic_xchg(atomic_t *v, int new)
+static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
 	unsigned long flags;
 	int prev;
 
 	local_irq_save(flags);
-	prev = atomic_read(v);
-	atomic_set(v, new);
+	prev = arch_atomic_read(v);
+	arch_atomic_set(v, new);
 	local_irq_restore(flags);
 	return prev;
 }
 
 #endif /* !CONFIG_RMW_INSNS */
 
-static inline int atomic_sub_and_test(int i, atomic_t *v)
+static inline int arch_atomic_sub_and_test(int i, atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("subl %2,%1; seq %0"
@@ -200,9 +200,9 @@ static inline int atomic_sub_and_test(int i, atomic_t *v)
 			     : ASM_DI (i));
 	return c != 0;
 }
-#define atomic_sub_and_test atomic_sub_and_test
+#define arch_atomic_sub_and_test arch_atomic_sub_and_test
 
-static inline int atomic_add_negative(int i, atomic_t *v)
+static inline int arch_atomic_add_negative(int i, atomic_t *v)
 {
 	char c;
 	__asm__ __volatile__("addl %2,%1; smi %0"
@@ -210,6 +210,6 @@ static inline int atomic_add_negative(int i, atomic_t *v)
 			     : ASM_DI (i));
 	return c != 0;
 }
-#define atomic_add_negative atomic_add_negative
+#define arch_atomic_add_negative arch_atomic_add_negative
 
 #endif /* __ARCH_M68K_ATOMIC __ */
diff --git a/arch/m68k/include/asm/cmpxchg.h b/arch/m68k/include/asm/cmpxchg.h
index 7629c9c1ed5b..e8ca4b0ccefa 100644
--- a/arch/m68k/include/asm/cmpxchg.h
+++ b/arch/m68k/include/asm/cmpxchg.h
@@ -76,11 +76,11 @@ static inline unsigned long __xchg(unsigned long x, volatile void * ptr, int siz
 }
 #endif
 
-#define xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
+#define arch_xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
 
 #include <asm-generic/cmpxchg-local.h>
 
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 extern unsigned long __invalid_cmpxchg_size(volatile void *,
 					    unsigned long, unsigned long, int);
@@ -118,14 +118,14 @@ static inline unsigned long __cmpxchg(volatile void *p, unsigned long old,
 	return old;
 }
 
-#define cmpxchg(ptr, o, n)						    \
+#define arch_cmpxchg(ptr, o, n)						    \
 	({(__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
 			(unsigned long)(n), sizeof(*(ptr)));})
-#define cmpxchg_local(ptr, o, n)					    \
+#define arch_cmpxchg_local(ptr, o, n)					    \
 	({(__typeof__(*(ptr)))__cmpxchg((ptr), (unsigned long)(o),	    \
 			(unsigned long)(n), sizeof(*(ptr)));})
 
-#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n)	arch_cmpxchg64_local((ptr), (o), (n))
 
 #else
 
-- 
2.11.0

