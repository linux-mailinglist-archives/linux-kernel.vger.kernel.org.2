Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746CB377FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 11:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhEJJqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 05:46:06 -0400
Received: from foss.arm.com ([217.140.110.172]:52498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhEJJqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 05:46:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8F161684;
        Mon, 10 May 2021 02:44:59 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4FC393F73B;
        Mon, 10 May 2021 02:44:55 -0700 (PDT)
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
Subject: [PATCH 33/33] locking/atomics: atomic-instrumented: simplify ifdeffery
Date:   Mon, 10 May 2021 10:37:53 +0100
Message-Id: <20210510093753.40683-34-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210510093753.40683-1-mark.rutland@arm.com>
References: <20210510093753.40683-1-mark.rutland@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all architectures implement ARCH_ATOMIC, the fallbacks are
generated before the instrumented wrappers are generated. Due to this,
in atomic-instrumented.h we can assume that the whole set of atomic
functions has been generated. Likewise, atomic-instrumented.h doesn't
need to provide a preprocessor definition for every atomic it wraps.

This patch removes the redundant ifdeffery.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
---
 include/asm-generic/atomic-instrumented.h | 498 +-----------------------------
 scripts/atomic/gen-atomic-instrumented.sh |  51 +--
 2 files changed, 3 insertions(+), 546 deletions(-)

diff --git a/include/asm-generic/atomic-instrumented.h b/include/asm-generic/atomic-instrumented.h
index 888b6cfeed91..bc45af52c93b 100644
--- a/include/asm-generic/atomic-instrumented.h
+++ b/include/asm-generic/atomic-instrumented.h
@@ -27,17 +27,13 @@ atomic_read(const atomic_t *v)
 	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic_read(v);
 }
-#define atomic_read atomic_read
 
-#if defined(arch_atomic_read_acquire)
 static __always_inline int
 atomic_read_acquire(const atomic_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic_read_acquire(v);
 }
-#define atomic_read_acquire atomic_read_acquire
-#endif
 
 static __always_inline void
 atomic_set(atomic_t *v, int i)
@@ -45,17 +41,13 @@ atomic_set(atomic_t *v, int i)
 	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_set(v, i);
 }
-#define atomic_set atomic_set
 
-#if defined(arch_atomic_set_release)
 static __always_inline void
 atomic_set_release(atomic_t *v, int i)
 {
 	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic_set_release(v, i);
 }
-#define atomic_set_release atomic_set_release
-#endif
 
 static __always_inline void
 atomic_add(int i, atomic_t *v)
@@ -63,87 +55,62 @@ atomic_add(int i, atomic_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_add(i, v);
 }
-#define atomic_add atomic_add
 
-#if !defined(arch_atomic_add_return_relaxed) || defined(arch_atomic_add_return)
 static __always_inline int
 atomic_add_return(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return(i, v);
 }
-#define atomic_add_return atomic_add_return
-#endif
 
-#if defined(arch_atomic_add_return_acquire)
 static __always_inline int
 atomic_add_return_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return_acquire(i, v);
 }
-#define atomic_add_return_acquire atomic_add_return_acquire
-#endif
 
-#if defined(arch_atomic_add_return_release)
 static __always_inline int
 atomic_add_return_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return_release(i, v);
 }
-#define atomic_add_return_release atomic_add_return_release
-#endif
 
-#if defined(arch_atomic_add_return_relaxed)
 static __always_inline int
 atomic_add_return_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_return_relaxed(i, v);
 }
-#define atomic_add_return_relaxed atomic_add_return_relaxed
-#endif
 
-#if !defined(arch_atomic_fetch_add_relaxed) || defined(arch_atomic_fetch_add)
 static __always_inline int
 atomic_fetch_add(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add(i, v);
 }
-#define atomic_fetch_add atomic_fetch_add
-#endif
 
-#if defined(arch_atomic_fetch_add_acquire)
 static __always_inline int
 atomic_fetch_add_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_acquire(i, v);
 }
-#define atomic_fetch_add_acquire atomic_fetch_add_acquire
-#endif
 
-#if defined(arch_atomic_fetch_add_release)
 static __always_inline int
 atomic_fetch_add_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_release(i, v);
 }
-#define atomic_fetch_add_release atomic_fetch_add_release
-#endif
 
-#if defined(arch_atomic_fetch_add_relaxed)
 static __always_inline int
 atomic_fetch_add_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_relaxed(i, v);
 }
-#define atomic_fetch_add_relaxed atomic_fetch_add_relaxed
-#endif
 
 static __always_inline void
 atomic_sub(int i, atomic_t *v)
@@ -151,267 +118,188 @@ atomic_sub(int i, atomic_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_sub(i, v);
 }
-#define atomic_sub atomic_sub
 
-#if !defined(arch_atomic_sub_return_relaxed) || defined(arch_atomic_sub_return)
 static __always_inline int
 atomic_sub_return(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return(i, v);
 }
-#define atomic_sub_return atomic_sub_return
-#endif
 
-#if defined(arch_atomic_sub_return_acquire)
 static __always_inline int
 atomic_sub_return_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return_acquire(i, v);
 }
-#define atomic_sub_return_acquire atomic_sub_return_acquire
-#endif
 
-#if defined(arch_atomic_sub_return_release)
 static __always_inline int
 atomic_sub_return_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return_release(i, v);
 }
-#define atomic_sub_return_release atomic_sub_return_release
-#endif
 
-#if defined(arch_atomic_sub_return_relaxed)
 static __always_inline int
 atomic_sub_return_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_return_relaxed(i, v);
 }
-#define atomic_sub_return_relaxed atomic_sub_return_relaxed
-#endif
 
-#if !defined(arch_atomic_fetch_sub_relaxed) || defined(arch_atomic_fetch_sub)
 static __always_inline int
 atomic_fetch_sub(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub(i, v);
 }
-#define atomic_fetch_sub atomic_fetch_sub
-#endif
 
-#if defined(arch_atomic_fetch_sub_acquire)
 static __always_inline int
 atomic_fetch_sub_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_acquire(i, v);
 }
