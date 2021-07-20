Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2E43CF2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 05:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348416AbhGTDMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 23:12:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:24180 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348361AbhGTDJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:09:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="211229339"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="211229339"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 20:49:26 -0700
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="661006641"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 20:49:26 -0700
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
Subject: [PATCH v3 05/10] x86/tdx: Handle port I/O
Date:   Mon, 19 Jul 2021 20:48:56 -0700
Message-Id: <20210720034901.2120205-6-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720034901.2120205-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720034901.2120205-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX hypervisors cannot emulate instructions directly. This
includes port IO which is normally emulated in the hypervisor.
All port IO instructions inside TDX trigger the #VE exception
in the guest and would be normally emulated there.

Also string I/O is not supported in TDX guest. So, unroll the
string I/O operation into a loop operating on one element at
a time. This method is similar to AMD SEV, so just extend the
support for TDX guest platform.

Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---

Changes since v2:
 * None

Changes since v1:
 * Fixed comments for tdg_handle_io().
 * Used _tdx_hypercall() instead of __tdx_hypercall() in tdg_handle_io().

 arch/x86/include/asm/io.h |  7 +++++--
 arch/x86/kernel/tdx.c     | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 50f9eb17d364..b677f81168a0 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -40,6 +40,7 @@
 
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/protected_guest.h>
 #include <asm/page.h>
 #include <asm/early_ioremap.h>
 #include <asm/pgtable_types.h>
@@ -309,7 +310,8 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    prot_guest_has(PR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -325,7 +327,8 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    prot_guest_has(PR_GUEST_UNROLL_STRING_IO)) {		\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 549d10d1f27d..2bd596be70fd 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -177,6 +177,34 @@ static void tdg_handle_cpuid(struct pt_regs *regs)
 	regs->dx = out.r15;
 }
 
+/*
+ * tdx_handle_early_io() cannot be re-used in #VE handler for handling
+ * I/O because the way of handling string I/O is different between
+ * normal and early I/O case. Also, once trace support is enabled,
+ * tdg_handle_io() will be extended to use trace calls which is also
+ * not valid for early I/O cases.
+ */
+static void tdg_handle_io(struct pt_regs *regs, u32 exit_qual)
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
+	BUG_ON(string);
+
+	ret = _tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
+			     regs->ax, &outh);
+	if (!out) {
+		regs->ax &= ~mask;
+		regs->ax |= (ret ? UINT_MAX : outh.r11) & mask;
+	}
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -223,6 +251,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_CPUID:
 		tdg_handle_cpuid(regs);
 		break;
+	case EXIT_REASON_IO_INSTRUCTION:
+		tdg_handle_io(regs, ve->exit_qual);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

