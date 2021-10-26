Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113F743B412
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbhJZOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbhJZObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A65C06122B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:50 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q187so14329854pgq.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=Ttc8QCLTo936epLfk1IRO61zZr+MgXudiBLLTmYUH71zsQObIV+tc7neKCk4xQEEJf
         p88j2Q3BhIgS79/wZAFtT5oll+xFlORQNFuVxyKkxshIPI6deodpjhi4FulxfMbVsH6S
         27RMwFbE56HoBW/qxS1Y7Ep6ITGkAdal9476hMkfKq86/MkkuUjrIu2tEFuSoOc3LFFi
         QD4GQ16jJIAMP1bJ4nDJK8FGSzWe1sn+zoVMS3Ascl5PtJzLL2ADk5cj7/adytCYjGrq
         L4L0a1RQULWcp3lCgeyTdh9//wN5SoaLWSENJfg4CYSb11UK+1mnx9yLW0bD9XywJBa/
         tdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=6ev0ySgyF/71ncyd/qgfkWGcgyiIf4GPR/8EbyTtUOhZvp9a5TP2tEaIC+Q54h8LUq
         E6oASetBRW2JhoRdAVG2UAuLqjk01YJKq2y4QPG0nXt3Z5qSFenoHhbb/suZQ1sYNAAG
         mSH3rSi7AfYLV5kMo2iKVNTd6oJJyf8jyabSuVXTfwKGgncolAY+vrn3KQHUWty3zQLx
         5reB0mm1UyY011REYbI5bVzJHHSay5Tbq2YRXF626/74L2gtfB5wgKU7cfXyJmwnfuhQ
         AqgN2+MvNtgTGyaUdQNup4FAlBqap5lbXG39rHTxBndPMSKIuRUH/Q/I9aRjP9pCYHZG
         dliw==
X-Gm-Message-State: AOAM532N3pNYN9rNdnC2UeG7Q0TQxg0N2XqewDTbR72PPrHnn/mFsY5N
        dlnHqTkYHlN6vs4QKLvnuPI1URqayoU=
X-Google-Smtp-Source: ABdhPJx+JdbT2fKlXItur9X7K3uoSYO3qiUXw3jx6UTI9s/zTtw+EKzS82RSCJ3dL7eFF+anRfObdQ==
X-Received: by 2002:a63:101c:: with SMTP id f28mr18723259pgl.330.1635258529913;
        Tue, 26 Oct 2021 07:28:49 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id t32sm25126473pfg.29.2021.10.26.07.28.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:49 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 16/50] x86/traps: Add fence_swapgs_{user,kernel}_entry()
Date:   Tue, 26 Oct 2021 22:27:48 +0800
Message-Id: <20211026142824.18362-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

fence_swapgs_{user,kernel}_entry() in entry64.c are the same as
the ASM macro FENCE_SWAPGS_{USER,KERNEL}_ENTRY.

fence_swapgs_user_entry is used in the user entry swapgs code path,
to prevent a speculative swapgs when coming from kernel space.

fence_swapgs_kernel_entry is used in the kernel entry code path,
to prevent the swapgs from getting speculatively skipped when
coming from user space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 9a5c535b1ddf..bdc9540f25d3 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -38,3 +38,24 @@ static __always_inline void switch_to_kernel_cr3(void)
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 #endif
+
+/*
+ * Mitigate Spectre v1 for conditional swapgs code paths.
+ *
+ * fence_swapgs_user_entry is used in the user entry swapgs code path, to
+ * prevent a speculative swapgs when coming from kernel space.  It must be
+ * used with switch_to_kernel_cr3() in the same path.
+ *
+ * fence_swapgs_kernel_entry is used in the kernel entry code path without
+ * CR3 write or with conditinal CR3 write only, to prevent the swapgs from
+ * getting speculatively skipped when coming from user space.
+ */
+static __always_inline void fence_swapgs_user_entry(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_USER);
+}
+
+static __always_inline void fence_swapgs_kernel_entry(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
+}
-- 
2.19.1.6.gb485710b

