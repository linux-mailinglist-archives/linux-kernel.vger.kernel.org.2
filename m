Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132444189B7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhIZPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbhIZPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:10:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4065C061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:10 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e7so15320643pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=CcR0JUfB6MDcnMLgkQUASvwq8PLts9YRIR8yDQ/Wqo2IvuOH1ZnI+jawu+vxguEv32
         QgsUhT+WhoKpTUvPeXVhW7t8gNRDoSFSKL0N6iuIQa7u4BQtpkYQYSLTt2ye9Xdy+vF3
         XV1Wl8Jk6nMiMG/s+v0dJlqFEE/59DvK/BEM+IiBY9W9izOp0QUrT3tqWI5P5KIMD09A
         baetY2Hjbu45JQjlcEeNvzHIC4p6LreKpKvGgtlPPLVWnuns40XWt3tJ2RWNekwqZLsB
         9SwIltzz6pBVD5BoMSLUeHOxbcd0PAEOtPjgyLauxmtkDNUX/ye7tKUZWSUNMOb+jW5K
         rg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=mEdyu1dGVw1HfQ6xThtT9DjHWhjX6fKuYJT3jZt2q3Vq9s9Hm4OWp2SJV/QEalhqGx
         XqCploe/HdCeHsSPIPOtyLF1YeaO0f8IRstUYJmUyI43wVk6QyGqtdBHMFd1lkbhYtqd
         2c+u5W6284aAUcqsq9GnPR4SwHQcAiUPyu4tPIpqIHuj8AiodLuo+U/4J0X2pjpXnQOQ
         6N13pCiDXYBQaXwx/ag7XF1b1Hwz0+aMhFv1FqSViaLA2ptkyBl+PzqRlvuLxVy7SrxG
         AuAHDTJoGJqVMhCIuT3LgQP+sCpyiJRFRE5eryyhEz/uKV1QX0+4u1WcHBz6lkDR04cX
         ZcDQ==
X-Gm-Message-State: AOAM533VGVVDylKvn3uXbB0Oonih3vRDY/pYB+3UNDel8+dAJiXTQHHb
        vGMnx/4SYHs0uSsPYL2uFSeRLxyAQ8wVpA==
X-Google-Smtp-Source: ABdhPJzRtWUKqEar+Uvr+0SR2BGSn564NWCNdSTfJnoQN5ZH0hQELPdn0BHnYIf9fm0+o9f/2MMrMg==
X-Received: by 2002:a62:d11e:0:b0:446:d705:7175 with SMTP id z30-20020a62d11e000000b00446d7057175mr16290341pfg.74.1632668950308;
        Sun, 26 Sep 2021 08:09:10 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id q11sm13745424pjf.14.2021.09.26.08.09.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:09:10 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 05/41] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Sun, 26 Sep 2021 23:08:02 +0800
Message-Id: <20210926150838.197719-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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