-#define atomic_fetch_sub_acquire atomic_fetch_sub_acquire
-#endif
 
-#if defined(arch_atomic_fetch_sub_release)
 static __always_inline int
 atomic_fetch_sub_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_release(i, v);
 }
-#define atomic_fetch_sub_release atomic_fetch_sub_release
-#endif
 
-#if defined(arch_atomic_fetch_sub_relaxed)
 static __always_inline int
 atomic_fetch_sub_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_sub_relaxed(i, v);
 }
-#define atomic_fetch_sub_relaxed atomic_fetch_sub_relaxed
-#endif
 
-#if defined(arch_atomic_inc)
 static __always_inline void
 atomic_inc(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_inc(v);
 }
-#define atomic_inc atomic_inc
-#endif
 
-#if defined(arch_atomic_inc_return)
 static __always_inline int
 atomic_inc_return(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return(v);
 }
-#define atomic_inc_return atomic_inc_return
-#endif
 
-#if defined(arch_atomic_inc_return_acquire)
 static __always_inline int
 atomic_inc_return_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return_acquire(v);
 }
-#define atomic_inc_return_acquire atomic_inc_return_acquire
-#endif
 
-#if defined(arch_atomic_inc_return_release)
 static __always_inline int
 atomic_inc_return_release(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return_release(v);
 }
-#define atomic_inc_return_release atomic_inc_return_release
-#endif
 
-#if defined(arch_atomic_inc_return_relaxed)
 static __always_inline int
 atomic_inc_return_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_return_relaxed(v);
 }
-#define atomic_inc_return_relaxed atomic_inc_return_relaxed
-#endif
 
-#if defined(arch_atomic_fetch_inc)
 static __always_inline int
 atomic_fetch_inc(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc(v);
 }
-#define atomic_fetch_inc atomic_fetch_inc
-#endif
 
-#if defined(arch_atomic_fetch_inc_acquire)
 static __always_inline int
 atomic_fetch_inc_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_acquire(v);
 }
-#define atomic_fetch_inc_acquire atomic_fetch_inc_acquire
-#endif
 
-#if defined(arch_atomic_fetch_inc_release)
 static __always_inline int
 atomic_fetch_inc_release(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_release(v);
 }
-#define atomic_fetch_inc_release atomic_fetch_inc_release
-#endif
 
-#if defined(arch_atomic_fetch_inc_relaxed)
 static __always_inline int
 atomic_fetch_inc_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_inc_relaxed(v);
 }
-#define atomic_fetch_inc_relaxed atomic_fetch_inc_relaxed
-#endif
 
-#if defined(arch_atomic_dec)
 static __always_inline void
 atomic_dec(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_dec(v);
 }
-#define atomic_dec atomic_dec
-#endif
 
-#if defined(arch_atomic_dec_return)
 static __always_inline int
 atomic_dec_return(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return(v);
 }
-#define atomic_dec_return atomic_dec_return
-#endif
 
-#if defined(arch_atomic_dec_return_acquire)
 static __always_inline int
 atomic_dec_return_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return_acquire(v);
 }
-#define atomic_dec_return_acquire atomic_dec_return_acquire
-#endif
 
-#if defined(arch_atomic_dec_return_release)
 static __always_inline int
 atomic_dec_return_release(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return_release(v);
 }
-#define atomic_dec_return_release atomic_dec_return_release
-#endif
 
-#if defined(arch_atomic_dec_return_relaxed)
 static __always_inline int
 atomic_dec_return_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_return_relaxed(v);
 }
-#define atomic_dec_return_relaxed atomic_dec_return_relaxed
-#endif
 
-#if defined(arch_atomic_fetch_dec)
 static __always_inline int
 atomic_fetch_dec(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec(v);
 }
-#define atomic_fetch_dec atomic_fetch_dec
-#endif
 
-#if defined(arch_atomic_fetch_dec_acquire)
 static __always_inline int
 atomic_fetch_dec_acquire(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_acquire(v);
 }
-#define atomic_fetch_dec_acquire atomic_fetch_dec_acquire
-#endif
 
-#if defined(arch_atomic_fetch_dec_release)
 static __always_inline int
 atomic_fetch_dec_release(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_release(v);
 }
-#define atomic_fetch_dec_release atomic_fetch_dec_release
-#endif
 
-#if defined(arch_atomic_fetch_dec_relaxed)
 static __always_inline int
 atomic_fetch_dec_relaxed(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_dec_relaxed(v);
 }
-#define atomic_fetch_dec_relaxed atomic_fetch_dec_relaxed
-#endif
 
 static __always_inline void
 atomic_and(int i, atomic_t *v)
@@ -419,97 +307,69 @@ atomic_and(int i, atomic_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_and(i, v);
 }
-#define atomic_and atomic_and
 
-#if !defined(arch_atomic_fetch_and_relaxed) || defined(arch_atomic_fetch_and)
 static __always_inline int
 atomic_fetch_and(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and(i, v);
 }
-#define atomic_fetch_and atomic_fetch_and
-#endif
 
-#if defined(arch_atomic_fetch_and_acquire)
 static __always_inline int
 atomic_fetch_and_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_acquire(i, v);
 }
-#define atomic_fetch_and_acquire atomic_fetch_and_acquire
-#endif
 
-#if defined(arch_atomic_fetch_and_release)
 static __always_inline int
 atomic_fetch_and_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_release(i, v);
 }
-#define atomic_fetch_and_release atomic_fetch_and_release
-#endif
 
-#if defined(arch_atomic_fetch_and_relaxed)
 static __always_inline int
 atomic_fetch_and_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_and_relaxed(i, v);
 }
-#define atomic_fetch_and_relaxed atomic_fetch_and_relaxed
-#endif
 
-#if defined(arch_atomic_andnot)
 static __always_inline void
 atomic_andnot(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_andnot(i, v);
 }
-#define atomic_andnot atomic_andnot
-#endif
 
-#if defined(arch_atomic_fetch_andnot)
 static __always_inline int
 atomic_fetch_andnot(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot(i, v);
 }
