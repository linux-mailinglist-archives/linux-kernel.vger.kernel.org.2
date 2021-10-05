Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24184423238
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 22:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhJEUoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 16:44:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:11168 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235823AbhJEUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 16:43:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10128"; a="289354600"
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="289354600"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 13:42:01 -0700
X-IronPort-AV: E=Sophos;i="5.85,349,1624345200"; 
   d="scan'208";a="523979570"
Received: from alyee-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.5.222])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 13:42:00 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/10] x86/tdx: Handle port I/O
Date:   Tue,  5 Oct 2021 13:41:31 -0700
Message-Id: <20211005204136.1812078-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211005204136.1812078-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v6:
 * None

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
index b99ead877549..01d7935feaed 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -67,6 +67,7 @@ bool intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_TDX:
+	case CC_ATTR_GUEST_UNROLL_STRING_IO:
 		return is_tdx_guest;
 	default:
 		return false;
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 4cbffcb737d9..cd0fb5d14ad7 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -175,6 +175,38 @@ static u64 tdx_handle_cpuid(struct pt_regs *regs)
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
@@ -221,6 +253,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
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
index 26eb19f37d56..03dfddd736d2 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -70,6 +70,17 @@ enum cc_attr {
 	 * Examples include Intel TDX.
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

