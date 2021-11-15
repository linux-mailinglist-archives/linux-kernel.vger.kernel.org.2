Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E757B450A39
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhKOQ54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 11:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhKOQ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 11:57:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8624C061714
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 08:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eDF+PT/lT22ezS73apcdD8wnw6ClAL+truZnktg303A=; b=dUIsrp6v9c0JNNeGch4qU6C542
        CuYNGENmu1zvcyd+FeePCLxITLrEiH+F06PVdCT4T/n+aIfmuNhPbfd2e+l3/NXZZeVLp+/I8LGtn
        YzzJMkX6fDFh3N/wuShAbBJ3YFe0CLyIsDpTrXDxzo+3a5ziTM6xG8QW7sJjQ0TEgoXXe1XIpwttx
        6P2mkOiqC5jjyZ53jwW0bmmWERlAy3tsCdaPUoq9Kf9OWVjFbPl5wxmlNXbPPyQZkCpXar1WNRggT
        OuLhig5RNKvZ4xAkB1Qf733KI77BgKBYjHQzu58K4qRV8IyJW76VtRUyKeqeLI5VmX/Op8kvjW4Yj
        pcNBq9ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmfFd-00GAjb-NS; Mon, 15 Nov 2021 16:54:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2BD92300129;
        Mon, 15 Nov 2021 17:54:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EA7F20BE2263; Mon, 15 Nov 2021 17:54:37 +0100 (CET)
Date:   Mon, 15 Nov 2021 17:54:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.orgg
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        mark.rutland@arm.com, dvyukov@google.com, seanjc@google.com,
        pbonzini@redhat.com, mbenes@suse.cz
Subject: [PATCH v2.1 02/23] x86/mmx_32: Remove X86_USE_3DNOW
Message-ID: <YZKQzUmeNuwyvZpk@hirez.programming.kicks-ass.net>
References: <20211110100102.250793167@infradead.org>
 <20211110101325.009464367@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110101325.009464367@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



The alternative (har har) for this patch is the below, which seems
favoured by Boris.

---
Subject: x86/mmx_32: Remove X86_USE_3DNOW
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 15 17:46:39 CET 2021

This code puts an exception table entry on the PREFETCH instruction to
overwrite it with a JMP.d8 when it triggers an exception. Except of
course, our code is no longer writable, also SMP.

Instead of fixing this broken mess, simply take it out.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig                               |    2 
 arch/x86/Kconfig.cpu                           |    4 
 arch/x86/include/asm/mmx.h                     |   15 
 arch/x86/include/asm/page_32.h                 |   14 
 arch/x86/include/asm/required-features.h       |    4 
 arch/x86/include/asm/string_32.h               |   33 --
 arch/x86/lib/Makefile                          |    1 
 arch/x86/lib/memcpy_32.c                       |    4 
 arch/x86/lib/mmx_32.c                          |  388 -------------------------
 arch/x86/lib/usercopy_32.c                     |    1 
 tools/arch/x86/include/asm/required-features.h |    4 
 11 files changed, 1 insertion(+), 469 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1945,7 +1945,7 @@ config EFI
 
 config EFI_STUB
 	bool "EFI stub support"
-	depends on EFI && !X86_USE_3DNOW
+	depends on EFI
 	depends on $(cc-option,-mabi=ms) || X86_32
 	select RELOCATABLE
 	help
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -342,10 +342,6 @@ config X86_USE_PPRO_CHECKSUM
 	def_bool y
 	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
 
-config X86_USE_3DNOW
-	def_bool y
-	depends on (MCYRIXIII || MK7 || MGEODE_LX) && !UML
-
 #
 # P6_NOPs are a relatively minor optimization that require a family >=
 # 6 processor, except that it is broken on certain VIA chips.
