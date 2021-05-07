Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8433767FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbhEGPbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237859AbhEGPbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:31:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7253C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 08:30:41 -0700 (PDT)
Message-Id: <20210507114000.569244755@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620401440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lC6LfVWZK++IU363drNYkNe2lv699M+/bta+s+tjMw8=;
        b=YWd2G10sIkPqHBob5v4Bp+/eWOktQovvZybNFzg2pa46Xk0edj+qEPMJexd1jpQzjuqpcv
        I2dMjRmr2MssYf2UscYl4HVxAr+bOIemCo5eSN9RVgIHxwXAygNYJeViOmpRhSuwZlOap0
        cuxeHnsGzUXQkNQ4dOhyknFhs+z1kVVmSLkOaZL0nW9JDO32/DUXigLmN2U6LC1CbbP5gE
        5iAq55sL+wJMZvw4hfs3WR4NK4nHM2Kxi8fEZJeTWpCvJf+b8dHoecvtQkk5eMNt/DDj6L
        cJkAyHwGd2NL4JEkunjlCH2txn7KYWJN7ABOL6V7mvQNk1GDmLrAW97pekGksg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620401440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lC6LfVWZK++IU363drNYkNe2lv699M+/bta+s+tjMw8=;
        b=XvRHUNvMEElRSaUG+rQ2G+ltqzB/+5uXHItXopPFFOuxwKuE7EjQEUSEtjNuzS+0bQYZ0Y
        GPQKQAP98i+ZSRAA==
Date:   Fri, 07 May 2021 13:02:12 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>
Subject: [patch 2/2] x86/idt: Rework IDT setup for boot CPU
References: <20210507110210.147106915@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A basic IDT setup for the boot CPU has to be done before invoking
cpu_init() because that might trigger #GP when accessing certain MSRs. This
setup cannot install the IST variants on 64-bit because the TSS setup which
is required for ISTs to work happens in cpu_init(). That leaves a
theoretical window where a NMI would invoke the ASM entry point which
relies on IST being enabled on the kernel stack which is undefined
behaviour.

This setup logic has never worked correctly, but on the other hand a NMI
hitting the boot CPU before it has fully set up the IDT would be fatal
anyway. So the small window between the wrong NMI gate and the IST based
NMI gate is not really adding a substantial amount of risk.

But the setup logic is nevertheless more convoluted than necessary. The
recent separation of the TSS setup into a separate function to ensure that
#VC is working on secondary CPUs early on, allows to rework the boot CPU
setup so it can setup TSS first, then initialize IDT with the IST variants
before invoking cpu_init() and get rid of the post cpu_init() IST setup.

Move the invocation of cpu_init_exception_handling() ahead of
idt_setup_traps() and merge the IST setup into the default setup table.

Reported-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/desc.h |    2 --
 arch/x86/kernel/idt.c       |   40 ++++++++++++----------------------------
 arch/x86/kernel/traps.c     |    7 +++----
 3 files changed, 15 insertions(+), 34 deletions(-)

