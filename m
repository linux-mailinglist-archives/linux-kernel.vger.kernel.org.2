Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C0A377FB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhEJJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:45:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52290 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhEJJpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:45:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BEE41655;
        Mon, 10 May 2021 02:44:21 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6ACD3F73B;
        Mon, 10 May 2021 02:44:16 -0700 (PDT)
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
Subject: [PATCH 30/33] locking/atomic: sparc: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:50 +0100
Message-Id: <20210510093753.40683-31-mark.rutland@arm.com>
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

As a step towards that, this patch migrates sparc to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/sparc/Kconfig                  |  1 +
 arch/sparc/include/asm/atomic_32.h  | 38 ++++++++++++++++-----------------
 arch/sparc/include/asm/atomic_64.h  | 36 +++++++++++++++----------------
 arch/sparc/include/asm/cmpxchg_32.h | 10 ++++-----
 arch/sparc/include/asm/cmpxchg_64.h | 10 ++++-----
 arch/sparc/lib/atomic32.c           | 24 ++++++++++-----------
 arch/sparc/lib/atomic_64.S          | 42 ++++++++++++++++++-------------------
 7 files changed, 81 insertions(+), 80 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 164a5254c91c..46790083e918 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_ATOMIC
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
 	select ARCH_MIGHT_HAVE_PC_SERIO
 	select DMA_OPS
diff --git a/arch/sparc/include/asm/atomic_32.h b/arch/sparc/include/asm/atomic_32.h
index efad5532f169..38537109ec5d 100644
--- a/arch/sparc/include/asm/atomic_32.h
+++ b/arch/sparc/include/asm/atomic_32.h
@@ -18,30 +18,30 @@
 #include <asm/barrier.h>
 #include <asm-generic/atomic64.h>
 
-int atomic_add_return(int, atomic_t *);
-int atomic_fetch_add(int, atomic_t *);
-int atomic_fetch_and(int, atomic_t *);
-int atomic_fetch_or(int, atomic_t *);
-int atomic_fetch_xor(int, atomic_t *);
-int atomic_cmpxchg(atomic_t *, int, int);
-int atomic_xchg(atomic_t *, int);
-int atomic_fetch_add_unless(atomic_t *, int, int);
-void atomic_set(atomic_t *, int);
+int arch_atomic_add_return(int, atomic_t *);
+int arch_atomic_fetch_add(int, atomic_t *);
+int arch_atomic_fetch_and(int, atomic_t *);
+int arch_atomic_fetch_or(int, atomic_t *);
+int arch_atomic_fetch_xor(int, atomic_t *);
+int arch_atomic_cmpxchg(atomic_t *, int, int);
+int arch_atomic_xchg(atomic_t *, int);
+int arch_atomic_fetch_add_unless(atomic_t *, int, int);
+void arch_atomic_set(atomic_t *, int);
 
-#define atomic_fetch_add_unless	atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless	arch_atomic_fetch_add_unless
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
-#define atomic_read(v)          READ_ONCE((v)->counter)
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
-#define atomic_add(i, v)	((void)atomic_add_return( (int)(i), (v)))
-#define atomic_sub(i, v)	((void)atomic_add_return(-(int)(i), (v)))
+#define arch_atomic_add(i, v)	((void)arch_atomic_add_return( (int)(i), (v)))
+#define arch_atomic_sub(i, v)	((void)arch_atomic_add_return(-(int)(i), (v)))
 
-#define atomic_and(i, v)	((void)atomic_fetch_and((i), (v)))
-#define atomic_or(i, v)		((void)atomic_fetch_or((i), (v)))
-#define atomic_xor(i, v)	((void)atomic_fetch_xor((i), (v)))
+#define arch_atomic_and(i, v)	((void)arch_atomic_fetch_and((i), (v)))
+#define arch_atomic_or(i, v)	((void)arch_atomic_fetch_or((i), (v)))
+#define arch_atomic_xor(i, v)	((void)arch_atomic_fetch_xor((i), (v)))
 
-#define atomic_sub_return(i, v)	(atomic_add_return(-(int)(i), (v)))
-#define atomic_fetch_sub(i, v)  (atomic_fetch_add (-(int)(i), (v)))
+#define arch_atomic_sub_return(i, v)	(arch_atomic_add_return(-(int)(i), (v)))
+#define arch_atomic_fetch_sub(i, v)	(arch_atomic_fetch_add (-(int)(i), (v)))
 
 #endif /* !(__ARCH_SPARC_ATOMIC__) */
