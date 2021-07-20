Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0A03CF189
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbhGTBAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:00:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:28258 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378872AbhGTAKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 20:10:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="191435156"
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="191435156"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:12 -0700
X-IronPort-AV: E=Sophos;i="5.84,253,1620716400"; 
   d="scan'208";a="660970671"
Received: from ywei11-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.138.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 17:42:12 -0700
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
Subject: [PATCH v4 08/11] x86/tdx: Add HLT support for TDX guest
Date:   Mon, 19 Jul 2021 17:40:54 -0700
Message-Id: <20210720004057.2112666-9-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210720004057.2112666-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Per Guest-Host-Communication Interface (GHCI) for Intel Trust
Domain Extensions (Intel TDX) specification, sec 3.8,
TDVMCALL[Instruction.HLT] provides HLT operation. Use it to implement
halt() and safe_halt() paravirtualization calls.

The same TDX hypercall is used to handle #VE exception due to
EXIT_REASON_HLT.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v3:
 * None

 arch/x86/kernel/tdx.c | 51 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 1bbcf7626af2..b6e744a5521a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/protected_guest.h>
 
 #include <asm/tdx.h>
+#include <asm/vmx.h>
 
 /* TDX Module call Leaf IDs */
 #define TDINFO				1
@@ -80,6 +81,33 @@ static void tdg_get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+static __cpuidle void tdg_halt(void)
+{
+	u64 ret;
+
+	ret = _tdx_hypercall(EXIT_REASON_HLT, irqs_disabled(), 0, 0, 0, NULL);
+
+	/* It should never fail */
+	BUG_ON(ret);
+}
+
+static __cpuidle void tdg_safe_halt(void)
+{
+	u64 ret;
+
+	/*
+	 * Enable interrupts next to the TDVMCALL to avoid
+	 * performance degradation.
+	 */
+	local_irq_enable();
+
+	/* IRQ is enabled, So set R12 as 0 */
+	ret = _tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 0, NULL);
+
+	/* It should never fail */
+	BUG_ON(ret);
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -106,13 +134,19 @@ unsigned long tdg_get_ve_info(struct ve_info *ve)
 int tdg_handle_virtualization_exception(struct pt_regs *regs,
 					struct ve_info *ve)
 {
-	/*
-	 * TODO: Add handler support for various #VE exit
-	 * reasons. It will be added by other patches in
-	 * the series.
-	 */
-	pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
-	return -EFAULT;
+	switch (ve->exit_reason) {
+	case EXIT_REASON_HLT:
+		tdg_halt();
+		break;
+	default:
+		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
+		return -EFAULT;
+	}
+
+	/* After successful #VE handling, move the IP */
+	regs->ip += ve->instr_len;
+
+	return 0;
 }
 
 void __init tdx_early_init(void)
@@ -124,5 +158,8 @@ void __init tdx_early_init(void)
 
 	tdg_get_info();
 
+	pv_ops.irq.safe_halt = tdg_safe_halt;
+	pv_ops.irq.halt = tdg_halt;
+
 	pr_info("Guest initialized\n");
 }
-- 
2.25.1

