Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A74153A5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 00:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238482AbhIVW5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 18:57:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:10397 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238377AbhIVW4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 18:56:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="246164390"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="246164390"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:53 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="653457376"
Received: from mnamagi-mobl1.gar.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.34.84])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 15:54:52 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/10] x86/tdx: Handle in-kernel MMIO
Date:   Wed, 22 Sep 2021 15:52:38 -0700
Message-Id: <20210922225239.3501262-10-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20210922225239.3501262-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

In traditional VMs, MMIO is usually implemented by giving a guest
access to a mapping which will cause a VMEXIT on access and then the
VMM emulating the access. That's not possible in TDX guest because
VMEXIT will expose the register state to the host. TDX guests don't
trust the host and can't have its state exposed to the host. In TDX
the MMIO regions are instead configured to trigger a #VE exception in
the guest. The guest #VE handler then emulates the MMIO instruction
inside the guest and converts them into a controlled TDCALL to the
host, rather than completely exposing the state to the host.

Currently, TDX only supports MMIO for instructions that are known to
come from io.h macros (build_mmio_read/write()). For drivers that don't
use the io.h macros or uses structure overlay to do MMIO are currently
not supported in TDX guest (for example the MMIO based XAPIC is disable
at runtime for TDX).

This way of handling is similar to AMD SEV.

Also, reasons for supporting #VE based MMIO in TDX guest are,

* MMIO is widely used and more drivers will be added in the future.
* To avoid annotating every TDX specific MMIO readl/writel etc.
* If annotation is not preferred, an alternative way is required
  for every MMIO access in the kernel (even though 99.9% will never
  be used on TDX) which would be a complete waste and incredible
  binary bloat for nothing.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---

Changes since v5:
 * None

Changes since v4:
 * Changed order of variable declaration in tdx_handle_mmio().
 * Changed tdg_* prefix with tdx_*.

Changes since v3:
 * None

Changes since v2:
 * None

 arch/x86/kernel/tdx.c | 108 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/arch/x86/kernel/tdx.c b/arch/x86/kernel/tdx.c
index 31a2c2a9722a..aa4719c22c2a 100644
--- a/arch/x86/kernel/tdx.c
+++ b/arch/x86/kernel/tdx.c
@@ -6,6 +6,9 @@
 
 #include <asm/tdx.h>
 #include <asm/vmx.h>
+#include <asm/insn.h>
+#include <asm/insn-eval.h>
+#include <linux/sched/signal.h> /* force_sig_fault() */
 
 /* TDX Module call Leaf IDs */
 #define TDGETVEINFO			3
@@ -212,6 +215,103 @@ static void tdx_handle_io(struct pt_regs *regs, u32 exit_qual)
 	}
 }
 
+static unsigned long tdx_mmio(int size, bool write, unsigned long addr,
+			      unsigned long *val)
+{
+	struct tdx_hypercall_output out = {0};
+	u64 err;
+
+	err = _tdx_hypercall(EXIT_REASON_EPT_VIOLATION, size, write,
+			     addr, *val, &out);
+	*val = out.r11;
+	return err;
+}
+
+static int tdx_handle_mmio(struct pt_regs *regs, struct ve_info *ve)
+{
+	char buffer[MAX_INSN_SIZE];
+	unsigned long *reg, val;
+	struct insn insn = {};
+	enum mmio_type mmio;
+	int size, ret;
+	u8 sign_byte;
+
+	if (user_mode(regs)) {
+		ret = insn_fetch_from_user(regs, buffer);
+		if (!ret)
+			return -EFAULT;
+		if (!insn_decode_from_regs(&insn, regs, buffer, ret))
+			return -EFAULT;
+	} else {
+		ret = copy_from_kernel_nofault(buffer, (void *)regs->ip,
+					       MAX_INSN_SIZE);
+		if (ret)
+			return -EFAULT;
+		insn_init(&insn, buffer, MAX_INSN_SIZE, 1);
+		insn_get_length(&insn);
+	}
+
+	mmio = insn_decode_mmio(&insn, &size);
+	if (mmio == MMIO_DECODE_FAILED)
+		return -EFAULT;
+
+	if (mmio != MMIO_WRITE_IMM && mmio != MMIO_MOVS) {
+		reg = insn_get_modrm_reg_ptr(&insn, regs);
+		if (!reg)
+			return -EFAULT;
+	}
+
+	switch (mmio) {
+	case MMIO_WRITE:
+		memcpy(&val, reg, size);
+		ret = tdx_mmio(size, true, ve->gpa, &val);
+		break;
+	case MMIO_WRITE_IMM:
+		val = insn.immediate.value;
+		ret = tdx_mmio(size, true, ve->gpa, &val);
+		break;
+	case MMIO_READ:
+		ret = tdx_mmio(size, false, ve->gpa, &val);
+		if (ret)
+			break;
+		/* Zero-extend for 32-bit operation */
+		if (size == 4)
+			*reg = 0;
+		memcpy(reg, &val, size);
+		break;
+	case MMIO_READ_ZERO_EXTEND:
+		ret = tdx_mmio(size, false, ve->gpa, &val);
+		if (ret)
+			break;
+
+		/* Zero extend based on operand size */
+		memset(reg, 0, insn.opnd_bytes);
+		memcpy(reg, &val, size);
+		break;
+	case MMIO_READ_SIGN_EXTEND:
+		ret = tdx_mmio(size, false, ve->gpa, &val);
+		if (ret)
+			break;
+
+		if (size == 1)
+			sign_byte = (val & 0x80) ? 0xff : 0x00;
+		else
+			sign_byte = (val & 0x8000) ? 0xff : 0x00;
+
+		/* Sign extend based on operand size */
+		memset(reg, sign_byte, insn.opnd_bytes);
+		memcpy(reg, &val, size);
+		break;
+	case MMIO_MOVS:
+	case MMIO_DECODE_FAILED:
+		return -EFAULT;
+	}
+
+	if (ret)
+		return -EFAULT;
+	return insn.length;
+}
+
 unsigned long tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_output out = {0};
@@ -261,6 +361,14 @@ int tdx_handle_virtualization_exception(struct pt_regs *regs,
 	case EXIT_REASON_IO_INSTRUCTION:
 		tdx_handle_io(regs, ve->exit_qual);
 		break;
+	case EXIT_REASON_EPT_VIOLATION:
+		/* Currently only MMIO triggers EPT violation */
+		ve->instr_len = tdx_handle_mmio(regs, ve);
+		if (ve->instr_len < 0) {
+			pr_warn_once("MMIO failed\n");
+			return -EFAULT;
+		}
+		break;
 	default:
 		pr_warn("Unexpected #VE: %lld\n", ve->exit_reason);
 		return -EFAULT;
-- 
2.25.1

