Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ED5377FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEJJpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:45:39 -0400
Received: from foss.arm.com ([217.140.110.172]:52362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230292AbhEJJpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:45:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B28B1165C;
        Mon, 10 May 2021 02:44:31 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 87FA83F73B;
        Mon, 10 May 2021 02:44:27 -0700 (PDT)
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
Subject: [PATCH 31/33] locking/atomic: xtensa: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:51 +0100
Message-Id: <20210510093753.40683-32-mark.rutland@arm.com>
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

As a step towards that, this patch migrates xtensa to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/xtensa/Kconfig               |  1 +
 arch/xtensa/include/asm/atomic.h  | 26 +++++++++++++-------------
 arch/xtensa/include/asm/cmpxchg.h | 10 +++++-----
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 2332b2156993..39bb9bdae6b1 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -2,6 +2,7 @@
 config XTENSA
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT if !MMU
 	select ARCH_HAS_DMA_PREP_COHERENT if MMU
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if MMU
diff --git a/arch/xtensa/include/asm/atomic.h b/arch/xtensa/include/asm/atomic.h
index 744c2f463845..4361fe4247e3 100644
--- a/arch/xtensa/include/asm/atomic.h
+++ b/arch/xtensa/include/asm/atomic.h
@@ -43,7 +43,7 @@
  *
  * Atomically reads the value of @v.
  */
-#define atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
 /**
  * atomic_set - set atomic variable
@@ -52,11 +52,11 @@
  *
  * Atomically sets the value of @v to @i.
  */
-#define atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
+#define arch_atomic_set(v,i)		WRITE_ONCE((v)->counter, (i))
 
 #if XCHAL_HAVE_EXCLUSIVE
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -74,7 +74,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -95,7 +95,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -116,7 +116,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 
 #elif XCHAL_HAVE_S32C1I
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t * v)			\
+static inline void arch_atomic_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -135,7 +135,7 @@ static inline void atomic_##op(int i, atomic_t * v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t * v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -157,7 +157,7 @@ static inline int atomic_##op##_return(int i, atomic_t * v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -180,7 +180,7 @@ static inline int atomic_fetch_##op(int i, atomic_t * v)		\
 #else /* XCHAL_HAVE_S32C1I */
 
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t * v)			\
+static inline void arch_atomic_##op(int i, atomic_t * v)		\
 {									\
 	unsigned int vval;						\
 									\
@@ -198,7 +198,7 @@ static inline void atomic_##op(int i, atomic_t * v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t * v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t * v)	\
 {									\
 	unsigned int vval;						\
 									\
@@ -218,7 +218,7 @@ static inline int atomic_##op##_return(int i, atomic_t * v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t * v)		\
+static inline int arch_atomic_fetch_##op(int i, atomic_t * v)		\
 {									\
 	unsigned int tmp, vval;						\
 									\
@@ -257,7 +257,7 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, o, n) ((int)arch_cmpxchg(&((v)->counter), (o), (n)))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #endif /* _XTENSA_ATOMIC_H */
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 9c4d6e5316ce..3699e2818efb 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -80,7 +80,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 	}
 }
 
-#define cmpxchg(ptr,o,n)						      \
+#define arch_cmpxchg(ptr,o,n)						      \
 	({ __typeof__(*(ptr)) _o_ = (o);				      \
 	   __typeof__(*(ptr)) _n_ = (n);				      \
 	   (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,	      \
@@ -107,11 +107,11 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n)				  	       \
+#define arch_cmpxchg_local(ptr, o, n)				  	       \
 	((__typeof__(*(ptr)))__generic_cmpxchg_local((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
-#define cmpxchg64(ptr, o, n)    cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n)    arch_cmpxchg64_local((ptr), (o), (n))
 
 /*
  * xchg_u32
@@ -169,7 +169,7 @@ static inline unsigned long xchg_u32(volatile int * m, unsigned long val)
 #endif
 }
 
-#define xchg(ptr,x) \
+#define arch_xchg(ptr,x) \
 	((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
 
 static inline u32 xchg_small(volatile void *ptr, u32 x, int size)
-- 
2.11.0

