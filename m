Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3A4189CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhIZPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhIZPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:12:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F855C06176A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:18 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id x191so8347289pgd.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w003xji+DRLW9jRMVAMC4PkT2jGNXJE/ZrMiHGZPjHo=;
        b=BCPAXX+0Vfq5E+cn8nYUdS7TlVIPPTe1wQdm6NqeH2Do0MBWgMrIrzGlviMZzUpz1+
         ZwAhuH3AcUc1R0yDvViwhMCm9QmvNj5RejC8vzGOCy1YtZ/qVGyAb7g4xhBuY8r8Rl59
         Ng5adKKAUVBonhbHPdyCHTL7DfKTcJku37fhmstdKs1BuWmItTDoGmeIbGBBiOtHSciX
         cmzGdXcE3HOttqPSSkcQ2rlV61TOFLeDK3OBlUb6tXmuC7Pq3eCVLWc5twLrtNyk0sDi
         bbBFnZro3PO6Y9+CWkuQJI622fXUQKlHWgUDjQMlwwpCHIQdVJtyTcu3ewXRiELueggu
         NwEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w003xji+DRLW9jRMVAMC4PkT2jGNXJE/ZrMiHGZPjHo=;
        b=iaLmwyw2JLZv7pScftko6rw3rZzjiCIEN4MFDR+xTzixE7dfN0yjld+5YbUwJNRKQx
         1qaz4eA6jxZ92gOKIdj6iCtuL8hhShwgIhQuQCPfW2HdFQlUgUNOS8+w56fRuQjBSZvh
         FnRlg2Q3rynK0rvoOUQ9/leeqvCpqplnaqdZ5zIkMKwJ3+amPIt+lhDmQTXk05JHryHx
         9ejgxsfRmqjGIlKv03H0Mh+TnIachBx4otKIJEM6oXOgoFVnmltQ/ljgyibSRIkS5FFf
         ofwFTSudFy5VyZSIqpEbj2tiJSdfpbn+Ts7mQWkCE9cW8N98iGxUY/OqSMwX1R0QtEQ9
         olYA==
X-Gm-Message-State: AOAM5338zq0RUaBoGO8VUnV5qpyZVZV6VfzI4vIpwpDX2Dmw3F7YQ47r
        EvjD/VCH2S9jB550VNHZDHDWzK560rN/9A==
X-Google-Smtp-Source: ABdhPJwkzT8voR0q7EMxs592whJ+S8qMLUlLRfjPjVZsEQHIAz+GsUpSCOPIQjvaiZNkd36/HrnROA==
X-Received: by 2002:a63:da49:: with SMTP id l9mr12532265pgj.277.1632669077987;
        Sun, 26 Sep 2021 08:11:17 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id g12sm17282828pja.28.2021.09.26.08.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:11:17 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Travis <mike.travis@hpe.com>
Subject: [PATCH V2 24/41] x86/entry: Implement the C version ist_paranoid_entry()
Date:   Sun, 26 Sep 2021 23:08:21 +0800
Message-Id: <20210926150838.197719-25-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/entry64.c        | 39 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/idtentry.h |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index 1a0d5d703ad6..67f13aebd948 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -273,3 +273,42 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
 	/* SWAPGS required on exit */
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
+	asm volatile ("cld");
+
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
index 6779def97591..fa8d73cfd8d6 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -293,6 +293,9 @@ static __always_inline void __##func(struct pt_regs *regs)
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

