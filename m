Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647273B7480
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhF2Ols (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbhF2OlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:41:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D63EC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:38:53 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:35:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624977531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wgUUJM5AtwFNBfZTUJlOL14zI0hpQvKjoimdtXXt2BY=;
        b=EC44T+//GmdKOgemrUTAztFVhhIqevmgFnB3zbYElUQR0FhxqyOdQ5M1hI14vsQ1K/K89C
        mNpbzBElkcBqDD/8GZJlZCCbdmesreMr1ZJVI0v1DMk7x+hBBE9QNbXqWLe8ViLUD7NzJh
        Q7TWWNjROYF86AFzbVF7YtNxEuS5Gd88X7Xs+3vBKtb//Vs36FghpdmlrqPFHvGcW/lVA0
        GvObAViX7ixif6KI8AiQ70Mr+aJAzMtH9tnNmWBJ4Rvz5xvtWATOxkZusiOuxMOewM69cr
        lAEyVyU13IYZu/1b5+GQAaAU0/FpGCE9ULp+efaQQlNTakRZ50F+zZahir1SYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624977531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wgUUJM5AtwFNBfZTUJlOL14zI0hpQvKjoimdtXXt2BY=;
        b=jyluP96+b+HD1rSKVTmTOUksl2ZKy/BEHM+YS1RhQEDKW4lyM2h8sHJLYuM1u1rv7fqUn6
        J7GLTZrWMRUwu9BA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/irq for v5.14-rc1
References: <162497731214.6531.6083197571290189651.tglx@nanos>
Message-ID: <162497731818.6531.4930124202969522982.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/irq branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2021-06-29

up to:  056c52f5e824: x86/kexec: Set_[gi]dt() -> native_[gi]dt_invalidate() in machine_kexec_*.c


X86 interrupt related changes:

  - Consolidate the VECTOR defines and the usage sites.

  - Cleanup GDT/IDT related code and replace open coded ASM with proper
    native helfper functions.

Thanks,

	tglx

------------------>
H. Peter Anvin (Intel) (5):
      x86/irq: Remove unused vectors defines
      x86/irq: Add and use NR_EXTERNAL_VECTORS and NR_SYSTEM_VECTORS
      x86/idt: Remove address argument from idt_invalidate()
      x86: Add native_[ig]dt_invalidate()
      x86/kexec: Set_[gi]dt() -> native_[gi]dt_invalidate() in machine_kexec_*.c


 arch/x86/include/asm/desc.h              | 22 ++++++++++++++++++++-
 arch/x86/include/asm/idtentry.h          |  4 ++--
 arch/x86/include/asm/irq_vectors.h       |  7 +++++--
 arch/x86/kernel/idt.c                    |  5 ++---
 arch/x86/kernel/machine_kexec_32.c       | 15 ++-------------
 arch/x86/kernel/machine_kexec_64.c       | 33 ++------------------------------
 arch/x86/kernel/reboot.c                 |  2 +-
 tools/arch/x86/include/asm/irq_vectors.h |  7 +++++--
 8 files changed, 40 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index 476082a83d1c..400c17862870 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -224,6 +224,26 @@ static inline void store_idt(struct desc_ptr *dtr)
 	asm volatile("sidt %0":"=m" (*dtr));
 }
 
+static inline void native_gdt_invalidate(void)
+{
+	const struct desc_ptr invalid_gdt = {
+		.address = 0,
+		.size = 0
+	};
+
+	native_load_gdt(&invalid_gdt);
+}
+
+static inline void native_idt_invalidate(void)
+{
+	const struct desc_ptr invalid_idt = {
+		.address = 0,
+		.size = 0
+	};
+
+	native_load_idt(&invalid_idt);
+}
+
 /*
  * The LTR instruction marks the TSS GDT entry as busy. On 64-bit, the GDT is
  * a read-only remapping. To prevent a page fault, the GDT is switched to the
@@ -427,6 +447,6 @@ static inline void idt_setup_early_pf(void) { }
 static inline void idt_setup_ist_traps(void) { }
 #endif
 
-extern void idt_invalidate(void *addr);
+extern void idt_invalidate(void);
 
 #endif /* _ASM_X86_DESC_H */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 73d45b0dfff2..c03a18cac78e 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -504,7 +504,7 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+    .rept NR_EXTERNAL_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
 	.byte	0x6a, vector
@@ -520,7 +520,7 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
+    .rept NR_SYSTEM_VECTORS
 	UNWIND_HINT_IRET_REGS
 0 :
 	.byte	0x6a, vector
