Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16F934B350
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 01:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhC0ATb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 20:19:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:48252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230299AbhC0AS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 20:18:57 -0400
IronPort-SDR: fXwo0yQhp1T9JE3RsciYIgc3Gz9ILaHSN3M+geh1gSWE/BgZZ29vuE/d0AU8oTT0+yDDnThFZu
 ViMDaI+e3WwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191274076"
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="191274076"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 17:18:56 -0700
IronPort-SDR: B87GfP4DtzqNdrNhYTI8yhd1qCp6G7jiybI53sCs37Wrmk2Tmy51Mll7Q5ZFYbJzZzT2qvPI7F
 TXXf4H3bMzzw==
X-IronPort-AV: E=Sophos;i="5.81,282,1610438400"; 
   d="scan'208";a="410128575"
Received: from zcmahone-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.255.231.203])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 17:18:55 -0700
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
Subject: [PATCH v1 1/1] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Fri, 26 Mar 2021 17:18:22 -0700
Message-Id: <331b34e3d6153f0a7b0ab0a9a8cb5de71f0bfd93.1616803999.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
References: <CALCETrUgEFy4shmh_pxOTzEVJZq8y23zK7cr51UhXba0KhQ8qg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-root TDX guest mode, MWAIT, MONITOR and WBINVD instructions
are not supported. So handle #VE due to these instructions as no ops.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---

Changes since previous series:
 * Suppressed MWAIT feature as per Andi's comment.
 * Added warning debug log for MWAIT #VE exception.

 arch/x86/kernel/tdx.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index e936b2f88bf6..fb7d22b846fc 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -308,6 +308,9 @@ void __init tdx_early_init(void)
 
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
 
+	/* MWAIT is not supported in TDX platform, so suppress it */
+	setup_clear_cpu_cap(X86_FEATURE_MWAIT);
+
 	tdg_get_info();
 
 	pv_ops.irq.safe_halt = tdg_safe_halt;
@@ -362,6 +365,26 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	/*
+	 * Per Guest-Host-Communication Interface (GHCI) for Intel Trust
+	 * Domain Extensions (Intel TDX) specification, sec 2.4,
+	 * some instructions that unconditionally cause #VE (such as WBINVD,
+	 * MONITOR, MWAIT) do not have corresponding TDCALL
+	 * [TDG.VP.VMCALL <Instruction>] leaves, since the TD has been designed
+	 * with no deterministic way to confirm the result of those operations
+	 * performed by the host VMM.  In those cases, the goal is for the TD
+	 * #VE handler to increment the RIP appropriately based on the VE
+	 * information provided via TDCALL.
+	 */
+	case EXIT_REASON_WBINVD:
+		pr_warn_once("WBINVD #VE Exception\n");
+	case EXIT_REASON_MONITOR_INSTRUCTION:
+		/* Handle as nops. */
+		break;
+	case EXIT_REASON_MWAIT_INSTRUCTION:
+		/* MWAIT is supressed, not supposed to reach here. */
+		pr_warn("MWAIT unexpected #VE Exception\n");
+		return -EFAULT;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

