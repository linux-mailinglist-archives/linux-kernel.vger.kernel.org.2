Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BD8377F97
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhEJJlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:41:45 -0400
Received: from foss.arm.com ([217.140.110.172]:50974 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230137AbhEJJll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:41:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C68E14FF;
        Mon, 10 May 2021 02:40:37 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D059C3F73B;
        Mon, 10 May 2021 02:40:32 -0700 (PDT)
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
Subject: [PATCH 10/33] locking/atomic: atomic64: support ARCH_ATOMIC
Date:   Mon, 10 May 2021 10:37:30 +0100
Message-Id: <20210510093753.40683-11-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like all architectures to convert to ARCH_ATOMIC, as this will
enable functionality, and once all architectures are converted it will
be possible to make significant cleanups to the atomic headers.

A number of architectures use asm-generic/atomic64.h, and it's
impractical to convert the header and all these architectures in one go.
To make it possible to convert them one-by-one, let's make the
asm-generic implementation function as either atomic64_*() or
arch_atomic64_*() depending on whether ARCH_ATOMIC is selected. To do
this, the generic implementations are prefixed as generic_atomic64_*(),
and preprocessor definitions map atomic64_*()/arch_atomic64_*() onto
these as appropriate.

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
 include/asm-generic/atomic64.h | 74 ++++++++++++++++++++++++++++++++++--------
 lib/atomic64.c                 | 36 ++++++++++----------
 2 files changed, 79 insertions(+), 31 deletions(-)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d4450f..c8c7d9fae820 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -15,19 +15,17 @@ typedef struct {
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-extern s64 atomic64_read(const atomic64_t *v);
-extern void atomic64_set(atomic64_t *v, s64 i);
-
-#define atomic64_set_release(v, i)	atomic64_set((v), (i))
+extern s64 generic_atomic64_read(const atomic64_t *v);
+extern void generic_atomic64_set(atomic64_t *v, s64 i);
 
 #define ATOMIC64_OP(op)							\
-extern void	 atomic64_##op(s64 a, atomic64_t *v);
+extern void generic_atomic64_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OP_RETURN(op)						\
-extern s64 atomic64_##op##_return(s64 a, atomic64_t *v);
+extern s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v);
 
 #define ATOMIC64_FETCH_OP(op)						\
-extern s64 atomic64_fetch_##op(s64 a, atomic64_t *v);
+extern s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v);
 
 #define ATOMIC64_OPS(op)	ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
 
@@ -46,11 +44,61 @@ ATOMIC64_OPS(xor)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-extern s64 atomic64_dec_if_positive(atomic64_t *v);
-#define atomic64_dec_if_positive atomic64_dec_if_positive
-extern s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
-extern s64 atomic64_xchg(atomic64_t *v, s64 new);
-extern s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
+extern s64 generic_atomic64_dec_if_positive(atomic64_t *v);
+extern s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n);
+extern s64 generic_atomic64_xchg(atomic64_t *v, s64 new);
+extern s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u);
+
+#ifdef CONFIG_ARCH_ATOMIC
+
+#define arch_atomic64_read		generic_atomic64_read
+#define arch_atomic64_set		generic_atomic64_set
+#define arch_atomic64_set_release	generic_atomic64_set
+
+#define arch_atomic64_add		generic_atomic64_add
+#define arch_atomic64_add_return	generic_atomic64_add_return
+#define arch_atomic64_fetch_add		generic_atomic64_fetch_add
+#define arch_atomic64_sub		generic_atomic64_sub
+#define arch_atomic64_sub_return	generic_atomic64_sub_return
+#define arch_atomic64_fetch_sub		generic_atomic64_fetch_sub
+
+#define arch_atomic64_and		generic_atomic64_and
+#define arch_atomic64_fetch_and		generic_atomic64_fetch_and
+#define arch_atomic64_or		generic_atomic64_or
+#define arch_atomic64_fetch_or		generic_atomic64_fetch_or
+#define arch_atomic64_xor		generic_atomic64_xor
+#define arch_atomic64_fetch_xor		generic_atomic64_fetch_xor
+
+#define arch_atomic64_dec_if_positive	generic_atomic64_dec_if_positive
+#define arch_atomic64_cmpxchg		generic_atomic64_cmpxchg
+#define arch_atomic64_xchg		generic_atomic64_xchg
+#define arch_atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
+
+#else /* CONFIG_ARCH_ATOMIC */
+
+#define atomic64_read			generic_atomic64_read
+#define atomic64_set			generic_atomic64_set
+#define atomic64_set_release		generic_atomic64_set
+
+#define atomic64_add			generic_atomic64_add
+#define atomic64_add_return		generic_atomic64_add_return
+#define atomic64_fetch_add		generic_atomic64_fetch_add
+#define atomic64_sub			generic_atomic64_sub
+#define atomic64_sub_return		generic_atomic64_sub_return
+#define atomic64_fetch_sub		generic_atomic64_fetch_sub
+
+#define atomic64_and			generic_atomic64_and
+#define atomic64_fetch_and		generic_atomic64_fetch_and
+#define atomic64_or			generic_atomic64_or
+#define atomic64_fetch_or		generic_atomic64_fetch_or
+#define atomic64_xor			generic_atomic64_xor
+#define atomic64_fetch_xor		generic_atomic64_fetch_xor
+
+#define atomic64_dec_if_positive	generic_atomic64_dec_if_positive
+#define atomic64_cmpxchg		generic_atomic64_cmpxchg
+#define atomic64_xchg			generic_atomic64_xchg
+#define atomic64_fetch_add_unless	generic_atomic64_fetch_add_unless
+
+#endif /* CONFIG_ARCH_ATOMIC */
 
 #endif  /*  _ASM_GENERIC_ATOMIC64_H  */