diff --git a/arch/sparc/include/asm/atomic_64.h b/arch/sparc/include/asm/atomic_64.h
index 6b235d3d1d9d..077891686715 100644
--- a/arch/sparc/include/asm/atomic_64.h
+++ b/arch/sparc/include/asm/atomic_64.h
@@ -14,23 +14,23 @@
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic64_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic64_read(v)	READ_ONCE((v)->counter)
 
-#define atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
-#define atomic64_set(v, i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_set(v, i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic64_set(v, i)	WRITE_ONCE(((v)->counter), (i))
 
 #define ATOMIC_OP(op)							\
-void atomic_##op(int, atomic_t *);					\
-void atomic64_##op(s64, atomic64_t *);
+void arch_atomic_##op(int, atomic_t *);					\
+void arch_atomic64_##op(s64, atomic64_t *);
 
 #define ATOMIC_OP_RETURN(op)						\
-int atomic_##op##_return(int, atomic_t *);				\
-s64 atomic64_##op##_return(s64, atomic64_t *);
+int arch_atomic_##op##_return(int, atomic_t *);				\
+s64 arch_atomic64_##op##_return(s64, atomic64_t *);
 
 #define ATOMIC_FETCH_OP(op)						\
-int atomic_fetch_##op(int, atomic_t *);					\
-s64 atomic64_fetch_##op(s64, atomic64_t *);
+int arch_atomic_fetch_##op(int, atomic_t *);				\
+s64 arch_atomic64_fetch_##op(s64, atomic64_t *);
 
 #define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
 
