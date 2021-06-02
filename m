Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0CF397EED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 04:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhFBCYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 22:24:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:39490 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230414AbhFBCXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 22:23:37 -0400
IronPort-SDR: Ls+1Q0CF/i5s5ufBO0oLLJ//o4c5BdVoIkE7YufQ+5qd99swLNLNpMNpYjh/uq+ZdD1io2HAUU
 g0BLzFlE09Tw==
X-IronPort-AV: E=McAfee;i="6200,9189,10002"; a="191037611"
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="191037611"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:52 -0700
IronPort-SDR: /50QWJuamk2Af5O7nXslCfbtggWuype9jayEaMohCzwo8sjQFjQvX2IDm6z81ShHCc48aAY6hp
 Hl1Y+CSZfxpg==
X-IronPort-AV: E=Sophos;i="5.83,241,1616482800"; 
   d="scan'208";a="633069250"
Received: from mjdelaro-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.3.23])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2021 19:21:51 -0700
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
Subject: [PATCH v1 11/11] x86/tdx: Handle CPUID via #VE
Date:   Tue,  1 Jun 2021 19:21:36 -0700
Message-Id: <20210602022136.2186759-12-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210602022136.2186759-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/kernel/tdx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index af7acea500ab..17725646eb30 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -164,6 +164,22 @@ static int tdg_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret ? -EIO : 0;
 }
 
+static void tdg_handle_cpuid(struct pt_regs *regs)
+{
+	u64 ret;
+	struct tdx_hypercall_output out = {0};
+
+	ret = __tdx_hypercall(EXIT_REASON_CPUID, regs->ax,
+			      regs->cx, 0, 0, &out);
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
@@ -207,6 +223,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
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

