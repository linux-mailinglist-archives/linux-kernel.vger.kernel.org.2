Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BF427452
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 01:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbhJHXnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 19:43:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:35990 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244009AbhJHXnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 19:43:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10131"; a="213752115"
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="213752115"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 16:40:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,358,1624345200"; 
   d="scan'208";a="590706824"
Received: from dmsojoza-mobl3.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.251.135.62])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 16:40:38 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Subject: [PATCH v9 11/11] x86/tdx: Handle CPUID via #VE
Date:   Fri,  8 Oct 2021 16:40:09 -0700
Message-Id: <20211008234009.1211215-12-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008234009.1211215-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20211008234009.1211215-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

Changes since v8:
 * Removed zero initialization of struct tdx_hypercall_output in
   tdx_handle_cpuid().
 * Changed return type of tdx_handle_cpuid() to bool.

Changes since v7: 
 * None

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
index 7c6c84015302..f8f242215dbc 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -143,6 +143,31 @@ static bool tdx_write_msr_safe(unsigned int msr, unsigned int low,
 	return ret ? false : true;
 }
 
+static bool tdx_handle_cpuid(struct pt_regs *regs)
+{
+	struct tdx_hypercall_output out;
+
+	/*
+	 * Emulate CPUID instruction via hypercall. More info about
+	 * ABI can be found in TDX Guest-Host-Communication Interface
+	 * (GHCI), section titled "VP.VMCALL<Instruction.CPUID>".
+	 */
+	if (_tdx_hypercall(EXIT_REASON_CPUID, regs->ax, regs->cx, 0, 0, &out))
+		return false;
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
+	return true;
+}
+
 bool tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out;
@@ -191,6 +216,9 @@ bool tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_MSR_WRITE:
 		ret = tdx_write_msr_safe(regs->cx, regs->ax, regs->dx);
 		break;
+	case EXIT_REASON_CPUID:
+		ret = tdx_handle_cpuid(regs);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return false;
-- 
2.25.1

