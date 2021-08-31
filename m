Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D473FCC94
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbhHaRwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240599AbhHaRwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:13 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16166C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m4so11145775pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cKJKix7V4+8OJWG7NYRAywgnyYbhA97Td6yueyJaEo0=;
        b=sx0/84XcVXA7145IRx0EmPQXqT95ytN4wLAp8nwL8xXi8kYW0NGz2DGMKGH7I6ZCQp
         IXpwvTSbXh+ZUFmSQkjp//oPngE/Rwh14N9u5NVBC5Un+k1Vj5AqEsjzb2EK5KV3y3bX
         BfSt8n6m8PPdvqG5ZdavAQ9ro4iJtqtXyyIzDDKBjSMW0u/3sAj0rQT5RubG/OkgE3f0
         c/J+yVNdnf7z1eTCjc9Jk2ARe5g+rkQ3oWqLbXvOu9IN8i4MNNSjGQHrIIIvVVurBhSG
         b0KYHP9Bo4DnXrHdgdDnLbGSBhOdSbSTXmengz9PkEyUvwCx9pJTGtVsWgLds5X1g1Y3
         9Hnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKJKix7V4+8OJWG7NYRAywgnyYbhA97Td6yueyJaEo0=;
        b=VxOqFzWpTgApJC21uO6njAGRVeh+jwEg6jrpohp5Wlwfrrp+lPuxDP5nmwFa+fC+eC
         V8SlOYbeq4AVXB/0U8crQUD0SKg8rtACuKZD1a6zqJBpg9MX2fH67uHnKlPHgievV+3r
         wo3IbjVNVf3ZQLch/Jp3beoFzSAASKYurR1AZPiOUDd/74te3CyTEe/fmyuTT9Jn7avB
         4Olzpxk8drTfxp81y1zqGX2HcYE8Ww1Z7gTpWHwFEcdrPEA5SnbXsV3iHN1fGHEwapGw
         EtOczrxh/p5xYy0rjJbEnqKLuAMkgwG4mY3+pOHAGyh7P1S5LtQMY9VFiR3jNBrRH82O
         8Y9w==
X-Gm-Message-State: AOAM531U5LsYiSDMxkAWHp9r+63AzHQ2/e12FFM+zVj2pJcLWdzRXeW0
        XIWG1UWtGeZOwY4dbQhO5kLtaLlUyOE=
X-Google-Smtp-Source: ABdhPJxFRIVycVYQI6vcXMeAwzkKTHZ57mLC+Kt2c3mIuRxxIY0MQbs2aRwZyYKKHmUcUqdfBmn5fA==
X-Received: by 2002:a17:90a:af92:: with SMTP id w18mr6624650pjq.98.1630432277471;
        Tue, 31 Aug 2021 10:51:17 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u21sm21989951pgk.57.2021.08.31.10.51.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:17 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 08/24] x86/traps: Add C verion of SWITCH_TO_KERNEL_CR3 as switch_to_kernel_cr3()
Date:   Wed,  1 Sep 2021 01:50:09 +0800
Message-Id: <20210831175025.27570-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/traps.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index ef07ae5fb3a0..9b7d0f15402e 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -765,6 +765,30 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
 }
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
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
-- 
2.19.1.6.gb485710b

