Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B24444E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 16:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhKCPtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 11:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhKCPtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 11:49:00 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55353C061203
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:46:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 17so4646176ljq.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 08:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2u3icssaC8jhgF8435R6ePfZOiFJ7Tfhdhj7jNVm04s=;
        b=qK1OMqyvy2ZaD6C9BiPN7MW3qLrAM6qt9X/Tedakk/Tegd08kqE4QMfl6pxx2i1Cog
         GCO1dpXEEJEFi2lh/1rSdw7CxKiZHiFbDsg1edwB1wqVN8H3MCEGsT3QYf7yoBO3rDVo
         TxCudTYId1g+Ix0AXBPyCvxaoTXMY5C+1RX4hINUQuMssdtTRurupJZBZ87UHrZfrrA+
         L2zbYFM5lau79cMjsLsUZMl1BuG2O8SQ2ppfRDgWToDV//0meYtxHPnmfw8YuJTuMb7q
         aMaX5daxqkvl9EUsKRmSZTNaW7V/VkM5I05FHLgUhv5WE0GI6YvDQXSw42mArwjlzuku
         wJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2u3icssaC8jhgF8435R6ePfZOiFJ7Tfhdhj7jNVm04s=;
        b=Z2ldevE+AgVwktsw8hEDuuBFWzyNMo/tyPHK095u05J53jMJBuj2pz5IoTBrBeyqU7
         jmHYAKUa0oeR1698aGC679vw8Uj5Tn0Nx7eZcP2EG2OUgS15zvkv0GuJwuKE9XER/7HU
         ax8P43lpMM3wXyj+emSRd035K3xwbJksX2/PDfxkG5XqTcC6KpZ06fgY2CSFSpPdUPN2
         iVfhkYZ1kI2L+twKqUdF61XLf+TkJA/Djs2RY0dC6CY7z7lubvsDy1hVTML/RKumZ1Gd
         EZkWVGaChzZ8EOBEpv6yklLyAzxfrG2oSgDCUROHS+kgoZzJvqwDer13H5AaSt9PSluf
         G6dg==
X-Gm-Message-State: AOAM53309N7BGmn4bpzlqfF4pMTfwV119ZHN/2qZzGLAl9OVnu36CFkl
        5FEkSUXWAVCUhpAtx3BIlNGASg==
X-Google-Smtp-Source: ABdhPJxa8frq243Nzf04SHgMN9iCwca7WmV48g6XpNhe8JhlRPlHT9Vde7W87y4/WyotFPKvFCBW2A==
X-Received: by 2002:a2e:a882:: with SMTP id m2mr48454212ljq.416.1635954381712;
        Wed, 03 Nov 2021 08:46:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id t5sm210122lfe.46.2021.11.03.08.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 08:46:19 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 9C5761033ED; Wed,  3 Nov 2021 18:46:18 +0300 (+03)
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCHv3 2/4] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Date:   Wed,  3 Nov 2021 18:45:53 +0300
Message-Id: <20211103154555.23729-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
References: <20211103154555.23729-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill@shutemov.name>

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
index 91d7182ad2d6..5c6869565fb3 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -19,6 +19,7 @@ bool insn_has_rep_prefix(struct insn *insn);
 void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_rm_off(struct insn *insn, struct pt_regs *regs);
 int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs);
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs);
 unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 8b7c2f2ea8f4..385232a67281 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -848,6 +848,26 @@ int insn_get_modrm_reg_off(struct insn *insn, struct pt_regs *regs)
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
+unsigned long *insn_get_modrm_reg_ptr(struct insn *insn, struct pt_regs *regs)
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

