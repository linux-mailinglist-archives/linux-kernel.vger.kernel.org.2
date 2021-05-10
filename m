Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8DD377FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhEJJoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:44:37 -0400
Received: from foss.arm.com ([217.140.110.172]:52160 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhEJJoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:44:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8286F1650;
        Mon, 10 May 2021 02:43:32 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 547303F73B;
        Mon, 10 May 2021 02:43:28 -0700 (PDT)
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
Subject: [PATCH 28/33] locking/atomic: riscv: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:48 +0100
Message-Id: <20210510093753.40683-29-mark.rutland@arm.com>
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

As a step towards that, this patch migrates riscv to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/atomic.h  | 128 +++++++++++++++++++--------------------
 arch/riscv/include/asm/cmpxchg.h |  34 +++++------
 3 files changed, 82 insertions(+), 81 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a8ad8eb76120..c59b9f4a9d62 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,7 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ARCH_ATOMIC
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
diff --git a/arch/riscv/include/asm/atomic.h b/arch/riscv/include/asm/atomic.h
index 400a8c8b6de7..ac9bdf4fc404 100644
--- a/arch/riscv/include/asm/atomic.h
+++ b/arch/riscv/include/asm/atomic.h
@@ -25,22 +25,22 @@
 #define __atomic_release_fence()					\
 	__asm__ __volatile__(RISCV_RELEASE_BARRIER "" ::: "memory");
 
-static __always_inline int atomic_read(const atomic_t *v)
+static __always_inline int arch_atomic_read(const atomic_t *v)
 {
 	return READ_ONCE(v->counter);
 }
-static __always_inline void atomic_set(atomic_t *v, int i)
+static __always_inline void arch_atomic_set(atomic_t *v, int i)
 {
 	WRITE_ONCE(v->counter, i);
 }
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 #define ATOMIC64_INIT(i) { (i) }
-static __always_inline s64 atomic64_read(const atomic64_t *v)
+static __always_inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	return READ_ONCE(v->counter);
 }
-static __always_inline void atomic64_set(atomic64_t *v, s64 i)
+static __always_inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	WRITE_ONCE(v->counter, i);
 }
@@ -53,7 +53,7 @@ static __always_inline void atomic64_set(atomic64_t *v, s64 i)
  */
 #define ATOMIC_OP(op, asm_op, I, asm_type, c_type, prefix)		\
 static __always_inline							\
