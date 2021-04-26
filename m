Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912BE36B896
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbhDZSEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:04:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:22346 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234343AbhDZSDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:03:34 -0400
IronPort-SDR: JXKp49xNFJmyM+l6yrxqwyWoQ1l6Kr5SFNQBHFqvxEjs6kkKomXJ0mRr41T9EXKAOHdTCdCfal
 rzIYQ0wtb0iA==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194263256"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194263256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:49 -0700
IronPort-SDR: mlGVjO1wrTFdncFOqXW/bWAUFNx5U0EPmvS4OlFPWORQwqmGUUzVxkN3kph/rC8Y73uH803fp/
 wRNLLrvrqzqQ==
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="447353395"
Received: from ssumanpx-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.34.197])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 11:02:49 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [RFC v2 15/32] x86/tdx: Handle in-kernel MMIO
Date:   Mon, 26 Apr 2021 11:01:42 -0700
Message-Id: <38eb0c5dce2e2ff6bdab4dffbead09780ec86e50.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
 arch/x86/kernel/tdx.c | 100 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index ec61f2f06c98..3fe617978fc4 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -5,6 +5,8 @@
 
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <linux/sched/signal.h> /* force_sig_fault() */
 
 #include <linux/cpu.h>
 
@@ -219,6 +221,101 @@ static void tdg_handle_io(struct pt_regs *regs, u32 exit_qual)
 	}
 }
 
+static unsigned long tdg_mmio(int size, bool write, unsigned long addr,
+		unsigned long val)
+{
+	return tdvmcall_out_r11(EXIT_REASON_EPT_VIOLATION, size,
+				write, addr, val);
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
@@ -271,6 +368,9 @@ int tdg_handle_virtualization_exception(struct pt_regs *regs,
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

