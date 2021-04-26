Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E6836B899
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234595AbhDZSEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:39 -0400
Received: from mga04.intel.com ([192.55.52.120]:22343 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234148AbhDZSDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:34 -0400
IronPort-SDR: kbUIcSiUQuDuo4K3U5xpw1d2AWSF/mlYNC9lgwzLFm9aY6bEZKAFUedXxlMGbmlFmR5943Z5lP
 P6gEsoIb/UpA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263258"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263258"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:50 -0700
IronPort-SDR: TZoklZsXDchjOM4p2zZP7e3bYTlApnrnKHxrPMqoDZMFUplpEIZNxZjDe13rn6YqcZGnsZZibw
 OgIHWi4lETWQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353400"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:49 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 16/32] x86/tdx: Handle MWAIT, MONITOR and WBINVD
Date:   Mon, 26 Apr 2021 11:01:43 -0700
Message-Id: <d6ca05720290060e909c1f4d12858f900f1be0e7.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
   
To prevent TD guest from using MWAIT/MONITOR instructions,
support for these instructions are already disabled by TDX
module (SEAM). So CPUID flags for these instructions should
be in disabled state.

After the above mentioned preventive measures, if TD guests still
execute these instructions, add appropriate warning messages in #VE
handler. For WBIND instruction, since it's related to memory writeback
and cache flushes, it's mainly used in context of IO devices. Since
TDX 1.0 does not support non-virtual I/O devices, skipping it should
not cause any fatal issues. But to let users know about its usage, use
WARN() to report about it.. For MWAIT/MONITOR instruction, since its
unsupported use WARN() to report unsupported usage.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 3fe617978fc4..294dda5bf3f6 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -371,6 +371,21 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_EPT_VIOLATION:
 		ve->instr_len = tdg_handle_mmio(regs, ve);
 		break;
+	case EXIT_REASON_WBINVD:
+		/*
+		 * WBINVD is not supported inside TDX guests. All in-
+		 * kernel uses should have been disabled.
+		 */
+		WARN_ONCE(1, "TD Guest used unsupported WBINVD instruction\n");
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
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

