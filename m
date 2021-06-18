Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E91D3AD598
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 00:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhFRXBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 19:01:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:13198 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235232AbhFRXA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 19:00:57 -0400
IronPort-SDR: 9N39t9ifnfcmf293b3PaNKtRhW5quOkT7ORsO7dYwsVaiK1V/SbHfxOZPgD4NQc433CnV+L7K+
 dG5SM1CpZ5ZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="193763424"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="193763424"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:46 -0700
IronPort-SDR: 8Fbzprk0uEzkUilq2qMx1L0DtzPy7cXhoPH6hAyWWAFR3Zi+BvDA3mb6pfm8DykelIvd75lLjW
 pkdYodfFeHoA==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="554874205"
Received: from shahdhav-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.6.127])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 15:58:45 -0700
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
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/11] x86/tdx: Handle CPUID via #VE
Date:   Fri, 18 Jun 2021 15:57:55 -0700
Message-Id: <20210618225755.662725-12-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210618225755.662725-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

TDX has three classes of CPUID leaves: some CPUID leaves
are always handled by the CPU, others are handled by the TDX module,
and some others are handled by the VMM. Since the VMM cannot directly
intercept the instruction these are reflected with a #VE exception
to the guest, which then converts it into a hypercall to the VMM,
or handled directly.

The TDX module EAS has a full list of CPUID leaves which are handled
natively or by the TDX module in 16.2. Only unknown CPUIDs are handled by
the #VE method. In practice this typically only applies to the
hypervisor specific CPUIDs unknown to the native CPU.

Therefore there is no risk of causing this in early CPUID code which
runs before the #VE handler is set up because it will never access
those exotic CPUID leaves.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index a02ee45695e6..f48567dce97a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -157,6 +157,21 @@ static int tdg_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret ? -EIO : 0;
 }
 
+static void tdg_handle_cpuid(struct pt_regs *regs)
+{
+	u64 ret;
+	struct tdx_hypercall_output out = {0};
+
+	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
+
+	WARN_ON(ret);
+
+	regs->ax = out.r12;
+	regs->bx = out.r13;
+	regs->cx = out.r14;
+	regs->dx = out.r15;
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -200,6 +215,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdg_write_msr_safe(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		tdg_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