-#define atomic_fetch_andnot atomic_fetch_andnot
-#endif
 
-#if defined(arch_atomic_fetch_andnot_acquire)
 static __always_inline int
 atomic_fetch_andnot_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_acquire(i, v);
 }
-#define atomic_fetch_andnot_acquire atomic_fetch_andnot_acquire
-#endif
 
-#if defined(arch_atomic_fetch_andnot_release)
 static __always_inline int
 atomic_fetch_andnot_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_release(i, v);
 }
-#define atomic_fetch_andnot_release atomic_fetch_andnot_release
-#endif
 
-#if defined(arch_atomic_fetch_andnot_relaxed)
 static __always_inline int
 atomic_fetch_andnot_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_andnot_relaxed(i, v);
 }
-#define atomic_fetch_andnot_relaxed atomic_fetch_andnot_relaxed
-#endif
 
 static __always_inline void
 atomic_or(int i, atomic_t *v)
@@ -517,47 +377,34 @@ atomic_or(int i, atomic_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_or(i, v);
 }
-#define atomic_or atomic_or
 
-#if !defined(arch_atomic_fetch_or_relaxed) || defined(arch_atomic_fetch_or)
 static __always_inline int
 atomic_fetch_or(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or(i, v);
 }
-#define atomic_fetch_or atomic_fetch_or
-#endif
 
-#if defined(arch_atomic_fetch_or_acquire)
 static __always_inline int
 atomic_fetch_or_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_acquire(i, v);
 }
-#define atomic_fetch_or_acquire atomic_fetch_or_acquire
-#endif
 
-#if defined(arch_atomic_fetch_or_release)
 static __always_inline int
 atomic_fetch_or_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_release(i, v);
 }
-#define atomic_fetch_or_release atomic_fetch_or_release
-#endif
 
-#if defined(arch_atomic_fetch_or_relaxed)
 static __always_inline int
 atomic_fetch_or_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_or_relaxed(i, v);
 }
-#define atomic_fetch_or_relaxed atomic_fetch_or_relaxed
-#endif
 
 static __always_inline void
 atomic_xor(int i, atomic_t *v)
@@ -565,129 +412,91 @@ atomic_xor(int i, atomic_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic_xor(i, v);
 }
-#define atomic_xor atomic_xor
 
-#if !defined(arch_atomic_fetch_xor_relaxed) || defined(arch_atomic_fetch_xor)
 static __always_inline int
 atomic_fetch_xor(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor(i, v);
 }
-#define atomic_fetch_xor atomic_fetch_xor
-#endif
 
-#if defined(arch_atomic_fetch_xor_acquire)
 static __always_inline int
 atomic_fetch_xor_acquire(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_acquire(i, v);
 }
-#define atomic_fetch_xor_acquire atomic_fetch_xor_acquire
-#endif
 
-#if defined(arch_atomic_fetch_xor_release)
 static __always_inline int
 atomic_fetch_xor_release(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_release(i, v);
 }
-#define atomic_fetch_xor_release atomic_fetch_xor_release
-#endif
 
-#if defined(arch_atomic_fetch_xor_relaxed)
 static __always_inline int
 atomic_fetch_xor_relaxed(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_xor_relaxed(i, v);
 }
-#define atomic_fetch_xor_relaxed atomic_fetch_xor_relaxed
-#endif
 
-#if !defined(arch_atomic_xchg_relaxed) || defined(arch_atomic_xchg)
 static __always_inline int
 atomic_xchg(atomic_t *v, int i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg(v, i);
 }
-#define atomic_xchg atomic_xchg
-#endif
 
-#if defined(arch_atomic_xchg_acquire)
 static __always_inline int
 atomic_xchg_acquire(atomic_t *v, int i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg_acquire(v, i);
 }
-#define atomic_xchg_acquire atomic_xchg_acquire
-#endif
 
-#if defined(arch_atomic_xchg_release)
 static __always_inline int
 atomic_xchg_release(atomic_t *v, int i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg_release(v, i);
 }
-#define atomic_xchg_release atomic_xchg_release
-#endif
 
-#if defined(arch_atomic_xchg_relaxed)
 static __always_inline int
 atomic_xchg_relaxed(atomic_t *v, int i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_xchg_relaxed(v, i);
 }
-#define atomic_xchg_relaxed atomic_xchg_relaxed
-#endif
 
-#if !defined(arch_atomic_cmpxchg_relaxed) || defined(arch_atomic_cmpxchg)
 static __always_inline int
 atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg(v, old, new);
 }
-#define atomic_cmpxchg atomic_cmpxchg
-#endif
 
-#if defined(arch_atomic_cmpxchg_acquire)
 static __always_inline int
 atomic_cmpxchg_acquire(atomic_t *v, int old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_acquire(v, old, new);
 }
-#define atomic_cmpxchg_acquire atomic_cmpxchg_acquire
-#endif
 
-#if defined(arch_atomic_cmpxchg_release)
 static __always_inline int
 atomic_cmpxchg_release(atomic_t *v, int old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_release(v, old, new);
 }
-#define atomic_cmpxchg_release atomic_cmpxchg_release
-#endif
 
-#if defined(arch_atomic_cmpxchg_relaxed)
 static __always_inline int
 atomic_cmpxchg_relaxed(atomic_t *v, int old, int new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_cmpxchg_relaxed(v, old, new);
 }
-#define atomic_cmpxchg_relaxed atomic_cmpxchg_relaxed
-#endif
 
-#if defined(arch_atomic_try_cmpxchg)
 static __always_inline bool
 atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 {
@@ -695,10 +504,7 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg(v, old, new);
 }
-#define atomic_try_cmpxchg atomic_try_cmpxchg
-#endif
 
