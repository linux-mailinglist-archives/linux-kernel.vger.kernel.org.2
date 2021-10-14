Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5762F42D13D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNDwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJNDwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:52:39 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EFDC061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:50:35 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so5990371pjw.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KNsLAO3bsrVKtbvZO43zkDsVCtIXcB6A2H/H+A1u2RU=;
        b=a/Y1eBqxxriG6F5NcyjjolBnRH/LDWJqwk+62fPzoqX8EJu2i4BsJnANXb04z42cUh
         w9tR4q4FvqchGSV3q3uQbreoYtdS5YD5alxrxWmmYQ5sSdFGXmMkmmy4cITubXDilDgI
         QDXxHg2t0HEus/Z+5kEaRq5uXoV+QZGXrgfrhLROxXPfQzQdRklsPuDH7ksnHN2MeuQp
         foimhGiSDGbH3CkxufiZFhUK1aCCkqtBOKZ1jR/ryaMt+/7tNcp9fpEYj969XRMU9WDt
         t21DY/JRn43fe4xv7xeYRKZPDi/8K2+xXMVGO3+LOV1/J3T6CxCic6ghpfufr5+hca/O
         jRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KNsLAO3bsrVKtbvZO43zkDsVCtIXcB6A2H/H+A1u2RU=;
        b=TROW8lxKlwVI+XtoKJYxiSHaEjKeJwJh85v17ogZo8K9E0w9r1QoDA/nOas1ivqPww
         luAAnFIPtiwXISxVbfRW4x0Dfo8ucTXRxBhYxQzmrldKAEw7hF+1iJJM3P0MLoQ93CCi
         3IngnF5GtJn6gtVdl29k7mENLlH8qn7v9f2P0ij4baYPuXa4nqE48QjuNqh33sa3jDNv
         Y4mP8CfI+D4qJmfc2GRmnwInhXXi+qFg8Fc8Eg9idibkun+83hIBnVkCHD9Sy8ji1kTA
         CLSIop3DzdxKyf3/7pNfs0FOQvIQdM/r41VUQDYtDnAKPyXr5Up3SlEsqdENAgHBHu5g
         CG0Q==
X-Gm-Message-State: AOAM530c7WqUthKNBQGPgOassrpu9JCovYPSX7ELYsnKJTGgI3afkX1y
        KgUicpuemLfLGKyBHlzC5aP0rVPUrgs=
X-Google-Smtp-Source: ABdhPJykubmBoD9YbnMDTDM0Sf9VLXBrilUtImoHtPKuFiVwwl4xDdO1c0EEw+JUPnng8AMBVGGEkQ==
X-Received: by 2002:a17:902:cec9:b0:13f:17c2:8f14 with SMTP id d9-20020a170902cec900b0013f17c28f14mr2970578plg.66.1634183434494;
        Wed, 13 Oct 2021 20:50:34 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id r14sm853945pgn.91.2021.10.13.20.50.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:50:34 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V3 36/49] x86/entry: Implement the C version ist_paranoid_exit()
Date:   Thu, 14 Oct 2021 11:50:13 +0800
Message-Id: <20211014035027.17681-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the whole ASM version paranoid_exit().

No functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c        | 40 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 8e1474ece7f9..51293ecbfe3f 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -325,3 +325,43 @@ void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
 	/* Handle GSBASE, store the return value in *@gsbase for exit. */
 	*gsbase = ist_switch_to_kernel_gsbase();
 }
+
+/*
+ * "Paranoid" exit path from exception stack.  This is invoked
+ * only on return from IST interrupts that came from kernel space.
+ *
+ * We may be returning to very strange contexts (e.g. very early
+ * in syscall entry), so checking for preemption here would
+ * be complicated.  Fortunately, there's no good reason to try
+ * to handle preemption here.
+ */
+__visible __entry_text
+void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase)
+{
+	/*
+	 * Restore CR3 at first, it can use kernel GSBASE.
+	 */
+	ist_restore_cr3(cr3);
+
+	barrier();
+
+	/*
+	 * Handle the three GSBASE cases.
+	 *
+	 * @gsbase contains the GSBASE related information depending
+	 * on the availability of the FSGSBASE instructions:
+	 *
+	 * FSGSBASE	@gsbase
+	 *     N        0 -> SWAPGS on exit
+	 *              1 -> no SWAPGS on exit
+	 *
+	 *     Y        User space GSBASE, must be restored unconditionally
+	 */
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		wrgsbase(gsbase);
+		return;
+	}
+
+	if (gsbase)
+		native_swapgs();
+}
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index f6efa21ec242..cf41901227ed 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -309,6 +309,8 @@ static __always_inline void __##func(struct pt_regs *regs)
 #ifdef CONFIG_X86_64
 __visible __entry_text
 void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase);
+__visible __entry_text
+void ist_paranoid_exit(unsigned long cr3, unsigned long gsbase);
 
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
-- 
2.19.1.6.gb485710b

