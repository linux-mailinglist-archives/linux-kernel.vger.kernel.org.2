Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCF45EB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376744AbhKZK3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376912AbhKZK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC95EC061370
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:20 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9623338pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gqbv+71I1CWkSH2SnrMSgQz0SXEb2KPHeNxjLfYRhlI=;
        b=BoOlliByxwGG1c+qkJ/AQ9Ha0W8ZcYhM5XkQCpdAQFOYE+eG8h/Tucu2uprM3uzxt6
         CfBXmPTk/6VTboUYa/6DTIuCZwzlx8EeUYfzdQ5CPi3R295UsR6qWtARA/gZXdZGSGot
         RLnBkpvgGY2inJGcyzS2e42HOaIP1+h8ThwEJ3jTd5Knh+D04C/lH8FwvbCOpXHxAmvf
         NwnTxoDmSAXpAP43+w8tHOxHCXp9aNP2HabOZF21kpeorYHYR0Ky50YvbyCw9QA46bNt
         qtPLYtl0fDLniA1j8UaHiFd0d7qnw++VXITccQ2xDsqEsq8HQAcoVYOsnTNCzVj2iA3F
         61pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gqbv+71I1CWkSH2SnrMSgQz0SXEb2KPHeNxjLfYRhlI=;
        b=0/1/QScfwRgFA+P1Kkksux+zkQebW5KFBjG5jj7AYyqwUuRiRTCDtMphz6w4LadE9D
         LKCqFoUjd5nasrcBCuB3EY+Sauj8yMCZLgh2Zu9HLN7Fxe726BZ0JWdJvAPNsKp4YgL6
         J8hCMBdv0XS7KdBtHKZQdpTQae0WDmvaqC5SFIznjUuGyzvLgZ2oyO6jaMBGx9Mw51aI
         aY5lIK2EmQIRtpwC6M2S6vfwAt4H2U0CPqb1gGv2AMjCONTSFxK2TbJoiOAVR3fV1fnU
         K8h5MwrziWFYLQekCSIH48ZEllyPMWYPVQB/pjmds87MvBO+HTEdC7Ndxf1I91uZrJdY
         qb3g==
X-Gm-Message-State: AOAM530Ag6hGeoRYVNl9wOjk8NAneMaGNLpCbBCuHrutcXsi7YlE+Nff
        sFNWvWTbrQMg0LRW1d+iL8db+6jx3Kw=
X-Google-Smtp-Source: ABdhPJxXmTBYoufCBD6YF53cd1kfBGOQT2T83zCWCow8muwmi9PbM0mfkD0g7JlnTWlpRvb1e6AmDA==
X-Received: by 2002:a17:903:1210:b0:143:a088:7932 with SMTP id l16-20020a170903121000b00143a0887932mr37599342plh.11.1637921720357;
        Fri, 26 Nov 2021 02:15:20 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id h3sm7067554pfc.204.2021.11.26.02.15.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:20 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V6 33/49] x86/entry: Add the C version get_percpu_base()
Date:   Fri, 26 Nov 2021 18:11:53 +0800
Message-Id: <20211126101209.8613-34-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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