-#if defined(arch_atomic_try_cmpxchg_acquire)
 static __always_inline bool
 atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 {
@@ -706,10 +512,7 @@ atomic_try_cmpxchg_acquire(atomic_t *v, int *old, int new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_acquire(v, old, new);
 }
-#define atomic_try_cmpxchg_acquire atomic_try_cmpxchg_acquire
-#endif
 
-#if defined(arch_atomic_try_cmpxchg_release)
 static __always_inline bool
 atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 {
@@ -717,10 +520,7 @@ atomic_try_cmpxchg_release(atomic_t *v, int *old, int new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_release(v, old, new);
 }
-#define atomic_try_cmpxchg_release atomic_try_cmpxchg_release
-#endif
 
-#if defined(arch_atomic_try_cmpxchg_relaxed)
 static __always_inline bool
 atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 {
@@ -728,108 +528,76 @@ atomic_try_cmpxchg_relaxed(atomic_t *v, int *old, int new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic_try_cmpxchg_relaxed(v, old, new);
 }
-#define atomic_try_cmpxchg_relaxed atomic_try_cmpxchg_relaxed
-#endif
 
-#if defined(arch_atomic_sub_and_test)
 static __always_inline bool
 atomic_sub_and_test(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_sub_and_test(i, v);
 }
-#define atomic_sub_and_test atomic_sub_and_test
-#endif
 
-#if defined(arch_atomic_dec_and_test)
 static __always_inline bool
 atomic_dec_and_test(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_and_test(v);
 }
-#define atomic_dec_and_test atomic_dec_and_test
-#endif
 
-#if defined(arch_atomic_inc_and_test)
 static __always_inline bool
 atomic_inc_and_test(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_and_test(v);
 }
-#define atomic_inc_and_test atomic_inc_and_test
-#endif
 
-#if defined(arch_atomic_add_negative)
 static __always_inline bool
 atomic_add_negative(int i, atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_negative(i, v);
 }
-#define atomic_add_negative atomic_add_negative
-#endif
 
-#if defined(arch_atomic_fetch_add_unless)
 static __always_inline int
 atomic_fetch_add_unless(atomic_t *v, int a, int u)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_fetch_add_unless(v, a, u);
 }
-#define atomic_fetch_add_unless atomic_fetch_add_unless
-#endif
 
-#if defined(arch_atomic_add_unless)
 static __always_inline bool
 atomic_add_unless(atomic_t *v, int a, int u)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_add_unless(v, a, u);
 }
-#define atomic_add_unless atomic_add_unless
-#endif
 
-#if defined(arch_atomic_inc_not_zero)
 static __always_inline bool
 atomic_inc_not_zero(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_not_zero(v);
 }
-#define atomic_inc_not_zero atomic_inc_not_zero
-#endif
 
-#if defined(arch_atomic_inc_unless_negative)
 static __always_inline bool
 atomic_inc_unless_negative(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_inc_unless_negative(v);
 }
-#define atomic_inc_unless_negative atomic_inc_unless_negative
-#endif
 
-#if defined(arch_atomic_dec_unless_positive)
 static __always_inline bool
 atomic_dec_unless_positive(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_unless_positive(v);
 }
-#define atomic_dec_unless_positive atomic_dec_unless_positive
-#endif
 
-#if defined(arch_atomic_dec_if_positive)
 static __always_inline int
 atomic_dec_if_positive(atomic_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic_dec_if_positive(v);
 }
-#define atomic_dec_if_positive atomic_dec_if_positive
-#endif
 
 static __always_inline s64
 atomic64_read(const atomic64_t *v)
@@ -837,17 +605,13 @@ atomic64_read(const atomic64_t *v)
 	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic64_read(v);
 }
-#define atomic64_read atomic64_read
 
-#if defined(arch_atomic64_read_acquire)
 static __always_inline s64
 atomic64_read_acquire(const atomic64_t *v)
 {
 	instrument_atomic_read(v, sizeof(*v));
 	return arch_atomic64_read_acquire(v);
 }
-#define atomic64_read_acquire atomic64_read_acquire
-#endif
 
 static __always_inline void
 atomic64_set(atomic64_t *v, s64 i)
@@ -855,17 +619,13 @@ atomic64_set(atomic64_t *v, s64 i)
 	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_set(v, i);
 }
-#define atomic64_set atomic64_set
 
-#if defined(arch_atomic64_set_release)
 static __always_inline void
 atomic64_set_release(atomic64_t *v, s64 i)
 {
 	instrument_atomic_write(v, sizeof(*v));
 	arch_atomic64_set_release(v, i);
 }
-#define atomic64_set_release atomic64_set_release
-#endif
 
 static __always_inline void
 atomic64_add(s64 i, atomic64_t *v)
@@ -873,87 +633,62 @@ atomic64_add(s64 i, atomic64_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_add(i, v);
 }
-#define atomic64_add atomic64_add
 
-#if !defined(arch_atomic64_add_return_relaxed) || defined(arch_atomic64_add_return)
 static __always_inline s64
 atomic64_add_return(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return(i, v);
 }
-#define atomic64_add_return atomic64_add_return
-#endif
 
-#if defined(arch_atomic64_add_return_acquire)
 static __always_inline s64
 atomic64_add_return_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return_acquire(i, v);
 }
-#define atomic64_add_return_acquire atomic64_add_return_acquire
-#endif
 
-#if defined(arch_atomic64_add_return_release)
 static __always_inline s64
 atomic64_add_return_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return_release(i, v);
 }
-#define atomic64_add_return_release atomic64_add_return_release
-#endif
 
-#if defined(arch_atomic64_add_return_relaxed)
 static __always_inline s64
 atomic64_add_return_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_return_relaxed(i, v);
 }
-#define atomic64_add_return_relaxed atomic64_add_return_relaxed
-#endif
 
-#if !defined(arch_atomic64_fetch_add_relaxed) || defined(arch_atomic64_fetch_add)
 static __always_inline s64
 atomic64_fetch_add(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add(i, v);
 }
-#define atomic64_fetch_add atomic64_fetch_add
-#endif
 
-#if defined(arch_atomic64_fetch_add_acquire)
 static __always_inline s64
 atomic64_fetch_add_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_acquire(i, v);
 }
-#define atomic64_fetch_add_acquire atomic64_fetch_add_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_add_release)
 static __always_inline s64
 atomic64_fetch_add_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_release(i, v);
 }
