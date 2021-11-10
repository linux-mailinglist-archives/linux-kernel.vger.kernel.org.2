Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E059A44C09E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhKJMD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhKJMDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:03:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F8CC06120A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:01 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id x7so1347049pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqbv+71I1CWkSH2SnrMSgQz0SXEb2KPHeNxjLfYRhlI=;
        b=AFDI/IplOkU185eWk3iBfyruG2Tg+h8kj9XGHi+QygqsWi2WLozv5W0xthAjeYVq3L
         txemHFmuilEDiAhWJRBS0gipM0EpPEZW7Oo9NlxFgiQL/JKe6kM3l4GDJtiaQGDFj5LK
         kZWZkoYlJiwN5yPRPinC//lthAfQlJEkQcMlc8RqrFYlGVQCUbMkCsDEeIgsDnEOJbg+
         oIwvcJEM6V3xcoS6+hGBL9h8Oim4OrFIsRIi1RO+XVL6oDr8mqFRQIZwd+xQwub7eokM
         45DihsDi7275gO7vMtkCnUm8DZAqwXWEZc0udF6kiWA3iqw4EJXJ8S55OA5HsBL1eiJ0
         kCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqbv+71I1CWkSH2SnrMSgQz0SXEb2KPHeNxjLfYRhlI=;
        b=skCwo7+eplALLYFfCbqaspwTjgpHGZAaX/tZ6Gj6IzD4D6kVjlWbgGUohkLvLwh7r8
         6EBhFlihJcE0u/SyRLV0jfQmtcKNDJrbeSQQWLwzrfsfex5iXkIm91MPqFC4evcJY6lY
         /u2EJPmhnlnFASlDVkBPLVAhgL02WBbTYPq7fE7Tnlqc3CHQR/BrTd8zcrh9ymWJifpN
         +54O8zVIWA9Ep8Z43e9RgHyKHjXNUFoSGrl6Ta77ZWqME0Rxym0EqD67VSHv5YAqH/Ra
         Vgr+p9VgOtW6v0qKZZuhDsbvenQLFTNM2iWPClq8g0x3AFnkA3Ng0+M4jD42Z5fCXwMD
         xZvg==
X-Gm-Message-State: AOAM530s2QJTV1kkX95/EHlQk+F+Nb3tQkaSD0AjrxC9miWBVrt0nK7E
        YhUqQQcbPum9EdAcQ9XKgAVQEZNAfsg=
X-Google-Smtp-Source: ABdhPJx4BeeFk0FKpaRmmhjiDSPGKfq2FZJJX6PuKS7+8wqdCXn5gfkFStKBaifo4g+nFQ8pZR4ghw==
X-Received: by 2002:a17:902:9694:b0:143:6f27:29ad with SMTP id n20-20020a170902969400b001436f2729admr13363157plp.46.1636545659668;
        Wed, 10 Nov 2021 04:00:59 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id q18sm11078485pgm.24.2021.11.10.04.00.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:00:59 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V5 34/50] x86/entry: Add the C version get_percpu_base()
Date:   Wed, 10 Nov 2021 19:57:20 +0800
Message-Id: <20211110115736.3776-35-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the C version of asm macro GET_PERCPU_BASE().

Not functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 5f47221d8935..3ec145c38e9e 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -183,3 +183,39 @@ struct pt_regs *error_entry(struct pt_regs *eregs)
 	/* Enter from kernel, don't move pt_regs */
 	return eregs;
 }
+
+#ifdef CONFIG_SMP
+/*
+ * CPU/node NR is loaded from the limit (size) field of a special segment
+ * descriptor entry in GDT.
+ *
+ * Do not use RDPID, because KVM loads guest's TSC_AUX on vm-entry and
+ * may not restore the host's value until the CPU returns to userspace.
+ * Thus the kernel would consume a guest's TSC_AUX if an NMI arrives
+ * while running KVM's run loop.
+ */
+static __always_inline unsigned int gdt_get_cpu(void)
+{
+	unsigned int p;
+
+	asm ("lsl %[seg],%[p]" : [p] "=a" (p) : [seg] "r" (__CPUNODE_SEG));
+
+	return p & VDSO_CPUNODE_MASK;
+}
+
+/*
+ * Fetch the per-CPU GSBASE value for this processor.
+ *
+ * We normally use %gs for accessing per-CPU data, but we are setting up
+ * %gs here and obviously can not use %gs itself to access per-CPU data.
+ */
+static __always_inline unsigned long get_percpu_base(void)
+{
+	return __per_cpu_offset[gdt_get_cpu()];
+}
+#else
+static __always_inline unsigned long get_percpu_base(void)
+{
+	return pcpu_unit_offsets;
+}
+#endif
-- 
2.19.1.6.gb485710b

