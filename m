Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34063311B34
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhBFE4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:56:54 -0500
Received: from mga09.intel.com ([134.134.136.24]:63384 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhBFDcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:32:54 -0500
IronPort-SDR: 6CmcQncHTaP+oEPCcwzkV4u9ChCtxAt8zmrz+/WuKPmQgqozKAhd1YFeOjjzZTSUPy2Oo5Am8a
 pDrNQYm3dQLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650736"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650736"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:11 -0800
IronPort-SDR: I96yAc+aPBqc9IxDT6vDvOGwbFRHcdCgXc6reJA8Q1ypIM4EROsOazqPOLnQDQdxNh3oBQbT3c
 65H8LYvTfFzQ==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183916"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:11 -0800
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
Subject: [RFC v1 13/26] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Fri,  5 Feb 2021 15:38:30 -0800
Message-Id: <f443f4a2d80ea3717bd1865ae61cec2a100805c3.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/kernel/tdx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index eff58329751e..8d1d7555fb56 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -451,6 +451,23 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdx_handle_mmio(regs, ve);
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
+	case EXIT_REASON_MWAIT_INSTRUCTION:
+	case EXIT_REASON_MONITOR_INSTRUCTION:
+		/* Handle as nops. */
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

