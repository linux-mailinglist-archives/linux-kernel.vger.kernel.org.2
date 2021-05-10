Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89FC377FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhEJJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:42:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhEJJmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:42:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E1F11576;
        Mon, 10 May 2021 02:41:45 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 10B143F73B;
        Mon, 10 May 2021 02:41:40 -0700 (PDT)
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
Subject: [PATCH 19/33] locking/atomic: ia64: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:39 +0100
Message-Id: <20210510093753.40683-20-mark.rutland@arm.com>
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

As a step towards that, this patch migrates ia64 to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/ia64/Kconfig                    |  1 +
 arch/ia64/include/asm/atomic.h       | 74 ++++++++++++++++++------------------
 arch/ia64/include/asm/cmpxchg.h      | 16 ++++++++
 arch/ia64/include/uapi/asm/cmpxchg.h | 10 +++--
 4 files changed, 61 insertions(+), 40 deletions(-)
 create mode 100644 arch/ia64/include/asm/cmpxchg.h

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 279252e3e0f7..c5414dcd5d0d 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -8,6 +8,7 @@ menu "Processor type and features"
 
 config IA64
 	bool
+	select ARCH_ATOMIC
 	select ARCH_HAS_DMA_MARK_CLEAN
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
diff --git a/arch/ia64/include/asm/atomic.h b/arch/ia64/include/asm/atomic.h
index f267d956458f..266c429b9137 100644
--- a/arch/ia64/include/asm/atomic.h
+++ b/arch/ia64/include/asm/atomic.h
@@ -21,11 +21,11 @@
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-#define atomic_read(v)		READ_ONCE((v)->counter)
-#define atomic64_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic_read(v)	READ_ONCE((v)->counter)
+#define arch_atomic64_read(v)	READ_ONCE((v)->counter)
 
-#define atomic_set(v,i)		WRITE_ONCE(((v)->counter), (i))
-#define atomic64_set(v,i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic_set(v,i)	WRITE_ONCE(((v)->counter), (i))
+#define arch_atomic64_set(v,i)	WRITE_ONCE(((v)->counter), (i))
 
 #define ATOMIC_OP(op, c_op)						\
 static __inline__ int							\
@@ -36,7 +36,7 @@ ia64_atomic_##op (int i, atomic_t *v)					\
 									\
 	do {								\
 		CMPXCHG_BUGCHECK(v);					\
-		old = atomic_read(v);					\
+		old = arch_atomic_read(v);				\
 		new = old c_op i;					\
 	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic_t)) != old); \
 	return new;							\
@@ -51,7 +51,7 @@ ia64_atomic_fetch_##op (int i, atomic_t *v)				\
 									\
 	do {								\
 		CMPXCHG_BUGCHECK(v);					\
-		old = atomic_read(v);					\
+		old = arch_atomic_read(v);				\
 		new = old c_op i;					\
 	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic_t)) != old); \
 	return old;							\
@@ -74,7 +74,7 @@ ATOMIC_OPS(sub, -)
 #define __ia64_atomic_const(i)	0
 #endif
 
-#define atomic_add_return(i,v)						\
+#define arch_atomic_add_return(i,v)					\
 ({									\
 	int __ia64_aar_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -82,7 +82,7 @@ ATOMIC_OPS(sub, -)
 		: ia64_atomic_add(__ia64_aar_i, v);			\
 })
 
-#define atomic_sub_return(i,v)						\
+#define arch_atomic_sub_return(i,v)					\
 ({									\
 	int __ia64_asr_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -90,7 +90,7 @@ ATOMIC_OPS(sub, -)
 		: ia64_atomic_sub(__ia64_asr_i, v);			\
 })
 
-#define atomic_fetch_add(i,v)						\
+#define arch_atomic_fetch_add(i,v)					\
 ({									\
 	int __ia64_aar_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -98,7 +98,7 @@ ATOMIC_OPS(sub, -)
 		: ia64_atomic_fetch_add(__ia64_aar_i, v);		\
 })
 
