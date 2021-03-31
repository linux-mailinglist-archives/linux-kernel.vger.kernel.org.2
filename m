Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 424463508F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbhCaVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:10:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:47630 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233291AbhCaVKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:10:19 -0400
IronPort-SDR: oZegbmosS8oeMsEHK6esgpfQTy3r8y45rEraGFDSs2QptKr36mAAc8MF1cR89HeTD4e9XLWRa4
 asyYncauybrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="189860375"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="189860375"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:10:11 -0700
IronPort-SDR: SmGk/Jaofhn11Elbj0KQMbIBGFtymvgsCuuvONoHwZCDjk4HeGXve99bX775xN0fO03/0AThea
 w0cx9UQuq3AA==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="412355353"
Received: from sjard-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.174.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 14:10:09 -0700
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
Subject: [PATCH v4 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Wed, 31 Mar 2021 14:09:59 -0700
Message-Id: <e62cfd0ae90de435e6819979d9027f76d835a22a.1617224710.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
References: <2FE32855-EA5D-44E4-AACC-25E9B1476547@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per Guest-Host Communication Interface (GHCI) Specification
for Intel TDX, sec 2.4.1, TDX architecture does not support
MWAIT, MONITOR and WBINVD instructions. So in non-root TDX mode,
if MWAIT/MONITOR instructions are executed with CPL != 0 it will
trigger #UD, and for CPL = 0 case, virtual exception (#VE) is
triggered. WBINVD instruction behavior is also similar to
MWAIT/MONITOR, but for CPL != 0 case, it will trigger #GP instead
of #UD.

To prevent TD guest from using these unsupported instructions,
following measures are adapted:

1. For MWAIT/MONITOR instructions, support for these instructions
are already disabled by TDX module (SEAM). So CPUID flags for
these instructions should be in disabled state. Also, just to be
sure that these instructions are disabled, forcefully unset
X86_FEATURE_MWAIT CPU cap in OS.

2. For WBINVD instruction, we use audit to find the code that uses
this instruction and disable them for TD.

After the above mentioned preventive measures, if TD guest still
execute these instructions, add appropriate warning messages in #VE
handler.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---

Changes since v3:
 * WARN user if SEAM does not disable MONITOR/MWAIT instruction.
 * Fix the commit log and comments to address review comments from
   from Dave & Sean.

Changes since v2:
 * Added BUG() for WBINVD, WARN for MONITOR instructions.
 * Fixed comments as per Dave's review.

Changes since v1:
 * Added WARN() for MWAIT #VE exception.

Changes since previous series:
 * Suppressed MWAIT feature as per Andi's comment.
 * Added warning debug log for MWAIT #VE exception.

 arch/x86/kernel/tdx.c | 44 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e936b2f88bf6..82b411b828a5 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -63,6 +63,14 @@ static inline bool cpuid_has_tdx_guest(void)
 	return true;
 }
 
+static inline bool cpuid_has_mwait(void)
+{
+	if (cpuid_ecx(1) & (1 << (X86_FEATURE_MWAIT % 32)))
+		return true;
+
+	return false;
+}
+
 bool is_tdx_guest(void)
 {
 	return static_cpu_has(X86_FEATURE_TDX_GUEST);
@@ -301,12 +309,25 @@ static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
 	return insn.length;
 }
 
+/* Initialize TDX specific CPU capabilities */
+static void __init tdx_cpu_cap_init(void)
+{
+	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+
+	if (cpuid_has_mwait()) {
+		WARN(1, "TDX Module failed to disable MWAIT\n");
+		/* MWAIT is not supported in TDX platform, so suppress it */
+		setup_clear_cpu_cap(X86_FEATURE_MWAIT);
+	}
+
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
 		return;
 
-	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
+	tdx_cpu_cap_init();
 
 	tdg_get_info();
 
@@ -362,6 +383,27 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	case EXIT_REASON_WBINVD:
+		/*
+		 * TDX architecture does not support WBINVD instruction.
+		 * Currently, usage of this instruction is prevented by
+		 * disabling the drivers which uses it. So if we still
+		 * reach here, it needs user attention.
+		 */
+		pr_err("TD Guest used unsupported WBINVD instruction\n");
+		BUG();
+		break;
+	case EXIT_REASON_MONITOR_INSTRUCTION:
+	case EXIT_REASON_MWAIT_INSTRUCTION:
+		/*
+		 * MWAIT/MONITOR features are disabled by TDX Module (SEAM)
+		 * and also re-suppressed in kernel by clearing
+		 * X86_FEATURE_MWAIT CPU feature flag in tdx_early_init(). So
+		 * if TD guest still executes MWAIT/MONITOR instruction with
+		 * above suppression, it needs user attention.
+		 */
+		WARN(1, "TD Guest used unsupported MWAIT/MONITOR instruction\n");
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

