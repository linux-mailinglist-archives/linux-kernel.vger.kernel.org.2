Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DBA42D107
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhJNDhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhJNDho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:44 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC7C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:40 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so3781260pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yczlImmJZUDVVto43TWdibC8uGbZcKJHr/ucX+Q9lY=;
        b=hm6xnM13jNr6nMPHTCK3kdTDwlMh0qx05iDxWbONqGCM8ACw5Ik8coVSdF8V0zZAhu
         e8WSjL0F+9uxFCPY6xyjYZ9tnTbSWmhO3DCtPjOCP7nDUQnVTufOP85k2URXDbXSwcwA
         e34W+uJjGLGwuXzcO0qhQT5k+uSnZ8vjczGoHE91C0KRmKkC1NYVIS9q5tUtKRjTCs2Q
         z5dMDlHFWWQu7np4RpFpdqHtSwClrRyd1Tlt5tUBIZ2I8TVTmsGiLjv2g2cUKIhjeM7R
         mXYZjh8sHKtDnoChJtd8je6kFkJm3tK7dXVn1GdJXaZb3w1HkqM93o99zcSo71KNJ7ut
         Gfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yczlImmJZUDVVto43TWdibC8uGbZcKJHr/ucX+Q9lY=;
        b=SYCzJgU5HPTKd7HzQcm4XmLjedDi8aH5EBQWSOh4Ho0GlHT7ZyAZk++7583i0UXmSy
         +Qwo0tam2MXEZvAHiao27RLVmF0mj5OBNmZGwNmf5QPgw/YtAme5nNPVGLpBYqgjxZwj
         aBnOXmyw7dHUE57oLfq5Pxe5bx70DI6ur6d//eUIJowsZlIxwfIa4ujDD0CH3o02z1Xs
         kiD8A1dFjYlTpflkRzXiDIJHcNF1cqGK7ekOpYDKR7w7bWePo7UOq68chKzWosmj/Xqg
         O+l1ZjTL0DCHqoA1o9nc91sZcnmr452BeHmxg5t1gKRgZNzg+NBAwqrmkcOj2UMUHcF0
         glTw==
X-Gm-Message-State: AOAM533lvdRr25QDlF6XilH6rGubwSQdBrpH1dmJN51omvTCjMP+I5NH
        7nJfPRzT8Bf47hh+8KSDraORrocHx3U=
X-Google-Smtp-Source: ABdhPJwZEuVr985TPW49eWE0UPT1xyImzClE1Q88BW4vIt6Ofgd6mGjOy2p3bq2ZYBG5t+fkvpZMIA==
X-Received: by 2002:a17:902:c713:b0:13f:295d:803c with SMTP id p19-20020a170902c71300b0013f295d803cmr2911243plp.46.1634182539456;
        Wed, 13 Oct 2021 20:35:39 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id rm6sm860766pjb.18.2021.10.13.20.35.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:39 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 17/49] x86/entry: Add C {user,kernel}_entry_swapgs_and_fence()
Date:   Thu, 14 Oct 2021 11:33:40 +0800
Message-Id: <20211014033414.16321-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

The C user_entry_swapgs_and_fence() implements the ASM code:
        swapgs
        FENCE_SWAPGS_USER_ENTRY

It will be used in the user entry swapgs code path,  doing the swapgs and
lfence to prevent a speculative swapgs when coming from kernel space.

The C kernel_entry_swapgs_and_fence() implements the ASM code:
	swapgs
        FENCE_SWAPGS_KERNEL_ENTRY

It will be used in the kernel entry swapgs code path to prevent the
swapgs from getting speculatively skipped when coming from user space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index bdc9540f25d3..173cf621317c 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -49,6 +49,12 @@ static __always_inline void switch_to_kernel_cr3(void) {}
  * fence_swapgs_kernel_entry is used in the kernel entry code path without
  * CR3 write or with conditinal CR3 write only, to prevent the swapgs from
  * getting speculatively skipped when coming from user space.
+ *
+ * user_entry_swapgs_and_fence is a wrapper of swapgs and fence for user entry
+ * code path.
+ *
+ * kernel_entry_swapgs_and_fence is a wrapper of swapgs and fence for kernel
+ * entry with user gsbase code path.
  */
 static __always_inline void fence_swapgs_user_entry(void)
 {
@@ -59,3 +65,15 @@ static __always_inline void fence_swapgs_kernel_entry(void)
 {
 	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
 }
+
+static __always_inline void user_entry_swapgs_and_fence(void)
+{
+	native_swapgs();
+	fence_swapgs_user_entry();
+}
+
+static __always_inline void kernel_entry_swapgs_and_fence(void)
+{
+	native_swapgs();
+	fence_swapgs_kernel_entry();
+}
-- 
2.19.1.6.gb485710b

