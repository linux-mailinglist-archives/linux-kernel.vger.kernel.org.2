Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C903944C0A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhKJMEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhKJMEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:07 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DE1C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so2838768plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mSh//8dJzHrwdVHlYbD1/+GdUk+stDq7pKLS+ZY+HzA=;
        b=Q5R8jVIJSrhBiCEW/OAYKiluspRXGFwV7BHeX83VusZ6FLP+RonbPoCCEw2rHZsaEp
         biMG/NFYUTLBQ+XUZq/4GbNPjWI67b4p0tDzPfLJWXxANjBwecOBQPQwkLoAz2h/7Gle
         3KU4KxeBPgeWLjdJZFVi6CPwmyoFk1WU74SJZD5p6RO7GQiZ0rtSfxZfxYLVQjxgwpxr
         qmNbYinVKzDrHkL9aHRgP2tdQnWQM71Gk7DQ8QXfL1KRn8S0bouLvUDhu3timwRmXq3t
         tLjf8WqohE4LFG3+yIoD8y/xR6XNnUqlYtiotz9brRwEuNX6xkuAUq1vyGBeq/YR+sVT
         8FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mSh//8dJzHrwdVHlYbD1/+GdUk+stDq7pKLS+ZY+HzA=;
        b=xxjzhB4IDxn2BC/o1cV34qlGql4eU/f/KqsgTrJck9nmR0gH3axEkl3oDvwJ4hOkFm
         iAc/VrMPYl6PCyQ5FnMkPgaMCpDpeI41Gwn8P6PX1TBEsowIhmpCd9652VBUo4Ts/KQH
         HoQjA9xBWGMClJI3j8na28OrIu0bICPQFZRn9m0OhSA9kvgjqbuNikP8aEbV02EwxkC0
         8ReNIqEDioxiU4EDDPh25m+MtjVRos5p+wCyLPzRBzavkOZsnDQrg4Kh3AFbSj+8/B6i
         4LfcfNd/P0D/H80fRP8kwqfQFw+g5NbK2IBw3LlVblBCpjwvHfJy4XG4bUxpX/jcICJc
         t7TA==
X-Gm-Message-State: AOAM531mEXZMBfBlFQPcmcI3kQiHVs0876/IxlPCunTtbBLIYQcdikwR
        GfMmdL75GrOLlAG+csMlEq8LRycfMlQ=
X-Google-Smtp-Source: ABdhPJzJA2BeqPkR7GzL+ROya7DenU4+Lnz2+084fHvzVwFh9t4AeLYcKWS18+Q6aVisPoTD3sxG3A==
X-Received: by 2002:a17:90b:4a0e:: with SMTP id kk14mr16187496pjb.42.1636545679589;
        Wed, 10 Nov 2021 04:01:19 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id w3sm20092947pfd.195.2021.11.10.04.01.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:19 -0800 (PST)
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
Subject: [PATCH V5 37/50] x86/entry: Implement the C version ist_paranoid_exit()
Date:   Wed, 10 Nov 2021 19:57:23 +0800
Message-Id: <20211110115736.3776-38-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index e1af3e5720f9..0e8a3bef3b25 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -267,6 +267,29 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 	return 0;
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
@@ -303,3 +326,21 @@ void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
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

