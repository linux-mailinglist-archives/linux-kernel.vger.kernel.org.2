Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77743377FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhEJJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:42:20 -0400
Received: from foss.arm.com ([217.140.110.172]:51300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhEJJmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:42:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B9C4152B;
        Mon, 10 May 2021 02:41:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01B393F73B;
        Mon, 10 May 2021 02:41:06 -0700 (PDT)
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
Subject: [PATCH 15/33] locking/atomic: arm: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:35 +0100
Message-Id: <20210510093753.40683-16-mark.rutland@arm.com>
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

As a step towards that, this patch migrates arm to ARCH_ATOMIC. The arch
code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common code
wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm/Kconfig               |  1 +
 arch/arm/include/asm/atomic.h  | 96 +++++++++++++++++++++---------------------
 arch/arm/include/asm/cmpxchg.h | 16 +++----
 3 files changed, 57 insertions(+), 56 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24804f11302d..b7334a6643b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -3,6 +3,7 @@ config ARM
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
diff --git a/arch/arm/include/asm/atomic.h b/arch/arm/include/asm/atomic.h
index 455eb19a5ac1..db8512d9a918 100644
--- a/arch/arm/include/asm/atomic.h
+++ b/arch/arm/include/asm/atomic.h
@@ -22,8 +22,8 @@
  * strex/ldrex monitor on some implementations. The reason we can use it for
  * atomic_set() is the clrex or dummy strex done on every exception return.
  */
-#define atomic_read(v)	READ_ONCE((v)->counter)
-#define atomic_set(v,i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_set(v,i)	WRITE_ONCE(((v)->counter), (i))
 
 #if __LINUX_ARM_ARCH__ >= 6
 
@@ -34,7 +34,7 @@
  */
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -52,7 +52,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned long tmp;						\
 	int result;							\
@@ -73,7 +73,7 @@ static inline int atomic_##op##_return_relaxed(int i, atomic_t *v)	\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
+static inline int arch_atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 {									\
 	unsigned long tmp;						\
 	int result, val;						\
@@ -93,17 +93,17 @@ static inline int atomic_fetch_##op##_relaxed(int i, atomic_t *v)	\
 	return result;							\
 }
 
-#define atomic_add_return_relaxed	atomic_add_return_relaxed
-#define atomic_sub_return_relaxed	atomic_sub_return_relaxed
-#define atomic_fetch_add_relaxed	atomic_fetch_add_relaxed
-#define atomic_fetch_sub_relaxed	atomic_fetch_sub_relaxed
+#define arch_atomic_add_return_relaxed		arch_atomic_add_return_relaxed
+#define arch_atomic_sub_return_relaxed		arch_atomic_sub_return_relaxed
+#define arch_atomic_fetch_add_relaxed		arch_atomic_fetch_add_relaxed
+#define arch_atomic_fetch_sub_relaxed		arch_atomic_fetch_sub_relaxed
 
-#define atomic_fetch_and_relaxed	atomic_fetch_and_relaxed
-#define atomic_fetch_andnot_relaxed	atomic_fetch_andnot_relaxed
-#define atomic_fetch_or_relaxed		atomic_fetch_or_relaxed
-#define atomic_fetch_xor_relaxed	atomic_fetch_xor_relaxed
+#define arch_atomic_fetch_and_relaxed		arch_atomic_fetch_and_relaxed
+#define arch_atomic_fetch_andnot_relaxed	arch_atomic_fetch_andnot_relaxed
+#define arch_atomic_fetch_or_relaxed		arch_atomic_fetch_or_relaxed
+#define arch_atomic_fetch_xor_relaxed		arch_atomic_fetch_xor_relaxed
 
-static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
+static inline int arch_atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 {
 	int oldval;
 	unsigned long res;
@@ -123,9 +123,9 @@ static inline int atomic_cmpxchg_relaxed(atomic_t *ptr, int old, int new)
 
 	return oldval;
 }
-#define atomic_cmpxchg_relaxed		atomic_cmpxchg_relaxed
+#define arch_atomic_cmpxchg_relaxed		arch_atomic_cmpxchg_relaxed
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int oldval, newval;
 	unsigned long tmp;
@@ -151,7 +151,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 
 	return oldval;
 }
-#define atomic_fetch_add_unless		atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless		arch_atomic_fetch_add_unless
 
 #else /* ARM_ARCH_6 */
 
@@ -160,7 +160,7 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 #endif
 
 #define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	unsigned long flags;						\
 									\
@@ -170,7 +170,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int val;							\
@@ -184,7 +184,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int val;							\
@@ -197,7 +197,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 	return val;							\
 }
 
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int ret;
 	unsigned long flags;
@@ -211,7 +211,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return ret;
 }
 
-#define atomic_fetch_andnot		atomic_fetch_andnot
+#define arch_atomic_fetch_andnot		arch_atomic_fetch_andnot
 
 #endif /* __LINUX_ARM_ARCH__ */
 