-#define atomic64_fetch_add_release atomic64_fetch_add_release
-#endif
 
-#if defined(arch_atomic64_fetch_add_relaxed)
 static __always_inline s64
 atomic64_fetch_add_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_relaxed(i, v);
 }
-#define atomic64_fetch_add_relaxed atomic64_fetch_add_relaxed
-#endif
 
 static __always_inline void
 atomic64_sub(s64 i, atomic64_t *v)
@@ -961,267 +696,188 @@ atomic64_sub(s64 i, atomic64_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_sub(i, v);
 }
-#define atomic64_sub atomic64_sub
 
-#if !defined(arch_atomic64_sub_return_relaxed) || defined(arch_atomic64_sub_return)
 static __always_inline s64
 atomic64_sub_return(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return(i, v);
 }
-#define atomic64_sub_return atomic64_sub_return
-#endif
 
-#if defined(arch_atomic64_sub_return_acquire)
 static __always_inline s64
 atomic64_sub_return_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_acquire(i, v);
 }
-#define atomic64_sub_return_acquire atomic64_sub_return_acquire
-#endif
 
-#if defined(arch_atomic64_sub_return_release)
 static __always_inline s64
 atomic64_sub_return_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_release(i, v);
 }
-#define atomic64_sub_return_release atomic64_sub_return_release
-#endif
 
-#if defined(arch_atomic64_sub_return_relaxed)
 static __always_inline s64
 atomic64_sub_return_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_return_relaxed(i, v);
 }
-#define atomic64_sub_return_relaxed atomic64_sub_return_relaxed
-#endif
 
-#if !defined(arch_atomic64_fetch_sub_relaxed) || defined(arch_atomic64_fetch_sub)
 static __always_inline s64
 atomic64_fetch_sub(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub(i, v);
 }
-#define atomic64_fetch_sub atomic64_fetch_sub
-#endif
 
-#if defined(arch_atomic64_fetch_sub_acquire)
 static __always_inline s64
 atomic64_fetch_sub_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_acquire(i, v);
 }
-#define atomic64_fetch_sub_acquire atomic64_fetch_sub_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_sub_release)
 static __always_inline s64
 atomic64_fetch_sub_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_release(i, v);
 }
-#define atomic64_fetch_sub_release atomic64_fetch_sub_release
-#endif
 
-#if defined(arch_atomic64_fetch_sub_relaxed)
 static __always_inline s64
 atomic64_fetch_sub_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_sub_relaxed(i, v);
 }
-#define atomic64_fetch_sub_relaxed atomic64_fetch_sub_relaxed
-#endif
 
-#if defined(arch_atomic64_inc)
 static __always_inline void
 atomic64_inc(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_inc(v);
 }
-#define atomic64_inc atomic64_inc
-#endif
 
-#if defined(arch_atomic64_inc_return)
 static __always_inline s64
 atomic64_inc_return(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return(v);
 }
-#define atomic64_inc_return atomic64_inc_return
-#endif
 
-#if defined(arch_atomic64_inc_return_acquire)
 static __always_inline s64
 atomic64_inc_return_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_acquire(v);
 }
-#define atomic64_inc_return_acquire atomic64_inc_return_acquire
-#endif
 
-#if defined(arch_atomic64_inc_return_release)
 static __always_inline s64
 atomic64_inc_return_release(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_release(v);
 }
-#define atomic64_inc_return_release atomic64_inc_return_release
-#endif
 
-#if defined(arch_atomic64_inc_return_relaxed)
 static __always_inline s64
 atomic64_inc_return_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_return_relaxed(v);
 }
-#define atomic64_inc_return_relaxed atomic64_inc_return_relaxed
-#endif
 
-#if defined(arch_atomic64_fetch_inc)
 static __always_inline s64
 atomic64_fetch_inc(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc(v);
 }
-#define atomic64_fetch_inc atomic64_fetch_inc
-#endif
 
-#if defined(arch_atomic64_fetch_inc_acquire)
 static __always_inline s64
 atomic64_fetch_inc_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_acquire(v);
 }
-#define atomic64_fetch_inc_acquire atomic64_fetch_inc_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_inc_release)
 static __always_inline s64
 atomic64_fetch_inc_release(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_release(v);
 }
-#define atomic64_fetch_inc_release atomic64_fetch_inc_release
-#endif
 
-#if defined(arch_atomic64_fetch_inc_relaxed)
 static __always_inline s64
 atomic64_fetch_inc_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_inc_relaxed(v);
 }
-#define atomic64_fetch_inc_relaxed atomic64_fetch_inc_relaxed
-#endif
 
-#if defined(arch_atomic64_dec)
 static __always_inline void
 atomic64_dec(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_dec(v);
 }
-#define atomic64_dec atomic64_dec
-#endif
 
-#if defined(arch_atomic64_dec_return)
 static __always_inline s64
 atomic64_dec_return(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return(v);
 }
-#define atomic64_dec_return atomic64_dec_return
-#endif
 
-#if defined(arch_atomic64_dec_return_acquire)
 static __always_inline s64
 atomic64_dec_return_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_acquire(v);
 }
-#define atomic64_dec_return_acquire atomic64_dec_return_acquire
-#endif
 
-#if defined(arch_atomic64_dec_return_release)
 static __always_inline s64
 atomic64_dec_return_release(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_release(v);
 }
-#define atomic64_dec_return_release atomic64_dec_return_release
-#endif
 
-#if defined(arch_atomic64_dec_return_relaxed)
 static __always_inline s64
 atomic64_dec_return_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_return_relaxed(v);
 }
-#define atomic64_dec_return_relaxed atomic64_dec_return_relaxed
-#endif
 
-#if defined(arch_atomic64_fetch_dec)
 static __always_inline s64
 atomic64_fetch_dec(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec(v);
 }
-#define atomic64_fetch_dec atomic64_fetch_dec
-#endif
 
-#if defined(arch_atomic64_fetch_dec_acquire)
 static __always_inline s64
 atomic64_fetch_dec_acquire(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_acquire(v);
 }
