Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F183A1F58
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 23:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhFIVtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 17:49:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:4884 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230293AbhFIVsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 17:48:52 -0400
IronPort-SDR: D7lv6gWC/HzVNMFACIYWbZtO36NUXgubMnstNtB14VEysXqftfWexwgvjlnVGM3ah3kVDyp4K4
 9+TWDZcjVuDQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="266330468"
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="266330468"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:32 -0700
IronPort-SDR: rspU343VOP7go2SZ+NiUvLjwGZh60s2cwXr2ah9ijJxt0bPDh4cnpqJrYIBZmvPu4PK3n1QjxE
 ppTTTwOzhpRw==
X-IronPort-AV: E=Sophos;i="5.83,261,1616482800"; 
   d="scan'208";a="448450540"
Received: from qwang4-mobl1.ccr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.35.228])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 14:46:31 -0700
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
Subject: [PATCH v1 10/10] x86/tdx: Handle MWAIT and MONITOR
Date:   Wed,  9 Jun 2021 14:45:55 -0700
Message-Id: <20210609214555.1955404-11-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210609214555.1955404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 56399d9835c2..18844dae1ddf 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -383,6 +383,14 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
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

