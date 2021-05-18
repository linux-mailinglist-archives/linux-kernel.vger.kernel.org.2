Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8B386E71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 02:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbhERAto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 20:49:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:60295 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239874AbhERAtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 20:49:42 -0400
IronPort-SDR: ymV8JGPCx/fE4YfKJoaNyKxMt1ln4IMcS+ohL3PJFnPky6/lGgucr+e0arPqNFjmcyfYTzujYQ
 d+G1pQaSKWlQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180876267"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180876267"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:48:21 -0700
IronPort-SDR: FUghebYxmyHkEfASwtQj+fiV0+K7tyLLmUqhDhZWBbEIvl8S3Vy39NO2WSIPz1icLzGmS4K/bP
 UAGHQLa9u0dQ==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="411046683"
Received: from sdayal-mobl.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.213.167.196])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 17:48:20 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2-fix 1/1] x86/tdx: Handle in-kernel MMIO
Date:   Mon, 17 May 2021 17:48:07 -0700
Message-Id: <20210518004807.258503-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
References: <3e9a26c3-8eee-88f5-f8e2-8a2dd2c028ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

In traditional VMs, MMIO tends to be implemented by giving a
guest access to a mapping which will cause a VMEXIT on access.
That's not possible in TDX guest. So use #VE to implement MMIO
support. In TDX guest, MMIO triggers #VE with EPT_VIOLATION
exit reason.

For now we only handle a subset of instructions that the kernel
uses for MMIO operations. User-space access triggers SIGBUS.

Also, reasons for supporting #VE based MMIO in TDX guest are,

* MMIO is widely used and we'll have more drivers in the future.
* We don't want to annotate every TDX specific MMIO readl/writel etc.
* If we didn't annotate we would need to add an alternative to every
  MMIO access in the kernel (even though 99.9% will never be used on
  TDX) which would be a complete waste and incredible binary bloat
  for nothing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since RFC v2:
 * Fixed commit log as per Dave's review.

 arch/x86/kernel/tdx.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index b9e3010987e0..9330c7a9ad69 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,8 @@
 
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <linux/sched/signal.h> /* force_sig_fault() */
 
 #include <linux/cpu.h>
 #include <linux/protected_guest.h>
@@ -209,6 +211,101 @@ static void tdg_handle_io(struct pt_regs *regs, u32 exit_qual)
 	}
 }
 
+static unsigned long tdg_mmio(int size, bool write, unsigned long addr,
+		unsigned long val)
+{
+	return tdx_hypercall_out_r11(EXIT_REASON_EPT_VIOLATION, size,
+				     write, addr, val);
+}
+
+static inline void *get_reg_ptr(struct pt_regs *regs, struct insn *insn)
+{
+	static const int regoff[] = {
+		offsetof(struct pt_regs, ax),
+		offsetof(struct pt_regs, cx),
+		offsetof(struct pt_regs, dx),
+		offsetof(struct pt_regs, bx),
+		offsetof(struct pt_regs, sp),
+		offsetof(struct pt_regs, bp),
+		offsetof(struct pt_regs, si),
+		offsetof(struct pt_regs, di),
+		offsetof(struct pt_regs, r8),
+		offsetof(struct pt_regs, r9),
+		offsetof(struct pt_regs, r10),
+		offsetof(struct pt_regs, r11),
+		offsetof(struct pt_regs, r12),
+		offsetof(struct pt_regs, r13),
+		offsetof(struct pt_regs, r14),
+		offsetof(struct pt_regs, r15),
+	};
+	int regno;
+
+	regno = X86_MODRM_REG(insn->modrm.value);
+	if (X86_REX_R(insn->rex_prefix.value))
+		regno += 8;
+
+	return (void *)regs + regoff[regno];
+}
+
+static int tdg_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+{
+	int size;
+	bool write;
+	unsigned long *reg;
+	struct insn insn;
+	unsigned long val = 0;
+
+	/*
+	 * User mode would mean the kernel exposed a device directly
+	 * to ring3, which shouldn't happen except for things like
+	 * DPDK.
+	 */
+	if (user_mode(regs)) {
+		pr_err("Unexpected user-mode MMIO access.\n");
+		force_sig_fault(SIGBUS, BUS_ADRERR, (void __user *) ve->gla);
+		return 0;
+	}
+
+	kernel_insn_init(&insn, (void *) regs->ip, MAX_INSN_SIZE);
+	insn_get_length(&insn);
+	insn_get_opcode(&insn);
+
+	write = ve->exit_qual & 0x2;
+
+	size = insn.opnd_bytes;
+	switch (insn.opcode.bytes[0]) {
+	/* MOV r/m8	r8	*/
+	case 0x88:
+	/* MOV r8	r/m8	*/
+	case 0x8A:
+	/* MOV r/m8	imm8	*/
+	case 0xC6:
+		size = 1;
+		break;
+	}
+
+	if (inat_has_immediate(insn.attr)) {
+		BUG_ON(!write);
+		val = insn.immediate.value;
+		tdg_mmio(size, write, ve->gpa, val);
+		return insn.length;
+	}
+
+	BUG_ON(!inat_has_modrm(insn.attr));
+
+	reg = get_reg_ptr(regs, &insn);
+
+	if (write) {
+		memcpy(&val, reg, size);
+		tdg_mmio(size, write, ve->gpa, val);
+	} else {
+		val = tdg_mmio(size, write, ve->gpa, val);
+		memset(reg, 0, size);
+		memcpy(reg, &val, size);
+	}
+	return insn.length;
+}
+
 unsigned long tdg_get_ve_info(struct ve_info *ve)
 {
 	u64 ret;
@@ -258,6 +355,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_IO_INSTRUCTION:
 		tdg_handle_io(regs, ve->exit_qual);
 		break;
+	case EXIT_REASON_EPT_VIOLATION:
+		ve->instr_len = tdg_handle_mmio(regs, ve);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

