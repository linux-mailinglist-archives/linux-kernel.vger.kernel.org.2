Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3D245EB7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376750AbhKZK3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376925AbhKZK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:22 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C7CC061373
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:40 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id g19so8469509pfb.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sq0pyNwSiU0YOEEmJg4qMUcF5UCPsJUuDI8P3f7GAd0=;
        b=HP8PtrOxd5rcXiGux1HAhMocWpLMg/uReEzcxkOeuHPm+XHitXBcR4vrTlnf4GS+cH
         gmM/ZwJ3ykGB6OUqmU2VXqs+tQ+qm68vzpo1AAZztCo3cbNAu3ZDve6o9eNx0qfSkVxJ
         oe2EoW5qdqf6kg7vluVLtl+xFeiAEfEDmHqKqeEuiY5fG17H6itHtEisl9qUlUJ9IBun
         SpH9PpUqllAio7mF12FLAK9g9P9YaHIrk+4F1AkGe409fABH9AIAeni+8IeQJNZ1A7sy
         fc0k3jb0frrolS4CV7buWj26iMCy28DhmE1/N+JIiN3Ud95bHl47iQGWnGNP7Tl/o2Fr
         khJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sq0pyNwSiU0YOEEmJg4qMUcF5UCPsJUuDI8P3f7GAd0=;
        b=K87oc21pKjfdTzplAvA+m1FKacNFBr+11rFYFDWBqOFG044OxQBsQqP/LjdiNSJuWq
         15sO2eDeiAVXbUqCEtqM6JLeJGD4DKyD8oKRqF7N5soi/jxgh+chuT5aClE4H9P1CBBI
         79EHYDeJ/XTcJVOXJj1IH9ZuXdUluSzv4ncT4BM4kii7sAKoIPmOftIh/HSCXsQo5rwL
         HQYliRsvTivtLA9Nnx3oNs23gbWdn7Cq5UVvvkXHDCClVc2kV5Z8r/O7zs0N9XYPjpGl
         y4t7AcV28WZoik7zkcwb5NFxRjhM2zx17yFijAbsuTpN4XnJla2BQ0gn1weJVu6dkMuA
         o8jQ==
X-Gm-Message-State: AOAM533VdtJcisHkSyKUxrOLF9yeLEGMTh/M1Nom1NaIX3qUqmRmQbGl
        FDOOE8tSPU/pUXrs0wNYvxa56dyXM8c=
X-Google-Smtp-Source: ABdhPJx0vpvU0uf/5rcqKAlZf4+n6IwkDj0eCYQQffeWwROAxewl5qyfsOQvqkCBXHHHbR1aHDYvZg==
X-Received: by 2002:a63:8449:: with SMTP id k70mr20245897pgd.27.1637921739661;
        Fri, 26 Nov 2021 02:15:39 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id j127sm6436292pfg.14.2021.11.26.02.15.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:39 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH V6 36/49] x86/entry: Implement the C version ist_paranoid_exit()
Date:   Fri, 26 Nov 2021 18:11:56 +0800
Message-Id: <20211126101209.8613-37-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry64.c        | 41 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index dc0bd9dc6d48..63a6021a1f70 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -269,6 +269,29 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 	return ret;
 }
 
+static __always_inline void ist_restore_gsbase(unsigned long gsbase)
+{
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
+	if (!gsbase)
+		native_swapgs();
+}
+
 /*
  * Switch and save CR3 in *@cr3 if PTI enabled. Return GSBASE related
  * information in *@gsbase depending on the availability of the FSGSBASE
@@ -305,3 +328,21 @@ void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
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
+	/* Restore CR3 at first, it can use kernel GSBASE. */
+	ist_restore_cr3(cr3);
+	barrier();
+	ist_restore_gsbase(gsbase);
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