--- a/arch/x86/include/asm/mmx.h
+++ b/arch/x86/include/asm/mmx.h
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_MMX_H
-#define _ASM_X86_MMX_H
-
-/*
- *	MMX 3Dnow! helper operations
- */
-
-#include <linux/types.h>
-
-extern void *_mmx_memcpy(void *to, const void *from, size_t size);
-extern void mmx_clear_page(void *page);
-extern void mmx_copy_page(void *to, void *from);
-
-#endif /* _ASM_X86_MMX_H */
--- a/arch/x86/include/asm/page_32.h
+++ b/arch/x86/include/asm/page_32.h
@@ -19,19 +19,6 @@ extern unsigned long __phys_addr(unsigne
 #define pfn_valid(pfn)		((pfn) < max_mapnr)
 #endif /* CONFIG_FLATMEM */
 
-#ifdef CONFIG_X86_USE_3DNOW
-#include <asm/mmx.h>
-
-static inline void clear_page(void *page)
-{
-	mmx_clear_page(page);
-}
-
-static inline void copy_page(void *to, void *from)
-{
-	mmx_copy_page(to, from);
-}
-#else  /* !CONFIG_X86_USE_3DNOW */
 #include <linux/string.h>
 
 static inline void clear_page(void *page)
@@ -43,7 +30,6 @@ static inline void copy_page(void *to, v
 {
 	memcpy(to, from, PAGE_SIZE);
 }
-#endif	/* CONFIG_X86_USE_3DNOW */
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_PAGE_32_H */
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -35,11 +35,7 @@
 # define NEED_CMOV	0
 #endif
 
-#ifdef CONFIG_X86_USE_3DNOW
-# define NEED_3DNOW	(1<<(X86_FEATURE_3DNOW & 31))
-#else
 # define NEED_3DNOW	0
-#endif
 
 #if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
 # define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -146,42 +146,9 @@ static __always_inline void *__constant_
 extern void *memcpy(void *, const void *, size_t);
 
 #ifndef CONFIG_FORTIFY_SOURCE
-#ifdef CONFIG_X86_USE_3DNOW
-
-#include <asm/mmx.h>
-
-/*
- *	This CPU favours 3DNow strongly (eg AMD Athlon)
- */
-
-static inline void *__constant_memcpy3d(void *to, const void *from, size_t len)
-{
-	if (len < 512)
-		return __constant_memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
-}
-
-static inline void *__memcpy3d(void *to, const void *from, size_t len)
-{
-	if (len < 512)
-		return __memcpy(to, from, len);
-	return _mmx_memcpy(to, from, len);
-}
-
-#define memcpy(t, f, n)				\
-	(__builtin_constant_p((n))		\
-	 ? __constant_memcpy3d((t), (f), (n))	\
-	 : __memcpy3d((t), (f), (n)))
-
-#else
-
-/*
- *	No 3D Now!
- */
 
 #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
 
-#endif
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
 #define __HAVE_ARCH_MEMMOVE
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -63,7 +63,6 @@ ifeq ($(CONFIG_X86_32),y)
 ifneq ($(CONFIG_X86_CMPXCHG64),y)
         lib-y += cmpxchg8b_emu.o atomic64_386_32.o
 endif
-        lib-$(CONFIG_X86_USE_3DNOW) += mmx_32.o
 else
         obj-y += iomap_copy_64.o
         lib-y += csum-partial_64.o csum-copy_64.o csum-wrappers_64.o
--- a/arch/x86/lib/memcpy_32.c
+++ b/arch/x86/lib/memcpy_32.c
@@ -7,11 +7,7 @@
 
 __visible void *memcpy(void *to, const void *from, size_t n)
 {
-#if defined(CONFIG_X86_USE_3DNOW) && !defined(CONFIG_FORTIFY_SOURCE)
-	return __memcpy3d(to, from, n);
-#else
 	return __memcpy(to, from, n);
-#endif
 }
 EXPORT_SYMBOL(memcpy);
 
--- a/arch/x86/lib/mmx_32.c
+++ b/arch/x86/lib/mmx_32.c
@@ -1,388 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- *	MMX 3DNow! library helper functions
- *
- *	To do:
- *	We can use MMX just for prefetch in IRQ's. This may be a win.
- *		(reported so on K6-III)
- *	We should use a better code neutral filler for the short jump
- *		leal ebx. [ebx] is apparently best for K6-2, but Cyrix ??
- *	We also want to clobber the filler register so we don't get any
- *		register forwarding stalls on the filler.
- *
- *	Add *user handling. Checksums are not a win with MMX on any CPU
- *	tested so far for any MMX solution figured.
- *
- *	22/09/2000 - Arjan van de Ven
- *		Improved for non-engineering-sample Athlons
- *
- */
-#include <linux/hardirq.h>
-#include <linux/string.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <linux/types.h>
-
-#include <asm/fpu/api.h>
-#include <asm/asm.h>
-
-/*
- * Use KFPU_387.  MMX instructions are not affected by MXCSR,
- * but both AMD and Intel documentation states that even integer MMX
- * operations will result in #MF if an exception is pending in FCW.
- *
- * EMMS is not needed afterwards because, after calling kernel_fpu_end(),
- * any subsequent user of the 387 stack will reinitialize it using
- * KFPU_387.
- */
-
-void *_mmx_memcpy(void *to, const void *from, size_t len)
-{
-	void *p;
-	int i;
-
-	if (unlikely(in_interrupt()))
-		return __memcpy(to, from, len);
-
-	p = to;
-	i = len >> 6; /* len/64 */
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"		/* This set is 28 bytes */
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from));
-
-	for ( ; i > 5; i--) {
-		__asm__ __volatile__ (
-		"1:  prefetch 320(%0)\n"
-		"2:  movq (%0), %%mm0\n"
-		"  movq 8(%0), %%mm1\n"
-		"  movq 16(%0), %%mm2\n"
-		"  movq 24(%0), %%mm3\n"
-		"  movq %%mm0, (%1)\n"
-		"  movq %%mm1, 8(%1)\n"
-		"  movq %%mm2, 16(%1)\n"
-		"  movq %%mm3, 24(%1)\n"
-		"  movq 32(%0), %%mm0\n"
-		"  movq 40(%0), %%mm1\n"
-		"  movq 48(%0), %%mm2\n"
-		"  movq 56(%0), %%mm3\n"
-		"  movq %%mm0, 32(%1)\n"
-		"  movq %%mm1, 40(%1)\n"
-		"  movq %%mm2, 48(%1)\n"
-		"  movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-
-	for ( ; i > 0; i--) {
-		__asm__ __volatile__ (
-		"  movq (%0), %%mm0\n"
-		"  movq 8(%0), %%mm1\n"
-		"  movq 16(%0), %%mm2\n"
-		"  movq 24(%0), %%mm3\n"
-		"  movq %%mm0, (%1)\n"
-		"  movq %%mm1, 8(%1)\n"
-		"  movq %%mm2, 16(%1)\n"
-		"  movq %%mm3, 24(%1)\n"
-		"  movq 32(%0), %%mm0\n"
-		"  movq 40(%0), %%mm1\n"
-		"  movq 48(%0), %%mm2\n"
-		"  movq 56(%0), %%mm3\n"
-		"  movq %%mm0, 32(%1)\n"
-		"  movq %%mm1, 40(%1)\n"
-		"  movq %%mm2, 48(%1)\n"
-		"  movq %%mm3, 56(%1)\n"
-			: : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-	/*
-	 * Now do the tail of the block:
-	 */
-	__memcpy(to, from, len & 63);
-	kernel_fpu_end();
-
-	return p;
-}
-EXPORT_SYMBOL(_mmx_memcpy);
-
-#ifdef CONFIG_MK7
-
-/*
- *	The K7 has streaming cache bypass load/store. The Cyrix III, K6 and
- *	other MMX using processors do not.
- */
-
-static void fast_clear_page(void *page)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for (i = 0; i < 4096/64; i++) {
-		__asm__ __volatile__ (
-		"  movntq %%mm0, (%0)\n"
-		"  movntq %%mm0, 8(%0)\n"
-		"  movntq %%mm0, 16(%0)\n"
-		"  movntq %%mm0, 24(%0)\n"
-		"  movntq %%mm0, 32(%0)\n"
-		"  movntq %%mm0, 40(%0)\n"
-		"  movntq %%mm0, 48(%0)\n"
-		"  movntq %%mm0, 56(%0)\n"
-		: : "r" (page) : "memory");
-		page += 64;
-	}
-
-	/*
-	 * Since movntq is weakly-ordered, a "sfence" is needed to become
-	 * ordered again:
-	 */
-	__asm__ __volatile__("sfence\n"::);
-
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	/*
-	 * maybe the prefetch stuff can go before the expensive fnsave...
-	 * but that is for later. -AV
-	 */
-	__asm__ __volatile__(
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b) : : "r" (from));
-
-	for (i = 0; i < (4096-320)/64; i++) {
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movntq %%mm0, (%1)\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movntq %%mm1, 8(%1)\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movntq %%mm2, 16(%1)\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movntq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm4\n"
-		"   movntq %%mm4, 32(%1)\n"
-		"   movq 40(%0), %%mm5\n"
-		"   movntq %%mm5, 40(%1)\n"
-		"   movq 48(%0), %%mm6\n"
-		"   movntq %%mm6, 48(%1)\n"
-		"   movq 56(%0), %%mm7\n"
-		"   movntq %%mm7, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-		_ASM_EXTABLE(1b, 3b) : : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-
-	for (i = (4096-320)/64; i < 4096/64; i++) {
-		__asm__ __volatile__ (
-		"2: movq (%0), %%mm0\n"
-		"   movntq %%mm0, (%1)\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movntq %%mm1, 8(%1)\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movntq %%mm2, 16(%1)\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movntq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm4\n"
-		"   movntq %%mm4, 32(%1)\n"
-		"   movq 40(%0), %%mm5\n"
-		"   movntq %%mm5, 40(%1)\n"
-		"   movq 48(%0), %%mm6\n"
-		"   movntq %%mm6, 48(%1)\n"
-		"   movq 56(%0), %%mm7\n"
-		"   movntq %%mm7, 56(%1)\n"
-			: : "r" (from), "r" (to) : "memory");
-		from += 64;
-		to += 64;
-	}
-	/*
-	 * Since movntq is weakly-ordered, a "sfence" is needed to become
-	 * ordered again:
-	 */
-	__asm__ __volatile__("sfence \n"::);
-	kernel_fpu_end();
-}
-
-#else /* CONFIG_MK7 */
-
-/*
- *	Generic MMX implementation without K7 specific streaming
- */
-static void fast_clear_page(void *page)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"  pxor %%mm0, %%mm0\n" : :
-	);
-
-	for (i = 0; i < 4096/128; i++) {
-		__asm__ __volatile__ (
-		"  movq %%mm0, (%0)\n"
-		"  movq %%mm0, 8(%0)\n"
-		"  movq %%mm0, 16(%0)\n"
-		"  movq %%mm0, 24(%0)\n"
-		"  movq %%mm0, 32(%0)\n"
-		"  movq %%mm0, 40(%0)\n"
-		"  movq %%mm0, 48(%0)\n"
-		"  movq %%mm0, 56(%0)\n"
-		"  movq %%mm0, 64(%0)\n"
-		"  movq %%mm0, 72(%0)\n"
-		"  movq %%mm0, 80(%0)\n"
-		"  movq %%mm0, 88(%0)\n"
-		"  movq %%mm0, 96(%0)\n"
-		"  movq %%mm0, 104(%0)\n"
-		"  movq %%mm0, 112(%0)\n"
-		"  movq %%mm0, 120(%0)\n"
-			: : "r" (page) : "memory");
-		page += 128;
-	}
-
-	kernel_fpu_end();
-}
-
-static void fast_copy_page(void *to, void *from)
-{
-	int i;
-
-	kernel_fpu_begin_mask(KFPU_387);
-
-	__asm__ __volatile__ (
-		"1: prefetch (%0)\n"
-		"   prefetch 64(%0)\n"
-		"   prefetch 128(%0)\n"
-		"   prefetch 192(%0)\n"
-		"   prefetch 256(%0)\n"
-		"2:  \n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x1AEB, 1b\n"	/* jmp on 26 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b) : : "r" (from));
-
-	for (i = 0; i < 4096/64; i++) {
-		__asm__ __volatile__ (
-		"1: prefetch 320(%0)\n"
-		"2: movq (%0), %%mm0\n"
-		"   movq 8(%0), %%mm1\n"
-		"   movq 16(%0), %%mm2\n"
-		"   movq 24(%0), %%mm3\n"
-		"   movq %%mm0, (%1)\n"
-		"   movq %%mm1, 8(%1)\n"
-		"   movq %%mm2, 16(%1)\n"
-		"   movq %%mm3, 24(%1)\n"
-		"   movq 32(%0), %%mm0\n"
-		"   movq 40(%0), %%mm1\n"
-		"   movq 48(%0), %%mm2\n"
-		"   movq 56(%0), %%mm3\n"
-		"   movq %%mm0, 32(%1)\n"
-		"   movq %%mm1, 40(%1)\n"
-		"   movq %%mm2, 48(%1)\n"
-		"   movq %%mm3, 56(%1)\n"
-		".section .fixup, \"ax\"\n"
-		"3: movw $0x05EB, 1b\n"	/* jmp on 5 bytes */
-		"   jmp 2b\n"
-		".previous\n"
-			_ASM_EXTABLE(1b, 3b)
-			: : "r" (from), "r" (to) : "memory");
-
-		from += 64;
-		to += 64;
-	}
-	kernel_fpu_end();
-}
-
-#endif /* !CONFIG_MK7 */
-
-/*
- * Favour MMX for page clear and copy:
- */
-static void slow_zero_page(void *page)
-{
-	int d0, d1;
-
-	__asm__ __volatile__(
-		"cld\n\t"
-		"rep ; stosl"
-
-			: "=&c" (d0), "=&D" (d1)
-			:"a" (0), "1" (page), "0" (1024)
-			:"memory");
-}
-
-void mmx_clear_page(void *page)
-{
-	if (unlikely(in_interrupt()))
-		slow_zero_page(page);
-	else
-		fast_clear_page(page);
-}
-EXPORT_SYMBOL(mmx_clear_page);
-
-static void slow_copy_page(void *to, void *from)
-{
-	int d0, d1, d2;
-
-	__asm__ __volatile__(
-		"cld\n\t"
-		"rep ; movsl"
-		: "=&c" (d0), "=&D" (d1), "=&S" (d2)
-		: "0" (1024), "1" ((long) to), "2" ((long) from)
-		: "memory");
-}
-
-void mmx_copy_page(void *to, void *from)
-{
-	if (unlikely(in_interrupt()))
-		slow_copy_page(to, from);
-	else
-		fast_copy_page(to, from);
-}
-EXPORT_SYMBOL(mmx_copy_page);
--- a/arch/x86/lib/usercopy_32.c
+++ b/arch/x86/lib/usercopy_32.c
@@ -8,7 +8,6 @@
  */
 #include <linux/export.h>
 #include <linux/uaccess.h>
-#include <asm/mmx.h>
 #include <asm/asm.h>
 
 #ifdef CONFIG_X86_INTEL_USERCOPY
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -35,11 +35,7 @@
 # define NEED_CMOV	0
 #endif
 
-#ifdef CONFIG_X86_USE_3DNOW
-# define NEED_3DNOW	(1<<(X86_FEATURE_3DNOW & 31))
-#else
 # define NEED_3DNOW	0
-#endif
 
 #if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
 # define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
