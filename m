Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AE6377FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhEJJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:44:25 -0400
Received: from foss.arm.com ([217.140.110.172]:52036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230363AbhEJJoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:44:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E50A215DB;
        Mon, 10 May 2021 02:43:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B3F9C3F73B;
        Mon, 10 May 2021 02:43:14 -0700 (PDT)
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
Subject: [PATCH 26/33] locking/atomic: parisc: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:46 +0100
Message-Id: <20210510093753.40683-27-mark.rutland@arm.com>
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

As a step towards that, this patch migrates parisc to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/parisc/Kconfig               |  1 +
 arch/parisc/include/asm/atomic.h  | 34 +++++++++++++++++-----------------
 arch/parisc/include/asm/cmpxchg.h | 12 ++++++------
 3 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index bde9907bc5b2..bfa120a4add1 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -2,6 +2,7 @@
 config PARISC
 	def_bool y
 	select ARCH_32BIT_OFF_T if !64BIT
+	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/parisc/include/asm/atomic.h b/arch/parisc/include/asm/atomic.h
index 21b375c67e53..dd5a299ada69 100644
--- a/arch/parisc/include/asm/atomic.h
+++ b/arch/parisc/include/asm/atomic.h
@@ -56,7 +56,7 @@ extern arch_spinlock_t __atomic_hash[ATOMIC_HASH_SIZE] __lock_aligned;
  * are atomic, so a reader never sees inconsistent values.
  */
 
-static __inline__ void atomic_set(atomic_t *v, int i)
+static __inline__ void arch_atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
 	_atomic_spin_lock_irqsave(v, flags);
@@ -66,19 +66,19 @@ static __inline__ void atomic_set(atomic_t *v, int i)
 	_atomic_spin_unlock_irqrestore(v, flags);
 }
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
-static __inline__ int atomic_read(const atomic_t *v)
+static __inline__ int arch_atomic_read(const atomic_t *v)
 {
 	return READ_ONCE((v)->counter);
 }
 
 /* exported interface */
-#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n)	(arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), new))
 
 #define ATOMIC_OP(op, c_op)						\
-static __inline__ void atomic_##op(int i, atomic_t *v)			\
+static __inline__ void arch_atomic_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -88,7 +88,7 @@ static __inline__ void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static __inline__ int atomic_##op##_return(int i, atomic_t *v)		\
+static __inline__ int arch_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -101,7 +101,7 @@ static __inline__ int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static __inline__ int atomic_fetch_##op(int i, atomic_t *v)		\
+static __inline__ int arch_atomic_fetch_##op(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -141,7 +141,7 @@ ATOMIC_OPS(xor, ^=)
 #define ATOMIC64_INIT(i) { (i) }
 
 #define ATOMIC64_OP(op, c_op)						\
-static __inline__ void atomic64_##op(s64 i, atomic64_t *v)		\
+static __inline__ void arch_atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -151,7 +151,7 @@ static __inline__ void atomic64_##op(s64 i, atomic64_t *v)		\
 }
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
+static __inline__ s64 arch_atomic64_##op##_return(s64 i, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	s64 ret;							\
@@ -164,7 +164,7 @@ static __inline__ s64 atomic64_##op##_return(s64 i, atomic64_t *v)	\
 }
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-static __inline__ s64 atomic64_fetch_##op(s64 i, atomic64_t *v)		\
+static __inline__ s64 arch_atomic64_fetch_##op(s64 i, atomic64_t *v)	\
 {									\
 	unsigned long flags;						\
 	s64 ret;							\
@@ -200,7 +200,7 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP
 
 static __inline__ void
-atomic64_set(atomic64_t *v, s64 i)
+arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
 	_atomic_spin_lock_irqsave(v, flags);
@@ -210,18 +210,18 @@ atomic64_set(atomic64_t *v, s64 i)
 	_atomic_spin_unlock_irqrestore(v, flags);
 }
 
-#define atomic64_set_release(v, i)	atomic64_set((v), (i))
+#define arch_atomic64_set_release(v, i)	arch_atomic64_set((v), (i))
 
 static __inline__ s64
-atomic64_read(const atomic64_t *v)
+arch_atomic64_read(const atomic64_t *v)
 {
 	return READ_ONCE((v)->counter);
 }
 
 /* exported interface */
-#define atomic64_cmpxchg(v, o, n) \
-	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic64_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #endif /* !CONFIG_64BIT */
 
diff --git a/arch/parisc/include/asm/cmpxchg.h b/arch/parisc/include/asm/cmpxchg.h
index c2015654b684..5f274be10567 100644
--- a/arch/parisc/include/asm/cmpxchg.h
+++ b/arch/parisc/include/asm/cmpxchg.h
@@ -44,7 +44,7 @@ __xchg(unsigned long x, volatile void *ptr, int size)
 **		if (((unsigned long)p & 0xf) == 0)
 **			return __ldcw(p);
 */
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) __ret;					\
 	__typeof__(*(ptr)) _x_ = (x);					\
@@ -78,7 +78,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 	return old;
 }
 
-#define cmpxchg(ptr, o, n)						 \
+#define arch_cmpxchg(ptr, o, n)						 \
 ({									 \
 	__typeof__(*(ptr)) _o_ = (o);					 \
 	__typeof__(*(ptr)) _n_ = (n);					 \
@@ -106,19 +106,19 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n)					\
+#define arch_cmpxchg_local(ptr, o, n)					\
 	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),	\
 			(unsigned long)(n), sizeof(*(ptr))))
 #ifdef CONFIG_64BIT
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
 ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
 })
 #else
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 #endif
 
-#define cmpxchg64(ptr, o, n) __cmpxchg_u64(ptr, o, n)
+#define arch_cmpxchg64(ptr, o, n) __cmpxchg_u64(ptr, o, n)
 
 #endif /* _ASM_PARISC_CMPXCHG_H_ */
-- 
2.11.0

