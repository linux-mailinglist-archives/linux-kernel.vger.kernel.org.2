Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8FF39FB09
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhFHPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:42:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:7777 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231865AbhFHPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:42:32 -0400
IronPort-SDR: XEQFihwLHzdiOq3MhEeG6dOIvLT73LbpDkALjOuDnMo+3qGuZ0kpwfhgGTmuJMZIQSwpBf50Ke
 3g18hoEEwtSw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201849042"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="201849042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:31 -0700
IronPort-SDR: VttaD7YBAqqi3YTpEGQ3UF677EkoUVYPUPknEbppZ5oSpHp0Zb9eFq7XLeBE6+YUirqImNAy9S
 fbOF7EeUUnoA==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552314849"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:30 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix-v2 2/3] x86/tdx: Handle early IO operations
Date:   Tue,  8 Jun 2021 08:40:22 -0700
Message-Id: <cce334a71f527c5554f175e98f94f6690b4efdf4.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2-fix-v1:
 * Fixed commit log as per review comments.
 * Removed IS_ENABLED(CONFIG_INTEL_TDX_GUEST) check for tdg_early_handle_ve()
 * Changed VE_GET_IO_TYPE to VE_IS_IO_OUT() and modified tdx_early_io()
   as per review suggestion.
 * Added support to check string I/O case in tdx_early_io().
 * Modified tdx_early_io() to pass exit_qual instead of ve_info.

 arch/x86/include/asm/tdx.h |  6 ++++
 arch/x86/kernel/head64.c   |  3 ++
 arch/x86/kernel/tdx.c      | 56 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index ac38ed5b50db..fab5eebf4023 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -74,6 +74,7 @@ u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
 		    struct tdx_hypercall_output *out);
 
 bool tdx_protected_guest_has(unsigned long flag);
+bool tdg_early_handle_ve(struct pt_regs *regs);
 
 /*
  * To support I/O port access in decompressor or early kernel init
@@ -135,6 +136,11 @@ static inline bool tdx_protected_guest_has(unsigned long flag)
 	return false;
 }
 
+static inline bool tdg_early_handle_ve(struct pt_regs *regs)
+{
+	return false;
+}
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
index b1cdb37a8636..3410cfc8a988 100644
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
@@ -254,6 +259,57 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
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
+	ret = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
+			      regs->ax, &outh);
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

