Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DB3B4EE9
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 16:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFZOUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 10:20:11 -0400
Received: from mga09.intel.com ([134.134.136.24]:42506 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhFZOT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 10:19:56 -0400
IronPort-SDR: a+X62TclNmk18gCplR2rFDHFKU9vdG5FEfvfxtk5bDhU1QRa9fJ4JolkmnQYIKidTlegUtYtpd
 QyMzTt4EbZ3g==
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="207729777"
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="207729777"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:34 -0700
X-IronPort-AV: E=Sophos;i="5.83,301,1616482800"; 
   d="scan'208";a="624775874"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.254.8.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2021 07:17:32 -0700
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
Subject: [PATCH v2 06/10] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Date:   Sat, 26 Jun 2021 07:17:14 -0700
Message-Id: <f892e4e5d99a766a96dbc8af503dcc9a3b727e63.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1624716673.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

The helper returns a pointer to the register indicated by
ModRM byte.

It's going to replace vc_insn_get_reg() in the SEV MMIO
implementation. TDX MMIO implementation will also use it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/include/asm/insn-eval.h |  1 +
 arch/x86/lib/insn-eval.c         | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index 91d7182ad2d6..041f399153b9 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -19,6 +19,7 @@ bool insn_has_rep_prefix(struct insn *insn);
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
+void *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index a67afd74232c..9069d0703881 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -850,6 +850,26 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
 	return get_reg_offset(insn, regs, REG_TYPE_REG);
 }
 
+/**
+ * insn_get_modrm_reg_ptr() - Obtain register pointer based on ModRM byte
+ * @insn:	Instruction containing the ModRM byte
+ * @regs:	Register values as seen when entering kernel mode
+ *
+ * Returns:
+ *
+ * The register indicated by the reg part of the ModRM byte.
+ * The register is obtained as a pointer within pt_regs.
+ */
+void *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
+{
+	int offset;
+
+	offset = insn_get_modrm_reg_off(insn, regs);
+	if (offset < 0)
+		return NULL;
+	return (void *)regs + offset;
+}
+
 /**
  * get_seg_base_limit() - obtain base address and limit of a segment
  * @insn:	Instruction. Must be valid.
-- 
2.25.1