diff --git a/lib/atomic64.c b/lib/atomic64.c
index e98c85a99787..3df653994177 100644
--- a/lib/atomic64.c
+++ b/lib/atomic64.c
@@ -42,7 +42,7 @@ static inline raw_spinlock_t *lock_addr(const atomic64_t *v)
 	return &atomic64_lock[addr & (NR_LOCKS - 1)].lock;
 }
 
-s64 atomic64_read(const atomic64_t *v)
+s64 generic_atomic64_read(const atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -53,9 +53,9 @@ s64 atomic64_read(const atomic64_t *v)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_read);
+EXPORT_SYMBOL(generic_atomic64_read);
 
-void atomic64_set(atomic64_t *v, s64 i)
+void generic_atomic64_set(atomic64_t *v, s64 i)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -64,10 +64,10 @@ void atomic64_set(atomic64_t *v, s64 i)
 	v->counter = i;
 	raw_spin_unlock_irqrestore(lock, flags);
 }
-EXPORT_SYMBOL(atomic64_set);
+EXPORT_SYMBOL(generic_atomic64_set);
 
 #define ATOMIC64_OP(op, c_op)						\
-void atomic64_##op(s64 a, atomic64_t *v)				\
+void generic_atomic64_##op(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -76,10 +76,10 @@ void atomic64_##op(s64 a, atomic64_t *v)				\
 	v->counter c_op a;						\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 }									\
-EXPORT_SYMBOL(atomic64_##op);
+EXPORT_SYMBOL(generic_atomic64_##op);
 
 #define ATOMIC64_OP_RETURN(op, c_op)					\
-s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
+s64 generic_atomic64_##op##_return(s64 a, atomic64_t *v)		\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -90,10 +90,10 @@ s64 atomic64_##op##_return(s64 a, atomic64_t *v)			\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 	return val;							\
 }									\
-EXPORT_SYMBOL(atomic64_##op##_return);
+EXPORT_SYMBOL(generic_atomic64_##op##_return);
 
 #define ATOMIC64_FETCH_OP(op, c_op)					\
-s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
+s64 generic_atomic64_fetch_##op(s64 a, atomic64_t *v)			\
 {									\
 	unsigned long flags;						\
 	raw_spinlock_t *lock = lock_addr(v);				\
@@ -105,7 +105,7 @@ s64 atomic64_fetch_##op(s64 a, atomic64_t *v)				\
 	raw_spin_unlock_irqrestore(lock, flags);			\
 	return val;							\
 }									\
-EXPORT_SYMBOL(atomic64_fetch_##op);
+EXPORT_SYMBOL(generic_atomic64_fetch_##op);
 
 #define ATOMIC64_OPS(op, c_op)						\
 	ATOMIC64_OP(op, c_op)						\
@@ -130,7 +130,7 @@ ATOMIC64_OPS(xor, ^=)
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
 
-s64 atomic64_dec_if_positive(atomic64_t *v)
+s64 generic_atomic64_dec_if_positive(atomic64_t *v)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -143,9 +143,9 @@ s64 atomic64_dec_if_positive(atomic64_t *v)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_dec_if_positive);
+EXPORT_SYMBOL(generic_atomic64_dec_if_positive);
 
-s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+s64 generic_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -158,9 +158,9 @@ s64 atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_cmpxchg);
+EXPORT_SYMBOL(generic_atomic64_cmpxchg);
 
-s64 atomic64_xchg(atomic64_t *v, s64 new)
+s64 generic_atomic64_xchg(atomic64_t *v, s64 new)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -172,9 +172,9 @@ s64 atomic64_xchg(atomic64_t *v, s64 new)
 	raw_spin_unlock_irqrestore(lock, flags);
 	return val;
 }
-EXPORT_SYMBOL(atomic64_xchg);
+EXPORT_SYMBOL(generic_atomic64_xchg);
 
-s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
+s64 generic_atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	unsigned long flags;
 	raw_spinlock_t *lock = lock_addr(v);
@@ -188,4 +188,4 @@ s64 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 
 	return val;
 }
-EXPORT_SYMBOL(atomic64_fetch_add_unless);
+EXPORT_SYMBOL(generic_atomic64_fetch_add_unless);
-- 
2.11.0

