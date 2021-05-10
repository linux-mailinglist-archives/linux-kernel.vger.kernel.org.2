Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19640377FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEJJmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:42:36 -0400
Received: from foss.arm.com ([217.140.110.172]:51492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhEJJme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:42:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A2F153B;
        Mon, 10 May 2021 02:41:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF4333F73B;
        Mon, 10 May 2021 02:41:25 -0700 (PDT)
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
Subject: [PATCH 18/33] locking/atomic: hexagon: move to ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:38 +0100
Message-Id: <20210510093753.40683-19-mark.rutland@arm.com>
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

As a step towards that, this patch migrates hexagon to ARCH_ATOMIC. The
arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
code wraps these with optional instrumentation to provide the regular
functions.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/hexagon/Kconfig               |  1 +
 arch/hexagon/include/asm/atomic.h  | 28 ++++++++++++++--------------
 arch/hexagon/include/asm/cmpxchg.h |  4 ++--
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 44a409967af1..1368954ef679 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,6 +5,7 @@ comment "Linux Kernel Configuration for Hexagon"
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_ATOMIC
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	# Other pending projects/to-do items.
diff --git a/arch/hexagon/include/asm/atomic.h b/arch/hexagon/include/asm/atomic.h
index 4ab895d7111f..6e94f8d04146 100644
--- a/arch/hexagon/include/asm/atomic.h
+++ b/arch/hexagon/include/asm/atomic.h
@@ -14,7 +14,7 @@
 
 /*  Normal writes in our arch don't clear lock reservations  */
 
-static inline void atomic_set(atomic_t *v, int new)
+static inline void arch_atomic_set(atomic_t *v, int new)
 {
 	asm volatile(
 		"1:	r6 = memw_locked(%0);\n"
@@ -26,26 +26,26 @@ static inline void atomic_set(atomic_t *v, int new)
 	);
 }
 
-#define atomic_set_release(v, i)	atomic_set((v), (i))
+#define arch_atomic_set_release(v, i)	arch_atomic_set((v), (i))
 
 /**
- * atomic_read - reads a word, atomically
+ * arch_atomic_read - reads a word, atomically
  * @v: pointer to atomic value
  *
  * Assumes all word reads on our architecture are atomic.
  */
-#define atomic_read(v)		READ_ONCE((v)->counter)
+#define arch_atomic_read(v)		READ_ONCE((v)->counter)
 
 /**
- * atomic_xchg - atomic
+ * arch_atomic_xchg - atomic
  * @v: pointer to memory to change
  * @new: new value (technically passed in a register -- see xchg)
  */
-#define atomic_xchg(v, new)	(xchg(&((v)->counter), (new)))
+#define arch_atomic_xchg(v, new)	(arch_xchg(&((v)->counter), (new)))
 
 
 /**
- * atomic_cmpxchg - atomic compare-and-exchange values
+ * arch_atomic_cmpxchg - atomic compare-and-exchange values
  * @v: pointer to value to change
  * @old:  desired old value to match
  * @new:  new value to put in
@@ -61,7 +61,7 @@ static inline void atomic_set(atomic_t *v, int new)
  *
  * "old" is "expected" old val, __oldval is actual old value
  */
-static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
+static inline int arch_atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	int __oldval;
 
@@ -81,7 +81,7 @@ static inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 }
 
 #define ATOMIC_OP(op)							\
-static inline void atomic_##op(int i, atomic_t *v)			\
+static inline void arch_atomic_##op(int i, atomic_t *v)			\
 {									\
 	int output;							\
 									\
@@ -97,7 +97,7 @@ static inline void atomic_##op(int i, atomic_t *v)			\
 }									\
 
 #define ATOMIC_OP_RETURN(op)						\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
+static inline int arch_atomic_##op##_return(int i, atomic_t *v)		\
 {									\
 	int output;							\
 									\
@@ -114,7 +114,7 @@ static inline int atomic_##op##_return(int i, atomic_t *v)		\
 }
 
 #define ATOMIC_FETCH_OP(op)						\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
+static inline int arch_atomic_fetch_##op(int i, atomic_t *v)		\
 {									\
 	int output, val;						\
 									\
@@ -148,7 +148,7 @@ ATOMIC_OPS(xor)
 #undef ATOMIC_OP
 
 /**
- * atomic_fetch_add_unless - add unless the number is a given value
+ * arch_atomic_fetch_add_unless - add unless the number is a given value
  * @v: pointer to value
  * @a: amount to add
  * @u: unless value is equal to u
@@ -157,7 +157,7 @@ ATOMIC_OPS(xor)
  *
  */
 
-static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
+static inline int arch_atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	int __oldval;
 	register int tmp;
@@ -180,6 +180,6 @@ static inline int atomic_fetch_add_unless(atomic_t *v, int a, int u)
 	);
 	return __oldval;
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
+#define arch_atomic_fetch_add_unless arch_atomic_fetch_add_unless
 
 #endif
diff --git a/arch/hexagon/include/asm/cmpxchg.h b/arch/hexagon/include/asm/cmpxchg.h
index 92b8a02e588a..cdb705e1496a 100644
--- a/arch/hexagon/include/asm/cmpxchg.h
+++ b/arch/hexagon/include/asm/cmpxchg.h
@@ -42,7 +42,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
  * Atomically swap the contents of a register with memory.  Should be atomic
  * between multiple CPU's and within interrupts on the same CPU.
  */
-#define xchg(ptr, v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v), (ptr), \
+#define arch_xchg(ptr, v) ((__typeof__(*(ptr)))__xchg((unsigned long)(v), (ptr), \
 	sizeof(*(ptr))))
 
 /*
@@ -51,7 +51,7 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr,
  *  variable casting.
  */
 
-#define cmpxchg(ptr, old, new)					\
+#define arch_cmpxchg(ptr, old, new)				\
 ({								\
 	__typeof__(ptr) __ptr = (ptr);				\
 	__typeof__(*(ptr)) __old = (old);			\
-- 
2.11.0