-#define atomic64_fetch_dec_acquire atomic64_fetch_dec_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_dec_release)
 static __always_inline s64
 atomic64_fetch_dec_release(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_release(v);
 }
-#define atomic64_fetch_dec_release atomic64_fetch_dec_release
-#endif
 
-#if defined(arch_atomic64_fetch_dec_relaxed)
 static __always_inline s64
 atomic64_fetch_dec_relaxed(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_dec_relaxed(v);
 }
-#define atomic64_fetch_dec_relaxed atomic64_fetch_dec_relaxed
-#endif
 
 static __always_inline void
 atomic64_and(s64 i, atomic64_t *v)
@@ -1229,97 +885,69 @@ atomic64_and(s64 i, atomic64_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_and(i, v);
 }
-#define atomic64_and atomic64_and
 
-#if !defined(arch_atomic64_fetch_and_relaxed) || defined(arch_atomic64_fetch_and)
 static __always_inline s64
 atomic64_fetch_and(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and(i, v);
 }
-#define atomic64_fetch_and atomic64_fetch_and
-#endif
 
-#if defined(arch_atomic64_fetch_and_acquire)
 static __always_inline s64
 atomic64_fetch_and_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_acquire(i, v);
 }
-#define atomic64_fetch_and_acquire atomic64_fetch_and_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_and_release)
 static __always_inline s64
 atomic64_fetch_and_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_release(i, v);
 }
-#define atomic64_fetch_and_release atomic64_fetch_and_release
-#endif
 
-#if defined(arch_atomic64_fetch_and_relaxed)
 static __always_inline s64
 atomic64_fetch_and_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_and_relaxed(i, v);
 }
-#define atomic64_fetch_and_relaxed atomic64_fetch_and_relaxed
-#endif
 
-#if defined(arch_atomic64_andnot)
 static __always_inline void
 atomic64_andnot(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_andnot(i, v);
 }
-#define atomic64_andnot atomic64_andnot
-#endif
 
-#if defined(arch_atomic64_fetch_andnot)
 static __always_inline s64
 atomic64_fetch_andnot(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot(i, v);
 }
-#define atomic64_fetch_andnot atomic64_fetch_andnot
-#endif
 
-#if defined(arch_atomic64_fetch_andnot_acquire)
 static __always_inline s64
 atomic64_fetch_andnot_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_acquire(i, v);
 }
-#define atomic64_fetch_andnot_acquire atomic64_fetch_andnot_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_andnot_release)
 static __always_inline s64
 atomic64_fetch_andnot_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_release(i, v);
 }
-#define atomic64_fetch_andnot_release atomic64_fetch_andnot_release
-#endif
 
-#if defined(arch_atomic64_fetch_andnot_relaxed)
 static __always_inline s64
 atomic64_fetch_andnot_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_andnot_relaxed(i, v);
 }
-#define atomic64_fetch_andnot_relaxed atomic64_fetch_andnot_relaxed
-#endif
 
 static __always_inline void
 atomic64_or(s64 i, atomic64_t *v)
@@ -1327,47 +955,34 @@ atomic64_or(s64 i, atomic64_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_or(i, v);
 }
-#define atomic64_or atomic64_or
 
-#if !defined(arch_atomic64_fetch_or_relaxed) || defined(arch_atomic64_fetch_or)
 static __always_inline s64
 atomic64_fetch_or(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or(i, v);
 }
-#define atomic64_fetch_or atomic64_fetch_or
-#endif
 
-#if defined(arch_atomic64_fetch_or_acquire)
 static __always_inline s64
 atomic64_fetch_or_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_acquire(i, v);
 }
-#define atomic64_fetch_or_acquire atomic64_fetch_or_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_or_release)
 static __always_inline s64
 atomic64_fetch_or_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_release(i, v);
 }
-#define atomic64_fetch_or_release atomic64_fetch_or_release
-#endif
 
-#if defined(arch_atomic64_fetch_or_relaxed)
 static __always_inline s64
 atomic64_fetch_or_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_or_relaxed(i, v);
 }
-#define atomic64_fetch_or_relaxed atomic64_fetch_or_relaxed
-#endif
 
 static __always_inline void
 atomic64_xor(s64 i, atomic64_t *v)
@@ -1375,129 +990,91 @@ atomic64_xor(s64 i, atomic64_t *v)
 	instrument_atomic_read_write(v, sizeof(*v));
 	arch_atomic64_xor(i, v);
 }
-#define atomic64_xor atomic64_xor
 
-#if !defined(arch_atomic64_fetch_xor_relaxed) || defined(arch_atomic64_fetch_xor)
 static __always_inline s64
 atomic64_fetch_xor(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor(i, v);
 }
-#define atomic64_fetch_xor atomic64_fetch_xor
-#endif
 
-#if defined(arch_atomic64_fetch_xor_acquire)
 static __always_inline s64
 atomic64_fetch_xor_acquire(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_acquire(i, v);
 }
-#define atomic64_fetch_xor_acquire atomic64_fetch_xor_acquire
-#endif
 
-#if defined(arch_atomic64_fetch_xor_release)
 static __always_inline s64
 atomic64_fetch_xor_release(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_release(i, v);
 }
-#define atomic64_fetch_xor_release atomic64_fetch_xor_release
-#endif
 
-#if defined(arch_atomic64_fetch_xor_relaxed)
 static __always_inline s64
 atomic64_fetch_xor_relaxed(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_xor_relaxed(i, v);
 }
-#define atomic64_fetch_xor_relaxed atomic64_fetch_xor_relaxed
-#endif
 
-#if !defined(arch_atomic64_xchg_relaxed) || defined(arch_atomic64_xchg)
 static __always_inline s64
 atomic64_xchg(atomic64_t *v, s64 i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg(v, i);
 }
-#define atomic64_xchg atomic64_xchg
-#endif
 
-#if defined(arch_atomic64_xchg_acquire)
 static __always_inline s64
 atomic64_xchg_acquire(atomic64_t *v, s64 i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg_acquire(v, i);
 }
-#define atomic64_xchg_acquire atomic64_xchg_acquire
-#endif
 
