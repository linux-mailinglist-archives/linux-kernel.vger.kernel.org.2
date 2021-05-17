Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08021386DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344403AbhEQXvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:51:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:40464 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243685AbhEQXvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:51:44 -0400
IronPort-SDR: 5l0ll1cV+B+kXfX3nxwqb2kJoArF130UoWXBec8HUEQabJihodEfjvBu6TIQkbyfEHcBM580NX
 jNHVeRsTECEA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180868912"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180868912"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:50:23 -0700
IronPort-SDR: /XYq727h1UTcwXSk/FnF6+Np9tN8OzSkbCJV1eTeH8F3i8yPo1Ryz5maGiGtZMBscelK62SgqC
 6Dtxr/1y1idg==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="472661384"
Received: from sdayal-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.213.167.196])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:50:20 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix 1/1] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
Date:   Mon, 17 May 2021 16:50:08 -0700
Message-Id: <20210517235008.257241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <28f5b8c2-2307-45b0-19b4-0737df8f06f3@suse.com>
References: <28f5b8c2-2307-45b0-19b4-0737df8f06f3@suse.com>
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

Changes since v1:
 * Removed CONFIG_PARAVIRT_XL
 * Moved HLT and SAFE_HLT under CONFIG_PARAVIRT

 arch/x86/include/asm/irqflags.h       | 40 +++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 +++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +-
 arch/x86/kernel/paravirt.c            |  4 ++-
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index 144d70ea4393..6671744dbf3c 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -59,6 +59,28 @@ static inline __cpuidle void native_halt(void)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
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
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -80,24 +102,6 @@ static __always_inline void arch_local_irq_enable(void)
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
index 4abf110e2243..5d967bce8937 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -84,6 +84,16 @@ static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
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
@@ -145,16 +155,6 @@ static inline void __write_cr4(unsigned long x)
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
index de87087d3bde..68bf35ce6dd5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -177,10 +177,9 @@ struct pv_irq_ops {
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
index c60222ab8ab9..b001f5aaee4a 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -322,9 +322,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,
-- 
2.25.1

