Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E140EA00
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350129AbhIPSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 14:38:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:52262 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349780AbhIPSiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 14:38:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="286319763"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="286319763"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 11:36:10 -0700
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="545819478"
Received: from rswart-mobl1.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.255.64.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 11:36:09 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Peter H Anvin <hpa@zytor.com>, Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 12/12] x86/tdx: Handle CPUID via #VE
Date:   Thu, 16 Sep 2021 11:35:50 -0700
Message-Id: <20210916183550.15349-13-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210916183550.15349-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

When running virtualized, the CPUID instruction is handled differently
based on the leaf being accessed.  The behavior depends only on the
leaf and applies equally to both kernel/ring-0 and userspace/ring-3
execution of CPUID. Historically, there are two basic classes:

 * Leaves handled transparently to the guest
 * Leaves handled by the VMM

In a typical guest without TDX, "handled by the VMM" leaves cause a
VMEXIT.  TDX replaces these VMEXITs with a #VE exception in the guest.
The guest typically handles the #VE by making a hypercall to the VMM.

The TDX module specification [1], section titled "CPUID Virtualization"
talks about a few more classes of CPUID handling. But, for the purposes
of this patch, the "handled transparently" CPUID leaves are all lumped
together because the guest handling is the same.

[1] - https://software.intel.com/content/dam/develop/external/us/en/documents/tdx-module-1.0-public-spec-v0.931.pdf

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v6:
 * Fixed commit log as per Dave Hansen comments.
 * Added extra comments for _tdx_hypercall() usage.

Changes since v5:
 * Fixed commit log as per review comments.
 * Removed WARN_ON() in tdx_handle_cpuid().
 * Renamed "tdg" prefix with "tdx".

Changes since v4:
 * None

Changes since v3:
 * None

 arch/x86/kernel/tdx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 5c52dde4a5fd..45dbd8863ec0 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -150,6 +150,31 @@ static int tdx_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret ? -EIO : 0;
 }
 
+static u64 tdx_handle_cpuid(struct pt_regs *regs)
+{
+	struct tdx_hypercall_output out = {0};
+	u64 ret;
+
+	/*
+	 * Emulate CPUID instruction via hypercall. More info about
+	 * ABI can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
+	 */
+	ret = _tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out);
+
+	/*
+	 * As per TDX GHCI CPUID ABI, r12-r15 registers contains contents of
+	 * EAX, EBX, ECX, EDX registers after CPUID instruction execution.
+	 * So copy the register contents back to pt_regs.
+	 */
+	regs->ax = out.r12;
+	regs->bx = out.r13;
+	regs->cx = out.r14;
+	regs->dx = out.r15;
+
+	return ret;
+}
+
 unsigned long tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out = {0};
@@ -193,6 +218,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		ret = tdx_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

