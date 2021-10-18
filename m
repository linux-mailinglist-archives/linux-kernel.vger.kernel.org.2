Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F78C43244F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhJRQ6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhJRQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:58:30 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4652C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id e19so879673ljk.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CVY6sB943A0/C+1rE91nMU2/Mjjr6N7AE5dVN2kCUg4=;
        b=ON7io7mu2Qx/zr7peaBIMYae8dcNIE45jYrxnLnlKvAMK9szl5sdSNE0sxUbihgWTY
         Si2pCx+3bwgHgqU5U9203giZmJDLnlZ9ShARh20XLRhJ2GcOry1ikCmlURZnW+96Q0o0
         0HLiQ8ekpu/Tv3t1drHMK/JuE8LE9n6pKmf84ADyOWaHV1JKZpSuZzFlw1ISl165oAC5
         +8iB0iO5vGsbq70xtmPxGQp4fDubt9E6xAy9A3LqFZwkpqZDTSAVoCUlMLIQ8gVx95Tm
         Dm1Y0vDPrULXkvWeBJYjJWmiOFyx7/vbMzamhxKerGClLgsqUVcIWIRAf2jdkOZZDV0N
         P+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CVY6sB943A0/C+1rE91nMU2/Mjjr6N7AE5dVN2kCUg4=;
        b=CmwJfQL8vq6BIZVgGn1SibE8qWlTVA2k7yG7Fsi8e6yLBq50WUfwnxphnBZcpY62oW
         iuuHFrRNUObMK7Xf+pS8Dkouy0jqQK5GPhVHMwLKxmCDeV380sD0UVUVh1RhLC1U3LdD
         C1YXWlYmMfOdZfVjjpm8e7Ig/oLckDfy8R7fhpTO0699sH9XmUlZydk1EmqQpo9o07bq
         wFLQtOpDPvORPUK2YwNvjwB3zQTXbGpsMGv9mO6Tjqdz1OsP5mu6FGY3szUVGQi5+pBa
         Fxh2DooC98B2842QtYqsC9O2ihEkK4VwdtCSCjKfeQS+cKvwrSyBB0yX7IVENVApIPj0
         J5qw==
X-Gm-Message-State: AOAM530P16gUbdE542BlA5npJI+1dq2r+i7QDExSWr0a0HhV/d/2pr0f
        IC1Yocdno8iEzQ7sqZo1r1M14g==
X-Google-Smtp-Source: ABdhPJwZzJLwEJjA0NlLFmk3YgZom4nW1WqPH7E4/x2wOXMSNtIXEocq7VSVEfkBk0JQM0eJcGuJBg==
X-Received: by 2002:a2e:a5c9:: with SMTP id n9mr904259ljp.512.1634576177203;
        Mon, 18 Oct 2021 09:56:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f13sm1442187lfq.217.2021.10.18.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:56:16 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 58F1C10309B; Mon, 18 Oct 2021 19:56:20 +0300 (+03)
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCHv2 1/3] x86/insn-eval: Introduce insn_get_modrm_reg_ptr()
Date:   Mon, 18 Oct 2021 19:56:12 +0300
Message-Id: <20211018165614.20153-2-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
References: <20211018165614.20153-1-kirill.shutemov@linux.intel.com>
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
index a1d24fdc07cf..64fbab09b966 100644
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

