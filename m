Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFBB4153A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhIVW5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:57:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:62861 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238380AbhIVW41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:56:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221832435"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="221832435"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:55 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653457352"
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
Subject: [PATCH v6 05/10] x86/tdx: Handle port I/O
Date:   Wed, 22 Sep 2021 15:52:34 -0700
Message-Id: <20210922225239.3501262-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX hypervisors cannot emulate instructions directly. This includes
port IO which is normally emulated in the hypervisor. All port IO
instructions inside TDX trigger the #VE exception in the guest and
would be normally emulated there.

Also string I/O is not supported in TDX guest. So, unroll the string
I/O operation into a loop operating on one element at a time. This
method is similar to AMD SEV, so just extend the support for TDX guest
platform.

Add a new confidential guest flag CC_ATTR_GUEST_UNROLL_STRING_IO to
add string unroll support in asm/io.h

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---

Changes since v5:
 * Changed prot_guest_has() to cc_platform_has().

Changes since v4:
 * Changed order of variable declaration in tdx_handle_io().
 * Changed tdg_* prefix with tdx_*.

Changes since v3:
 * Included PATTR_GUEST_UNROLL_STRING_IO protected guest flag
   addition change in this patch.
 * Rebased on top of Tom Lendacks protected guest change.

Changes since v2:
 * None

Changes since v1:
 * Fixed comments for tdg_handle_io().
 * Used _tdx_hypercall() instead of __tdx_hypercall() in tdg_handle_io().

 arch/x86/include/asm/io.h   |  7 +++++--
 arch/x86/kernel/cpu/intel.c |  1 +
 arch/x86/kernel/tdx.c       | 35 +++++++++++++++++++++++++++++++++++
 include/linux/cc_platform.h | 11 +++++++++++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index fa6aa43e5dc3..67e0c4a0a0f4 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -40,6 +40,7 @@
 
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/cc_platform.h>
 #include <asm/page.h>
 #include <asm/tdx.h>
 #include <asm/early_ioremap.h>
@@ -310,7 +311,8 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -326,7 +328,8 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    cc_platform_has(CC_ATTR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index ab337c194beb..c7c02c2e7601 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -66,6 +66,7 @@ bool intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_TDX:
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 		return cpu_feature_enabled(X86_FEATURE_TDX_GUEST);
 	default:
 		return false;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b3515f789f64..31a2c2a9722a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -180,6 +180,38 @@ static u64 tdx_handle_cpuid(struct pt_regs *regs)
 	return ret;
 }
 
+/*
+ * tdx_handle_early_io() cannot be re-used in #VE handler for handling
+ * I/O because the way of handling string I/O is different between
+ * normal and early I/O case. Also, once trace support is enabled,
+ * tdx_handle_io() will be extended to use trace calls which is also
+ * not valid for early I/O cases.
+ */
+static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
+{
+	struct tdx_hypercall_output outh;
+	int out, size, port, ret;
+	bool string;
+	u64 mask;
+
+	string = VE_IS_IO_STRING(exit_qual);
+
+	/* I/O strings ops are unrolled at build time. */
+	BUG_ON(string);
+
+	out = VE_IS_IO_OUT(exit_qual);
+	size = VE_GET_IO_SIZE(exit_qual);
+	port = VE_GET_PORT_NUM(exit_qual);
+	mask = GENMASK(8 * size, 0);
+
+	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
+			     regs->ax, &outh);
+	if (!out) {
+		regs->ax &= ~mask;
+		regs->ax |= (ret ? UINT_MAX : outh.r11) & mask;
+	}
+}
+
 unsigned long tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out = {0};
@@ -226,6 +258,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_CPUID:
 		ret = tdx_handle_cpuid(regs);
 		break;
+	case EXIT_REASON_IO_INSTRUCTION:
+		tdx_handle_io(regs, ve->exit_qual);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index e38430e6e396..253fd4ca7178 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -70,6 +70,17 @@ enum cc_attr {
 	 * Examples include SEV-ES.
 	 */
 	CC_ATTR_GUEST_TDX,
+
+	/**
+	 * @CC_ATTR_GUEST_UNROLL_STRING_IO: String I/O is implemented with
+	 *                                  IN/OUT instructions
+	 *
+	 * The platform/OS is running as a guest/virtual machine and uses
+	 * IN/OUT instructions in place of string I/O.
+	 *
+	 * Examples include TDX Guest.
+	 */
+	CC_ATTR_GUEST_UNROLL_STRING_IO,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
-- 
2.25.1

