Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77B43B455
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236509AbhJZOig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhJZOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74110C061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a26so3708944pfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CRFKrmGwY5n2TXCZOXai744qmHmWAyuISZC1rBVd2oI=;
        b=bXJqex/5xyUspH70qPE8HsYV6QVZTHknr7piy4gEU/TGqExgvDfY20YFp6e8o4Nd25
         NJnDzfsHmheWW5HLSXlKRBJYzxLlI1gzxn7r5ypzq17GUB5jFLN6S2A9QW52y1jbIyny
         99J+xaSL1DiDW69CIgmdc9F3sNp1qEziYabRYtlr1sNR2uAv2w/CTsLSfKROnEDZjC2q
         dKHDvtr/xlIla9PFq1iLw3NX9fND1wa+cf5skchP9saxiueqqGwUrq4+Tfz/s6NtVMfB
         eQ8x1uQtV6kcK7XuJ1XH/YA84qTAAKFzutWDWxPpF7/aNLBv38h+XH1RysCvPeBXEpaM
         csjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CRFKrmGwY5n2TXCZOXai744qmHmWAyuISZC1rBVd2oI=;
        b=3hnDm2V6sn9W/CjOmNJszbKJSL6DUmblazzsAL2GLdkgNGP9cC0Kku8+QwnEf0ziko
         pPCyboZEt3SyCcy2df55oesmM7ZYarL3oT/FIaZ63+G6jmoy/WDrPNwpUi7cQM2haIky
         XV/kEx5d4TtWsSZ4Js2WTQX5IiDwnLzMQWmyDT4FKEtOL5Y2jjz2j98LzXTryJNziIg+
         sifoDpZhG1+72Grn+GKn1C1iAZHP+2jGwd4kn2po3//OWUOCB0MLCACaV+rU82+DNzDp
         Jnm+mqUBktt1FjfRuMyuUhcRlftAFatQ9c7jtLqVx5W9p3Tf+19N5CuzFMyItQbscPsh
         VE4g==
X-Gm-Message-State: AOAM530FdD4Gbfc1W2PvVGZQ3FdqzBR58Hlyf5yS9oBeGeqiauKCQm8z
        woWcvdMdmxa57koGHlR8qKBNLjezWaU=
X-Google-Smtp-Source: ABdhPJwZ6e4EutwaNvCCQJRoZgAC/mYY2jLn0bmobaQ/Qhy82UTK2xnDvlzrbO6va77WiktWdIw6nQ==
X-Received: by 2002:aa7:8c0d:0:b0:47b:dc76:38c1 with SMTP id c13-20020aa78c0d000000b0047bdc7638c1mr20847868pfd.22.1635258952828;
        Tue, 26 Oct 2021 07:35:52 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id me18sm1108820pjb.33.2021.10.26.07.35.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:52 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 35/50] x86/entry: Add the C version ist_switch_to_kernel_gsbase()
Date:   Tue, 26 Oct 2021 22:34:21 +0800
Message-Id: <20211026143436.19071-10-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the second half of paranoid_entry() whose functionality
is to switch to kernel gsbase.

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 51 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 8f3a9f2d9c6a..448b9947ed9c 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -223,3 +223,54 @@ static __always_inline unsigned long get_percpu_base(void)
 	return pcpu_unit_offsets;
 }
 #endif
+
+/*
+ * Handle GSBASE depends on the availability of FSGSBASE.
+ *
+ * Without FSGSBASE the kernel enforces that negative GSBASE
+ * values indicate kernel GSBASE. With FSGSBASE no assumptions
+ * can be made about the GSBASE value when entering from user
+ * space.
+ */
+static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
+{
+	unsigned long gsbase;
+
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		/*
+		 * Read the current GSBASE for return.
+		 * Retrieve and set the current CPUs kernel GSBASE.
+		 *
+		 * The unconditional write to GS base below ensures that
+		 * no subsequent loads based on a mispredicted GS base can
+		 * happen, therefore no LFENCE is needed here.
+		 */
+		gsbase = rdgsbase();
+		wrgsbase(get_percpu_base());
+		return gsbase;
+	}
+
+	gsbase = __rdmsr(MSR_GS_BASE);
+
+	/*
+	 * The kernel-enforced convention is a negative GSBASE indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
+	 */
+	if ((long)gsbase < 0) {
+		fence_swapgs_kernel_entry();
+		/* no SWAPGS required on exit */
+		return 1;
+	}
+
+	/*
+	 * SWAPGS is needed.
+	 *
+	 * The above ist_switch_to_kernel_cr3() doesn't do an unconditional
+	 * CR3 write, even in the PTI case.  So do an lfence to prevent GS
+	 * speculation, regardless of whether PTI is enabled.
+	 */
+	kernel_entry_swapgs_and_fence();
+
+	/* SWAPGS required on exit */
+	return 0;
+}
-- 
2.19.1.6.gb485710b

