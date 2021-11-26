Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5292545EB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377006AbhKZK3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376913AbhKZK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:20 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E79C061371
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n8so6393094plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t2fIiy47OEpLjVbfsJgqPPIh3aEgH6Yh0HohjVlu8j4=;
        b=bgWdJMSju3Wt5U1vMIl+P1IUyaBQBWOWMskwkvVnH3+Jfl+dfHwKEnkNnYRNsug2bG
         5fZ4344taclaHcwpq7OlYeXbHS4Nswo3wcOQxY1IstN6K8XOQLdiLI6912e6PoLGDqpy
         IllXD/9IZCeoj3OdsG3kKG174xUIocbQ63z1APuDEf/kRhw29e10kJ7PrNC8XWA+bhcL
         0N/s04sXw2GoLwD9EU8+kfF4EfGvd6OKsi8WT0wXktrY4++qr4XH4S/0dgDia2RuVRR/
         J4HxaAgygc7Z0xrCAAq1MpPovUqLvrD+OOXmDlG4KtOnR9RngIVAbNfArlIZQnsBWgje
         OlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t2fIiy47OEpLjVbfsJgqPPIh3aEgH6Yh0HohjVlu8j4=;
        b=KJoCPGod3h65fHaUj9R8SojurUtzAM5a4OrXB724Mrq2OA9xW6hWXxzBhzZYdYrlE/
         vo0yZw3AYdS7IGovYkZuY1PMdP5SmolxZp/BOW56uhnLEyboasDcRh5gie+gXviJfRgz
         peSFbR9Mx+7V4jCIWgJ8Huu82sGg5LMW4cpyeKj15oTXMvj8QpBS7rQP99L0Ae84brCF
         +F2oOH3pHGesomOeuYVUF6V5/V+c004YlsQ8ykcJHoWOcoD64U5VMnegI6D8jTG8WJh0
         SX/E9sSDrOtakpFGDAYzNov53Wm7s5ZWDx6fTAf9SVic72VkL4oaIFWz7nx2Pey/T3A9
         jNxA==
X-Gm-Message-State: AOAM532v0qQofy268Y4ajAObGLG1J1Q2kw5Vgli1y/EYAsuKWm3lx210
        34c7/psS4E3zeNtigDNLMK+yV2kykec=
X-Google-Smtp-Source: ABdhPJzYdZeBFG3Yp57o2PQVMVUbMlFOvIG7rfsmxu3VQsO44tJZhC6Ef61+OYr7KM8dKxctCu82UA==
X-Received: by 2002:a17:90b:4a50:: with SMTP id lb16mr14618164pjb.147.1637921726136;
        Fri, 26 Nov 2021 02:15:26 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id q17sm7170780pfu.117.2021.11.26.02.15.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:25 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 34/49] x86/entry: Add the C version ist_switch_to_kernel_gsbase()
Date:   Fri, 26 Nov 2021 18:11:54 +0800
Message-Id: <20211126101209.8613-35-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry64.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 3ec145c38e9e..60c37dbe650b 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -219,3 +219,52 @@ static __always_inline unsigned long get_percpu_base(void)
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
+	int ret = 1;
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
+	 * a kernel value.  No SWAPGS needed on entry and exit.
+	 */
+	if ((long)gsbase >= 0) {
+		/* User GSBASE active, SWAPGS required on exit */
+		ret = 0;
+		native_swapgs();
+	}
+
+	/*
+	 * The above ist_switch_to_kernel_cr3() doesn't do an unconditional
+	 * CR3 write, even in the PTI case.  So do an lfence to prevent GS
+	 * speculation, regardless of whether PTI is enabled.
+	 */
+	fence_swapgs_kernel_entry();
+
+	return ret;
+}
-- 
2.19.1.6.gb485710b

