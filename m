Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106EB3B4EE5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhFZOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:20:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:42506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFZOT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:19:57 -0400
IronPort-SDR: 3qx8Chn8+2mp6K5wlkGcUJcf/uRgWdXtSRyVTOPCSjPivYSHo8sY4LrsTGo+NNh9d2f9gBprkJ
 70ngP9DqS3IA==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207729779"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207729779"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:35 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="624775881"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:33 -0700
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
Subject: [PATCH v2 07/10] x86/insn-eval: Introduce insn_decode_mmio()
Date:   Sat, 26 Jun 2021 07:17:15 -0700
Message-Id: <0ba555704eef3ce3de1e1fffb8506bca7364563e.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

In preparation for sharing MMIO instruction decode between
SEV-ES and TDX, factor out the common decode into a new
insn_decode_mmio() helper.

For regular virtual machine, MMIO is handled by the VMM and KVM
emulates instructions that caused MMIO. But, this model doesn't
work for a secure VMs (like SEV or TDX) as VMM doesn't have
access to the guest memory and register state. So, for TDX or
SEV VMM needs assistance in handling MMIO. It induces exception
in the guest. Guest has to decode the instruction and handle it
on its own.

The code is based on the current SEV MMIO implementation.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/insn-eval.h | 12 +++++
 arch/x86/lib/insn-eval.c         | 82 ++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 041f399153b9..4a4ca7e7be66 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -29,4 +29,16 @@ int insn_fetch_from_user_inatomic(struct pt_regs *regs,
 bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 			   unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
+enum mmio_type {
+	MMIO_DECODE_FAILED,
+	MMIO_WRITE,
+	MMIO_WRITE_IMM,
+	MMIO_READ,
+	MMIO_READ_ZERO_EXTEND,
+	MMIO_READ_SIGN_EXTEND,
+	MMIO_MOVS,
+};
+
+enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes);
+
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 9069d0703881..ae15a74040a5 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1559,3 +1559,85 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
 
 	return true;
 }
+
+/**
+ * insn_decode_mmio() - Decode a MMIO instruction
+ * @insn:	Structure to store decoded instruction
+ * @bytes:	Returns size of memory operand
+ *
+ * Decodes instruction that used for Memory-mapped I/O.
+ *
+ * Returns:
+ *
+ * Type of the instruction. Size of the memory operand is stored in
+ * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
+ */
+enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
+{
+	int type = MMIO_DECODE_FAILED;
+
+	*bytes = 0;
+
+	insn_get_opcode(insn);
+	switch (insn->opcode.bytes[0]) {
+	case 0x88: /* MOV m8,r8 */
+		*bytes = 1;
+		fallthrough;
+	case 0x89: /* MOV m16/m32/m64, r16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_WRITE;
+		break;
+
+	case 0xc6: /* MOV m8, imm8 */
+		*bytes = 1;
+		fallthrough;
+	case 0xc7: /* MOV m16/m32/m64, imm16/imm32/imm64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_WRITE_IMM;
+		break;
+
+	case 0x8a: /* MOV r8, m8 */
+		*bytes = 1;
+		fallthrough;
+	case 0x8b: /* MOV r16/r32/r64, m16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_READ;
+		break;
+
+	case 0xa4: /* MOVS m8, m8 */
+		*bytes = 1;
+		fallthrough;
+	case 0xa5: /* MOVS m16/m32/m64, m16/m32/m64 */
+		if (!*bytes)
+			*bytes = insn->opnd_bytes;
+		type = MMIO_MOVS;
+		break;
+
+	case 0x0f: /* Two-byte instruction */
+		switch (insn->opcode.bytes[1]) {
+		case 0xb6: /* MOVZX r16/r32/r64, m8 */
+			*bytes = 1;
+			fallthrough;
+		case 0xb7: /* MOVZX r32/r64, m16 */
+			if (!*bytes)
+				*bytes = 2;
+			type = MMIO_READ_ZERO_EXTEND;
+			break;
+
+		case 0xbe: /* MOVSX r16/r32/r64, m8 */
+			*bytes = 1;
+			fallthrough;
+		case 0xbf: /* MOVSX r32/r64, m16 */
+			if (!*bytes)
+				*bytes = 2;
+			type = MMIO_READ_SIGN_EXTEND;
+			break;
+		}
+		break;
+	}
+
+	return type;
+}
-- 
2.25.1

