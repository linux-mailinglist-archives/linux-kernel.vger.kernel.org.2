Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBC4377F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhEJJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:42:06 -0400
Received: from foss.arm.com ([217.140.110.172]:51176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230229AbhEJJmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:42:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 859C11515;
        Mon, 10 May 2021 02:41:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4599B3F73B;
        Mon, 10 May 2021 02:40:56 -0700 (PDT)
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
Subject: [PATCH 13/33] locking/atomic: alpha: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:33 +0100
Message-Id: <20210510093753.40683-14-mark.rutland@arm.com>
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

As a step towards that, this patch migrates alpha to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Note: xchg_local() is NOT currently part of the generic atomic
arch_atomic API, and is not instrumented.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Will Deacon <will@kernel.org>
---
 arch/alpha/Kconfig               |  1 +
 arch/alpha/include/asm/atomic.h  | 88 +++++++++++++++++++++-------------------
 arch/alpha/include/asm/cmpxchg.h | 12 +++---
 3 files changed, 54 insertions(+), 47 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 5998106faa60..7920fc2e2a2a 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -2,6 +2,7 @@
 config ALPHA
 	bool
 	default y
+	select ARCH_ATOMIC
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/alpha/include/asm/atomic.h b/arch/alpha/include/asm/atomic.h
index e41c113c6688..60a2872986a2 100644
--- a/arch/alpha/include/asm/atomic.h
+++ b/arch/alpha/include/asm/atomic.h
@@ -26,11 +26,11 @@
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic64_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic64_read(v)	READ_ONCE((v)->counter)
 
-#define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
-#define atomic64_set(v,i)	WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_set(v,i)	WRITE_ONCE((v)->counter, (i))
+#define arch_atomic64_set(v,i)	WRITE_ONCE((v)->counter, (i))
 
 /*
  * To get proper branch prediction for the main line, we must branch
@@ -39,7 +39,7 @@
  */
 
 #define ATOMIC_OP(op, asm_op)						\
-static __inline__ void atomic_##op(int i, atomic_t * v)			\
+static __inline__ void arch_atomic_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long temp;						\
 	__asm__ __volatile__(						\
@@ -55,7 +55,7 @@ static __inline__ void atomic_##op(int i, atomic_t * v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, asm_op)					\
-static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	long temp, result;						\
 	__asm__ __volatile__(						\
@@ -74,7 +74,7 @@ static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC_FETCH_OP(op, asm_op)					\
-static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	long temp, result;						\
 	__asm__ __volatile__(						\
@@ -92,7 +92,7 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC64_OP(op, asm_op)						\
-static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		\
+static __inline__ void arch_atomic64_##op(s64 i, atomic64_t * v)	\
 {									\
 	s64 temp;							\
 	__asm__ __volatile__(						\
@@ -108,7 +108,8 @@ static __inline__ void atomic64_##op(s64 i, atomic64_t * v)		\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, asm_op)					\
-static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)	\
+static __inline__ s64							\
+arch_atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)		\
 {									\
 	s64 temp, result;						\
 	__asm__ __volatile__(						\
@@ -127,7 +128,8 @@ static __inline__ s64 atomic64_##op##_return_relaxed(s64 i, atomic64_t * v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, asm_op)					\
-static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)	\
+static __inline__ s64							\
+arch_atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)		\
 {									\
 	s64 temp, result;						\
 	__asm__ __volatile__(						\
@@ -155,18 +157,18 @@ static __inline__ s64 atomic64_fetch_##op##_relaxed(s64 i, atomic64_t * v)	\
 ATOMIC_OPS(add)
 ATOMIC_OPS(sub)
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
 
-#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
 
-#define atomic_andnot atomic_andnot
-#define atomic64_andnot atomic64_andnot
+#define arch_atomic_andnot		arch_atomic_andnot
+#define arch_atomic64_andnot		arch_atomic64_andnot
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, asm)						\
@@ -180,15 +182,15 @@ ATOMIC_OPS(andnot, bic)
 ATOMIC_OPS(or, bis)
 ATOMIC_OPS(xor, xor)
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
+#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
 
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
+#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
 
 #undef ATOMIC_OPS
 #undef ATOMIC64_FETCH_OP
@@ -198,14 +200,18 @@ ATOMIC_OPS(xor, xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic64_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic64_cmpxchg(v, old, new) \
+	(arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic64_xchg(v, new) \
+	(arch_xchg(&((v)->counter), new))
 
-#define atomic_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, old, new) \
+	(arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic_xchg(v, new) \
+	(arch_xchg(&((v)->counter), new))
 
 /**
- * atomic_fetch_add_unless - add unless the number is a given value
+ * arch_atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -213,7 +219,7 @@ ATOMIC_OPS(xor, xor)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static __inline__ int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int c, new, old;
 	smp_mb();
@@ -234,10 +240,10 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	smp_mb();
 	return old;
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
 /**
- * atomic64_fetch_add_unless - add unless the number is a given value
+ * arch_atomic64_fetch_add_unless - add unless the number is a given value
  * @v: pointer of type atomic64_t
  * @a: the amount to add to v...
  * @u: ...unless v is equal to u.
@@ -245,7 +251,7 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
  * Atomically adds @a to @v, so long as it was not @u.
  * Returns the old value of @v.
  */
-static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static __inline__ s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 c, new, old;
 	smp_mb();
@@ -266,16 +272,16 @@ static __inline__ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 	smp_mb();
 	return old;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 /*
- * atomic64_dec_if_positive - decrement by 1 if old value positive
+ * arch_atomic64_dec_if_positive - decrement by 1 if old value positive
  * @v: pointer of type atomic_t
  *
  * The function returns the old value of *v minus 1, even if
  * the atomic variable, v, was not decremented.
  */
-static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 old, tmp;
 	smp_mb();
@@ -295,6 +301,6 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 	smp_mb();
 	return old - 1;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 #endif /* _ALPHA_ATOMIC_H */
diff --git a/arch/alpha/include/asm/cmpxchg.h b/arch/alpha/include/asm/cmpxchg.h
index 6c7c39452471..6e0a850aa9d3 100644
--- a/arch/alpha/include/asm/cmpxchg.h
+++ b/arch/alpha/include/asm/cmpxchg.h
@@ -17,7 +17,7 @@
 				       sizeof(*(ptr)));			\
 })
 
-#define cmpxchg_local(ptr, o, n)					\
+#define arch_cmpxchg_local(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -26,7 +26,7 @@
 					  sizeof(*(ptr)));		\
 })
 
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
@@ -42,7 +42,7 @@
  * The leading and the trailing memory barriers guarantee that these
  * operations are fully ordered.
  */
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _x_ = (x);					\
@@ -53,7 +53,7 @@
 	__ret;								\
 })
 
-#define cmpxchg(ptr, o, n)						\
+#define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _o_ = (o);					\
@@ -65,10 +65,10 @@
 	__ret;								\
 })
 
-#define cmpxchg64(ptr, o, n)						\
+#define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
 })
 
 #undef ____cmpxchg
-- 
2.11.0

