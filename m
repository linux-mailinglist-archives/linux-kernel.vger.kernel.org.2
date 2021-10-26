Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B8A43B413
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhJZObb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236600AbhJZObW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:22 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE55CC06122F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so1835807pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yczlImmJZUDVVto43TWdibC8uGbZcKJHr/ucX+Q9lY=;
        b=SYV4FUVc8NrScaxthjnP7GD18ZtIcy7rnsdDoYhPp/eqBnpmQSORXVHCRbYKZtdT+l
         h6g4D3g845jMPtkwMBI9j61AIzRYVudS9e3cWyneu9piLcJeKYGoecedkOJe1d54U9Nq
         vcbeRtkx2/pKESw5DJKy+X6c7ml2rUKfuHxqeL4EqKtMBP5lbCcTaPHt4Fi9voeeWQC6
         TzDgdX17QHmwzQI9x8btVE2gsrlMYIN+9ZT6u2YLrwRZ2fy1XkBqAPAD8QN24HN6Hmzd
         HZvXTBkfjYIuPp+A1EDmYqSNI5AoFQY74siDc5uO2EkftMHHlnB6ycAmMhHkLuHSafER
         U41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yczlImmJZUDVVto43TWdibC8uGbZcKJHr/ucX+Q9lY=;
        b=kvQJ6wjTzCLBWiQS7Vmlzor6PmbxrlmoSg6w9M/LS4K3w9iOUZSrFxLNK7BhKuPEDD
         vkumxATOAnG8lqS5gfwVTSkCMmYCdV7m4850a+80fsL3VwbWbU8Cts8VQ2Twlv8iG6Kn
         NE+GBH39cbdM0n/kd4efvh/qSYNQlusEfLynr5czDal0qYAUONCmC5wsskr5BoIEco2o
         jolIyItbfrZMkXKa4/nN/K/0Dy+18bLnUJHBTcKsysGMZayndi/nezbaP2A6wR4crzJA
         DMLcIPGTS280ftJTyGXZiZA+U5J+KmpHSoTxKAT/MzkekYwhYLLOjSAN6plbYDkzUkzc
         5Zdw==
X-Gm-Message-State: AOAM530nF3kWH0T4R04E1gDo6o75TT+mUJ+Xaxxc3anpQ06jJfIScn4D
        wx+yif0kwbh8Ik0gJ5JOAgdKmrZRu14=
X-Google-Smtp-Source: ABdhPJyeByvZuhNsAJs0DWMMBZ0ZfBLDCAjwdl3G5zHkYqV1cx9MVuzWKVm5TqmwKFzDrqj9q0LibA==
X-Received: by 2002:a17:903:182:b0:140:47c1:1f13 with SMTP id z2-20020a170903018200b0014047c11f13mr14651407plg.63.1635258535420;
        Tue, 26 Oct 2021 07:28:55 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id e1sm20497103pgi.43.2021.10.26.07.28.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:28:55 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 17/50] x86/entry: Add C {user,kernel}_entry_swapgs_and_fence()
Date:   Tue, 26 Oct 2021 22:27:49 +0800
Message-Id: <20211026142824.18362-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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

