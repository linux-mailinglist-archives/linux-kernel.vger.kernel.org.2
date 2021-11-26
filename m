Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85C145EB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377052AbhKZK3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376917AbhKZK1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:27:20 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E90C061372
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:33 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id n8so6393289plf.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zgPqJhzbm9MC82ouByIaOIgT2Ozlbl55wQbaIGoJ1U=;
        b=ehH07cR8gWoXOXqkVuABJtZRKxXrrsgEFEf3DJpaJ0W9hXwDGKEcqppx53XJwNsNqE
         0IOwMRxiwRF/EZPU6+3+ybO1NWx2DE8nbEtC32BFkk9sEnhUq1LCuL2CyolW5tMPCxDv
         yWoKarJ1IPYwLv/aj2KDQtPJ4f1n44pGtqsKFCP5BLSFk5K6GLXVRt/rTvwFojpvewBw
         2VOA91Hdb6RqQhzSU36/rJgRtB4235sF63V97ITxb6JrD8PEDI19QIZXWzWeDoaMImOH
         bs09m20xddEu1IrZ+W5OHBFt9IdH+Qt7VII4MiY/mYoNJSlncW/2mr0x2pnkPiSfLjHg
         BWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4zgPqJhzbm9MC82ouByIaOIgT2Ozlbl55wQbaIGoJ1U=;
        b=dYV+Xc2JmFqISqn7/J3iYAvZZZNBsRiDOTVkj5wlgWItgPlinQ0TqNrGC9DfNQgJPg
         lbpE7fzMTyGlMLQwf0IdOdkipna141Rmz9TosYNbgF/AwdYWoC0gmGnsCICGp2Puupwz
         RoDlVVyd8EnpYM/ytFqxm0yqkQEcTHIYeB+kjrmACsy8cVkiE3y5vqRIFJ9qQu9ktyk7
         KPMwLoqTOX+Z6ydTJuxpkGegnX5jMm1OnZIhprYrpOTIuoGspjQCJguwZtqy1JryERPf
         VJW5hEeOAX4SR0wCDoRwXVL5ibbUQOx9zhCoZAHEiuLRbPuZIpsNA+1EkK8B6I7k+eTt
         h0iA==
X-Gm-Message-State: AOAM533gZGeeJZd+ZBQDvqJNwEm9dl5Oy3HT5JsmEEmBMReB6MiZtXBG
        ZT0NPGrO7ALuBoc3rDr7GU/nVcUq+gA=
X-Google-Smtp-Source: ABdhPJy6FNNKDMYCXn4LMUx5cZ1vJT8tE5ekt3ETv2dDrIwW5mxrv82UrDvLqKtPtMBLt5m+nY1Kbg==
X-Received: by 2002:a17:90a:d684:: with SMTP id x4mr14818473pju.244.1637921732875;
        Fri, 26 Nov 2021 02:15:32 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id y23sm4131933pgf.86.2021.11.26.02.15.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:32 -0800 (PST)
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
Subject: [PATCH V6 35/49] x86/entry: Implement the C version ist_paranoid_entry()
Date:   Fri, 26 Nov 2021 18:11:55 +0800
Message-Id: <20211126101209.8613-36-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It implements the whole ASM version paranoid_entry().

No functional difference intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry64.c        | 37 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 60c37dbe650b..dc0bd9dc6d48 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -268,3 +268,40 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 
 	return ret;
 }
+
+/*
+ * Switch and save CR3 in *@cr3 if PTI enabled. Return GSBASE related
+ * information in *@gsbase depending on the availability of the FSGSBASE
+ * instructions:
+ *
+ * FSGSBASE	*@gsbase
+ *     N        0 -> SWAPGS on exit
+ *              1 -> no SWAPGS on exit
+ *
+ *     Y        GSBASE value at entry, must be restored in ist_paranoid_exit
+ */
+__visible __entry_text
+void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
+{
+	/*
+	 * Always stash CR3 in *@cr3.  This value will be restored,
+	 * verbatim, at exit.  Needed if ist_paranoid_entry interrupted
+	 * another entry that already switched to the user CR3 value
+	 * but has not yet returned to userspace.
+	 *
+	 * This is also why CS (stashed in the "iret frame" by the
+	 * hardware at entry) can not be used: this may be a return
+	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GSBASE so it can
+	 * be done before switching to the kernel GSBASE. This is
+	 * required for FSGSBASE because the kernel GSBASE has to
+	 * be retrieved from a kernel internal table.
+	 */
+	*cr3 = ist_switch_to_kernel_cr3();
+
+	barrier();
+
+	/* Handle GSBASE, store the return value in *@gsbase for exit. */
+	*gsbase = ist_switch_to_kernel_gsbase();
+}
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 49fabc3e3f0d..f6efa21ec242 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -307,6 +307,9 @@ static __always_inline void __##func(struct pt_regs *regs)
 	DECLARE_IDTENTRY(vector, func)
 
 #ifdef CONFIG_X86_64
+__visible __entry_text
+void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase);
+
 /**
  * DECLARE_IDTENTRY_IST - Declare functions for IST handling IDT entry points
  * @vector:	Vector number (ignored for C)
-- 
2.19.1.6.gb485710b