@@ -223,7 +223,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 ATOMIC_OPS(add, +=, add)
 ATOMIC_OPS(sub, -=, sub)
 
-#define atomic_andnot atomic_andnot
+#define arch_atomic_andnot arch_atomic_andnot
 
 #undef ATOMIC_OPS
 #define ATOMIC_OPS(op, c_op, asm_op)					\
@@ -240,7 +240,7 @@ ATOMIC_OPS(xor, ^=, eor)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
 #ifndef CONFIG_GENERIC_ATOMIC64
 typedef struct {
@@ -250,7 +250,7 @@ typedef struct {
 #define ATOMIC64_INIT(i) { (i) }
 
 #ifdef CONFIG_ARM_LPAE
-static inline s64 atomic64_read(const atomic64_t *v)
+static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 result;
 
@@ -263,7 +263,7 @@ static inline s64 atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, s64 i)
+static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	__asm__ __volatile__("@ atomic64_set\n"
 "	strd	%2, %H2, [%1]"
@@ -272,7 +272,7 @@ static inline void atomic64_set(atomic64_t *v, s64 i)
 	);
 }
 #else
-static inline s64 atomic64_read(const atomic64_t *v)
+static inline s64 arch_atomic64_read(const atomic64_t *v)
 {
 	s64 result;
 
@@ -285,7 +285,7 @@ static inline s64 atomic64_read(const atomic64_t *v)
 	return result;
 }
 
-static inline void atomic64_set(atomic64_t *v, s64 i)
+static inline void arch_atomic64_set(atomic64_t *v, s64 i)
 {
 	s64 tmp;
 
@@ -302,7 +302,7 @@ static inline void atomic64_set(atomic64_t *v, s64 i)
 #endif
 
 #define ATOMIC64_OP(op, op1, op2)					\
-static inline void atomic64_##op(s64 i, atomic64_t *v)			\
+static inline void arch_atomic64_##op(s64 i, atomic64_t *v)		\
 {									\
 	s64 result;							\
 	unsigned long tmp;						\
@@ -322,7 +322,7 @@ static inline void atomic64_##op(s64 i, atomic64_t *v)			\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)				\
 static inline s64							\
-atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)			\
+arch_atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)		\
 {									\
 	s64 result;							\
 	unsigned long tmp;						\
@@ -345,7 +345,7 @@ atomic64_##op##_return_relaxed(s64 i, atomic64_t *v)			\
 
 #define ATOMIC64_FETCH_OP(op, op1, op2)					\
 static inline s64							\
-atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)			\
+arch_atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)		\
 {									\
 	s64 result, val;						\
 	unsigned long tmp;						\
@@ -374,34 +374,34 @@ atomic64_fetch_##op##_relaxed(s64 i, atomic64_t *v)			\
 ATOMIC64_OPS(add, adds, adc)
 ATOMIC64_OPS(sub, subs, sbc)
 
-#define atomic64_add_return_relaxed	atomic64_add_return_relaxed
-#define atomic64_sub_return_relaxed	atomic64_sub_return_relaxed
-#define atomic64_fetch_add_relaxed	atomic64_fetch_add_relaxed
-#define atomic64_fetch_sub_relaxed	atomic64_fetch_sub_relaxed
+#define arch_atomic64_add_return_relaxed	arch_atomic64_add_return_relaxed
+#define arch_atomic64_sub_return_relaxed	arch_atomic64_sub_return_relaxed
+#define arch_atomic64_fetch_add_relaxed		arch_atomic64_fetch_add_relaxed
+#define arch_atomic64_fetch_sub_relaxed		arch_atomic64_fetch_sub_relaxed
 
 #undef ATOMIC64_OPS
 #define ATOMIC64_OPS(op, op1, op2)					\
 	ATOMIC64_OP(op, op1, op2)					\
 	ATOMIC64_FETCH_OP(op, op1, op2)
 
-#define atomic64_andnot atomic64_andnot
+#define arch_atomic64_andnot arch_atomic64_andnot
 
 ATOMIC64_OPS(and, and, and)
 ATOMIC64_OPS(andnot, bic, bic)
 ATOMIC64_OPS(or,  orr, orr)
 ATOMIC64_OPS(xor, eor, eor)
 
-#define atomic64_fetch_and_relaxed	atomic64_fetch_and_relaxed
-#define atomic64_fetch_andnot_relaxed	atomic64_fetch_andnot_relaxed
-#define atomic64_fetch_or_relaxed	atomic64_fetch_or_relaxed
-#define atomic64_fetch_xor_relaxed	atomic64_fetch_xor_relaxed
+#define arch_atomic64_fetch_and_relaxed		arch_atomic64_fetch_and_relaxed
+#define arch_atomic64_fetch_andnot_relaxed	arch_atomic64_fetch_andnot_relaxed
+#define arch_atomic64_fetch_or_relaxed		arch_atomic64_fetch_or_relaxed
+#define arch_atomic64_fetch_xor_relaxed		arch_atomic64_fetch_xor_relaxed
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-static inline s64 atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
+static inline s64 arch_atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
 {
 	s64 oldval;
 	unsigned long res;
@@ -422,9 +422,9 @@ static inline s64 atomic64_cmpxchg_relaxed(atomic64_t *ptr, s64 old, s64 new)
 
 	return oldval;
 }
-#define atomic64_cmpxchg_relaxed	atomic64_cmpxchg_relaxed
+#define arch_atomic64_cmpxchg_relaxed	arch_atomic64_cmpxchg_relaxed
 
-static inline s64 atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
+static inline s64 arch_atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
 {
 	s64 result;
 	unsigned long tmp;
@@ -442,9 +442,9 @@ static inline s64 atomic64_xchg_relaxed(atomic64_t *ptr, s64 new)
 
 	return result;
 }
-#define atomic64_xchg_relaxed		atomic64_xchg_relaxed
+#define arch_atomic64_xchg_relaxed		arch_atomic64_xchg_relaxed
 
-static inline s64 atomic64_dec_if_positive(atomic64_t *v)
+static inline s64 arch_atomic64_dec_if_positive(atomic64_t *v)
 {
 	s64 result;
 	unsigned long tmp;
@@ -470,9 +470,9 @@ static inline s64 atomic64_dec_if_positive(atomic64_t *v)
 
 	return result;
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
+#define arch_atomic64_dec_if_positive arch_atomic64_dec_if_positive
 
-static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+static inline s64 arch_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	s64 oldval, newval;
 	unsigned long tmp;
@@ -500,7 +500,7 @@ static inline s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return oldval;
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+#define arch_atomic64_fetch_add_unless arch_atomic64_fetch_add_unless
 
 #endif /* !CONFIG_GENERIC_ATOMIC64 */
 #endif
diff --git a/arch/arm/include/asm/cmpxchg.h b/arch/arm/include/asm/cmpxchg.h
index 06bd8cea861a..4dfe538dfc68 100644
--- a/arch/arm/include/asm/cmpxchg.h
+++ b/arch/arm/include/asm/cmpxchg.h
@@ -114,7 +114,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 	return ret;
 }
 
-#define xchg_relaxed(ptr, x) ({						\
+#define arch_xchg_relaxed(ptr, x) ({					\
 	(__typeof__(*(ptr)))__xchg((unsigned long)(x), (ptr),		\
 				   sizeof(*(ptr)));			\
 })
