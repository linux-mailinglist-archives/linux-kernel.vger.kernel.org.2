Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517543B3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhJZOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236511AbhJZOYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:24:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC66C061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w16so1810222plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=qgY5yxPhBDBZ7zkeL7ZRt6H9OHcDO7hOP5DzZuRq+axFIVKd6uffuWAdjjCrEaX21b
         jEgcMzQ6ez4FeW089FemW+ilkksUTd9yrc8n5uaw/tQQ08HxB7SADnw+rnKTTg69ReES
         o/MYnwQbLhFMWNjZPwiXc9uYm3w+EClQoV31/mPYlm9JW5DgIepZtvA4f1eB3+Voa/zQ
         JnYiBBalfiuIcB1Exxoyp/7DvSdGpKjro4Ys/So3RWbY6TaCrEICPVl02qdt6sRKPxKF
         IYGTY0ebdheAXYZUK7SQOSjXo5eqf1q9FjjD8ozmcUfHP0r5qDDBZUPZta/OHGTPM36Y
         uvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=WQgH3e7FNjI5g4KjeFWPiNnjQEDyC3hpA+k/xi8FKeOzcb2NjyNiQw2PPOcXydzC33
         UoKkuCWjLq4ryiuRcHVjRfO/A31eAZN+cgzGZv6veyBzqyN55hajnivOt8Te8zXw9NSe
         WSOS1fppPgGHrnjz/E6AYCDd4lJzTqQkcvnUyNHvXYEgf5bh+XPlpPFBFtxHFIkq0AG+
         kOwNzCbS5u/VZOjNugSQbbZbE9wN8oUynDi7bHwqfQriE4gkr09VPh6Bb2oCOR0c4N6O
         nHH9SkEzdzttZtyaEULO9neVwKFZjOifuqy5FTxK+mg/F+iXfysjvcu7gh69T0/inQwX
         HrUQ==
X-Gm-Message-State: AOAM533E45R6kclKZGKBOq+nVP5UZWNKxzRT7nKpPNPua7zADu94RzTP
        3KLXhK7JjJsM7lToYxQrUb1TcM6zXpk=
X-Google-Smtp-Source: ABdhPJyWIgaGZiY51B0W/UGqthbr4SgHtIrR5pZGHFVCWYz/zX/rv+/7kL3Bt1MFEFjcSczmf6J7Uw==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr29014520pjs.38.1635258118986;
        Tue, 26 Oct 2021 07:21:58 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id p23sm12581255pfw.61.2021.10.26.07.21.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:21:58 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 08/50] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Tue, 26 Oct 2021 22:20:16 +0800
Message-Id: <20211026142058.17702-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

