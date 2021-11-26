Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115A645EB56
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376740AbhKZK1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbhKZKZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:25:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290A3C0613B4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so9561757pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=NXvDV1+/fzA2CizuNZYQxLIw2PNSdBaninuQel72zra8uVnirnP7c5Tx5twXlU7Be9
         qB/QazdJ2KS2tCV+qyktWjrLbd1X7kS9AF6veiwYBTSPAN56lWM7WkXN/RUwL7WrhViX
         FlWbRwD2Yyc/TSKT7AGDS7MjxOXkup0ji07ZvDLo621rDLTM9q3uw1QBbQr2XShJMmiR
         H3/9ta7knHKir7wk0yOxAN1zmHlPTq4jjjREkUejkkA9K+NE9GAu7hkJHXGOeDjcb0ZJ
         KM3QKwhI7gz8Q3EezUmokUP/H1vkuZa54rXVi3k5no6EVEXTXk+X+Pt0F9R02ezSb30l
         /xJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JXRYlHaZYG2aFI4DCBWmOyqizmtvtzTxNVeiLJn6Liw=;
        b=Ue40yXjNDOnSOVuBQZo6Q4JXilpJyatRRedAzJ9lkBPsWazd1y4El9gaCrq6faMd2X
         J2si0biQTWvvDa8S0jHlzKyljeKNIY+r7c+1djy5z+BcCpV+8Ut3EHjlOrFVq0lTV577
         9hO8Jjwm74SSSMet+uBMbt3Jb79ewuuYWmkI35VMPf80oRBDixbnnfQJy4s3g1iuC4gY
         sI5Tkm8QVi4aQXSvswV7L42nINzYpwmWGzD8j5x6sWYMEyKtzyTg6QsYMQrfDIjQ5fIa
         HPjgLOHSS2Aup1PyueeR4pL06yRp6DKrLllv8RLllllVDexndFbiJsRVZFO3FDjEBQCw
         AEOQ==
X-Gm-Message-State: AOAM532PNH4MsTaL404GIHZ6s7uVn3/PWzT1kIcxsotE7wMQUiEsnJz/
        PjpBwM+aIq1yttyGJ1+IUe7WdmosiKw=
X-Google-Smtp-Source: ABdhPJzQACgSP/rcaj16A3WczF696dR8rlqYW5T3NwOfuA6MQxalFTv3pESk/hti2UXSP5vjhFhmpQ==
X-Received: by 2002:a17:90b:3ec4:: with SMTP id rm4mr14254669pjb.88.1637921612586;
        Fri, 26 Nov 2021 02:13:32 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id g9sm7159917pfj.160.2021.11.26.02.13.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:13:32 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 15/49] x86/traps: Add fence_swapgs_{user,kernel}_entry()
Date:   Fri, 26 Nov 2021 18:11:35 +0800
Message-Id: <20211126101209.8613-16-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