-#define atomic_fetch_sub(i,v)						\
+#define arch_atomic_fetch_sub(i,v)					\
 ({									\
 	int __ia64_asr_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -110,13 +110,13 @@ ATOMIC_FETCH_OP(and, &)
 ATOMIC_FETCH_OP(or, |)
 ATOMIC_FETCH_OP(xor, ^)
 
-#define atomic_and(i,v)	(void)ia64_atomic_fetch_and(i,v)
-#define atomic_or(i,v)	(void)ia64_atomic_fetch_or(i,v)
-#define atomic_xor(i,v)	(void)ia64_atomic_fetch_xor(i,v)
+#define arch_atomic_and(i,v)	(void)ia64_atomic_fetch_and(i,v)
+#define arch_atomic_or(i,v)	(void)ia64_atomic_fetch_or(i,v)
+#define arch_atomic_xor(i,v)	(void)ia64_atomic_fetch_xor(i,v)
 
-#define atomic_fetch_and(i,v)	ia64_atomic_fetch_and(i,v)
-#define atomic_fetch_or(i,v)	ia64_atomic_fetch_or(i,v)
-#define atomic_fetch_xor(i,v)	ia64_atomic_fetch_xor(i,v)
+#define arch_atomic_fetch_and(i,v)	ia64_atomic_fetch_and(i,v)
+#define arch_atomic_fetch_or(i,v)	ia64_atomic_fetch_or(i,v)
+#define arch_atomic_fetch_xor(i,v)	ia64_atomic_fetch_xor(i,v)
 
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
@@ -131,7 +131,7 @@ ia64_atomic64_##op (s64 i, atomic64_t *v)				\
 									\
 	do {								\
 		CMPXCHG_BUGCHECK(v);					\
-		old = atomic64_read(v);					\
+		old = arch_atomic64_read(v);				\
 		new = old c_op i;					\
 	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic64_t)) != old); \
 	return new;							\
@@ -146,7 +146,7 @@ ia64_atomic64_fetch_##op (s64 i, atomic64_t *v)				\
 									\
 	do {								\
 		CMPXCHG_BUGCHECK(v);					\
-		old = atomic64_read(v);					\
+		old = arch_atomic64_read(v);				\
 		new = old c_op i;					\
 	} while (ia64_cmpxchg(acq, v, old, new, sizeof(atomic64_t)) != old); \
 	return old;							\
@@ -159,7 +159,7 @@ ia64_atomic64_fetch_##op (s64 i, atomic64_t *v)				\
 ATOMIC64_OPS(add, +)
 ATOMIC64_OPS(sub, -)
 
-#define atomic64_add_return(i,v)					\
+#define arch_atomic64_add_return(i,v)					\
 ({									\
 	s64 __ia64_aar_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -167,7 +167,7 @@ ATOMIC64_OPS(sub, -)
 		: ia64_atomic64_add(__ia64_aar_i, v);			\
 })
 
-#define atomic64_sub_return(i,v)					\
+#define arch_atomic64_sub_return(i,v)					\
 ({									\
 	s64 __ia64_asr_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -175,7 +175,7 @@ ATOMIC64_OPS(sub, -)
 		: ia64_atomic64_sub(__ia64_asr_i, v);			\
 })
 
-#define atomic64_fetch_add(i,v)						\
+#define arch_atomic64_fetch_add(i,v)					\
 ({									\
 	s64 __ia64_aar_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -183,7 +183,7 @@ ATOMIC64_OPS(sub, -)
 		: ia64_atomic64_fetch_add(__ia64_aar_i, v);		\
 })
 