diff --git a/arch/x86/include/asm/irq_vectors.h b/arch/x86/include/asm/irq_vectors.h
index 889f8b1b5b7f..43dcb9284208 100644
--- a/arch/x86/include/asm/irq_vectors.h
+++ b/arch/x86/include/asm/irq_vectors.h
@@ -26,8 +26,8 @@
  * This file enumerates the exact layout of them:
  */
 
+/* This is used as an interrupt vector when programming the APIC. */
 #define NMI_VECTOR			0x02
-#define MCE_VECTOR			0x12
 
 /*
  * IDT vectors usable for external interrupt sources start at 0x20.
@@ -84,7 +84,7 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-#define UV_BAU_MESSAGE			0xf5
+/* 0xf5 - unused, was UV_BAU_MESSAGE */
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
@@ -114,6 +114,9 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
+#define NR_EXTERNAL_VECTORS		(FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define NR_SYSTEM_VECTORS		(NR_VECTORS - FIRST_SYSTEM_VECTOR)
+
 /*
  * Size the maximum number of interrupts.
  *
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index d552f177eca0..2779f5226dc2 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -331,11 +331,10 @@ void __init idt_setup_early_handler(void)
 
 /**
  * idt_invalidate - Invalidate interrupt descriptor table
- * @addr:	The virtual address of the 'invalid' IDT
  */
-void idt_invalidate(void *addr)
+void idt_invalidate(void)
 {
-	struct desc_ptr idt = { .address = (unsigned long) addr, .size = 0 };
+	static const struct desc_ptr idt = { .address = 0, .size = 0 };
 
 	load_idt(&idt);
 }
diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 64b00b0d7fe8..1b373d79cedc 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -23,17 +23,6 @@
 #include <asm/set_memory.h>
 #include <asm/debugreg.h>
 
-static void set_gdt(void *newgdt, __u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* ia32 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	load_gdt(&curgdt);
-}
-
 static void load_segments(void)
 {
 #define __STR(X) #X
@@ -232,8 +221,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	idt_invalidate(phys_to_virt(0));
-	set_gdt(phys_to_virt(0), 0);
+	native_idt_invalidate();
+	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel_ptr((unsigned long)image->head,
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index c078b0d3ab0e..131f30fdcfbd 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -256,35 +256,6 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 	return init_transition_pgtable(image, level4p);
 }
 
-static void set_idt(void *newidt, u16 limit)
-{
-	struct desc_ptr curidt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curidt.size    = limit;
-	curidt.address = (unsigned long)newidt;
-
-	__asm__ __volatile__ (
-		"lidtq %0\n"
-		: : "m" (curidt)
-		);
-};
-
-
-static void set_gdt(void *newgdt, u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	__asm__ __volatile__ (
-		"lgdtq %0\n"
-		: : "m" (curgdt)
-		);
-};
-
 static void load_segments(void)
 {
 	__asm__ __volatile__ (
@@ -379,8 +350,8 @@ void machine_kexec(struct kimage *image)
 	 * The gdt & idt are now invalid.
 	 * If you want to load them you must set up your own idt & gdt.
 	 */
-	set_gdt(phys_to_virt(0), 0);
-	set_idt(phys_to_virt(0), 0);
+	native_idt_invalidate();
+	native_gdt_invalidate();
 
 	/* now call it */
 	image->start = relocate_kernel((unsigned long)image->head,
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index b29657b76e3f..ebfb91108232 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -669,7 +669,7 @@ static void native_machine_emergency_restart(void)
 			break;
 
 		case BOOT_TRIPLE:
-			idt_invalidate(NULL);
+			idt_invalidate();
 			__asm__ __volatile__("int3");
 
 			/* We're probably dead after this, but... */
diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index 889f8b1b5b7f..43dcb9284208 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -26,8 +26,8 @@
  * This file enumerates the exact layout of them:
  */
 
+/* This is used as an interrupt vector when programming the APIC. */
 #define NMI_VECTOR			0x02
-#define MCE_VECTOR			0x12
 
 /*
  * IDT vectors usable for external interrupt sources start at 0x20.
@@ -84,7 +84,7 @@
  */
 #define IRQ_WORK_VECTOR			0xf6
 
-#define UV_BAU_MESSAGE			0xf5
+/* 0xf5 - unused, was UV_BAU_MESSAGE */
 #define DEFERRED_ERROR_VECTOR		0xf4
 
 /* Vector on which hypervisor callbacks will be delivered */
@@ -114,6 +114,9 @@
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
 
+#define NR_EXTERNAL_VECTORS		(FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
+#define NR_SYSTEM_VECTORS		(NR_VECTORS - FIRST_SYSTEM_VECTOR)
+
 /*
  * Size the maximum number of interrupts.
  *