-void atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)		\
+void arch_atomic##prefix##_##op(c_type i, atomic##prefix##_t *v)	\
 {									\
 	__asm__ __volatile__ (						\
 		"	amo" #asm_op "." #asm_type " zero, %1, %0"	\
@@ -87,7 +87,7 @@ ATOMIC_OPS(xor, xor,  i)
  */
 #define ATOMIC_FETCH_OP(op, asm_op, I, asm_type, c_type, prefix)	\
 static __always_inline							\
-c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,			\
+c_type arch_atomic##prefix##_fetch_##op##_relaxed(c_type i,		\
 					     atomic##prefix##_t *v)	\
 {									\
 	register c_type ret;						\
@@ -99,7 +99,7 @@ c_type atomic##prefix##_fetch_##op##_relaxed(c_type i,			\
 	return ret;							\
 }									\
 static __always_inline							\
-c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
+c_type arch_atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
 {									\
 	register c_type ret;						\
 	__asm__ __volatile__ (						\
@@ -112,15 +112,15 @@ c_type atomic##prefix##_fetch_##op(c_type i, atomic##prefix##_t *v)	\
 
 #define ATOMIC_OP_RETURN(op, asm_op, c_op, I, asm_type, c_type, prefix)	\
 static __always_inline							\
-c_type atomic##prefix##_##op##_return_relaxed(c_type i,			\
+c_type arch_atomic##prefix##_##op##_return_relaxed(c_type i,		\
 					      atomic##prefix##_t *v)	\
 {									\
-        return atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
+        return arch_atomic##prefix##_fetch_##op##_relaxed(i, v) c_op I;	\
 }									\
 static __always_inline							\
-c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
+c_type arch_atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
 {									\
-        return atomic##prefix##_fetch_##op(i, v) c_op I;		\
+        return arch_atomic##prefix##_fetch_##op(i, v) c_op I;		\
 }
 
 #ifdef CONFIG_GENERIC_ATOMIC64
@@ -138,26 +138,26 @@ c_type atomic##prefix##_##op##_return(c_type i, atomic##prefix##_t *v)	\
 ATOMIC_OPS(add, add, +,  i)
 ATOMIC_OPS(sub, add, +, -i)
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_add_return		atomic_add_return
-#define atomic_sub_return		atomic_sub_return
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_add_return		arch_atomic_add_return
+#define arch_atomic_sub_return		arch_atomic_sub_return
 
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
-#define atomic_fetch_add		atomic_fetch_add
-#define atomic_fetch_sub		atomic_fetch_sub
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
+#define arch_atomic_fetch_add		arch_atomic_fetch_add
+#define arch_atomic_fetch_sub		arch_atomic_fetch_sub
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-#define atomic64_add_return		atomic64_add_return
-#define atomic64_sub_return		atomic64_sub_return
-
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
-#define atomic64_fetch_add		atomic64_fetch_add
-#define atomic64_fetch_sub		atomic64_fetch_sub
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_add_return		arch_atomic64_add_return
+#define arch_atomic64_sub_return		arch_atomic64_sub_return
+
+#define arch_atomic64_fetch_add_relaxed	arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed	arch_atomic64_fetch_sub_relaxed
+#define arch_atomic64_fetch_add		arch_atomic64_fetch_add
+#define arch_atomic64_fetch_sub		arch_atomic64_fetch_sub
 #endif
 
 #undef ATOMIC_OPS
@@ -175,20 +175,20 @@ ATOMIC_OPS(and, and, i)
 ATOMIC_OPS( or,  or, i)
 ATOMIC_OPS(xor, xor, i)
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
-#define atomic_fetch_and		atomic_fetch_and
-#define atomic_fetch_or			atomic_fetch_or
-#define atomic_fetch_xor		atomic_fetch_xor
+#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and		arch_atomic_fetch_and
+#define arch_atomic_fetch_or		arch_atomic_fetch_or
+#define arch_atomic_fetch_xor		arch_atomic_fetch_xor
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
-#define atomic64_fetch_and		atomic64_fetch_and
-#define atomic64_fetch_or		atomic64_fetch_or
-#define atomic64_fetch_xor		atomic64_fetch_xor
+#define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_or_relaxed	arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and		arch_atomic64_fetch_and
+#define arch_atomic64_fetch_or		arch_atomic64_fetch_or
+#define arch_atomic64_fetch_xor		arch_atomic64_fetch_xor
 #endif
 
 #undef ATOMIC_OPS
@@ -197,7 +197,7 @@ ATOMIC_OPS(xor, xor, i)
 #undef ATOMIC_OP_RETURN
 
 /* This is required to provide a full barrier on success. */
-static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static __always_inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
        int prev, rc;
 
@@ -214,10 +214,10 @@ static __always_inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 		: "memory");
 	return prev;
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static __always_inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
        s64 prev;
        long rc;
@@ -235,7 +235,7 @@ static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
 		: "memory");
 	return prev;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 #endif
 
 /*
@@ -244,45 +244,45 @@ static __always_inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u
  */
 #define ATOMIC_OP(c_t, prefix, size)					\
 static __always_inline							\
-c_t atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)		\
+c_t arch_atomic##prefix##_xchg_relaxed(atomic##prefix##_t *v, c_t n)	\
 {									\
 	return __xchg_relaxed(&(v->counter), n, size);			\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)		\
+c_t arch_atomic##prefix##_xchg_acquire(atomic##prefix##_t *v, c_t n)	\
 {									\
 	return __xchg_acquire(&(v->counter), n, size);			\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)		\
+c_t arch_atomic##prefix##_xchg_release(atomic##prefix##_t *v, c_t n)	\
 {									\
 	return __xchg_release(&(v->counter), n, size);			\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)			\
+c_t arch_atomic##prefix##_xchg(atomic##prefix##_t *v, c_t n)		\
 {									\
 	return __xchg(&(v->counter), n, size);				\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,		\
+c_t arch_atomic##prefix##_cmpxchg_relaxed(atomic##prefix##_t *v,	\
 				     c_t o, c_t n)			\
 {									\
 	return __cmpxchg_relaxed(&(v->counter), o, n, size);		\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,		\
+c_t arch_atomic##prefix##_cmpxchg_acquire(atomic##prefix##_t *v,	\
 				     c_t o, c_t n)			\
 {									\
 	return __cmpxchg_acquire(&(v->counter), o, n, size);		\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,		\
+c_t arch_atomic##prefix##_cmpxchg_release(atomic##prefix##_t *v,	\
 				     c_t o, c_t n)			\
 {									\
 	return __cmpxchg_release(&(v->counter), o, n, size);		\
 }									\
 static __always_inline							\
-c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
+c_t arch_atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
 {									\
 	return __cmpxchg(&(v->counter), o, n, size);			\
 }
@@ -298,19 +298,19 @@ c_t atomic##prefix##_cmpxchg(atomic##prefix##_t *v, c_t o, c_t n)	\
 
 ATOMIC_OPS()
 
-#define atomic_xchg_relaxed atomic_xchg_relaxed
-#define atomic_xchg_acquire atomic_xchg_acquire
-#define atomic_xchg_release atomic_xchg_release
-#define atomic_xchg atomic_xchg
-#define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
-#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
-#define atomic_cmpxchg_release atomic_cmpxchg_release
-#define atomic_cmpxchg atomic_cmpxchg
+#define arch_atomic_xchg_relaxed	arch_atomic_xchg_relaxed
+#define arch_atomic_xchg_acquire	arch_atomic_xchg_acquire
+#define arch_atomic_xchg_release	arch_atomic_xchg_release
+#define arch_atomic_xchg		arch_atomic_xchg
+#define arch_atomic_cmpxchg_relaxed	arch_atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_acquire	arch_atomic_cmpxchg_acquire
+#define arch_atomic_cmpxchg_release	arch_atomic_cmpxchg_release
+#define arch_atomic_cmpxchg		arch_atomic_cmpxchg
 
 #undef ATOMIC_OPS
 #undef ATOMIC_OP
 
-static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
+static __always_inline int arch_atomic_sub_if_positive(atomic_t *v, int offset)
 {
        int prev, rc;
 
@@ -328,10 +328,10 @@ static __always_inline int atomic_sub_if_positive(atomic_t *v, int offset)
 	return prev - offset;
 }
 
-#define atomic_dec_if_positive(v)	atomic_sub_if_positive(v, 1)
+#define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(v, 1)
 
 #ifndef CONFIG_GENERIC_ATOMIC64
-static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
+static __always_inline s64 arch_atomic64_sub_if_positive(atomic64_t *v, s64 offset)
 {
        s64 prev;
        long rc;
@@ -350,7 +350,7 @@ static __always_inline s64 atomic64_sub_if_positive(atomic64_t *v, s64 offset)
 	return prev - offset;
 }
 
-#define atomic64_dec_if_positive(v)	atomic64_sub_if_positive(v, 1)
+#define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(v, 1)
 #endif
 
 #endif /* _ASM_RISCV_ATOMIC_H */
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 262e5bbb2776..36dc962f6343 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -37,7 +37,7 @@
 	__ret;								\
 })
 