-#if defined(arch_atomic64_xchg_release)
 static __always_inline s64
 atomic64_xchg_release(atomic64_t *v, s64 i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg_release(v, i);
 }
-#define atomic64_xchg_release atomic64_xchg_release
-#endif
 
-#if defined(arch_atomic64_xchg_relaxed)
 static __always_inline s64
 atomic64_xchg_relaxed(atomic64_t *v, s64 i)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_xchg_relaxed(v, i);
 }
-#define atomic64_xchg_relaxed atomic64_xchg_relaxed
-#endif
 
-#if !defined(arch_atomic64_cmpxchg_relaxed) || defined(arch_atomic64_cmpxchg)
 static __always_inline s64
 atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg(v, old, new);
 }
-#define atomic64_cmpxchg atomic64_cmpxchg
-#endif
 
-#if defined(arch_atomic64_cmpxchg_acquire)
 static __always_inline s64
 atomic64_cmpxchg_acquire(atomic64_t *v, s64 old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_acquire(v, old, new);
 }
-#define atomic64_cmpxchg_acquire atomic64_cmpxchg_acquire
-#endif
 
-#if defined(arch_atomic64_cmpxchg_release)
 static __always_inline s64
 atomic64_cmpxchg_release(atomic64_t *v, s64 old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_release(v, old, new);
 }
-#define atomic64_cmpxchg_release atomic64_cmpxchg_release
-#endif
 
-#if defined(arch_atomic64_cmpxchg_relaxed)
 static __always_inline s64
 atomic64_cmpxchg_relaxed(atomic64_t *v, s64 old, s64 new)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_cmpxchg_relaxed(v, old, new);
 }
-#define atomic64_cmpxchg_relaxed atomic64_cmpxchg_relaxed
-#endif
 
-#if defined(arch_atomic64_try_cmpxchg)
 static __always_inline bool
 atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1505,10 +1082,7 @@ atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg(v, old, new);
 }
-#define atomic64_try_cmpxchg atomic64_try_cmpxchg
-#endif
 
-#if defined(arch_atomic64_try_cmpxchg_acquire)
 static __always_inline bool
 atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1516,10 +1090,7 @@ atomic64_try_cmpxchg_acquire(atomic64_t *v, s64 *old, s64 new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_acquire(v, old, new);
 }
-#define atomic64_try_cmpxchg_acquire atomic64_try_cmpxchg_acquire
-#endif
 
-#if defined(arch_atomic64_try_cmpxchg_release)
 static __always_inline bool
 atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1527,10 +1098,7 @@ atomic64_try_cmpxchg_release(atomic64_t *v, s64 *old, s64 new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_release(v, old, new);
 }
-#define atomic64_try_cmpxchg_release atomic64_try_cmpxchg_release
-#endif
 
-#if defined(arch_atomic64_try_cmpxchg_relaxed)
 static __always_inline bool
 atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 {
@@ -1538,218 +1106,161 @@ atomic64_try_cmpxchg_relaxed(atomic64_t *v, s64 *old, s64 new)
 	instrument_atomic_read_write(old, sizeof(*old));
 	return arch_atomic64_try_cmpxchg_relaxed(v, old, new);
 }
-#define atomic64_try_cmpxchg_relaxed atomic64_try_cmpxchg_relaxed
-#endif
 
-#if defined(arch_atomic64_sub_and_test)
 static __always_inline bool
 atomic64_sub_and_test(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_sub_and_test(i, v);
 }
-#define atomic64_sub_and_test atomic64_sub_and_test
-#endif
 
-#if defined(arch_atomic64_dec_and_test)
 static __always_inline bool
 atomic64_dec_and_test(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_and_test(v);
 }
-#define atomic64_dec_and_test atomic64_dec_and_test
-#endif
 
-#if defined(arch_atomic64_inc_and_test)
 static __always_inline bool
 atomic64_inc_and_test(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_and_test(v);
 }
-#define atomic64_inc_and_test atomic64_inc_and_test
-#endif
 
-#if defined(arch_atomic64_add_negative)
 static __always_inline bool
 atomic64_add_negative(s64 i, atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_negative(i, v);
 }
-#define atomic64_add_negative atomic64_add_negative
-#endif
 
-#if defined(arch_atomic64_fetch_add_unless)
 static __always_inline s64
 atomic64_fetch_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_fetch_add_unless(v, a, u);
 }
-#define atomic64_fetch_add_unless atomic64_fetch_add_unless
-#endif
 
-#if defined(arch_atomic64_add_unless)
 static __always_inline bool
 atomic64_add_unless(atomic64_t *v, s64 a, s64 u)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_add_unless(v, a, u);
 }
-#define atomic64_add_unless atomic64_add_unless
-#endif
 
-#if defined(arch_atomic64_inc_not_zero)
 static __always_inline bool
 atomic64_inc_not_zero(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_not_zero(v);
 }
-#define atomic64_inc_not_zero atomic64_inc_not_zero
-#endif
 
-#if defined(arch_atomic64_inc_unless_negative)
 static __always_inline bool
 atomic64_inc_unless_negative(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_inc_unless_negative(v);
 }
-#define atomic64_inc_unless_negative atomic64_inc_unless_negative
-#endif
 
-#if defined(arch_atomic64_dec_unless_positive)
 static __always_inline bool
 atomic64_dec_unless_positive(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_unless_positive(v);
 }
-#define atomic64_dec_unless_positive atomic64_dec_unless_positive
-#endif
 
-#if defined(arch_atomic64_dec_if_positive)
 static __always_inline s64
 atomic64_dec_if_positive(atomic64_t *v)
 {
 	instrument_atomic_read_write(v, sizeof(*v));
 	return arch_atomic64_dec_if_positive(v);
 }
-#define atomic64_dec_if_positive atomic64_dec_if_positive
-#endif
 
