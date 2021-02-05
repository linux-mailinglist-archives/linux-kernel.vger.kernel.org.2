Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E99311B32
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbhBFE4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:56:06 -0500
Received: from mga09.intel.com ([134.134.136.24]:63285 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231946AbhBFDbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:31:53 -0500
IronPort-SDR: DphWLePmpczsG9z6/QFbvPwObBSWjnLhUqwWs9NfQtUy17zF18NjK+E+eqRo4NZRiy8GYxYEcc
 Hxa7NB9dJzSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="181650733"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="181650733"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:11 -0800
IronPort-SDR: l/Ecpv9+4nyOqROk2INJr8YPTQOZjsuG0n/2RGdMAHguXwCQfki9zUgO+zM83RMk6VEKWsotKF
 9e/ujM+/sXEw==
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="416183911"
Received: from mdhake-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.53.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 15:39:10 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v1 12/26] x86/tdx: Handle in-kernel MMIO
Date:   Fri,  5 Feb 2021 15:38:29 -0800
Message-Id: <94a9847072098e554146ca4fa3c6f28fc1ac5b22.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Handle #VE due to MMIO operations. MMIO triggers #VE with EPT_VIOLATION
exit reason.

For now we only handle subset of instruction that kernel uses for MMIO
oerations. User-space access triggers SIGBUS.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/kernel/tdx.c | 120 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 3846d2807a7a..eff58329751e 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -6,6 +6,8 @@
 #include <linux/cpu.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <linux/sched/signal.h> /* force_sig_fault() */
 
 #ifdef CONFIG_KVM_GUEST
 #include "tdx-kvm.c"
@@ -270,6 +272,121 @@ static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
 	}
 }
 
+static unsigned long tdx_mmio(int size, bool write, unsigned long addr,
+		unsigned long val)
+{
+	register long r10 asm("r10") = TDVMCALL_STANDARD;
+	register long r11 asm("r11") = EXIT_REASON_EPT_VIOLATION;
+	register long r12 asm("r12") = size;
+	register long r13 asm("r13") = write;
+	register long r14 asm("r14") = addr;
+	register long r15 asm("r15") = val;
+	register long rcx asm("rcx");
+	long ret;
+
+	/* Allow to pass R10, R11, R12, R13, R14 and R15 down to the VMM */
+	rcx = BIT(10) | BIT(11) | BIT(12) | BIT(13) | BIT(14) | BIT(15);
+
+	asm volatile(TDCALL
+			: "=a"(ret), "=r"(r10), "=r"(r11), "=r"(r12), "=r"(r13),
+			  "=r"(r14), "=r"(r15)
+			: "a"(TDVMCALL), "r"(rcx), "r"(r10), "r"(r11), "r"(r12),
+			  "r"(r13), "r"(r14), "r"(r15)
+			: );
+
+	WARN_ON(ret || r10);
+
+	return r11;
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
+static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
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
+		tdx_mmio(size, write, ve->gpa, val);
+		return insn.length;
+	}
+
+	BUG_ON(!inat_has_modrm(insn.attr));
+
+	reg = get_reg_ptr(regs, &insn);
+
+	if (write) {
+		memcpy(&val, reg, size);
+		tdx_mmio(size, write, ve->gpa, val);
+	} else {
+		val = tdx_mmio(size, write, ve->gpa, val);
+		memset(reg, 0, size);
+		memcpy(reg, &val, size);
+	}
+	return insn.length;
+}
+
 void __init tdx_early_init(void)
 {
 	if (!cpuid_has_tdx_guest())
@@ -331,6 +448,9 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_IO_INSTRUCTION:
 		tdx_handle_io(regs, ve->exit_qual);
 		break;
+	case EXIT_REASON_EPT_VIOLATION:
+		ve->instr_len = tdx_handle_mmio(regs, ve);
+		break;
 	default:
 		pr_warn("Unexpected #VE: %d\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