-#define atomic64_fetch_sub(i,v)						\
+#define arch_atomic64_fetch_sub(i,v)					\
 ({									\
 	s64 __ia64_asr_i = (i);						\
 	__ia64_atomic_const(i)						\
@@ -195,29 +195,29 @@ ATOMIC64_FETCH_OP(and, &)
 ATOMIC64_FETCH_OP(or, |)
 ATOMIC64_FETCH_OP(xor, ^)
 
-#define atomic64_and(i,v)	(void)ia64_atomic64_fetch_and(i,v)
-#define atomic64_or(i,v)	(void)ia64_atomic64_fetch_or(i,v)
-#define atomic64_xor(i,v)	(void)ia64_atomic64_fetch_xor(i,v)
+#define arch_atomic64_and(i,v)	(void)ia64_atomic64_fetch_and(i,v)
+#define arch_atomic64_or(i,v)	(void)ia64_atomic64_fetch_or(i,v)
+#define arch_atomic64_xor(i,v)	(void)ia64_atomic64_fetch_xor(i,v)
 
-#define atomic64_fetch_and(i,v)	ia64_atomic64_fetch_and(i,v)
-#define atomic64_fetch_or(i,v)	ia64_atomic64_fetch_or(i,v)
-#define atomic64_fetch_xor(i,v)	ia64_atomic64_fetch_xor(i,v)
+#define arch_atomic64_fetch_and(i,v)	ia64_atomic64_fetch_and(i,v)
+#define arch_atomic64_fetch_or(i,v)	ia64_atomic64_fetch_or(i,v)
+#define arch_atomic64_fetch_xor(i,v)	ia64_atomic64_fetch_xor(i,v)
 
 #undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP
 
-#define atomic_cmpxchg(v, old, new) (cmpxchg(&((v)->counter), old, new))
-#define atomic_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic_cmpxchg(v, old, new) (arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
-#define atomic64_cmpxchg(v, old, new) \
-	(cmpxchg(&((v)->counter), old, new))
-#define atomic64_xchg(v, new) (xchg(&((v)->counter), new))
+#define arch_atomic64_cmpxchg(v, old, new) \
+	(arch_cmpxchg(&((v)->counter), old, new))
+#define arch_atomic64_xchg(v, new) (arch_xchg(&((v)->counter), new))
 
-#define atomic_add(i,v)			(void)atomic_add_return((i), (v))
-#define atomic_sub(i,v)			(void)atomic_sub_return((i), (v))
+#define arch_atomic_add(i,v)		(void)arch_atomic_add_return((i), (v))
+#define arch_atomic_sub(i,v)		(void)arch_atomic_sub_return((i), (v))
 
-#define atomic64_add(i,v)		(void)atomic64_add_return((i), (v))
-#define atomic64_sub(i,v)		(void)atomic64_sub_return((i), (v))
+#define arch_atomic64_add(i,v)		(void)arch_atomic64_add_return((i), (v))
+#define arch_atomic64_sub(i,v)		(void)arch_atomic64_sub_return((i), (v))
 
 #endif /* _ASM_IA64_ATOMIC_H */
diff --git a/arch/ia64/include/asm/cmpxchg.h b/arch/ia64/include/asm/cmpxchg.h
new file mode 100644
index 000000000000..94ef84429843
--- /dev/null
+++ b/arch/ia64/include/asm/cmpxchg.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_IA64_CMPXCHG_H
+#define _ASM_IA64_CMPXCHG_H
+
+#include <uapi/asm/cmpxchg.h>
+
+#define arch_xchg(ptr, x)	\
+({(__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
+
+#define arch_cmpxchg(ptr, o, n)		cmpxchg_acq((ptr), (o), (n))
+#define arch_cmpxchg64(ptr, o, n)	cmpxchg_acq((ptr), (o), (n))
+
+#define arch_cmpxchg_local		arch_cmpxchg
+#define arch_cmpxchg64_local		arch_cmpxchg64
+
+#endif /* _ASM_IA64_CMPXCHG_H */
diff --git a/arch/ia64/include/uapi/asm/cmpxchg.h b/arch/ia64/include/uapi/asm/cmpxchg.h
index 5d90307fd6e0..926c6cb1e029 100644
--- a/arch/ia64/include/uapi/asm/cmpxchg.h
+++ b/arch/ia64/include/uapi/asm/cmpxchg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _ASM_IA64_CMPXCHG_H
-#define _ASM_IA64_CMPXCHG_H
+#ifndef _UAPI_ASM_IA64_CMPXCHG_H
+#define _UAPI_ASM_IA64_CMPXCHG_H
 
 /*
  * Compare/Exchange, forked from asm/intrinsics.h
@@ -53,8 +53,10 @@ extern void ia64_xchg_called_with_bad_pointer(void);
 	__xchg_result;							\
 })
 
+#ifndef __KERNEL__
 #define xchg(ptr, x)							\
 ({(__typeof__(*(ptr))) __xchg((unsigned long) (x), (ptr), sizeof(*(ptr)));})
+#endif
 
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
@@ -126,12 +128,14 @@ extern long ia64_cmpxchg_called_with_bad_pointer(void);
  * we had to back-pedal and keep the "legacy" behavior of a full fence :-(
  */
 
+#ifndef __KERNEL__
 /* for compatibility with other platforms: */
 #define cmpxchg(ptr, o, n)	cmpxchg_acq((ptr), (o), (n))
 #define cmpxchg64(ptr, o, n)	cmpxchg_acq((ptr), (o), (n))
 
 #define cmpxchg_local		cmpxchg
 #define cmpxchg64_local		cmpxchg64
+#endif
 
 #ifdef CONFIG_IA64_DEBUG_CMPXCHG
 # define CMPXCHG_BUGCHECK_DECL	int _cmpxchg_bugcheck_count = 128;
@@ -152,4 +156,4 @@ do {									\
 
 #endif /* !__ASSEMBLY__ */
 
-#endif /* _ASM_IA64_CMPXCHG_H */
+#endif /* _UAPI_ASM_IA64_CMPXCHG_H */
-- 
2.11.0

