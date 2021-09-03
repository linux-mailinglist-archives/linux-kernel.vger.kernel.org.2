Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993F640041C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbhICR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:29:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:65004 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350187AbhICR3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:29:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="206593439"
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="206593439"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:25 -0700
X-IronPort-AV: E=Sophos;i="5.85,265,1624345200"; 
   d="scan'208";a="534222222"
Received: from dlinsen-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.56.172])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 10:28:24 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/11] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
Date:   Fri,  3 Sep 2021 10:28:02 -0700
Message-Id: <20210903172812.1097643-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210903172812.1097643-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
other VM guest types, features supported under CONFIG_PARAVIRT
are self sufficient. CONFIG_PARAVIRT mainly provides support for
TLB flush operations and time related operations.

For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
most of its requirement except the need of HLT and SAFE_HLT
paravirt calls, which is currently defined under
COFNIG_PARAVIRT_XXL.

Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
like platforms, move HLT and SAFE_HLT paravirt calls under
CONFIG_PARAVIRT.

Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
break any functionality for current users of CONFIG_PARAVIRT.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Change since v5:
 * Removed "/* Irq HLT ops. */" redundant comment.
 * Included asm/paravirt.h in asm/irqflags.h for
   CONFIG_PARAVIRT case to fix possible compilation issue.
 * Fixed typo in commit log.

Changes since v4:
 * None.

 arch/x86/include/asm/irqflags.h       | 48 ++++++++++++++++-----------
 arch/x86/include/asm/paravirt.h       | 20 +++++------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/kernel/paravirt.c            |  3 +-
 4 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index c5ce9845c999..ddc77c95adc6 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -59,27 +59,8 @@ static inline __cpuidle void native_halt(void)
 
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
-#include <asm/paravirt.h>
-#else
+#ifndef CONFIG_PARAVIRT
 #ifndef __ASSEMBLY__
-#include <linux/types.h>
-
-static __always_inline unsigned long arch_local_save_flags(void)
-{
-	return native_save_fl();
-}
-
-static __always_inline void arch_local_irq_disable(void)
-{
-	native_irq_disable();
-}
-
-static __always_inline void arch_local_irq_enable(void)
-{
-	native_irq_enable();
-}
-
 /*
  * Used in the idle loop; sti takes one instruction cycle
  * to complete:
@@ -97,6 +78,33 @@ static inline __cpuidle void halt(void)
 {
 	native_halt();
 }
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifdef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+#include <asm/paravirt.h>
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
+#ifndef CONFIG_PARAVIRT_XXL
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+static __always_inline unsigned long arch_local_save_flags(void)
+{
+	return native_save_fl();
+}
+
+static __always_inline void arch_local_irq_disable(void)
+{
+	native_irq_disable();
+}
+
+static __always_inline void arch_local_irq_enable(void)
+{
+	native_irq_enable();
+}
 
 /*
  * For spinlocks, etc:
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index da3a1ac82be5..d323a626c7a8 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -97,6 +97,16 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
 	PVOP_VCALL1(mmu.exit_mmap, mm);
 }
 
+static inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -162,16 +172,6 @@ static inline void __write_cr4(unsigned long x)
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
 	PVOP_ALT_VCALL0(cpu.wbinvd, "wbinvd", ALT_NOT(X86_FEATURE_XENPV));
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index d9d6b0203ec4..40082847f314 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -150,10 +150,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 04cafc057bed..8cea6e75ba29 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -283,9 +283,10 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
-- 
2.25.1

