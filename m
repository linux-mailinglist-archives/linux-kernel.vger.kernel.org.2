Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A7377FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhEJJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:43:46 -0400
Received: from foss.arm.com ([217.140.110.172]:51772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhEJJnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:43:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5351597;
        Mon, 10 May 2021 02:42:40 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 51B143F73B;
        Mon, 10 May 2021 02:42:36 -0700 (PDT)
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
Subject: [PATCH 22/33] locking/atomic: mips: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:42 +0100
Message-Id: <20210510093753.40683-23-mark.rutland@arm.com>
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

As a step towards that, this patch migrates mips to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Will Deacon <will@kernel.org>
---
 arch/mips/Kconfig               |  1 +
 arch/mips/include/asm/atomic.h  | 55 ++++++++++++++++++++++-------------------
 arch/mips/include/asm/cmpxchg.h | 22 ++++++++---------
 arch/mips/kernel/cmpxchg.c      |  4 +--
 4 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index ed51970c08e7..55b4da96872f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3,6 +3,7 @@ config MIPS
 	bool
 	default y
 	select ARCH_32BIT_OFF_T if !64BIT
+	select ARCH_ATOMIC
 	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
 	select ARCH_HAS_DEBUG_VIRTUAL if !64BIT
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/mips/include/asm/atomic.h b/arch/mips/include/asm/atomic.h
index 27ad76791539..95e1f7f3597f 100644
--- a/arch/mips/include/asm/atomic.h
+++ b/arch/mips/include/asm/atomic.h
@@ -25,24 +25,25 @@
 #include <asm/war.h>
 
 #define ATOMIC_OPS(pfx, type)						\
-static __always_inline type pfx##_read(const pfx##_t *v)		\
+static __always_inline type arch_##pfx##_read(const pfx##_t *v)		\
 {									\
 	return READ_ONCE(v->counter);					\
 }									\
 									\
-static __always_inline void pfx##_set(pfx##_t *v, type i)		\
+static __always_inline void arch_##pfx##_set(pfx##_t *v, type i)	\
 {									\
 	WRITE_ONCE(v->counter, i);					\
 }									\
 									\
-static __always_inline type pfx##_cmpxchg(pfx##_t *v, type o, type n)	\
+static __always_inline type						\
+arch_##pfx##_cmpxchg(pfx##_t *v, type o, type n)			\
 {									\
-	return cmpxchg(&v->counter, o, n);				\
+	return arch_cmpxchg(&v->counter, o, n);				\
 }									\
 									\
-static __always_inline type pfx##_xchg(pfx##_t *v, type n)		\
+static __always_inline type arch_##pfx##_xchg(pfx##_t *v, type n)	\
 {									\
-	return xchg(&v->counter, n);					\
+	return arch_xchg(&v->counter, n);				\
 }
 
 ATOMIC_OPS(atomic, int)
@@ -53,7 +54,7 @@ ATOMIC_OPS(atomic64, s64)
 #endif
 
 #define ATOMIC_OP(pfx, op, type, c_op, asm_op, ll, sc)			\
-static __inline__ void pfx##_##op(type i, pfx##_t * v)			\
+static __inline__ void arch_##pfx##_##op(type i, pfx##_t * v)		\
 {									\
 	type temp;							\
 									\
@@ -80,7 +81,8 @@ static __inline__ void pfx##_##op(type i, pfx##_t * v)			\
 }
 
 #define ATOMIC_OP_RETURN(pfx, op, type, c_op, asm_op, ll, sc)		\
-static __inline__ type pfx##_##op##_return_relaxed(type i, pfx##_t * v)	\
+static __inline__ type							\
+arch_##pfx##_##op##_return_relaxed(type i, pfx##_t * v)			\
 {									\
 	type temp, result;						\
 									\
@@ -113,7 +115,8 @@ static __inline__ type pfx##_##op##_return_relaxed(type i, pfx##_t * v)	\
 }
 
 #define ATOMIC_FETCH_OP(pfx, op, type, c_op, asm_op, ll, sc)		\
-static __inline__ type pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)	\
+static __inline__ type							\
+arch_##pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)			\
 {									\
 	int temp, result;						\
 									\
@@ -153,18 +156,18 @@ static __inline__ type pfx##_fetch_##op##_relaxed(type i, pfx##_t * v)	\
 ATOMIC_OPS(atomic, add, int, +=, addu, ll, sc)
 ATOMIC_OPS(atomic, sub, int, -=, subu, ll, sc)
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define arch_atomic_add_return_relaxed	arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed	arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed	arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed	arch_atomic_fetch_sub_relaxed
 
 #ifdef CONFIG_64BIT
 ATOMIC_OPS(atomic64, add, s64, +=, daddu, lld, scd)
 ATOMIC_OPS(atomic64, sub, s64, -=, dsubu, lld, scd)
-# define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-# define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-# define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-# define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+# define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+# define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+# define arch_atomic64_fetch_add_relaxed	arch_atomic64_fetch_add_relaxed
+# define arch_atomic64_fetch_sub_relaxed	arch_atomic64_fetch_sub_relaxed
 #endif /* CONFIG_64BIT */
 
 #undef ATOMIC_OPS
@@ -176,17 +179,17 @@ ATOMIC_OPS(atomic, and, int, &=, and, ll, sc)
 ATOMIC_OPS(atomic, or, int, |=, or, ll, sc)
 ATOMIC_OPS(atomic, xor, int, ^=, xor, ll, sc)
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed	arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_or_relaxed	arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed	arch_atomic_fetch_xor_relaxed
 
 #ifdef CONFIG_64BIT
 ATOMIC_OPS(atomic64, and, s64, &=, and, lld, scd)
 ATOMIC_OPS(atomic64, or, s64, |=, or, lld, scd)
 ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
-# define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-# define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-# define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+# define arch_atomic64_fetch_and_relaxed	arch_atomic64_fetch_and_relaxed
+# define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+# define arch_atomic64_fetch_xor_relaxed	arch_atomic64_fetch_xor_relaxed
 #endif
 
 #undef ATOMIC_OPS
@@ -203,7 +206,7 @@ ATOMIC_OPS(atomic64, xor, s64, ^=, xor, lld, scd)
  * The function returns the old value of @v minus @i.
  */
 #define ATOMIC_SIP_OP(pfx, type, op, ll, sc)				\
-static __inline__ int pfx##_sub_if_positive(type i, pfx##_t * v)	\
+static __inline__ int arch_##pfx##_sub_if_positive(type i, pfx##_t * v)	\
 {									\
 	type temp, result;						\
 									\
@@ -255,11 +258,11 @@ static __inline__ int pfx##_sub_if_positive(type i, pfx##_t * v)	\
 }
 
 ATOMIC_SIP_OP(atomic, int, subu, ll, sc)
-#define atomic_dec_if_positive(v)	atomic_sub_if_positive(1, v)
+#define arch_atomic_dec_if_positive(v)	arch_atomic_sub_if_positive(1, v)
 
 #ifdef CONFIG_64BIT
 ATOMIC_SIP_OP(atomic64, s64, dsubu, lld, scd)
-#define atomic64_dec_if_positive(v)	atomic64_sub_if_positive(1, v)
+#define arch_atomic64_dec_if_positive(v)	arch_atomic64_sub_if_positive(1, v)
 #endif
 
 #undef ATOMIC_SIP_OP
diff --git a/arch/mips/include/asm/cmpxchg.h b/arch/mips/include/asm/cmpxchg.h
index c7e0455d4d46..0b983800f48b 100644
--- a/arch/mips/include/asm/cmpxchg.h
+++ b/arch/mips/include/asm/cmpxchg.h
@@ -90,7 +90,7 @@ unsigned long __xchg(volatile void *ptr, unsigned long x, int size)
 	}
 }
 
