Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9FA44C0A0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhKJMEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhKJMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:04:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EDC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:12 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b13so2850700plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 04:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A982NPXSnTHpaqDF66iHMWDvT97siE6iPVMBlzTV53s=;
        b=CXgC2WyXPdsb5ULm9ExA78aOuqOhPBSe/8FrBps62jHiLG2BRVnC3fz9nFrt+zxRVL
         UpCKLK1qigGwa70+EEDY9Aa0SzFHHmbD6Vj7xkvRL/eKsgTujgtCrAQv6mhZR6V8MDEA
         ANNMSjg0D9EOy0Y2gZbq89s8zEQxJvQqdOVFN/qI+mJ9YZcKy/4vhhz5ZGpybuVRnVfO
         mTMC4b1vgjku6Y4SWuNJwHSTu6QFpZW/QbH1pD7B01fkZiEKKdFmh/ZcGwuLieSH5OVf
         UMxwtPR2jbZxW4ws02pXNUDIy1YcR49npmOSFbHhV6lH1sWrcSF+Su/yu1XR1U+S0h9e
         nj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A982NPXSnTHpaqDF66iHMWDvT97siE6iPVMBlzTV53s=;
        b=o42d7NxT75TFHbYV7MjFooJXxhOo3ZOLBvO47DcXVgdOOii6iuxVr8m6ipTKgSKfTO
         Za6f5ZNSVlrIVUxk3gHal0ScaFRb1iE3x8f5saVW76iFVAwOAOJo8rUpZhMjVnRc0Uzy
         HJrKNWK/j4c5szTNcPDBmwjTq+L1h/Hjzknt1vBM3G9VGb2sgpB2tJGJhVnQUQn6EA80
         MPaDRQE1nQAIH9YhTUNkOR+gKXL3SiEXX7M90/QOKxxRNHf6bmD6h25ETQVZzFLw2nNX
         ewIuWtQMWWgZzwaX2uiyHVbaF5JfYTT0EmgugAK4z7KwP6XIceqhIFZDP2Tn4S0ywgbs
         XnfA==
X-Gm-Message-State: AOAM531kN48NUPgs9b8syQ6oJHKTQ9flcjeuPSeewwV86I9kyKbTD32r
        6/3ZbKQjA9UHNKoWB+SZmTCRPkuAnsA=
X-Google-Smtp-Source: ABdhPJyopgQdyurU9xeGuT41oLqDNFcdfQqbfFZfCkErTWO53KIWrcsnSgLshJIKezw6nSQ6qp0Ksg==
X-Received: by 2002:a17:902:7797:b0:143:88c3:7ff1 with SMTP id o23-20020a170902779700b0014388c37ff1mr1351407pll.22.1636545672344;
        Wed, 10 Nov 2021 04:01:12 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id u10sm21903833pfh.49.2021.11.10.04.01.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:11 -0800 (PST)
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
Subject: [PATCH V5 36/50] x86/entry: Implement the C version ist_paranoid_entry()
Date:   Wed, 10 Nov 2021 19:57:22 +0800
Message-Id: <20211110115736.3776-37-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index 6eb8ccfc5a8b..e1af3e5720f9 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -266,3 +266,40 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 	native_swapgs();
 	return 0;
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

