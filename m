Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93256350E41
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 06:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhDAEwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 00:52:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:58121 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhDAEwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 00:52:38 -0400
IronPort-SDR: Q82hAnI764AJRElUUeHeqvKbM4X4D50f2MNnWXaarukMH0fP3bLtqQoBEls/w+EdR78T909Y9P
 jVpGAOP6hhHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="192251908"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="192251908"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 21:52:02 -0700
IronPort-SDR: C2gODEKp7lo2dhuKBo4fiJCVkdGAOB+LzvNwkC7FGJCP6KK/LJ2ef4DrNtSudevkcLfTkqAhd+
 pg3XBfO4UfkA==
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; 
   d="scan'208";a="412496407"
Received: from sjard-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.174.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 21:52:01 -0700
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
Subject: [PATCH v5 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Wed, 31 Mar 2021 21:51:30 -0700
Message-Id: <2d097239a74ff1eb80653cfff1f1e16b0211e60e.1617252428.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401042436.GJ1285835@tassilo.jf.intel.com>
References: <20210401042436.GJ1285835@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running as a TDX guest, there are a number of existing,
privileged instructions that do not work. If the guest kernel
uses these instructions, the hardware generates a #VE.

You can find the list of unsupported instructions in Intel
Trust Domain Extensions (Intel® TDX) Module specification,
sec 9.2.2 and in Guest-Host Communication Interface (GHCI)
Specification for Intel TDX, sec 2.4.1.
   
To prevent TD guest from using these unsupported instructions,
following measures are adapted:
   
1. For MWAIT/MONITOR instructions, support for these
instructions are already disabled by TDX module (SEAM).
So CPUID flags for these instructions should be in disabled
state. Also, just to be sure that these instructions are
disabled, forcefully unset X86_FEATURE_MWAIT CPU cap in OS.
       
2. For WBINVD instruction, we use audit to find the code that
uses this instruction and disable them for TD.

After the above mentioned preventive measures, if TD guests still
execute these instructions, add appropriate warning messages in #VE
handler.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---

Changes since v4:
 * Fixed commit log and comments as per Dave's comments
 * Used WARN_ONCE for MWAIT/MONITOR #VE.
 * Removed X86_FEATURE_MWAIT suppression code.

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

 arch/x86/kernel/tdx.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e936b2f88bf6..9bc84caf4096 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -362,6 +362,22 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	case EXIT_REASON_WBINVD:
+		/*
+		 * WBINVD is not supported inside TDX guests. All in-
+		 * kernel uses should have been disabled.
+		 */
+		pr_err("TD Guest used unsupported WBINVD instruction\n");
+		BUG();
+		break;
+	case EXIT_REASON_MONITOR_INSTRUCTION:
+	case EXIT_REASON_MWAIT_INSTRUCTION:
+		/*
+		 * Something in the kernel used MONITOR or MWAIT despite
+		 * X86_FEATURE_MWAIT being cleared for TDX guests.
+		 */
+		WARN_ONCE(1, "TD Guest used unsupported MWAIT/MONITOR instruction\n");
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

