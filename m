Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2183311AEA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBFEc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:32:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:63380 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhBFDQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:16:01 -0500
IronPort-SDR: +uFGnY7V/lfHldF2UDTlFJ4i1jKMnnY4v+He8Lq39WbUSCEZX47SxFRVfeE4/ntpGT3zgWIt92
 1Cn27SaefYrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650704"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650704"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:03 -0800
IronPort-SDR: KqoJNrjkqrs1UxmKMYkSr6UPDZEy/t9XYBXhzBTFTIQcVUFJ6BiHYafxXiWjEGkXpb/k92hfMG
 PugGsXwPT2Mg==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183860"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:03 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 01/26] x86/paravirt: Introduce CONFIG_PARAVIRT_XL
Date:   Fri,  5 Feb 2021 15:38:18 -0800
Message-Id: <ecbb771d8616e45cec8bf457a044c4233a50ad09.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Split off halt paravirt calls from CONFIG_PARAVIRT_XXL into
a separate config option. It provides a middle ground for
not-so-deep paravirtulized environments.

CONFIG_PARAVIRT_XL will be used by TDX that needs couple of paravirt
calls that was hidden under CONFIG_PARAVIRT_XXL, but the rest of the
config would be a bloat for TDX.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/Kconfig                      |  4 +++
 arch/x86/boot/compressed/misc.h       |  1 +
 arch/x86/include/asm/irqflags.h       | 42 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 22 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/kernel/paravirt.c            |  4 ++-
 arch/x86/mm/mem_encrypt_identity.c    |  1 +
 7 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7b6dd10b162a..8fe91114bfee 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -776,8 +776,12 @@ config PARAVIRT
 	  over full virtualization.  However, when run without a hypervisor
 	  the kernel is theoretically slower and slightly larger.
 
+config PARAVIRT_XL
+	bool
+
 config PARAVIRT_XXL
 	bool
+	select PARAVIRT_XL
 
 config PARAVIRT_DEBUG
 	bool "paravirt-ops debugging"
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 901ea5ebec22..4b84abe43765 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -9,6 +9,7 @@
  * paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XL
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 #undef CONFIG_KASAN
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 2dfc8d380dab..299c9b1ed857 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -68,11 +68,33 @@ static inline __cpuidle void native_halt(void)
 
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
+#ifdef CONFIG_PARAVIRT_XL
 #include <asm/paravirt.h>
 #else
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static inline __cpuidle void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static inline __cpuidle void halt(void)
+{
+	native_halt();
+}
+#endif /* !__ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT_XL */
+
+#ifndef CONFIG_PARAVIRT_XXL
+#ifndef __ASSEMBLY__
 
 static __always_inline unsigned long arch_local_save_flags(void)
 {
@@ -94,24 +116,6 @@ static __always_inline void arch_local_irq_enable(void)
 	native_irq_enable();
 }
 
-/*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static inline __cpuidle void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static inline __cpuidle void halt(void)
-{
-	native_halt();
-}
-
 /*
  * For spinlocks, etc:
  */
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f8dce11d2bc1..700b94abfd1b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -84,6 +84,18 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 	PVOP_VCALL1(mmu.exit_mmap, mm);
 }
 
+#ifdef CONFIG_PARAVIRT_XL
+static inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+#endif
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -145,16 +157,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline void wbinvd(void)
 {
 	PVOP_VCALL0(cpu.wbinvd);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index b6b02b7c19cc..634482a0a60d 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -190,7 +190,8 @@ struct pv_irq_ops {
 	struct paravirt_callee_save restore_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
+#ifdef CONFIG_PARAVIRT_XL
 	void (*safe_halt)(void);
 	void (*halt)(void);
 #endif
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 6c3407ba6ee9..85714a6389d6 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -327,9 +327,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.restore_fl		= __PV_IS_CALLEE_SAVE(native_restore_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+#ifdef CONFIG_PARAVIRT_XL
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
+#endif /* CONFIG_PARAVIRT_XL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 6c5eb6f3f14f..20d0cb116557 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -24,6 +24,7 @@
  * be extended when new paravirt and debugging variants are added.)
  */
 #undef CONFIG_PARAVIRT
+#undef CONFIG_PARAVIRT_XL
 #undef CONFIG_PARAVIRT_XXL
 #undef CONFIG_PARAVIRT_SPINLOCKS
 
-- 
2.25.1

