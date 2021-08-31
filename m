Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188E63FCC8D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240538AbhHaRwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240551AbhHaRwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:00 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BD3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e7so17539292pgk.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqM9fBNQzdZU6uk7ShshpfjLQWCdX/Iyi6VKrIrh4EY=;
        b=PqmvOjR6cbQ04qLcENjbAzVUSEKAMSl+EmFL5Gy1B5PrksjeOomhcmHRwp71+K+Yun
         TAG0Zg1+b4ASf0uarx1gacdMcpCWrdLq4UdVodBabl0k6LSmEVK0rOHpGsm5SEZ2F8pL
         Feyaj0ISJCX1PLijjYFi9aFy4+p/hTwn/63nqOEsWvuP+jq11nYH4KRUQzCciT/P+X2C
         OOS5ULBTarX/qlsXtYTW2LtPH+oUx3ZfatGQy5fGtSngiMauqNRZTPwiblp24dfVe5w/
         5VoW1kopTrO3uD5lkbZ2BUn2yLI403wtBH2dqEAiDj1CKj8q/X14u8jNOwgrla+qY3Vv
         dLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqM9fBNQzdZU6uk7ShshpfjLQWCdX/Iyi6VKrIrh4EY=;
        b=AA3iS3NzN+hSaPs4ZIc2GF7v41s01vbm4o7GePbQ+6onziuzWBlW3UXu1TnB+BKlk7
         F+s1DuNBDCpgThFfeCyCoA69dMiHInqLuKRn1VLfCgqh3D32O1KQLkH2M6tOLIuTq+bK
         D96rm0KNtu/EhbkJFwNIzj9XL3Yad24W2xPLJZb4oeVNWgP1KBfDUs8j6yofRTemSing
         rbHMaQLsJP/GZ0frVqcQDBsU2yvAEzAoYpLflS5qjxdQGIGYYaVwL+D4wPLnanfntm2M
         DSyvPn8P+nb+/CbWnv12Tzn9oooeW23hnDgnLj0i8jYxGseWIpGjVck7ObkAPmkA81vS
         oH1g==
X-Gm-Message-State: AOAM533klgD6sMmmFnwaWuVvjCovqAcxi9dVc2/f/xm+/thPhBxGbmKs
        TXB9GqibVFtlR5s7w0vvoUPCYIOinJU=
X-Google-Smtp-Source: ABdhPJzPH7GoZr1baHfQjH8tWhFu0onTtrJ81Bo0WEmwOna0/i/4Zx5RcQ7RzSbRSiid0bB7/D635g==
X-Received: by 2002:a63:f946:: with SMTP id q6mr27513200pgk.42.1630432264454;
        Tue, 31 Aug 2021 10:51:04 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id y12sm3441450pjm.42.2021.08.31.10.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:04 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 06/24] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Wed,  1 Sep 2021 01:50:07 +0800
Message-Id: <20210831175025.27570-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

These constants will be also used in traps.c, so we move them to
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

