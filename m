Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F9542D11F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhJNDol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhJNDnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:43:55 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77692C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:28 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 187so4265053pfc.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaS3e6HPf4uIDioaRz2iYDZJ5aCgKi5pCRpWThtL0F4=;
        b=eU1ZK7jMIezGEditoBhQYEsh65Q0C4BWQDSRE8cuTD7TZ1mciisyK1FTk1WMEcEUgJ
         Bqj9PVG9niuwr+VZhqeGf1sdbk3fIVkxabamMXDRsLnlTRtWPGvu8O7Zf+bjjOqMs0/E
         i5oCig8c29oQFmPchRq/HnHCN7pIXD8aIf8+xucjwpRFg6BIVERbLJMGveDidXmuMLXl
         FhgAt6gj3nHyBmSqUm+AIwU1AB0UYyfnDjb6u6rULTZxf/Nqu784XxOQv2/tSgrpFmX0
         DRpt2FV9VXM+/upoE11b0Z4tyrhkjWcgbHFBUDuiFjjQYPdfD1+bqhznaTEtj/Ms09IG
         cQ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaS3e6HPf4uIDioaRz2iYDZJ5aCgKi5pCRpWThtL0F4=;
        b=4Krh7sPTp5r6BEq90q/GLHUU9TvcphplV+PQk6U1wSyGOdu5oMqxn16FcdyDIHfGYw
         UOmNZiCU2vXPOJFZpuEevVU2jUhcx28M4o5omAL24/gzoGCQXD+rWG+2qD/QZzuzH5gO
         nsgmkR7OmEXM9FOGCdlvrWYpuyF/HYSU/5AoFHiLAWNK/K+Q8rDP2pYYSrKS2VdasOpt
         4H8xfO6GKtYSKISI4asK8YN3vNd4G+fomY9bRG6OYv9YH96fu+QrHDyHS8EfEwq9k82a
         3E9PzlGLf6/ggQ2AttPuFW1CSVavf+URcJr+K/XpUZPdlXvF9PZRKPSsHaJcPfqDmQP/
         6mwA==
X-Gm-Message-State: AOAM533gG5pvAQpuBvd2EXV69nd3dXL9RNWHJpW9XAqBmV735bcLnMxf
        5lWQcS7Oslgqvi+7t/GbT4ZStuYoUCc=
X-Google-Smtp-Source: ABdhPJyFrLqdjeDgY4TV65QOakFS78JdQSriqOHgMldopPZ+6e6+HpjEyZMxNH4ONwx/X+622Eyyew==
X-Received: by 2002:a62:e90d:0:b0:44d:35a1:e5a0 with SMTP id j13-20020a62e90d000000b0044d35a1e5a0mr3210645pfh.54.1634182887896;
        Wed, 13 Oct 2021 20:41:27 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id i124sm867959pfc.153.2021.10.13.20.41.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:41:27 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 33/49] x86/entry: Add the C version get_percpu_base()
Date:   Thu, 14 Oct 2021 11:41:05 +0800
Message-Id: <20211014034121.17025-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
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
index 5edbb4bb4786..48fd3199f00b 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -201,3 +201,39 @@ struct pt_regs *error_entry(struct pt_regs *eregs)
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

