Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79F377FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhEJJmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:42:17 -0400
Received: from foss.arm.com ([217.140.110.172]:51232 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhEJJmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:42:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 048E61516;
        Mon, 10 May 2021 02:41:06 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF2793F73B;
        Mon, 10 May 2021 02:41:01 -0700 (PDT)
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
Subject: [PATCH 14/33] locking/atomic: arc: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:34 +0100
Message-Id: <20210510093753.40683-15-mark.rutland@arm.com>
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

As a step towards that, this patch migrates arc to ARCH_ATOMIC. The arch
code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common code
wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arc/Kconfig               |  1 +
 arch/arc/include/asm/atomic.h  | 56 +++++++++++++++++++++---------------------
 arch/arc/include/asm/cmpxchg.h |  8 +++---
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 2d98501c0897..098ecc72d048 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -6,6 +6,7 @@
 config ARC
 	def_bool y
 	select ARC_TIMERS
+	select ARCH_ATOMIC
 	select ARCH_HAS_CACHE_LINE_SIZE
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DMA_PREP_COHERENT
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index 5afc79c9b2f5..1576a7ebec01 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -14,14 +14,14 @@
 #include <asm/barrier.h>
 #include <asm/smp.h>
 
-#define atomic_read(v)  READ_ONCE((v)->counter)
+#define arch_atomic_read(v)  READ_ONCE((v)->counter)
 
 #ifdef CONFIG_ARC_HAS_LLSC
 
-#define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned int val;						\
 									\
@@ -37,7 +37,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned int val;						\
 									\
@@ -63,7 +63,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned int val, orig;						\
 									\
@@ -94,11 +94,11 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 #ifndef CONFIG_SMP
 
  /* violating atomic_xxx API locking protocol in UP for optimization sake */
-#define atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_set(v, i) WRITE_ONCE(((v)->counter), (i))
 
 #else
 
-static inline void atomic_set(atomic_t *v, int i)
+static inline void arch_atomic_set(atomic_t *v, int i)
 {
 	/*
 	 * Independent of hardware support, all of the atomic_xxx() APIs need
@@ -116,7 +116,7 @@ static inline void atomic_set(atomic_t *v, int i)
 	atomic_ops_unlock(flags);
 }
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
 #endif
 
@@ -126,7 +126,7 @@ static inline void atomic_set(atomic_t *v, int i)
  */
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -136,7 +136,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	unsigned long temp;						\
@@ -154,7 +154,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	unsigned long orig;						\
@@ -180,8 +180,8 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define atomic_andnot		atomic_andnot
-#define atomic_fetch_andnot	atomic_fetch_andnot
+#define arch_atomic_andnot		arch_atomic_andnot
+#define arch_atomic_fetch_andnot	arch_atomic_fetch_andnot
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
@@ -220,7 +220,7 @@ typedef struct {
 
 #define ATOMIC64_INIT(a) { (a) }
 
-static inline s64 atomic64_read(const atomic64_t *v)
+static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 val;
 
@@ -232,7 +232,7 @@ static inline s64 atomic64_read(const atomic64_t *v)
 	return val;
 }
 
-static inline void atomic64_set(atomic64_t *v, s64 a)
+static inline void arch_atomic64_set(atomic64_t *v, s64 a)
 {
 	/*
 	 * This could have been a simple assignment in "C" but would need
@@ -253,7 +253,7 @@ static inline void atomic64_set(atomic64_t *v, s64 a)
 }
 
 #define ATOMIC64_OP(op, op1, op2)					\
-static inline void atomic64_##op(s64 a, atomic64_t *v)			\
+static inline void arch_atomic64_##op(s64 a, atomic64_t *v)		\
 {									\
 	s64 val;							\
 									\
@@ -270,7 +270,7 @@ static inline void atomic64_##op(s64 a, atomic64_t *v)			\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
-static inline s64 atomic64_##op##_return(s64 a, atomic64_t *v)		\
+static inline s64 arch_atomic64_##op##_return(s64 a, atomic64_t *v)	\
 {									\
 	s64 val;							\
 									\
@@ -293,7 +293,7 @@ static inline s64 atomic64_##op##_return(s64 a, atomic64_t *v)		\
 }
 
 #define ATOMIC64_FETCH_OP(op, op1, op2)		        		\
-static inline s64 atomic64_fetch_##op(s64 a, atomic64_t *v)		\
+static inline s64 arch_atomic64_fetch_##op(s64 a, atomic64_t *v)	\
 {									\
 	s64 val, orig;							\
 									\
@@ -320,8 +320,8 @@ static inline s64 atomic64_fetch_##op(s64 a, atomic64_t *v)		\
 	ATOMIC64_OP_RETURN(op, op1, op2)				\
 	ATOMIC64_FETCH_OP(op, op1, op2)
 
-#define atomic64_andnot		atomic64_andnot
-#define atomic64_fetch_andnot	atomic64_fetch_andnot
+#define arch_atomic64_andnot		arch_atomic64_andnot
+#define arch_atomic64_fetch_andnot	arch_atomic64_fetch_andnot
 
 ATOMIC64_OPS(add, add.f, adc)
 ATOMIC64_OPS(sub, sub.f, sbc)
@@ -336,7 +336,7 @@ ATOMIC64_OPS(xor, xor, xor)
 #undef ATOMIC64_OP
 
 static inline s64
-atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
+arch_atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
 {
 	s64 prev;
 
@@ -358,7 +358,7 @@ atomic64_cmpxchg(atomic64_t *ptr, s64 expected, s64 new)
 	return prev;
 }
 
-static inline s64 atomic64_xchg(atomic64_t *ptr, s64 new)
+static inline s64 arch_atomic64_xchg(atomic64_t *ptr, s64 new)
 {
 	s64 prev;
 
@@ -379,14 +379,14 @@ static inline s64 atomic64_xchg(atomic64_t *ptr, s64 new)
 }
 
 /**
- * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic64_t
  *
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
 
-static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 val;
 
@@ -408,10 +408,10 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 
 	return val;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 /**
- * atomic64_fetch_add_unless - add unless the number is a given value
+ * arch_atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -419,7 +419,7 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
  * Atomically adds @a to @v, if it was not @u.
  * Returns the old value of @v
  */
-static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 old, temp;
 
@@ -443,7 +443,7 @@ static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return old;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 #endif	/* !CONFIG_GENERIC_ATOMIC64 */
 
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index 9b87e162e539..87666980b78a 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -63,7 +63,7 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 
 #endif
 
-#define cmpxchg(ptr, o, n) ({				\
+#define arch_cmpxchg(ptr, o, n) ({			\
 	(typeof(*(ptr)))__cmpxchg((ptr),		\
 				  (unsigned long)(o),	\
 				  (unsigned long)(n));	\
@@ -75,7 +75,7 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
  *  !LLSC: cmpxchg() has to use an external lock atomic_ops_lock to guarantee
  *         semantics, and this lock also happens to be used by atomic_*()
  */
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
 
 
 /*
@@ -123,7 +123,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
 #if !defined(CONFIG_ARC_HAS_LLSC) && defined(CONFIG_SMP)
 
-#define xchg(ptr, with)			\
+#define arch_xchg(ptr, with)		\
 ({					\
 	unsigned long flags;		\
 	typeof(*(ptr)) old_val;		\
@@ -136,7 +136,7 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
 #else
 
-#define xchg(ptr, with)  _xchg(ptr, with)
+#define arch_xchg(ptr, with)  _xchg(ptr, with)
 
 #endif
 
-- 
2.11.0

