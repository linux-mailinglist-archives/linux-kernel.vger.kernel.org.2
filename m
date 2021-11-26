Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6530F45EB4A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376844AbhKZK0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376661AbhKZKYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:24:48 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C3C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:41 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so7666412pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=eLekWgqZFmW0uNide1QM822OAaFZ3f3W4vo/lzuRicgpXRYGbg6LOsbYRoM8JPuYPm
         yxV6MpjWU1W2/G9fknY9UqtqmgJ7m4tuKxUiSm//msRhD1oGGwbJPjFbkz91XcRJbNXQ
         mdqIusOFwuenOba/Dj7xIGF+dL22iZzTsk0GNAJ3OQaBXwBXrbjTR3GsTNciywn8xedU
         Gns+09cmYTLhMylMuSqyBXetsfWXXM97y6W3EkRZ/NGgq3ReYpHfPurmjQJte+95xKQe
         gXM29m+rxsRCC/D+1SMkgqvqc5h2Ymrlw+11SF+Tdtl0N9j1KGvJCtGD5aC3HBZVTnmo
         GgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=k82MGh+W40AF3ECCxsqlCc7P0JkmMEShfed3i+J1Nfg8qGiw9PYNOtsxD9XilkfKAB
         NFi6jZAsXhF89ax1n8ifIKM08oj9DelYVYvnsz1NZv0wJENS54YUSTrW+8VF2sOuTuRI
         MU1JfqTqxLt74S6dxpZL/O++wBkl7vSDvMbKNfY7lPO83ZWg/XqqgZlAXPhfjgmG9wTV
         uyYJ12xtoKEkMYo8qid6ybZt0Cmq0KjrYjPcpCG3xXQxh9aLb7MGs0VWVWiLfgvr0H5A
         TMRO2072iEMAelF3xNxRjQAEGro8SL61OJf9HCkh7POHOlnFZX61/7FoRPh+0NLZM4Fe
         E3bQ==
X-Gm-Message-State: AOAM530TX7x0rFK4ovsZMZeRO7FIjrd7oW505KOHnyNNmfy1dv/RI5FJ
        5nL2rxA8Ge6GH756LDeP4w/1n39kLEU=
X-Google-Smtp-Source: ABdhPJzgMY9IBjPC0gccyHvJ+Qz8J//l9lY9WZtUHbzI5WCZx0V7DnSabxXxwI9Fo2YTnOzs1GtFpQ==
X-Received: by 2002:a17:90a:dc15:: with SMTP id i21mr14478544pjv.183.1637921561088;
        Fri, 26 Nov 2021 02:12:41 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id e6sm4529876pgr.24.2021.11.26.02.12.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:12:40 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 07/49] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Fri, 26 Nov 2021 18:11:27 +0800
Message-Id: <20211126101209.8613-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

