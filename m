Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4642D0FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhJNDgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhJNDgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:36:43 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556BAC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso5925419pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=VA7spBkkBP1doYtsupHOWNez4Ir32/x1hwokYnAfV4FEO7AA0Lg92I/FPIv4c9pJu7
         wYUfA7DxcepYqmupnwqOLFmYej9v6sSXOkJjrmUaIKc31GqtmFhzX9PbtVHKUEJET5QD
         Abo3UVscduAEOYqCB8gvR3lh1pAyrxyizYgiz5zbc6OIqg5KTeCCX1DSbHKFNwJvLjVn
         QTILN65VIQKtVik4xeG81QhuTbay65OtRLUlMAJjlvXmGaqtcOr5byLYsdV0VkZpsi+M
         osW8QWEpabWdIilBCnT30Byeg79aMKBIbanG/aj4MnfWswJveINfj9KX5/+0CXS3xpMK
         3pEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KERbtBPjg9Xgw3qmQtkX07MzJXiLdhnUqwVs/TOwK18=;
        b=U0YUqLEDqyOJofYsX0RGMFWiz5VH8bydbuuHQdHLYjiY4hGkUzYOVtosLcYTxSJA0T
         wOKaKYhlkg7jz+6yg6tuCbC9DAK6C9lXXXNj4hSG57IhLTDfhQnhvfoRsiJrykvz1Fm6
         vGwTJKiFe1KLj+cqRlY15bJNcGHsy376tf5TVS9/6WJgKvGre02eEF7lPPnVoAf1VhWo
         JHqmxl4tNFCBzi3SbaoRs1x2jGCj0nYhG875sviDPoGElte0Te8yUmXRXzrUG1Ny2hA2
         7+hwVekAKo3s2fOEqVLLDSMplxh38isihUXFynQ74ncEuO/xmiO1q3eMSH9QK0i0b3wA
         Iu0A==
X-Gm-Message-State: AOAM5303kh8iooI3e450AKLBOoWUYYFLr5/RzjI75aoWjJP84ZUIbvn8
        C+pBtTa/WpXtlO7kMODw0D4lEFJNz0I=
X-Google-Smtp-Source: ABdhPJwRgycbaSOdksOFahB0OkxpEYNtRHIwtntpNl/MNtjdqyFudmYztS/nPfiqJ5CKquF3CTwiEA==
X-Received: by 2002:a17:90a:4fc5:: with SMTP id q63mr17978881pjh.148.1634182478723;
        Wed, 13 Oct 2021 20:34:38 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id w15sm816010pfc.220.2021.10.13.20.34.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:34:38 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 08/49] x86/entry: Move PTI_USER_* to arch/x86/include/asm/processor-flags.h
Date:   Thu, 14 Oct 2021 11:33:31 +0800
Message-Id: <20211014033414.16321-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

