Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E13442D104
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJNDhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJNDhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:32 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2F2C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c4so3209406pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=GP2gzClAzGvfiXU2UzYKiEiiXF9MJ9TkMyCBj8Cy43ALhy5k12HBIUVfvecGvULyJl
         yxo/x09Pwt4JlRhIATFvHll8Yr3yisMEXf0LQg/D1bG2bTsaCQRaNY1TpvdnD0npfxoE
         NrruwbAcLj9S+lzojp8d/vl4Nu/vOCDq7VshUBlTey6wN24qHJcWEAWqNpXQq16j4Nir
         93ORpRjUhA/Qdz85rkKDjjM9VdK0uC57PZtYeXN0PjemLZbpe4YmTSFIDzdXLtpARXTY
         oGuf6QnVQGYr2664LV1qZI/8Xt3L3jRaNp4z1ajN7vfFLtVTOh45c5UbOwUaQ7SPU6rn
         kR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kMfdZR7u3SGVAlrTiFoKn2/xZAEuhY7vC7t+axQgCY=;
        b=fQjMC3nMtvf9k8U8plt3l6A2jHGUFxMEjAODX+1qdLGXKHHwpejtgM6fYuFCduWb/E
         4zhwmtY21W1dg5spU2ZUP3vNLd4RqxVgB0O3bhn74CAQpD0iegJNfpbTOgmouZOrpNiK
         X7Cy0RpdknWm7KubTLa7D/GwmcXs/BD2/QQn7RWoi6SC+b+xnSZI5dmnSPQJKEh6Pxad
         bx73sdFBQ00OS3DahJwO369MMtMMtWPJqhPrE3Gdxec73Mhbvz+w8jETWO9jsvsjN/bI
         cH+AxXZGq0BwCYj+kTQHslUMxofj/NrQWREhEJNaIJYtq/A+tDm4R/iRwLWyBDLazMoV
         evKg==
X-Gm-Message-State: AOAM533eob8wON0fSxPKJt8Ei26wm1itkCpQTZF9H+Tn0/oFW+cwschX
        +9Fk+YsFkUVfHCwUSLtfAN1vQr+CmXo=
X-Google-Smtp-Source: ABdhPJyfD+Dkpb93e42pxX6KwY19qy2zop++om+LtHLG5IPzPblYdhXUYAUJKYUCcaz3mzasLSRNjw==
X-Received: by 2002:a17:90a:9d81:: with SMTP id k1mr18148717pjp.153.1634182527889;
        Wed, 13 Oct 2021 20:35:27 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id rj2sm882535pjb.32.2021.10.13.20.35.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:27 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 15/49] x86/entry: Add C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Thu, 14 Oct 2021 11:33:38 +0800
Message-Id: <20211014033414.16321-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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

