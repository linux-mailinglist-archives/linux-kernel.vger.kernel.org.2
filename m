Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DD634DC57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 01:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhC2XRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 19:17:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:10854 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhC2XRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 19:17:21 -0400
IronPort-SDR: NFdBpGQmtb+alLH3ZwJqkzE8lSFQiAlyuP/QJQtrQwbf+qUEZkhnoAlAy3P8YjUnC3zMEC/Z0i
 i0swwUBWb7Qw==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191743015"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191743015"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 16:17:19 -0700
IronPort-SDR: Z5W0BMz5p8K2prWGUK0s1hxhRXMVSn9v/y8W2FVfTOvWCMp6wfu0nY2P2k38RUIchYFJLZx9vI
 O0477Mk34e1A==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="411316263"
Received: from ajzangar-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.145.70])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 16:17:18 -0700
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
Subject: [PATCH v3 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Mon, 29 Mar 2021 16:16:15 -0700
Message-Id: <837afe840f5826bf7fcba07a5e483d7e2283db34.1617059703.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0356a84a-765e-b20b-2efd-c5d94fc2347e@intel.com>
References: <0356a84a-765e-b20b-2efd-c5d94fc2347e@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
are not supported. So handle #VE due to these instructions
appropriately.

Since the impact of executing WBINVD instruction in non ring-0 mode
can be heavy, use BUG() to report it. For others, raise a WARNING
message.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---

Changes since v2:
 * Added BUG() for WBINVD, WARN for MONITOR instructions.
 * Fixed comments as per Dave's review.

Changes since v1:
 * Added WARN() for MWAIT #VE exception.

Changes since previous series:
 * Suppressed MWAIT feature as per Andi's comment.
 * Added warning debug log for MWAIT #VE exception.

 arch/x86/kernel/tdx.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e936b2f88bf6..4c6336a055a3 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -308,6 +308,9 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	/* MWAIT is not supported in TDX platform, so suppress it */
+	setup_clear_cpu_cap(X86_FEATURE_MWAIT);
+
 	tdg_get_info();
 
 	pv_ops.irq.safe_halt = tdg_safe_halt;
@@ -362,6 +365,32 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	case EXIT_REASON_WBINVD:
+		/*
+		 * WBINVD is a privileged instruction, can only be executed
+		 * in ring 0. Since we reached here, the kernel is in buggy
+		 * state.
+		 */
+		pr_err("WBINVD #VE Exception\n");
+		BUG();
+		break;
+	case EXIT_REASON_MONITOR_INSTRUCTION:
+		/*
+		 * MONITOR is a privileged instruction, can only be executed
+		 * in ring 0. So we are not supposed to reach here. Raise a
+		 * warning message.
+		 */
+		WARN(1, "MONITOR unexpected #VE Exception\n");
+		break;
+	case EXIT_REASON_MWAIT_INSTRUCTION:
+		/*
+		 * MWAIT feature is suppressed in firmware and in
+		 * tdx_early_init() by clearing X86_FEATURE_MWAIT CPU feature
+		 * flag. Since we are not supposed to reach here, raise a
+		 * warning message and return -EFAULT.
+		 */
+		WARN(1, "MWAIT unexpected #VE Exception\n");
+		return -EFAULT;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

