Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46A13B4EE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhFZOUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:20:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:42506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230138AbhFZOUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:20:00 -0400
IronPort-SDR: nePpqpUJ13CxmgDbU25pv5SkNu0HT6uY5NVmXe7AkCBN7VMOZVhd6nu7K+/G7sm8zeP0x2UMZb
 WFX4zzqVCi4Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207729787"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207729787"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:38 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="624775900"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:37 -0700
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
Subject: [PATCH v2 10/10] x86/tdx: Handle MWAIT and MONITOR
Date:   Sat, 26 Jun 2021 07:17:18 -0700
Message-Id: <7d721334987012691cad9d17e35d6002e1fb81ce.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

To prevent TD guests from using MWAIT/MONITOR instructions,
the CPUID flags for these instructions are already disabled
by the TDX module. 
   
After the above mentioned preventive measures, if TD guests
still execute these instructions, add appropriate warning
message (WARN_ONCE()) in #VE handler. This handling behavior
is same as KVM (which also treats MWAIT/MONITOR as nops with
warning once in unsupported platforms).

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/kernel/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index f112b915c295..b0ffa106f2e9 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -363,6 +363,14 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 			return -EFAULT;
 		}
 		break;
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