@@ -128,20 +128,20 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
 #error "SMP is not supported on this platform"
 #endif
 
-#define xchg xchg_relaxed
+#define arch_xchg arch_xchg_relaxed
 
 /*
  * cmpxchg_local and cmpxchg64_local are atomic wrt current CPU. Always make
  * them available.
  */
-#define cmpxchg_local(ptr, o, n) ({					\
+#define arch_cmpxchg_local(ptr, o, n) ({				\
 	(__typeof(*ptr))__generic_cmpxchg_local((ptr),			\
 					        (unsigned long)(o),	\
 					        (unsigned long)(n),	\
 					        sizeof(*(ptr)));	\
 })
 
-#define cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) __generic_cmpxchg64_local((ptr), (o), (n))
 
 #include <asm-generic/cmpxchg.h>
 
@@ -207,7 +207,7 @@ static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
 	return oldval;
 }
 
-#define cmpxchg_relaxed(ptr,o,n) ({					\
+#define arch_cmpxchg_relaxed(ptr,o,n) ({				\
 	(__typeof__(*(ptr)))__cmpxchg((ptr),				\
 				      (unsigned long)(o),		\
 				      (unsigned long)(n),		\
@@ -234,7 +234,7 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	return ret;
 }
 
-#define cmpxchg_local(ptr, o, n) ({					\
+#define arch_cmpxchg_local(ptr, o, n) ({				\
 	(__typeof(*ptr))__cmpxchg_local((ptr),				\
 				        (unsigned long)(o),		\
 				        (unsigned long)(n),		\
@@ -266,13 +266,13 @@ static inline unsigned long long __cmpxchg64(unsigned long long *ptr,
 	return oldval;
 }
 
-#define cmpxchg64_relaxed(ptr, o, n) ({					\
+#define arch_cmpxchg64_relaxed(ptr, o, n) ({				\
 	(__typeof__(*(ptr)))__cmpxchg64((ptr),				\
 					(unsigned long long)(o),	\
 					(unsigned long long)(n));	\
 })
 
-#define cmpxchg64_local(ptr, o, n) cmpxchg64_relaxed((ptr), (o), (n))
+#define arch_cmpxchg64_local(ptr, o, n) arch_cmpxchg64_relaxed((ptr), (o), (n))
 
 #endif	/* __LINUX_ARM_ARCH__ >= 6 */
 
-- 
2.11.0

