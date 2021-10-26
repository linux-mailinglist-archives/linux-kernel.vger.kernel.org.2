Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B543B454
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236724AbhJZOie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbhJZOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8697C061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id np13so11087838pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pltELxhXmO26iewvCcOTgyQSWeQg6Qg1MaNOQ4EmcHI=;
        b=p62cJMplNt9vpB2Ge9z79b02uymMY/II4Fo9lGpEum4zaH0OkajI1gSb/amFlXwe0h
         LgYIuIzFcjCzwwxvAFvh8cHYDGVxnMti5UQUuk/eodYCAD6dB4oXZj4gM81jt83A88P4
         3jtHGXakWFGIbxC+ndc8eldhM01NhbudEpgvj8Xg11yYDw+7yzKOP7OzmAF9wB3HpKAW
         450hO2cvCISeefbmVR50S/S9njXnl/PoB1DG9XsRLKT4h+opxXZ9bwdTSzYyMfTSKFI6
         PJD1yQix/gLfDHinQevV9giSHWsm6qBO0Udcx9PeAhnLyfWZql0XZPUjZiBK7KQri4gn
         pSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pltELxhXmO26iewvCcOTgyQSWeQg6Qg1MaNOQ4EmcHI=;
        b=RxOSTaCooq6PJ1YQppfyvq5twPdxtYpjKdSy5ZXP1+SucR5sjb3/nV/coJWo7n8VVz
         ssN2sVQB9VXCJeYqOJB2V09b1WoreXgqqdHwMzePSZR4J1u7W9WjyCPGYasy9WLeh1Ys
         HIDkLYyFosm2+rLDbmbhjjJ1nI7VX9fhommN2qRXwpoS1Dyrze3mcv3zUCc9dnDXLs9Q
         V1xhc5E/TGPzJn7ukXZEpxx+H4GPZttYdWAvIaJRZM0UkyKA76bzx1ergJzFHGQDJZXu
         6pkv46COJKYGnHUqh2Pfgk3P2+fZHx7KjVVGIml2oHfDVYP742oPY+G965uWG3oJwWyC
         I/XQ==
X-Gm-Message-State: AOAM531wKT1CYklbScqZKdYVA/xFUZcO90m/k8kYYGjIAsOFajg0OJS3
        5wCtv6P+dWyjhWmE7cO2u1PHU71Fo8o=
X-Google-Smtp-Source: ABdhPJznBsu0HdH5i0+BiQP5LORoBkZS5mdrpLjvljC2lVsRIQng3GMGMvoncDBrmrDjhvyQRaqKDg==
X-Received: by 2002:a17:90b:3892:: with SMTP id mu18mr4445225pjb.102.1635258947280;
        Tue, 26 Oct 2021 07:35:47 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id c4sm13515758pfl.53.2021.10.26.07.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:35:47 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V4 34/50] x86/entry: Add the C version get_percpu_base()
Date:   Tue, 26 Oct 2021 22:34:20 +0800
Message-Id: <20211026143436.19071-9-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 446d91d7b376..8f3a9f2d9c6a 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -187,3 +187,39 @@ struct pt_regs *error_entry(struct pt_regs *eregs)
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

