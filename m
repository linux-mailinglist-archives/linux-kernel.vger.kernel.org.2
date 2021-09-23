Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9724153A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbhIVW5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:57:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:62858 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238373AbhIVW4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:56:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221832434"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="221832434"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:49 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653457346"
Received: from mnamagi-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.34.84])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:49 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/10] x86/tdx: Handle early IO operations
Date:   Wed, 22 Sep 2021 15:52:33 -0700
Message-Id: <20210922225239.3501262-5-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an early #VE handler to convert early port IOs into TDCALLs.

TDX cannot do port IO directly. The TDX module triggers a #VE exception
to let the guest kernel to emulate port I/O, by converting them into
TDCALLs to call the host.

To support port IO in early boot code, add a minimal support in early
exception handlers. This is similar to what AMD SEV does. This is
mainly to support early_printk's serial driver, as well as potentially
the VGA driver (although it is expected not to be used).

The early handler only does IO calls and nothing else, and anything
that goes wrong results in a normal early exception panic.

It cannot share the code paths with the normal #VE handler because it
needs to avoid using trace calls or printk.

This early handler allows us to use the normal in*/out* macros without
patching them for every driver. Since, there is no expectation that
early port IO is performance critical, the #VE emulation cost is worth
the simplicity benefit of not patching out port IO usage in early code.
There are also no concerns with nesting, since there should be no NMIs
this early.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v5:
 * None

Changes since v4:
 * Changed order of variable declaration in tdx_early_io()

Changes since v3:
 * None

Changes since v2:
 * None

Changes since v1:
 * Renamed tdx_early_io() to tdg_early_io().

 arch/x86/include/asm/tdx.h |  4 +++
 arch/x86/kernel/head64.c   |  3 ++
 arch/x86/kernel/tdx.c      | 60 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index b35ebb3c54f0..eedacf8ede3d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -73,6 +73,8 @@ unsigned long tdx_get_ve_info(struct ve_info *ve);
 int tdx_handle_virtualization_exception(struct pt_regs *regs,
 					struct ve_info *ve);
 
+bool tdx_early_handle_ve(struct pt_regs *regs);
+
 /*
  * To support I/O port access in decompressor or early kernel init
  * code, since #VE exception handler cannot be used, use paravirt
@@ -135,6 +137,8 @@ do {									\
 
 static inline void tdx_early_init(void) { };
 
+static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
+
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 10c2568d7c42..f1e09ecbc1b5 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -410,6 +410,9 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
 		return;
 
+	if (trapnr == X86_TRAP_VE && tdx_early_handle_ve(regs))
+		return;
+
 	early_fixup_exception(regs, trapnr);
 }
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 45dbd8863ec0..b3515f789f64 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -10,6 +10,11 @@
 /* TDX Module call Leaf IDs */
 #define TDGETVEINFO			3
 
+#define VE_IS_IO_OUT(exit_qual)		(((exit_qual) & 8) ? 0 : 1)
+#define VE_GET_IO_SIZE(exit_qual)	(((exit_qual) & 7) + 1)
+#define VE_GET_PORT_NUM(exit_qual)	((exit_qual) >> 16)
+#define VE_IS_IO_STRING(exit_qual)	((exit_qual) & 16 ? 1 : 0)
+
 /*
  * Wrapper for standard use of __tdx_hypercall with BUG_ON() check
  * for TDCALL error.
@@ -233,6 +238,61 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
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
+static __init bool tdx_early_io(struct pt_regs *regs, u32 exit_qual)
+{
+	struct tdx_hypercall_output outh;
+	int out, size, port, ret;
+	bool string;
+	u64 mask;
+
+	string = VE_IS_IO_STRING(exit_qual);
+
+	/* I/O strings ops are unrolled at build time. */
+	if (string)
+		return 0;
+
+	out = VE_IS_IO_OUT(exit_qual);
+	size = VE_GET_IO_SIZE(exit_qual);
+	port = VE_GET_PORT_NUM(exit_qual);
+	mask = GENMASK(8 * size, 0);
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
+__init bool tdx_early_handle_ve(struct pt_regs *regs)
+{
+	struct ve_info ve;
+
+	if (tdx_get_ve_info(&ve))
+		return false;
+
+	if (ve.exit_reason == EXIT_REASON_IO_INSTRUCTION)
+		return tdx_early_io(regs, ve.exit_qual);
+
+	return false;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
-- 
2.25.1

