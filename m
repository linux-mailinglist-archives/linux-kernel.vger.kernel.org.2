Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBFB4189CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhIZPNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhIZPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BDC061575
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id x4so2493548pln.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=82l7hm5ayFTY+bZsY9eWKZD25UHpS8vS8pRLVtykk+U=;
        b=WNRNa3XBWsZZGqFh+pOdrzf6bCIfdjgqcTgmn9dViAHUPtNHVpguxER1wdoiigE4+a
         NYRwaU/zjbMIqvA0SOzzlxx7AlTr2deax+ABmzLV7M86Xk0hlWhNUG1RXCDbdYD3Rh1k
         1jXCYg7/+PqHohJhnI1WXkAtuBfI6EFnx7qZYwIuEexKZsjqfBe++uWKf2ZEUl5oqxss
         GsZyy5DOxcWT3CkAQhCA4C8xqyck7JTsWfhORa0VFEJDOuVlvl1GYvAt3L66U5gVIqlb
         2/RRfVQTa5wvf+/xGh3VTNXWyxeegSnrc+PXl9AAXshtciywpoHyIpBfERMOICJi3LJg
         JzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82l7hm5ayFTY+bZsY9eWKZD25UHpS8vS8pRLVtykk+U=;
        b=oVbn5k+nmlFEzXqJbn8uVEhh7Y64jSRJU+mRR2U5qe5xSr6kJOsashnM23d+lG1ff9
         5r5u9XmJh96XSuKE6yq1hKwiGkt5W8Hq0wiwZpIVj+/A+EZby7I9YOhGuyu0eNcwlROQ
         qBOGr4LQtJHPLZD2aReYPNlqO6joVbH59z3hgnhRiXWPQqgU1xiawcodFWwwKXoZiRzw
         FINoW1kSHCT/JPSHPQTF4iFPL1mJqinS9oYiVw0vu2scx7xMj/WI4yD24uf2htuc0om0
         BnaM2djvs2dctCYXiBYQCjXM54MiHCSdEuf5Mv+duoI2EkhyeU9vHhLVbFBkIJQHEjkI
         4pwQ==
X-Gm-Message-State: AOAM531ig1zIOuKu8iR+cVCVlqBkIb1xzqWSOoHSN05eQJAcwzx9u0zn
        bc9orYiEqa6/G/z1qkZhj5zj5V8SKMvtsA==
X-Google-Smtp-Source: ABdhPJwmfpWfxJpGrtQJsCRNYJFIX55DvEVikDMltFU/yfbVJYe28Dfv7Ge6Xp4RiH7weX4AFl8gDQ==
X-Received: by 2002:a17:90a:5895:: with SMTP id j21mr13945357pji.99.1632669069964;
        Sun, 26 Sep 2021 08:11:09 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id e2sm14920438pfn.141.2021.09.26.08.11.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:09 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V2 23/41] x86/entry: Add the C version ist_switch_to_kernel_gsbase()
Date:   Sun, 26 Sep 2021 23:08:20 +0800
Message-Id: <20210926150838.197719-24-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry64.c | 44 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index b939b56d985d..1a0d5d703ad6 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -229,3 +229,47 @@ static __always_inline unsigned long get_percpu_base(void)
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
+		kernel_entry_fence_no_swapgs();
+		/* no SWAPGS required on exit */
+		return 1;
+	}
+
+	user_entry_swapgs_and_fence();
+
+	/* SWAPGS required on exit */
+	return 0;
+}
-- 
2.19.1.6.gb485710b

