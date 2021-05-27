Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8F39261A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 06:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhE0EZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 00:25:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:41864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhE0EZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 00:25:46 -0400
IronPort-SDR: LCKMCBrvYqydX8Q9b4wb2P0qJayOvyHlf93i85jYQ2GtTwOm6nEWRWgvfWIRP7D1wmsC8vLzoT
 92ou07Ri2p0w==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="223844425"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="223844425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:13 -0700
IronPort-SDR: ehVV0ofn/ghzP1WEnMlc3MJ3I19+z9z4No/B6jG0b9UBi+pn7R9m0ZxRSjGFyigr0SPfGSQ9+N
 d57xX3MZhxOQ==
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="480391414"
Received: from skgangad-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.33.45])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 21:24:13 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2-fix-v1 2/3] x86/tdx: Handle early IO operations
Date:   Wed, 26 May 2021 21:23:55 -0700
Message-Id: <20210527042356.3983284-3-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <CAPcyv4gBNqDFQEYjWqYTckPg-yy=LrvMw_FNY+tUuEwD35CfyA@mail.gmail.com>
 <20210527042356.3983284-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Add an early #VE handler to convert early port IOs into TDCALLs.

TDX cannot do port IO directly. The TDX module triggers a #VE
exception to let the guest kernel to emulate operations like
IO ports, by converting them into TDCALLs to call the host.

A fully featured #VE handler support for port IO will be added
later in this patch set (in patch titled "x86/tdx: Handle port
I/O). But it can be used only at later point in the boot
process. So to support port IO in early boot code, add a
minimal support in early exception handler. This is similar to
what AMD SEV does.

This is mainly to support early_printk's serial driver, as
well as potentially the VGA driver (although it is expected
not to be used).

The early handler only does IO calls and nothing else, and
anything that goes wrong results in a normal early exception
panic.

It cannot share the code paths with the normal #VE handler
because it needs to avoid using trace calls or printk.

This early handler allows us to use the normal in*/out*
macros without patching them for every driver. We don't
expect IO port IO to be performance critical at all, so an
extra #VE exception is no problem. There are also no concerns
with nesting, since there should be no NMIs this early.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/asm/tdx.h |  6 ++++
 arch/x86/kernel/head64.c   |  4 +++
 arch/x86/kernel/tdx.c      | 59 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 53f844200909..e880a9dd40d3 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -72,6 +72,7 @@ u64 __tdx_hypercall(u64 fn, u64 r12, u64 r13, u64 r14, u64 r15,
 		    struct tdx_hypercall_output *out);
 
 bool tdx_protected_guest_has(unsigned long flag);
+bool tdg_early_handle_ve(struct pt_regs *regs);
 
 #else // !CONFIG_INTEL_TDX_GUEST
 
@@ -87,6 +88,11 @@ static inline bool tdx_protected_guest_has(unsigned long flag)
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
index 75f2401cb5db..23d1ff4626aa 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -410,6 +410,10 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
 		return;
 
+	if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
+	    trapnr == X86_TRAP_VE && tdg_early_handle_ve(regs))
+		return;
+
 	early_fixup_exception(regs, trapnr);
 }
 
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 858e7f3d8f36..ca3442b7accf 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -13,6 +13,10 @@
 #define TDINFO				1
 #define TDGETVEINFO			3
 
+#define VE_GET_IO_TYPE(exit_qual)      (((exit_qual) & 8) ? 0 : 1)
+#define VE_GET_IO_SIZE(exit_qual)      (((exit_qual) & 7) + 1)
+#define VE_GET_PORT_NUM(exit_qual)     ((exit_qual) >> 16)
+
 static struct {
 	unsigned int gpa_width;
 	unsigned long attributes;
@@ -256,6 +260,61 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
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
+static __init bool tdx_early_io(struct ve_info *ve, struct pt_regs *regs)
+{
+	struct tdx_hypercall_output outh;
+	int out = VE_GET_IO_TYPE(ve->exit_qual);
+	int size = VE_GET_IO_SIZE(ve->exit_qual);
+	int port = VE_GET_PORT_NUM(ve->exit_qual);
+	int ret;
+
+	if (out) {
+		ret = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION,
+				      size, 1, port,
+				      regs->ax,
+				      &outh);
+	} else {
+		u64 mask = GENMASK(8 * size, 0);
+
+		ret = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION,
+				      size, 0, port,
+				      regs->ax, &outh);
+		if (!ret) {
+			regs->ax &= ~mask;
+			regs->ax |= outh.r11 & mask;
+		}
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
+		return tdx_early_io(&ve, regs);
+
+	return false;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
-- 
2.25.1

