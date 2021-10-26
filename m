Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5A43B40F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbhJZObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbhJZObJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:09 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84088C061224
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lx5-20020a17090b4b0500b001a262880e99so1836067pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=mYh6Ur38+KcKTY2kh7RNV36y3KogCi1bV69Xn81by9+Iq3gBGmCXhD6ntYXvbBlhgj
         xYi4BWYsLQ4+H+BokkYXmCnQ/27r4sY8t5us41Q4+6Js7r634FDRFIlfJ1RsYb7EvtFC
         x47whYvUHvp0m34sZ3/p5JVlgUwmPeBaTPgKxPpHBPt9JgbJxVxHaBoY7DG7z1iDcNYx
         VzbniPUPM5nGDpaQ0NyT3RqwtHansbkm6kBeqJxAGm4+Q54/jS4DfFqVf6J3CbkrLF1Y
         X4p61scn770LXiP+53lY1XFF3OrqANJLmTHzSYXl9efkAAMjKOheu9L+qnJHOxgvdNht
         hLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=0vWhezpk40xcWf/n6uxpQuEsKoEI2aDB3UR/etOitfFq5RBd3OrdqqU+SbvcFkSrDm
         rxKQrKgTSheEXvRWzgbphdw6FzCaf4y4Dk4/1/zft5z+/waOv5lBLr85qize3I98UQro
         s0pLrJ48w7qqYtrUOdtrIFNl6OVwFID3FoQNSWQCNw1b+tH/7BxKXKpPYxVjhYaYjNdg
         oGDRSsuKnT07aVXohcqvLZM8Pu2+0iXn13u70Zh/opMzOl2Tj2bYsVnbPJHhFFLzExPC
         zZ3znn4YzMh/2UxD8LhPgr72UIzDRV5g+aokuCCkY+a3xR+R371K9fqSNEMCHtSIr+7f
         41YA==
X-Gm-Message-State: AOAM531GVns7CFHcGUpgWGJ99GHK3Eu7zmPS8yzFeS+c4jZicYMPzv8D
        Y1XFVt7H+MrUSr+Uz3K44oR5k+tSHBc=
X-Google-Smtp-Source: ABdhPJymq1mRT2yJPvB4IR2vllLVnLcE8bIOQlOyMSlQ1/99sd3gnVzgiuU9GxDXAxo6fBDFPX8BnA==
X-Received: by 2002:a17:90b:4b06:: with SMTP id lx6mr42923042pjb.220.1635258523985;
        Tue, 26 Oct 2021 07:28:43 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id a25sm3608351pfl.115.2021.10.26.07.28.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:43 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 15/50] x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Tue, 26 Oct 2021 22:27:47 +0800
Message-Id: <20211026142824.18362-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The C version switch_to_kernel_cr3() implements SWITCH_TO_KERNEL_CR3().

No functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 9813a30dbadb..9a5c535b1ddf 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -14,3 +14,27 @@
 #include <asm/traps.h>
 
 extern unsigned char asm_load_gs_index_gs_change[];
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+static __always_inline void pti_switch_to_kernel_cr3(unsigned long user_cr3)
+{
+	/*
+	 * Clear PCID and "PAGE_TABLE_ISOLATION bit", point CR3
+	 * at kernel pagetables:
+	 */
+	unsigned long cr3 = user_cr3 & ~PTI_USER_PGTABLE_AND_PCID_MASK;
+
+	if (static_cpu_has(X86_FEATURE_PCID))
+		cr3 |= X86_CR3_PCID_NOFLUSH;
+
+	native_write_cr3(cr3);
+}
+
+static __always_inline void switch_to_kernel_cr3(void)
+{
+	if (static_cpu_has(X86_FEATURE_PTI))
+		pti_switch_to_kernel_cr3(__native_read_cr3());
+}
+#else
+static __always_inline void switch_to_kernel_cr3(void) {}
+#endif
-- 
2.19.1.6.gb485710b

