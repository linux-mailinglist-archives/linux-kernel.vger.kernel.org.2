Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED9E3FCCA2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbhHaRxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240737AbhHaRxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:53:30 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85796C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so17519717pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4WMMfg+KI4gcEIMWO1vL86x46tSzmtJuTclikLoZhwI=;
        b=CrDx4RSlI6ybO1ODpILI7A/AzVVR9ipA6pLnOKiH4BwP0c3jEAE7VW/j/9ceQLLcR5
         2NokslbHPVu/HTQ71tFiuC+7a0ZX0ylua32a1EC2Rt9eqW61Eh/+NjLgMHysbYhf4OdQ
         v4A9GRMqzlx9yZmE/TR9BZsFXVe0+ZgoXdsUVQjRMZzCp840RnTSXA9b5T2e3164TIXr
         ODQ3ArHrjz2++ke/VyPNfu0TFOQttj5VaNr2iWKbl6D1jZFBeGPb5YExnFEYLjZDG3g8
         XtWhAtC5UBqna3cCNyYAqgwzZcnYRJXVS3LdiQDeddvbqen/OVoOCDdhjfiU96mNdVQL
         YKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4WMMfg+KI4gcEIMWO1vL86x46tSzmtJuTclikLoZhwI=;
        b=X7z8vPBQnvzVNd/8ZGxkAh7T32b8KjP6bL/4Thi3fPlhbg4pl6YV5RjJFXqag0culy
         v3WVIEiHAhGzoscpNBWtwlF9DZAXRSzFAr0UGCQkcY3UXy1Ccc+2GWNa0tQs/RLqdfnu
         Yvc8oeuGvaWHaSnRu4doV/TpRuVNQvG4HEF2oXx6/7v5qqR0fuFhY73RNZ1+5haGhFEm
         RZmaAvBzXog5/KLn3FP+Wxn7F+8BMUJ14hHx324zynspqxcHXigUzI/44BoSoBg/CS6G
         Q1Ey48yTt1Mu3/cbAVW+tMEv81zs5z13pwg1+py+WeG8O5PfDe4nJ5V9/UHIJXMu3NXZ
         erbw==
X-Gm-Message-State: AOAM532JbAYsHxYE4a9pVSWRLhFIelPDl0O4cFLi4ndkTrnlg3Mv/yuU
        5OFLLtY6abeoYZiEfpxbOw0E0Lm9pUA=
X-Google-Smtp-Source: ABdhPJy3Hx9xhSiocoYYzzYcCfnMbvT6rmasLsSvKR1eO1lsZXmsT4EGJVG5adtMlyFCo6D/CCxN/A==
X-Received: by 2002:a63:fd54:: with SMTP id m20mr27872151pgj.104.1630432354888;
        Tue, 31 Aug 2021 10:52:34 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id i24sm7615467pfo.13.2021.08.31.10.52.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:52:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 20/24] x86/entry: Add the C version get_percpu_base()
Date:   Wed,  1 Sep 2021 01:50:21 +0800
Message-Id: <20210831175025.27570-21-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/traps.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index e912bfbd2a61..9f4bc52410d0 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -945,6 +945,42 @@ struct pt_regs *do_error_entry(struct pt_regs *eregs)
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
+	asm ("lsl %[seg],%[p]": [p] "=a" (p): [seg] "r" (__CPUNODE_SEG));
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
 #endif
 
 static bool is_sysenter_singlestep(struct pt_regs *regs)
-- 
2.19.1.6.gb485710b

