Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6638F4322F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhJRPfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhJRPfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:35:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EAEC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:33:33 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y26so499091lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3x1+MDGvGnzeKyu00j6KECfd2YR8Bl5CJG6uJH0f6mM=;
        b=FUkKanmIp19bdjB/r8+hSd3nTJpdtG5Dm86reEGNs/RR+Nv9D+qpgUrQ4OG54WXPHu
         zNt2PARDDRSkNMF0ZByBdyWTJPuvdjWH8tjXyFHC0StO9vszwLH7qMa+EmqQ0ylfDxZm
         YKchAHPDpMwdHMDFmbeOg7tz+oRljjIC4o2hp/44W/wUzjRK8hChNnHN1ZVZDSD48YsQ
         nG7u9UNVXq4KQ+u8GQxBISqvXXSpRpFzbjlegugQwZJ7smY7BzOqsQl1nHQS9UtFvEJ1
         j4tEyP98SX/Qy0CcXpQfqiSoZTd/tGHcb66/NyobzidsHjq5vf91a2qAAGsFf77qgZqX
         m7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3x1+MDGvGnzeKyu00j6KECfd2YR8Bl5CJG6uJH0f6mM=;
        b=7ZKLl4R1XgFGFcp/UpUAykxMUiAeOzaICACguxipwzZSVl1XjT+nhucVivhRAkNXe1
         Q7Z+ccVNZyYk8xI+soPDs5UgtPWWfvBs78GlHfAgMM7WoXWwCGPfhl7vH9OAL9d65YHe
         5bDxfjJJMGM4688cDsnF2u4ScPVAWj43OZgAXr1tIChcyQixWM5ijPH5kl2IDWpSDstE
         1ZDR/ygfr316P15ytK48nEaWFmIu2F1Kc3VepUfQmQDiY0VXq7rI/ZX8Q/1abpbuBHsC
         3vev2YsOATJPVeaf48PCZhJpaJ38MhYbWV2rJ75hluHz4lvSuKT6HJRvoulI95isn0cw
         e8gw==
X-Gm-Message-State: AOAM530cdZmRuNmiSYwOYAdN1Fd4M1JMBD7gVmhIK+dM+g27qwjfhoK3
        UB5IOvd5PQAktxS7+bGRMc3MEA==
X-Google-Smtp-Source: ABdhPJzOb65hWgq5EdUKNqcE/WHjCoXOFMR4dTjS/DR6DKwMLp1MWELbwStfm6xs3DQLPpHvFxh+PA==
X-Received: by 2002:ac2:4c49:: with SMTP id o9mr452127lfk.482.1634571212301;
        Mon, 18 Oct 2021 08:33:32 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d27sm1681326ljo.15.2021.10.18.08.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:33:31 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 131E2103091; Mon, 18 Oct 2021 18:33:35 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/3] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Date:   Mon, 18 Oct 2021 18:33:31 +0300
Message-Id: <20211018153333.8261-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper returns a pointer to the register indicated by
ModRM byte.

It's going to replace vc_insn_get_reg() in the SEV MMIO
implementation. TDX MMIO implementation will also use it.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
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
index a1d24fdc07cf..fbaa3fa24bde 100644
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
2.32.0