-#if !defined(arch_xchg_relaxed) || defined(arch_xchg)
 #define xchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_xchg_acquire)
 #define xchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_xchg_release)
 #define xchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_release(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_xchg_relaxed)
 #define xchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_xchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if !defined(arch_cmpxchg_relaxed) || defined(arch_cmpxchg)
 #define cmpxchg(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_cmpxchg_acquire)
 #define cmpxchg_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_acquire(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_cmpxchg_release)
 #define cmpxchg_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_release(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_cmpxchg_relaxed)
 #define cmpxchg_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg_relaxed(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if !defined(arch_cmpxchg64_relaxed) || defined(arch_cmpxchg64)
 #define cmpxchg64(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_cmpxchg64_acquire)
 #define cmpxchg64_acquire(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_acquire(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_cmpxchg64_release)
 #define cmpxchg64_release(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_release(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_cmpxchg64_relaxed)
 #define cmpxchg64_relaxed(ptr, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
 	instrument_atomic_write(__ai_ptr, sizeof(*__ai_ptr)); \
 	arch_cmpxchg64_relaxed(__ai_ptr, __VA_ARGS__); \
 })
-#endif
 
-#if !defined(arch_try_cmpxchg_relaxed) || defined(arch_try_cmpxchg)
 #define try_cmpxchg(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1758,9 +1269,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_try_cmpxchg_acquire)
 #define try_cmpxchg_acquire(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1769,9 +1278,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_acquire(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_try_cmpxchg_release)
 #define try_cmpxchg_release(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1780,9 +1287,7 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_release(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
-#endif
 
-#if defined(arch_try_cmpxchg_relaxed)
 #define try_cmpxchg_relaxed(ptr, oldp, ...) \
 ({ \
 	typeof(ptr) __ai_ptr = (ptr); \
@@ -1791,7 +1296,6 @@ atomic64_dec_if_positive(atomic64_t *v)
 	instrument_atomic_write(__ai_oldp, sizeof(*__ai_oldp)); \
 	arch_try_cmpxchg_relaxed(__ai_ptr, __ai_oldp, __VA_ARGS__); \
 })
-#endif
 
 #define cmpxchg_local(ptr, ...) \
 ({ \
@@ -1830,4 +1334,4 @@ atomic64_dec_if_positive(atomic64_t *v)
 })
 
 #endif /* _ASM_GENERIC_ATOMIC_INSTRUMENTED_H */
-// 4bec382e44520f4d8267e42620054db26a659ea3
+// 1d7c3a25aca5c7fb031c307be4c3d24c7b48fcd5
diff --git a/scripts/atomic/gen-atomic-instrumented.sh b/scripts/atomic/gen-atomic-instrumented.sh
index 5766ffcec7c5..b0c45aee19d7 100755
--- a/scripts/atomic/gen-atomic-instrumented.sh
+++ b/scripts/atomic/gen-atomic-instrumented.sh
@@ -41,34 +41,6 @@ gen_params_checks()
 	done
 }
 
-# gen_guard(meta, atomic, pfx, name, sfx, order)
-gen_guard()
-{
-	local meta="$1"; shift
-	local atomic="$1"; shift
-	local pfx="$1"; shift
-	local name="$1"; shift
-	local sfx="$1"; shift
-	local order="$1"; shift
-
-	local atomicname="arch_${atomic}_${pfx}${name}${sfx}${order}"
-
-	local template="$(find_fallback_template "${pfx}" "${name}" "${sfx}" "${order}")"
-
-	# We definitely need a preprocessor symbol for this atomic if it is an
-	# ordering variant, or if there's a generic fallback.
-	if [ ! -z "${order}" ] || [ ! -z "${template}" ]; then
-		printf "defined(${atomicname})"
-		return
-	fi
-
-	# If this is a base variant, but a relaxed variant *may* exist, then we
-	# only have a preprocessor symbol if the relaxed variant isn't defined
-	if meta_has_relaxed "${meta}"; then
-		printf "!defined(${atomicname}_relaxed) || defined(${atomicname})"
-	fi
-}
-
 #gen_proto_order_variant(meta, pfx, name, sfx, order, atomic, int, arg...)
 gen_proto_order_variant()
 {
@@ -82,16 +54,12 @@ gen_proto_order_variant()
 
 	local atomicname="${atomic}_${pfx}${name}${sfx}${order}"
 
-	local guard="$(gen_guard "${meta}" "${atomic}" "${pfx}" "${name}" "${sfx}" "${order}")"
-
 	local ret="$(gen_ret_type "${meta}" "${int}")"
 	local params="$(gen_params "${int}" "${atomic}" "$@")"
 	local checks="$(gen_params_checks "${meta}" "$@")"
 	local args="$(gen_args "$@")"
 	local retstmt="$(gen_ret_stmt "${meta}")"
 
-	[ ! -z "${guard}" ] && printf "#if ${guard}\n"
-
 cat <<EOF
 static __always_inline ${ret}
 ${atomicname}(${params})
@@ -99,11 +67,8 @@ ${atomicname}(${params})
 ${checks}
 	${retstmt}arch_${atomicname}(${args});
 }
-#define ${atomicname} ${atomicname}
 EOF
 
-	[ ! -z "${guard}" ] && printf "#endif\n"
-
 	printf "\n"
 }
 
@@ -139,19 +104,6 @@ EOF
 	fi
 }
 
-gen_optional_xchg()
-{
-	local name="$1"; shift
-	local sfx="$1"; shift
-	local guard="defined(arch_${name}${sfx})"
-
-	[ -z "${sfx}" ] && guard="!defined(arch_${name}_relaxed) || defined(arch_${name})"
-
-	printf "#if ${guard}\n"
-	gen_xchg "${name}${sfx}" ""
-	printf "#endif\n\n"
-}
-
 cat << EOF
 // SPDX-License-Identifier: GPL-2.0
 
@@ -188,7 +140,8 @@ done
 
 for xchg in "xchg" "cmpxchg" "cmpxchg64" "try_cmpxchg"; do
 	for order in "" "_acquire" "_release" "_relaxed"; do
-		gen_optional_xchg "${xchg}" "${order}"
+		gen_xchg "${xchg}${order}" ""
+		printf "\n"
 	done
 done
 
-- 
2.11.0

