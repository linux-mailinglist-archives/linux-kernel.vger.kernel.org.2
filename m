Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBA4311B13
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhBFEqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:46:13 -0500
Received: from mga09.intel.com ([134.134.136.24]:63380 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231936AbhBFD0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:26:12 -0500
IronPort-SDR: Y8BbK6XKvWo4KDpypLEyeU4AkE6n1u4aMt8KgE0NVxzeSQDELIun09vEAr0yAgCNirl8q0jcPv
 CLIiKtQcs7mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650725"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650725"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:09 -0800
IronPort-SDR: zxJsciv0+8epPRn9N5FVUle4SibbBi6SVYKn1UlNIvSb2DnHJPZT7aYKRTW7QSPsUd63hMpRX9
 x2JttSS7YRMQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183895"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:07 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 09/26] x86/tdx: Handle CPUID via #VE
Date:   Fri,  5 Feb 2021 15:38:26 -0800
Message-Id: <e45fcb584cd9fd67e6585ad8a904659a8b2ff9a5.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX has three classes of CPUID leaves: some CPUID leaves
are always handled by the CPU, others are handled by the TDX module,
and some others are handled by the VMM. Since the VMM cannot directly
intercept the instruction these are reflected with a #VE exception
to the guest, which then converts it into a TDCALL to the VMM,
or handled directly.

The TDX module EAS has a full list of CPUID leaves which are handled
natively or by the TDX module in 16.2. Only unknown CPUIDs are handled by
the #VE method. In practice this typically only applies to the
hypervisor specific CPUIDs unknown to the native CPU.

Therefore there is no risk of causing this in early CPUID code which
runs before the #VE handler is set up because it will never access
those exotic CPUID leaves.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5d961263601e..e98058c048b5 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -172,6 +172,35 @@ static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret || r10 ? -EIO : 0;
 }
 
+static void tdx_handle_cpuid(struct pt_regs *regs)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_CPUID;
+	register long r12 asm("r12") = regs->ax;
+	register long r13 asm("r13") = regs->cx;
+	register long r14 asm("r14");
+	register long r15 asm("r15");
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
+			  "=r"(r14), "=r"(r15)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13)
+			: );
+
+	regs->ax = r12;
+	regs->bx = r13;
+	regs->cx = r14;
+	regs->dx = r15;
+
+	WARN_ON(ret || r10);
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -227,6 +256,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		tdx_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

