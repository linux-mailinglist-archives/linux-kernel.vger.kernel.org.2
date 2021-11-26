Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97A5C45EB55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376732AbhKZK1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbhKZKZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:19 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4172C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p13so816669pfw.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=ID6oSFYruDQGR8nUnAEQL6FMVWO0vNy0Miw+ekbt6ZNrsEOQpQx17dL+orBTuuLPqV
         8c2m9qZ2CxlSaryBKZY8yPrM2WhOtXGcZxgmhXQpjIZB5EmIgHDLGtSuNW7nMDaqefGe
         sQFiG1VSi/2TkfUX8TUaW+nksT866g7NVcp58hPQranS76WDWzTl1eArIUEB6qGwVw4M
         t+yZGhFQwGYVyZHBxp75sp3DhCYJ8cTd7n7TQ06ovYw0lLkOELMuyWzTpZQaB25gIUYa
         TZqFLh7lGHE4bbL70oYnAHqquv4jUyx5xDmiiCsN5VMdkzHufGB5seeVNZ07dJCS/Z5b
         Y4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=1Yov21kOWyGeprJd24zr0W6mfcO/JngB5CwxrnvqCQCe2yOYT7AjV18bEr+Yxi9pjK
         FfyDbf5IyLHZhC7gZwXJIWIN32fmBHPVA79BJmC6oEpSm3I1pZSw9YKsJMz7iJ7ubqo2
         GqfG/p7jpDj3KWYZL9iCRCUr+tqcCR+xyvCINQF1rdJW9hotL/DlQVNEjt0/qFTb6mes
         JFnEM2aQz+jxTXMTNa0nJ8cOWWs7gyOlwih9SDRpOfurIn8moXv/4MsEx7ullTHgffjS
         JKQUk84C67nb+k77FjCzrRcalbW96es1c+XgSIMvg6T3FHoX0jYvlHA+ylRHqF0ivok3
         vcfg==
X-Gm-Message-State: AOAM530ihsDFPV3c02+bA0v9qqVh2TzDCf1dURJGR1NJtF59jnKgvH62
        ZVLxzHVD4Y05QJkKVZ7TSVXR+nNc928=
X-Google-Smtp-Source: ABdhPJwjfpWDTVcJ8wE7JJDhjMaVBOCVkgHt2Ukx+gXBEeQzomAGaGjV40mddRpWoWn5PIcsV/CB9w==
X-Received: by 2002:a63:80c8:: with SMTP id j191mr11551162pgd.143.1637921607408;
        Fri, 26 Nov 2021 02:13:27 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id e19sm4132103pgt.49.2021.11.26.02.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:27 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 14/49] x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Fri, 26 Nov 2021 18:11:34 +0800
Message-Id: <20211126101209.8613-15-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

