Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2941B44C06D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 12:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhKJMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhKJMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:01:07 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70DFC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:19 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso1475370pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=mwTM06nlxcYZcsbR/roeGBtvJqZd2j3ZMgWw/qWaqF1IVcz9pJZJaerzCsG1Lbeykg
         vXZcpskvAFHwzzvXG49wl8wf3SqaK/6efy6xP1Dy89og7A/NNnaH53KfAxNbe1Kb+t+G
         g0a2iPTA7Yygy6adFlMO1wr8Gem8OzwSVuOdqAQIO6uWG69WaNvMwuIBmrsFrLSgpGlv
         WAp86kgF4c2doMHVjgz8ZpCVxZ3XH7yKFghIFYookoGTKsIT6YgicL6HQN1tSvjCngBI
         h68ZTo/eGGmvZ31bI0altDUPptEGWjxTsl0EX5WviNln/AryjhL2AWdnvQlALscTrKEB
         A6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=fui8D3E45KRUcLK1JiUnHDp3eFVLrJG1TI40wi1ViXwXTMeE4n5+5qOsQMPUoxQJV4
         q6rU2gmEi9M81M58CuEVgXFtvDLlAX7IG7L6mr/0opURBNXJ6QwZ+KG1gn+OvN6ScxFS
         ri1AJIhN7mZpHPUWfsQ/Ha8gD+bUuoOxGqhrjhGwOTmKlRn9F4oJ8tzJhZ+RjN2QR7rJ
         mTXgaCVEeh2H9eImubgnTdVdqGL66j+o8o2UWPoeHYChgD79kQBh35Wb7An9e6PAjWjx
         7QudO6fMJjWeD+Q/qrPY04Y96Qpv9adPIDQCdCgQF/An1AXIbFquy/PpGdywYNcJiMG7
         oQ3A==
X-Gm-Message-State: AOAM5335pvr8yECp5NC3lzSUjB5UhUgx1n0rU8F7aPWkmPIyOPNuoMdn
        n34vhl3pMgw9mVTFzz7h8lwowKBYevU=
X-Google-Smtp-Source: ABdhPJzZQpiv8nIOvbzbw51aBkKfjWzyCMj+SQSnnOSKxtCJd7+aF61qPyJCkdH+Ll3A5JcLp7381Q==
X-Received: by 2002:a17:90a:6a82:: with SMTP id u2mr16354285pjj.105.1636545499158;
        Wed, 10 Nov 2021 03:58:19 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id z93sm5640853pjj.7.2021.11.10.03.58.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:58:18 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 08/50] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Wed, 10 Nov 2021 19:56:54 +0800
Message-Id: <20211110115736.3776-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

These constants will be also used in C file, so we move them to
arch/x86/include/asm/processor-flags.h which already has a kin
X86_CR3_PTI_PCID_USER_BIT defined in it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/calling.h               | 10 ----------
 arch/x86/include/asm/processor-flags.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index a4c061fb7c6e..996b041e92d2 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -149,16 +149,6 @@ For 32-bit we have the following conventions - kernel is built with
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 
-/*
- * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
- * halves:
- */
-#define PTI_USER_PGTABLE_BIT		PAGE_SHIFT
-#define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
-#define PTI_USER_PCID_BIT		X86_CR3_PTI_PCID_USER_BIT
-#define PTI_USER_PCID_MASK		(1 << PTI_USER_PCID_BIT)
-#define PTI_USER_PGTABLE_AND_PCID_MASK  (PTI_USER_PCID_MASK | PTI_USER_PGTABLE_MASK)
-
 .macro SET_NOFLUSH_BIT	reg:req
 	bts	$X86_CR3_PCID_NOFLUSH_BIT, \reg
 .endm
diff --git a/arch/x86/include/asm/processor-flags.h b/arch/x86/include/asm/processor-flags.h
index 02c2cbda4a74..4dd2fbbc861a 100644
--- a/arch/x86/include/asm/processor-flags.h
+++ b/arch/x86/include/asm/processor-flags.h
@@ -4,6 +4,7 @@
 
 #include <uapi/asm/processor-flags.h>
 #include <linux/mem_encrypt.h>
+#include <asm/page_types.h>
 
 #ifdef CONFIG_VM86
 #define X86_VM_MASK	X86_EFLAGS_VM
@@ -50,7 +51,21 @@
 #endif
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
+
 # define X86_CR3_PTI_PCID_USER_BIT	11
+
+#ifdef CONFIG_X86_64
+/*
+ * PAGE_TABLE_ISOLATION PGDs are 8k.  Flip bit 12 to switch between the two
+ * halves:
+ */
+#define PTI_USER_PGTABLE_BIT		PAGE_SHIFT
+#define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
+#define PTI_USER_PCID_BIT		X86_CR3_PTI_PCID_USER_BIT
+#define PTI_USER_PCID_MASK		(1 << PTI_USER_PCID_BIT)
+#define PTI_USER_PGTABLE_AND_PCID_MASK  (PTI_USER_PCID_MASK | PTI_USER_PGTABLE_MASK)
+#endif
+
 #endif
 
 #endif /* _ASM_X86_PROCESSOR_FLAGS_H */
-- 
2.19.1.6.gb485710b

