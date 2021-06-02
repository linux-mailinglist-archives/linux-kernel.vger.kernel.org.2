Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5262B397EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhFBCXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:23:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:26376 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhFBCXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:23:33 -0400
IronPort-SDR: TUq1LvvOgFN2PrVKu06JeKo5W9D8Owusi+utdwjSF0Te9PYyy4nNRi4dOm81iqwTGTcRtvTl5+
 d22zAj+pJT+w==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="267560434"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="267560434"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:50 -0700
IronPort-SDR: wVYhzber/HAjpBqX0tvlGfcslu7E+4JI5ohQ55hzStysAvdvZNOz6DUS2Ln8JiB0Qzm3n0Q6Ao
 zOoSUZw3EKIw==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633069227"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:49 -0700
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
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH v1 08/11] x86/tdx: Add HLT support for TDX guest
Date:   Tue,  1 Jun 2021 19:21:33 -0700
Message-Id: <20210602022136.2186759-9-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/kernel/tdx.c | 50 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 527d2638ddae..76b71bf56b81 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -88,6 +88,33 @@ static void tdg_get_info(void)
 	td_info.attributes = out.rdx;
 }
 
+static __cpuidle void tdg_halt(void)
+{
+	u64 ret;
+
+	ret = __tdx_hypercall(EXIT_REASON_HLT, irqs_disabled(), 0, 0, 0, NULL);
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
+	ret = __tdx_hypercall(EXIT_REASON_HLT, 0, 0, 0, 0, NULL);
+
+	/* It should never fail */
+	BUG_ON(ret);
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -114,13 +141,19 @@ unsigned long tdg_get_ve_info(struct ve_info *ve)
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
@@ -132,5 +165,8 @@ void __init tdx_early_init(void)
 
 	tdg_get_info();
 
+	pv_ops.irq.safe_halt = tdg_safe_halt;
+	pv_ops.irq.halt = tdg_halt;
+
 	pr_info("TDX guest is initialized\n");
 }
-- 
2.25.1

