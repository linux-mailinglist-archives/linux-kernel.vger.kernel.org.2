Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94AF377F96
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhEJJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:32 -0400
Received: from foss.arm.com ([217.140.110.172]:50906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhEJJlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6318A1477;
        Mon, 10 May 2021 02:40:26 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 354DD3F73B;
        Mon, 10 May 2021 02:40:22 -0700 (PDT)
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
Subject: [PATCH 09/33] locking/atomic: atomic: support ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:29 +0100
Message-Id: <20210510093753.40683-10-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like all architectures to convert to ARCH_ATOMIC, as this will
enable functionality, and once all architectures are converted it will
be possible to make significant cleanups to the atomic headers.

A number of architectures use asm-generic/atomic.h, and it's impractical
to convert the header and all these architectures in one go. To make it
possible to convert them one-by-one, let's make the asm-generic
implementation function as either atomic_*() or arch_atomic_*()
depending on whether ARCH_ATOMIC is selected. To do this, the C
implementations are prefixed as generic_atomic_*(), and preprocessor
definitions map atomic_*()/arch_atomic_*() onto these as
appropriate.

Once all users are moved over to ARCH_ATOMIC the ifdeffery in the header
can be simplified and/or removed entirely.

For existing users (none of which select ARCH_ATOMIC), there should be
no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/asm-generic/atomic.h | 71 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 316c82a27b0a..649060fa0fe8 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -12,39 +12,47 @@
 #include <asm/cmpxchg.h>
 #include <asm/barrier.h>
 
+#ifdef CONFIG_ARCH_ATOMIC
+#define __ga_cmpxchg	arch_cmpxchg
+#define __ga_xchg	arch_xchg
+#else
+#define __ga_cmpxchg	cmpxchg
+#define __ga_xchg	xchg
+#endif
+
 #ifdef CONFIG_SMP
 
 /* we can build all atomic primitives from cmpxchg */
 
 #define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void generic_atomic_##op(int i, atomic_t *v)		\
 {									\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c c_op i;						\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int c, old;							\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = __ga_cmpxchg(&v->counter, c, c c_op i)) != c)	\
 		c = old;						\
 									\
 	return c;							\
@@ -55,7 +63,7 @@ static inline int atomic_fetch_##op(int i, atomic_t *v)			\
 #include <linux/irqflags.h>
 
 #define ATOMIC_OP(op, c_op)						\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void generic_atomic_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 									\
@@ -65,7 +73,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int generic_atomic_##op##_return(int i, atomic_t *v)	\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -78,7 +86,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op, c_op)					\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int generic_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	unsigned long flags;						\
 	int ret;							\
@@ -112,10 +120,55 @@ ATOMIC_OP(xor, ^)
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
 
+#undef __ga_cmpxchg
+#undef __ga_xchg
+
+#ifdef CONFIG_ARCH_ATOMIC
+
+#define arch_atomic_add_return			generic_atomic_add_return
+#define arch_atomic_sub_return			generic_atomic_sub_return
+
+#define arch_atomic_fetch_add			generic_atomic_fetch_add
+#define arch_atomic_fetch_sub			generic_atomic_fetch_sub
+#define arch_atomic_fetch_and			generic_atomic_fetch_and
+#define arch_atomic_fetch_or			generic_atomic_fetch_or
+#define arch_atomic_fetch_xor			generic_atomic_fetch_xor
+
+#define arch_atomic_add				generic_atomic_add
+#define arch_atomic_sub				generic_atomic_sub
+#define arch_atomic_and				generic_atomic_and
+#define arch_atomic_or				generic_atomic_or
+#define arch_atomic_xor				generic_atomic_xor
+
+#define arch_atomic_read(v)			READ_ONCE((v)->counter)
+#define arch_atomic_set(v, i)			WRITE_ONCE(((v)->counter), (i))
+
+#define arch_atomic_xchg(ptr, v)		(arch_xchg(&(ptr)->counter, (v)))
+#define arch_atomic_cmpxchg(v, old, new)	(arch_cmpxchg(&((v)->counter), (old), (new)))
+
+#else /* CONFIG_ARCH_ATOMIC */
+
+#define atomic_add_return		generic_atomic_add_return
+#define atomic_sub_return		generic_atomic_sub_return
+
+#define atomic_fetch_add		generic_atomic_fetch_add
+#define atomic_fetch_sub		generic_atomic_fetch_sub
+#define atomic_fetch_and		generic_atomic_fetch_and
+#define atomic_fetch_or			generic_atomic_fetch_or
+#define atomic_fetch_xor		generic_atomic_fetch_xor
+
+#define atomic_add			generic_atomic_add
+#define atomic_sub			generic_atomic_sub
+#define atomic_and			generic_atomic_and
+#define atomic_or			generic_atomic_or
+#define atomic_xor			generic_atomic_xor
+
 #define atomic_read(v)			READ_ONCE((v)->counter)
 #define atomic_set(v, i)		WRITE_ONCE(((v)->counter), (i))
 
 #define atomic_xchg(ptr, v)		(xchg(&(ptr)->counter, (v)))
 #define atomic_cmpxchg(v, old, new)	(cmpxchg(&((v)->counter), (old), (new)))
 
+#endif /* CONFIG_ARCH_ATOMIC */
+
 #endif /* __ASM_GENERIC_ATOMIC_H */
-- 
2.11.0