@@ -49,18 +49,18 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_cmpxchg(v, o, n) (cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_cmpxchg(v, o, n) (arch_cmpxchg(&((v)->counter), (o), (n)))
 
-static inline int atomic_xchg(atomic_t *v, int new)
+static inline int arch_atomic_xchg(atomic_t *v, int new)
 {
-	return xchg(&v->counter, new);
+	return arch_xchg(&v->counter, new);
 }
 
-#define atomic64_cmpxchg(v, o, n) \
-	((__typeof__((v)->counter))cmpxchg(&((v)->counter), (o), (n)))
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic64_cmpxchg(v, o, n) \
+	((__typeof__((v)->counter))arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
-s64 atomic64_dec_if_positive(atomic64_t *v);
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+s64 arch_atomic64_dec_if_positive(atomic64_t *v);
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
 #endif /* !(__ARCH_SPARC64_ATOMIC__) */
diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 86e3da1d973d..27a57a3a7597 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -25,7 +25,7 @@ static inline unsigned long __xchg(unsigned long x, __volatile__ void * ptr, int
 	return x;
 }
 
-#define xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
+#define arch_xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
 
 /* Emulate cmpxchg() the same way we emulate atomics,
  * by hashing the object address and indexing into an array
@@ -55,7 +55,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 	return old;
 }
 
-#define cmpxchg(ptr, o, n)						\
+#define arch_cmpxchg(ptr, o, n)						\
 ({									\
 	__typeof__(*(ptr)) _o_ = (o);					\
 	__typeof__(*(ptr)) _n_ = (n);					\
@@ -64,7 +64,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 })
 
 u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
-#define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
+#define arch_cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 
 #include <asm-generic/cmpxchg-local.h>
 
@@ -72,9 +72,9 @@ u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n)				  	       \
+#define arch_cmpxchg_local(ptr, o, n)				  	       \
 	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC_CMPXCHG__ */
diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index 8915b577b92f..8c39a9981187 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -52,7 +52,7 @@ static inline unsigned long xchg64(__volatile__ unsigned long *m, unsigned long
 	return val;
 }
 
-#define xchg(ptr,x)							\
+#define arch_xchg(ptr,x)							\
 ({	__typeof__(*(ptr)) __ret;					\
 	__ret = (__typeof__(*(ptr)))					\
 		__xchg((unsigned long)(x), (ptr), sizeof(*(ptr)));	\
@@ -168,7 +168,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 	return old;
 }
 
-#define cmpxchg(ptr,o,n)						 \
+#define arch_cmpxchg(ptr,o,n)						 \
   ({									 \
      __typeof__(*(ptr)) _o_ = (o);					 \
      __typeof__(*(ptr)) _n_ = (n);					 \
@@ -195,14 +195,14 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	return old;
 }
 
-#define cmpxchg_local(ptr, o, n)				  	\
+#define arch_cmpxchg_local(ptr, o, n)				  	\
 	((__typeof__(*(ptr)))__cmpxchg_local((ptr), (unsigned long)(o),	\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n)					\
+#define arch_cmpxchg64_local(ptr, o, n)					\
   ({									\
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
   })
-#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n)	arch_cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC64_CMPXCHG__ */
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 281fa634bb1a..8b81d0f00c97 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -29,7 +29,7 @@ static DEFINE_SPINLOCK(dummy);
 #endif /* SMP */
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-int atomic_fetch_##op(int i, atomic_t *v)				\
+int arch_atomic_fetch_##op(int i, atomic_t *v)				\
 {									\
 	int ret;							\
 	unsigned long flags;						\
@@ -41,10 +41,10 @@ int atomic_fetch_##op(int i, atomic_t *v)				\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
 }									\
-EXPORT_SYMBOL(atomic_fetch_##op);
+EXPORT_SYMBOL(arch_atomic_fetch_##op);
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-int atomic_##op##_return(int i, atomic_t *v)				\
+int arch_atomic_##op##_return(int i, atomic_t *v)			\
 {									\
 	int ret;							\
 	unsigned long flags;						\
@@ -55,7 +55,7 @@ int atomic_##op##_return(int i, atomic_t *v)				\
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);			\
 	return ret;							\
 }									\
-EXPORT_SYMBOL(atomic_##op##_return);
+EXPORT_SYMBOL(arch_atomic_##op##_return);
 
 ATOMIC_OP_RETURN(add, +=)
 
@@ -67,7 +67,7 @@ ATOMIC_FETCH_OP(xor, ^=)
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 
-int atomic_xchg(atomic_t *v, int new)
+int arch_atomic_xchg(atomic_t *v, int new)
 {
 	int ret;
 	unsigned long flags;
@@ -78,9 +78,9 @@ int atomic_xchg(atomic_t *v, int new)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
-EXPORT_SYMBOL(atomic_xchg);
+EXPORT_SYMBOL(arch_atomic_xchg);
 
-int atomic_cmpxchg(atomic_t *v, int old, int new)
+int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
 	unsigned long flags;
@@ -93,9 +93,9 @@ int atomic_cmpxchg(atomic_t *v, int old, int new)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
-EXPORT_SYMBOL(atomic_cmpxchg);
+EXPORT_SYMBOL(arch_atomic_cmpxchg);
 
-int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int ret;
 	unsigned long flags;
@@ -107,10 +107,10 @@ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 	return ret;
 }
-EXPORT_SYMBOL(atomic_fetch_add_unless);
+EXPORT_SYMBOL(arch_atomic_fetch_add_unless);
 
 /* Atomic operations are already serializing */
-void atomic_set(atomic_t *v, int i)
+void arch_atomic_set(atomic_t *v, int i)
 {
 	unsigned long flags;
 
@@ -118,7 +118,7 @@ void atomic_set(atomic_t *v, int i)
 	v->counter = i;
 	spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
 }
-EXPORT_SYMBOL(atomic_set);
+EXPORT_SYMBOL(arch_atomic_set);
 
 unsigned long ___set_bit(unsigned long *addr, unsigned long mask)
 {
diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 456b65a30ecf..8245d4a97301 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -19,7 +19,7 @@
 	 */
 
 #define ATOMIC_OP(op)							\
-ENTRY(atomic_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
+ENTRY(arch_atomic_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
 	BACKOFF_SETUP(%o2);						\
 1:	lduw	[%o1], %g1;						\
 	op	%g1, %o0, %g7;						\
@@ -30,11 +30,11 @@ ENTRY(atomic_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
 	retl;								\
 	 nop;								\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic_##op);							\
-EXPORT_SYMBOL(atomic_##op);
+ENDPROC(arch_atomic_##op);						\
+EXPORT_SYMBOL(arch_atomic_##op);
 
 #define ATOMIC_OP_RETURN(op)						\
-ENTRY(atomic_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
+ENTRY(arch_atomic_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */\
 	BACKOFF_SETUP(%o2);						\
 1:	lduw	[%o1], %g1;						\
 	op	%g1, %o0, %g7;						\
@@ -45,11 +45,11 @@ ENTRY(atomic_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
 	retl;								\
 	 sra	%g1, 0, %o0;						\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic_##op##_return);						\
-EXPORT_SYMBOL(atomic_##op##_return);
+ENDPROC(arch_atomic_##op##_return);					\
+EXPORT_SYMBOL(arch_atomic_##op##_return);
 
 #define ATOMIC_FETCH_OP(op)						\
-ENTRY(atomic_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
+ENTRY(arch_atomic_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 	BACKOFF_SETUP(%o2);						\
 1:	lduw	[%o1], %g1;						\
 	op	%g1, %o0, %g7;						\
@@ -60,8 +60,8 @@ ENTRY(atomic_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 	retl;								\
 	 sra	%g1, 0, %o0;						\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic_fetch_##op);						\
-EXPORT_SYMBOL(atomic_fetch_##op);
+ENDPROC(arch_atomic_fetch_##op);					\
+EXPORT_SYMBOL(arch_atomic_fetch_##op);
 
 ATOMIC_OP(add)
 ATOMIC_OP_RETURN(add)
@@ -85,7 +85,7 @@ ATOMIC_FETCH_OP(xor)
 #undef ATOMIC_OP
 
 #define ATOMIC64_OP(op)							\
-ENTRY(atomic64_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
+ENTRY(arch_atomic64_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 	BACKOFF_SETUP(%o2);						\
 1:	ldx	[%o1], %g1;						\
 	op	%g1, %o0, %g7;						\
@@ -96,11 +96,11 @@ ENTRY(atomic64_##op) /* %o0 = increment, %o1 = atomic_ptr */		\
 	retl;								\
 	 nop;								\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic64_##op);							\
-EXPORT_SYMBOL(atomic64_##op);
+ENDPROC(arch_atomic64_##op);						\
+EXPORT_SYMBOL(arch_atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op)						\
-ENTRY(atomic64_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
+ENTRY(arch_atomic64_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
 	BACKOFF_SETUP(%o2);						\
 1:	ldx	[%o1], %g1;						\
 	op	%g1, %o0, %g7;						\
@@ -111,11 +111,11 @@ ENTRY(atomic64_##op##_return) /* %o0 = increment, %o1 = atomic_ptr */	\
 	retl;								\
 	 op	%g1, %o0, %o0;						\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic64_##op##_return);					\
-EXPORT_SYMBOL(atomic64_##op##_return);
+ENDPROC(arch_atomic64_##op##_return);					\
+EXPORT_SYMBOL(arch_atomic64_##op##_return);
 
 #define ATOMIC64_FETCH_OP(op)						\
-ENTRY(atomic64_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
+ENTRY(arch_atomic64_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 	BACKOFF_SETUP(%o2);						\
 1:	ldx	[%o1], %g1;						\
 	op	%g1, %o0, %g7;						\
@@ -126,8 +126,8 @@ ENTRY(atomic64_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 	retl;								\
 	 mov	%g1, %o0;						\
 2:	BACKOFF_SPIN(%o2, %o3, 1b);					\
-ENDPROC(atomic64_fetch_##op);						\
-EXPORT_SYMBOL(atomic64_fetch_##op);
+ENDPROC(arch_atomic64_fetch_##op);					\
+EXPORT_SYMBOL(arch_atomic64_fetch_##op);
 
 ATOMIC64_OP(add)
 ATOMIC64_OP_RETURN(add)
@@ -150,7 +150,7 @@ ATOMIC64_FETCH_OP(xor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-ENTRY(atomic64_dec_if_positive) /* %o0 = atomic_ptr */
+ENTRY(arch_atomic64_dec_if_positive) /* %o0 = atomic_ptr */
 	BACKOFF_SETUP(%o2)
 1:	ldx	[%o0], %g1
 	brlez,pn %g1, 3f
@@ -162,5 +162,5 @@ ENTRY(atomic64_dec_if_positive) /* %o0 = atomic_ptr */
 3:	retl
 	 sub	%g1, 1, %o0
 2:	BACKOFF_SPIN(%o2, %o3, 1b)
-ENDPROC(atomic64_dec_if_positive)
-EXPORT_SYMBOL(atomic64_dec_if_positive)
+ENDPROC(arch_atomic64_dec_if_positive)
+EXPORT_SYMBOL(arch_atomic64_dec_if_positive)
-- 
2.11.0

