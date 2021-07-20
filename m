Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681283CF30B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245743AbhGTDey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:34:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:8799 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240059AbhGTDeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:34:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="232950383"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="232950383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:53 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="468818638"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 21:13:53 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] x86/tdx: Add helper to do MapGPA hypercall
Date:   Mon, 19 Jul 2021 21:13:43 -0700
Message-Id: <20210720041346.2121680-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720041346.2121680-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

MapGPA hypercall is used by TDX guests to request VMM convert
the existing mapping of given GPA address range between
private/shared.

tdx_hcall_gpa_intent() is the wrapper used for making MapGPA
hypercall.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v1:
 * Modified tdx_hcall_gpa_intent() to use _tdx_hypercall() instead of
   tdx_hypercall().

 arch/x86/include/asm/tdx.h | 18 ++++++++++++++++++
 arch/x86/kernel/tdx.c      | 25 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1e2a1c6a1898..665c8cf57d5b 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -56,6 +56,15 @@ struct ve_info {
 	u32 instr_info;
 };
 
+/*
+ * Page mapping type enum. This is software construct not
+ * part of any hardware or VMM ABI.
+ */
+enum tdx_map_type {
+	TDX_MAP_PRIVATE,
+	TDX_MAP_SHARED,
+};
+
 #ifdef CONFIG_INTEL_TDX_GUEST
 
 void __init tdx_early_init(void);
@@ -79,6 +88,9 @@ bool tdg_early_handle_ve(struct pt_regs *regs);
 
 extern phys_addr_t tdg_shared_mask(void);
 
+extern int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				enum tdx_map_type map_type);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -149,6 +161,12 @@ static inline bool tdg_early_handle_ve(struct pt_regs *regs) { return false; }
 
 static inline phys_addr_t tdg_shared_mask(void) { return 0; }
 
+static inline int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+				       enum tdx_map_type map_type)
+{
+	return -ENODEV;
+}
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 7c4998bb47f8..031c1f1c294e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -18,6 +18,9 @@
 #define TDINFO				1
 #define TDGETVEINFO			3
 
+/* TDX hypercall Leaf IDs */
+#define TDVMCALL_MAP_GPA		0x10001
+
 #define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
 #define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
 #define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
@@ -100,6 +103,28 @@ static void tdg_get_info(void)
 	physical_mask &= ~tdg_shared_mask();
 }
 
+/*
+ * Inform the VMM of the guest's intent for this physical page:
+ * shared with the VMM or private to the guest.  The VMM is
+ * expected to change its mapping of the page in response.
+ *
+ * Note: shared->private conversions require further guest
+ * action to accept the page.
+ */
+int tdx_hcall_gpa_intent(phys_addr_t gpa, int numpages,
+			 enum tdx_map_type map_type)
+{
+	u64 ret;
+
+	if (map_type == TDX_MAP_SHARED)
+		gpa |= tdg_shared_mask();
+
+	ret = _tdx_hypercall(TDVMCALL_MAP_GPA, gpa, PAGE_SIZE * numpages, 0, 0,
+			     NULL);
+
+	return ret ? -EIO : 0;
+}
+
 static __cpuidle void tdg_halt(void)
 {
 	u64 ret;
-- 
2.25.1