-#define xchg_relaxed(ptr, x)						\
+#define arch_xchg_relaxed(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	(__typeof__(*(ptr))) __xchg_relaxed((ptr),			\
@@ -72,7 +72,7 @@
 	__ret;								\
 })
 
-#define xchg_acquire(ptr, x)						\
+#define arch_xchg_acquire(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	(__typeof__(*(ptr))) __xchg_acquire((ptr),			\
@@ -107,7 +107,7 @@
 	__ret;								\
 })
 
-#define xchg_release(ptr, x)						\
+#define arch_xchg_release(ptr, x)					\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	(__typeof__(*(ptr))) __xchg_release((ptr),			\
@@ -140,7 +140,7 @@
 	__ret;								\
 })
 
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) _x_ = (x);					\
 	(__typeof__(*(ptr))) __xchg((ptr), _x_, sizeof(*(ptr)));	\
@@ -149,13 +149,13 @@
 #define xchg32(ptr, x)							\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	xchg((ptr), (x));						\
+	arch_xchg((ptr), (x));						\
 })
 
 #define xchg64(ptr, x)							\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	xchg((ptr), (x));						\
+	arch_xchg((ptr), (x));						\
 })
 
 /*
@@ -199,7 +199,7 @@
 	__ret;								\
 })
 
-#define cmpxchg_relaxed(ptr, o, n)					\
+#define arch_cmpxchg_relaxed(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -245,7 +245,7 @@
 	__ret;								\
 })
 
-#define cmpxchg_acquire(ptr, o, n)					\
+#define arch_cmpxchg_acquire(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -291,7 +291,7 @@
 	__ret;								\
 })
 
-#define cmpxchg_release(ptr, o, n)					\
+#define arch_cmpxchg_release(ptr, o, n)					\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -337,7 +337,7 @@
 	__ret;								\
 })
 
-#define cmpxchg(ptr, o, n)						\
+#define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -345,31 +345,31 @@
 				       _o_, _n_, sizeof(*(ptr)));	\
 })
 
-#define cmpxchg_local(ptr, o, n)					\
+#define arch_cmpxchg_local(ptr, o, n)					\
 	(__cmpxchg_relaxed((ptr), (o), (n), sizeof(*(ptr))))
 
 #define cmpxchg32(ptr, o, n)						\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
 })
 
 #define cmpxchg32_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 4);				\
-	cmpxchg_relaxed((ptr), (o), (n))				\
+	arch_cmpxchg_relaxed((ptr), (o), (n))				\
 })
 
-#define cmpxchg64(ptr, o, n)						\
+#define arch_cmpxchg64(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
 })
 
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_relaxed((ptr), (o), (n));				\
+	arch_cmpxchg_relaxed((ptr), (o), (n));				\
 })
 
 #endif /* _ASM_RISCV_CMPXCHG_H */
-- 
2.11.0