-#define xchg(ptr, x)							\
+#define arch_xchg(ptr, x)						\
 ({									\
 	__typeof__(*(ptr)) __res;					\
 									\
@@ -175,14 +175,14 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	}
 }
 
-#define cmpxchg_local(ptr, old, new)					\
+#define arch_cmpxchg_local(ptr, old, new)				\
 	((__typeof__(*(ptr)))						\
 		__cmpxchg((ptr),					\
 			  (unsigned long)(__typeof__(*(ptr)))(old),	\
 			  (unsigned long)(__typeof__(*(ptr)))(new),	\
 			  sizeof(*(ptr))))
 
-#define cmpxchg(ptr, old, new)						\
+#define arch_cmpxchg(ptr, old, new)					\
 ({									\
 	__typeof__(*(ptr)) __res;					\
 									\
@@ -194,7 +194,7 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	if (__SYNC_loongson3_war == 0)					\
 		smp_mb__before_llsc();					\
 									\
-	__res = cmpxchg_local((ptr), (old), (new));			\
+	__res = arch_cmpxchg_local((ptr), (old), (new));		\
 									\
 	/*								\
 	 * In the Loongson3 workaround case __cmpxchg_asm() already	\
@@ -208,21 +208,21 @@ unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 })
 
 #ifdef CONFIG_64BIT
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg_local((ptr), (o), (n));					\
+	arch_cmpxchg_local((ptr), (o), (n));				\
   })
 
-#define cmpxchg64(ptr, o, n)						\
+#define arch_cmpxchg64(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
-	cmpxchg((ptr), (o), (n));					\
+	arch_cmpxchg((ptr), (o), (n));					\
   })
 #else
 
 # include <asm-generic/cmpxchg-local.h>
-# define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+# define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 # ifdef CONFIG_SMP
 
@@ -294,7 +294,7 @@ static inline unsigned long __cmpxchg64(volatile void *ptr,
 	return ret;
 }
 
-#  define cmpxchg64(ptr, o, n) ({					\
+#  define arch_cmpxchg64(ptr, o, n) ({					\
 	unsigned long long __old = (__typeof__(*(ptr)))(o);		\
 	unsigned long long __new = (__typeof__(*(ptr)))(n);		\
 	__typeof__(*(ptr)) __res;					\
@@ -317,7 +317,7 @@ static inline unsigned long __cmpxchg64(volatile void *ptr,
 })
 
 # else /* !CONFIG_SMP */
-#  define cmpxchg64(ptr, o, n) cmpxchg64_local((ptr), (o), (n))
+#  define arch_cmpxchg64(ptr, o, n) arch_cmpxchg64_local((ptr), (o), (n))
 # endif /* !CONFIG_SMP */
 #endif /* !CONFIG_64BIT */
 
diff --git a/arch/mips/kernel/cmpxchg.c b/arch/mips/kernel/cmpxchg.c
index 89107deb03fc..ac9c8cfb2ba9 100644
--- a/arch/mips/kernel/cmpxchg.c
+++ b/arch/mips/kernel/cmpxchg.c
@@ -41,7 +41,7 @@ unsigned long __xchg_small(volatile void *ptr, unsigned long val, unsigned int s
 	do {
 		old32 = load32;
 		new32 = (load32 & ~mask) | (val << shift);
-		load32 = cmpxchg(ptr32, old32, new32);
+		load32 = arch_cmpxchg(ptr32, old32, new32);
 	} while (load32 != old32);
 
 	return (load32 & mask) >> shift;
@@ -97,7 +97,7 @@ unsigned long __cmpxchg_small(volatile void *ptr, unsigned long old,
 		 */
 		old32 = (load32 & ~mask) | (old << shift);
 		new32 = (load32 & ~mask) | (new << shift);
-		load32 = cmpxchg(ptr32, old32, new32);
+		load32 = arch_cmpxchg(ptr32, old32, new32);
 		if (load32 == old32)
 			return old;
 	}
-- 
2.11.0