--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -421,10 +421,8 @@ extern bool idt_is_f00f_address(unsigned
 
 #ifdef CONFIG_X86_64
 extern void idt_setup_early_pf(void);
-extern void idt_setup_ist_traps(void);
 #else
 static inline void idt_setup_early_pf(void) { }
-static inline void idt_setup_ist_traps(void) { }
 #endif
 
 extern void idt_invalidate(void *addr);
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -35,12 +35,16 @@
 #define SYSG(_vector, _addr)				\
 	G(_vector, _addr, DEFAULT_STACK, GATE_INTERRUPT, DPL3, __KERNEL_CS)
 
+#ifdef CONFIG_X86_64
 /*
  * Interrupt gate with interrupt stack. The _ist index is the index in
  * the tss.ist[] array, but for the descriptor it needs to start at 1.
  */
 #define ISTG(_vector, _addr, _ist)			\
 	G(_vector, _addr, _ist + 1, GATE_INTERRUPT, DPL0, __KERNEL_CS)
+#else
+#define ISTG(_vector, _addr, _ist)	INTG(_vector, _addr)
+#endif
 
 /* Task gate */
 #define TSKG(_vector, _gdt)				\
@@ -74,7 +78,7 @@ static const __initconst struct idt_data
  */
 static const __initconst struct idt_data def_idts[] = {
 	INTG(X86_TRAP_DE,		asm_exc_divide_error),
-	INTG(X86_TRAP_NMI,		asm_exc_nmi),
+	ISTG(X86_TRAP_NMI,		asm_exc_nmi, IST_INDEX_NMI),
 	INTG(X86_TRAP_BR,		asm_exc_bounds),
 	INTG(X86_TRAP_UD,		asm_exc_invalid_op),
 	INTG(X86_TRAP_NM,		asm_exc_device_not_available),
@@ -91,12 +95,16 @@ static const __initconst struct idt_data
 #ifdef CONFIG_X86_32
 	TSKG(X86_TRAP_DF,		GDT_ENTRY_DOUBLEFAULT_TSS),
 #else
-	INTG(X86_TRAP_DF,		asm_exc_double_fault),
+	ISTG(X86_TRAP_DF,		asm_exc_double_fault, IST_INDEX_DF),
 #endif
-	INTG(X86_TRAP_DB,		asm_exc_debug),
+	ISTG(X86_TRAP_DB,		asm_exc_debug, IST_INDEX_DB),
 
 #ifdef CONFIG_X86_MCE
-	INTG(X86_TRAP_MC,		asm_exc_machine_check),
+	ISTG(X86_TRAP_MC,		asm_exc_machine_check, IST_INDEX_MCE),
+#endif
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	ISTG(X86_TRAP_VC,		asm_exc_vmm_communication, IST_INDEX_VC),
 #endif
 
 	SYSG(X86_TRAP_OF,		asm_exc_overflow),
@@ -221,22 +229,6 @@ static const __initconst struct idt_data
 	INTG(X86_TRAP_PF,		asm_exc_page_fault),
 };
 
-/*
- * The exceptions which use Interrupt stacks. They are setup after
- * cpu_init() when the TSS has been initialized.
- */
-static const __initconst struct idt_data ist_idts[] = {
-	ISTG(X86_TRAP_DB,	asm_exc_debug,			IST_INDEX_DB),
-	ISTG(X86_TRAP_NMI,	asm_exc_nmi,			IST_INDEX_NMI),
-	ISTG(X86_TRAP_DF,	asm_exc_double_fault,		IST_INDEX_DF),
-#ifdef CONFIG_X86_MCE
-	ISTG(X86_TRAP_MC,	asm_exc_machine_check,		IST_INDEX_MCE),
-#endif
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-	ISTG(X86_TRAP_VC,	asm_exc_vmm_communication,	IST_INDEX_VC),
-#endif
-};
-
 /**
  * idt_setup_early_pf - Initialize the idt table with early pagefault handler
  *
@@ -254,14 +246,6 @@ void __init idt_setup_early_pf(void)
 	idt_setup_from_table(idt_table, early_pf_idts,
 			     ARRAY_SIZE(early_pf_idts), true);
 }
-
-/**
- * idt_setup_ist_traps - Initialize the idt table with traps using IST
- */
-void __init idt_setup_ist_traps(void)
-{
-	idt_setup_from_table(idt_table, ist_idts, ARRAY_SIZE(ist_idts), true);
-}
 #endif
 
 static void __init idt_map_in_cea(void)
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1160,10 +1160,9 @@ void __init trap_init(void)
 	/* Init GHCB memory pages when running as an SEV-ES guest */
 	sev_es_init_vc_handling();
 
-	idt_setup_traps();
-
+	/* Initialize TSS before setting up traps so ISTs work */
 	cpu_init_exception_handling();
+	/* Setup traps as cpu_init() might #GP */
+	idt_setup_traps();
 	cpu_init();
-
-	idt_setup_ist_traps();
 }

