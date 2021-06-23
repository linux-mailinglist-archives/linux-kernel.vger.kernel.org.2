Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73BD3B19FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFWM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:27:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36882 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhFWM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:26:40 -0400
Message-Id: <20210623121455.102647114@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624451061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9wBiw34fqnD8TdaZ5/jHBJb/NIyHrl/NqcO8/x3KpfU=;
        b=l891rx8a9nWeZ+68JFOMHE7XCDrsrnWukTxTxzyF+e0lNUxhDqsQqRordtStDQMAyOR0Tz
        Yi0ikZ7+wfSDomywjNdv5utHVEXp+O1mRkeasAp0cydnP1WZueFWhwt3UoA9qTeIszoTsc
        9AVSn7AAFHx9pU7iXS4yPz0eRMhL0fKJa6LLfPnTRAhJ/3mcfbhR9i4WeppviXYP+J51Ro
        4rQUD1Zzwj6xS/wTKbUzFnOADhkyFsjseVGRiW/6O652QMtLB4SYH8X2129jmtbts6al2m
        T6ryhU5REA05nqYXCEnEsWJalruJSrhIGiqcJJkfXvgf6pd4yPlKIqZ0Ejl9CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624451061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9wBiw34fqnD8TdaZ5/jHBJb/NIyHrl/NqcO8/x3KpfU=;
        b=Uk6VW5ZILR7zrRIOCqi0TMgNq4fMsUubrTwJG4WFQryhsTDMDDBk9V2pt4zW53v9+2pobC
        4LRDGUUU7jBVdlDQ==
Date:   Wed, 23 Jun 2021 14:02:05 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Chang Seok Bae" <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [patch V4 38/65] x86/pkeys: Move read_pkru() and write_pkru()
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

write_pkru() was originally used just to write to the PKRU register.  It
was mercifully short and sweet and was not out of place in pgtable.h with
some other pkey-related code.

But, later work included a requirement to also modify the task XSAVE
buffer when updating the register.  This really is more related to the
XSAVE architecture than to paging.

Move the read/write_pkru() to asm/pkru.h.  pgtable.h won't miss them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/fpu/xstate.h |    1 
 arch/x86/include/asm/pgtable.h    |   57 -----------------------------------
 arch/x86/include/asm/pkru.h       |   61 ++++++++++++++++++++++++++++++++++++++
 arch/x86/kernel/process_64.c      |    1 
 arch/x86/kvm/svm/sev.c            |    1 
 arch/x86/kvm/x86.c                |    1 
 arch/x86/mm/pkeys.c               |    1 
 7 files changed, 67 insertions(+), 56 deletions(-)

--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/processor.h>
+#include <asm/fpu/api.h>
 #include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -23,7 +23,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
-#include <asm/fpu/xstate.h>
+#include <asm/pkru.h>
 #include <asm/fpu/api.h>
 #include <asm-generic/pgtable_uffd.h>
 
@@ -126,35 +126,6 @@ static inline int pte_dirty(pte_t pte)
 	return pte_flags(pte) & _PAGE_DIRTY;
 }
 
-
-static inline u32 read_pkru(void)
-{
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return rdpkru();
-	return 0;
-}
-
-static inline void write_pkru(u32 pkru)
-{
-	struct pkru_state *pk;
-
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
-	/*
-	 * The PKRU value in xstate needs to be in sync with the value that is
-	 * written to the CPU. The FPU restore on return to userland would
-	 * otherwise load the previous value again.
-	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
-	__write_pkru(pkru);
-	fpregs_unlock();
-}
-
 static inline int pte_young(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_ACCESSED;
@@ -1360,32 +1331,6 @@ static inline pmd_t pmd_swp_clear_uffd_w
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
-#define PKRU_BITS_PER_PKEY 2
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-extern u32 init_pkru_value;
-#else
-#define init_pkru_value	0
-#endif
-
-static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
-{
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
-}
-
-static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
-{
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	/*
-	 * Access-disable disables writes too so we need to check
-	 * both bits here.
-	 */
-	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
-}
-
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
 {
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
--- /dev/null
+++ b/arch/x86/include/asm/pkru.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKRU_H
+#define _ASM_X86_PKRU_H
+
+#include <asm/fpu/xstate.h>
+
+#define PKRU_AD_BIT 0x1
+#define PKRU_WD_BIT 0x2
+#define PKRU_BITS_PER_PKEY 2
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+extern u32 init_pkru_value;
+#else
+#define init_pkru_value	0
+#endif
+
+static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
+{
+	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
+}
+
+static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
+{
+	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	/*
+	 * Access-disable disables writes too so we need to check
+	 * both bits here.
+	 */
+	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
+}
+
+static inline u32 read_pkru(void)
+{
+	if (boot_cpu_has(X86_FEATURE_OSPKE))
+		return rdpkru();
+	return 0;
+}
+
+static inline void write_pkru(u32 pkru)
+{
+	struct pkru_state *pk;
+
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
+
+	/*
+	 * The PKRU value in xstate needs to be in sync with the value that is
+	 * written to the CPU. The FPU restore on return to userland would
+	 * otherwise load the previous value again.
+	 */
+	fpregs_lock();
+	if (pk)
+		pk->pkru = pkru;
+	__write_pkru(pkru);
+	fpregs_unlock();
+}
+
+#endif
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -41,6 +41,7 @@
 #include <linux/syscalls.h>
 
 #include <asm/processor.h>
+#include <asm/pkru.h>
 #include <asm/fpu/internal.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -19,6 +19,7 @@
 #include <linux/trace_events.h>
 #include <asm/fpu/internal.h>
 
+#include <asm/pkru.h>
 #include <asm/trapnr.h>
 
 #include "x86.h"
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -65,6 +65,7 @@
 #include <asm/msr.h>
 #include <asm/desc.h>
 #include <asm/mce.h>
+#include <asm/pkru.h>
 #include <linux/kernel_stat.h>
 #include <asm/fpu/internal.h> /* Ugh! */
 #include <asm/pvclock.h>
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,6 +10,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/pkru.h>			/* read/write_pkru()		*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {

