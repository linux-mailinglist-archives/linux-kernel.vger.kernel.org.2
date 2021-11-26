Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A945EB77
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377293AbhKZK3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376903AbhKZK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:19 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F37C061394
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:04 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id r138so7717410pgr.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iKlZG5hv1azdNYq9hzIYBOf+NCPmaY3hsLMxbKrVWuU=;
        b=ZUbobq6LWzmF0Q2NvMRUUi3uwFhsKkTk8Kq/nM1Hwp9czbxXLuKFBzJBpZW2pxMeEP
         yf2/unzrwBBA+0TlC1OOZhO5+hBxikAaLl59XcB9byohMyVNeyx8NVFYqDOv/M4hKcyO
         EZurgwIH0XqUXIQhmuEn4e/jffYTu1gxnLyW8V9VWsZnyAhidbAmSIUVq4P/WK97eAzk
         LqRf2PxFZ3V/kvz6CrKl/NdCCU8IWYRDJDZfDKpD2eWC7f5I+rnRbw+zmlP/IMobBKRc
         bLbJiqfLz7HyMjcQyn9xIN71UsyOzA75MUiMIF3dEhkbGfNW/hqkDXYxAzJYjsK94Fo5
         U4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iKlZG5hv1azdNYq9hzIYBOf+NCPmaY3hsLMxbKrVWuU=;
        b=Zfz5gKidpYi9Z58eqVW9ybLnMcDN+/PexEJrMtdhWMXb4vy4b6xtVQqDbyczhLJIyo
         ABZiHoKjbz1Iu2Xw7qV2aJO4NEOoZIr+UO2aNUrfqU3E2WFwxd1DStDKO77HJRrq3Tmn
         +28e+g6AbUNgv6XWl5lDcPXC70KNUIt72m2/6jUeKQ31T3gvB2SwYBP+BO7g4ghpUyWL
         RCpvCxNC0BZZ4l9MUt7v9z8V6tb5gI/nQW4U7u2yoPDx0AkTq+qF0AKTjM/5bSoC8WHv
         cJQsxHA4nntS05jDlROvtpe2gYnctXgLClFGB8qF+mivUroPYlYM3oaL8QzPQAwcIrM+
         yYYg==
X-Gm-Message-State: AOAM530SVo/f2ozBHwSQ1C1DTDrMSbdj1duMAnO0asO5SSVSuXgH2JkC
        l5nDVX9UkY78I/Fg/3vRbtbE30p8Ud8=
X-Google-Smtp-Source: ABdhPJz3ZQB1sua8zw3kZBnxsGLujY2kiozIiPRQUK4It6Flw7XyqvgItIYMIzKTA+bWZHIv02x8gA==
X-Received: by 2002:a63:135f:: with SMTP id 31mr9581513pgt.395.1637921704297;
        Fri, 26 Nov 2021 02:15:04 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id c9sm4556598pgq.58.2021.11.26.02.15.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:03 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 30/49] x86/entry: Add the C version ist_switch_to_kernel_cr3()
Date:   Fri, 26 Nov 2021 18:11:50 +0800
Message-Id: <20211126101209.8613-31-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It switches the CR3 to kernel CR3 and returns the original CR3, and
the caller should save the return value.

It is the C version of SAVE_AND_SWITCH_TO_KERNEL_CR3.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 0dc63ae8153a..283bd685a275 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -35,8 +35,23 @@ static __always_inline void switch_to_kernel_cr3(void)
 	if (static_cpu_has(X86_FEATURE_PTI))
 		pti_switch_to_kernel_cr3(__native_read_cr3());
 }
+
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void)
+{
+	unsigned long cr3 = 0;
+
+	if (static_cpu_has(X86_FEATURE_PTI)) {
+		cr3 = __native_read_cr3();
+
+		if (cr3 & PTI_USER_PGTABLE_MASK)
+			pti_switch_to_kernel_cr3(cr3);
+	}
+
+	return cr3;
+}
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
+static __always_inline unsigned long ist_switch_to_kernel_cr3(void) { return 0; }
 #endif
 
 /*
-- 
2.19.1.6.gb485710b

