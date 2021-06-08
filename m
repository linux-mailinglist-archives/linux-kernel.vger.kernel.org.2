Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A339939FB08
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhFHPmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:42:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:7767 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhFHPmc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:42:32 -0400
IronPort-SDR: f4Xb2iTbYEyD86EXa9N9wdRhiq9Polnfp9+e5AhWRqpxgXnY8+2rTQRg9Z5vG0O/VevBPx0f68
 krIev1oHwOyw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="201849045"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="201849045"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:31 -0700
IronPort-SDR: jDvZnNXmv7ZMEwvDTvkHrWl1QyyKdNEA3gnGhH1PDQ/+1yBzxlSkZwCLnze7JIhc7H/jHpmwiy
 rdqhmuD5DNXA==
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="552314854"
Received: from ticela-az-103.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.36.77])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 08:40:31 -0700
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
Subject: [RFC v2-fix-v2 3/3] x86/tdx: Handle port I/O
Date:   Tue,  8 Jun 2021 08:40:23 -0700
Message-Id: <369a29afba9bb561afa1b77e113a9dae4921fe53.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1623165571.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
Changes since RFC v2-fix-v1:
 * Fixed commit log to adapt to decompression support code split.

 arch/x86/include/asm/io.h |  6 ++++--
 arch/x86/kernel/tdx.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 391205dace98..e01d8bf2b37a 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -310,7 +310,8 @@ static inline unsigned type in##bwl##_p(int port)			\
 									\
 static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    protected_guest_has(VM_UNROLL_STRING_IO)) {			\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			out##bwl(*value, port);				\
@@ -326,7 +327,8 @@ static inline void outs##bwl(int port, const void *addr, unsigned long count) \
 									\
 static inline void ins##bwl(int port, void *addr, unsigned long count)	\
 {									\
-	if (sev_key_active()) {						\
+	if (sev_key_active() ||						\
+	    protected_guest_has(VM_UNROLL_STRING_IO)) {			\
 		unsigned type *value = (unsigned type *)addr;		\
 		while (count) {						\
 			*value = in##bwl(port);				\
diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 3410cfc8a988..48a0cc2663ea 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -201,6 +201,31 @@ static void tdg_handle_cpuid(struct pt_regs *regs)
 	regs->dx = out.r15;
 }
 
+/*
+ * Since the way we fail for string case is different we cannot
+ * reuse tdx_handle_early_io().
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
+	ret = __tdx_hypercall(EXIT_REASON_IO_INSTRUCTION, size, out, port,
+			      regs->ax, &outh);
+	if (!out) {
+		regs->ax &= ~mask;
+		regs->ax |= (ret ? UINT_MAX : outh.r11) & mask;
+	}
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -247,6 +272,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
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

