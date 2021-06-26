Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B0F3B4EE3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFZOUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:20:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:42501 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhFZOTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:19:54 -0400
IronPort-SDR: Gi1yQVx2+A9B6ZN0hDjIeXNbQafEJGEvPZFHeXB77nf7blDZHvKlCaWS+v+rnVWqaAkn33ExVh
 LqciWpavUfMg==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207729772"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207729772"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:32 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="624775857"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:30 -0700
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
Subject: [PATCH v2 04/10] x86/tdx: Handle early IO operations
Date:   Sat, 26 Jun 2021 07:17:12 -0700
Message-Id: <36260bc1b9cab1f63d16ce600cc1299547f99fa2.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an early #VE handler to convert early port IOs into
TDCALLs.

TDX cannot do port IO directly. The TDX module triggers
a #VE exception to let the guest kernel to emulate port
I/O, by converting them into TDCALLs to call the host.

To support port IO in early boot code, add a minimal
support in early exception handlers. This is similar to
what AMD SEV does. This is mainly to support early_printk's
serial driver, as well as potentially the VGA driver
(although it is expected not to be used).

The early handler only does IO calls and nothing else, and
anything that goes wrong results in a normal early exception
panic.

It cannot share the code paths with the normal #VE handler
because it needs to avoid using trace calls or printk.

This early handler allows us to use the normal in*/out*
macros without patching them for every driver. Since, there
is no expectation that early port IO is performance critical,
the #VE emulation cost is worth the simplicity benefit of not
patching out port IO usage in early code. There are also no
concerns with nesting, since there should be no NMIs this
early.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
Changes since v1:
 * Renamed tdx_early_io() to tdg_early_io().

 arch/x86/include/asm/tdx.h |  4 +++
 arch/x86/kernel/head64.c   |  3 ++
 arch/x86/kernel/tdx.c      | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 25946b4e8595..72154d3f63c2 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -75,6 +75,8 @@ unsigned long tdg_get_ve_info(struct ve_info *ve);
 int tdg_handle_virtualization_exception(struct pt_regs *regs,
 					struct ve_info *ve);
 
+bool tdg_early_handle_ve(struct pt_regs *regs);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -141,6 +143,8 @@ static inline void tdx_early_init(void) { };
 
 static inline bool tdx_prot_guest_has(unsigned long flag) { return false; }
 
+static inline bool tdg_early_handle_ve(struct pt_regs *regs) { return false; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #ifdef CONFIG_INTEL_TDX_GUEST_KVM
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index d1a4942ae160..323ce7f156f5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -410,6 +410,9 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
 		return;
 
+	if (trapnr == X86_TRAP_VE && tdg_early_handle_ve(regs))
+		return;
+
 	early_fixup_exception(regs, trapnr);
 }
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 07d86455d7fe..a20bdbdc2bc8 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,11 @@
 #define TDINFO				1
 #define TDGETVEINFO			3
 
+#define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
+#define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
+#define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
+#define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
@@ -230,6 +235,57 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	return ret;
 }
 
+/*
+ * Handle early IO, mainly for early printks serial output.
+ * This avoids anything that doesn't work early on, like tracing
+ * or printks, by calling the low level functions directly. Any
+ * problems are handled by falling back to a standard early exception.
+ *
+ * Assumes the IO instruction was using ax, which is enforced
+ * by the standard io.h macros.
+ */
+static __init bool tdg_early_io(struct pt_regs *regs, u32 exit_qual)
+{
+	struct tdx_hypercall_output outh;
+	int out = VE_IS_IO_OUT(exit_qual);
+	int size = VE_GET_IO_SIZE(exit_qual);
+	int port = VE_GET_PORT_NUM(exit_qual);
+	u64 mask = GENMASK(8 * size, 0);
+	bool string = VE_IS_IO_STRING(exit_qual);
+	int ret;
+
+	/* I/O strings ops are unrolled at build time. */
+	if (string)
+		return 0;
+
+	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
+			     regs->ax, &outh);
+	if (!out && !ret) {
+		regs->ax &= ~mask;
+		regs->ax |= outh.r11 & mask;
+	}
+
+	return !ret;
+}
+
+/*
+ * Early #VE exception handler. Just used to handle port IOs
+ * for early_printk. If anything goes wrong handle it like
+ * a normal early exception.
+ */
+__init bool tdg_early_handle_ve(struct pt_regs *regs)
+{
+	struct ve_info ve;
+
+	if (tdg_get_ve_info(&ve))
+		return false;
+
+	if (ve.exit_reason == EXIT_REASON_IO_INSTRUCTION)
+		return tdg_early_io(regs, ve.exit_qual);
+
+	return false;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
-- 
2.25.1

