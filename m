Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4012843B457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhJZOio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhJZOib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:38:31 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B060DC061767
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 187so14489960pfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anKSpqSrV77lA2Jw/TrzCwt7GostmDO7PEGwJX+kIAc=;
        b=AK9bdSwe9kMV8lAg11CIX7qfNdVQaXTG+tlqCD5ANb11ZK+Ys3NAd9yMaNh2Tklzmf
         aYeJMfLWTiMYdcSsxstzm8NPTtvOQat6fyVevZNDTnVIOE+CyYS4fYf+DBuTcTTtMl1p
         FXXoBZX9jL9QHPzrK/FXOybs/Rn2ZbW+3W5KeBW1vpqMqPTLzP4GF1pVQbSY3OMNfYAB
         90LnStIyGSsQY7GDR4kh08hJjJYQc8eB5Qj0cHtuDLRA0dskc3AeT3K8d9zuFHLfwKLV
         ZlnLQxx9/mzTXjQ/4lWvKtjBL5N8RQdFR8P8B/NBIpxQCdZ7u++JGHJyzgWyoOJUhYcm
         0a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anKSpqSrV77lA2Jw/TrzCwt7GostmDO7PEGwJX+kIAc=;
        b=TcIPZrV0BerzmFL+lINu9ubVu89RRdtQJlWY60oyQWmTcnnj508wQNfm+alOw8HKHi
         lXWAwIzlVgSAXISvOv+mGBpilWSYwVXVbtXSsIx+NfmPuTLx0a+Jb6Qgt0GcUVo52u+f
         bfVGRB627ddLz/qYOYnZxeQOKbXBEdIVpKjwVX+w1Chzziibla7BbA1A5tdnc/51RAm2
         srDOJ1m9aiTKU1ra+mCK/4xoAPGUS2qUbMCyU1nAo08VMb2tZpSSgWty05I4mErOUbpL
         8mjUzucDzNfT/zxPyjw4/DXtrkbhwD/0Ikt2nIl6QFZ7R+qTJHxp4i5C9GK5U8e4nHzQ
         KkAA==
X-Gm-Message-State: AOAM533JLs8YtNOG77xaOGpwv+ltzs3f1j3U0HcaNNuFZnF+1+9xYjPS
        dF01w8P+4A+Z/zQY8bNv5cgm22dvx9s=
X-Google-Smtp-Source: ABdhPJz7XQQhTRVUEWdPSowPAKM8OQClUTAMwniEppCNKqMasb+PAxQJDqqTptfz2UbWecAyEzUbPQ==
X-Received: by 2002:a63:7506:: with SMTP id q6mr19019167pgc.319.1635258967103;
        Tue, 26 Oct 2021 07:36:07 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id y4sm3133716pfi.178.2021.10.26.07.36.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:06 -0700 (PDT)
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
Subject: [PATCH V4 37/50] x86/entry: Implement the C version ist_paranoid_exit()
Date:   Tue, 26 Oct 2021 22:34:23 +0800
Message-Id: <20211026143436.19071-12-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 14005122f94b..161c025d5e7a 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -275,6 +275,29 @@ static __always_inline unsigned long ist_switch_to_kernel_gsbase(void)
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
+	if (gsbase)
+		native_swapgs();
+}
+
 /*
  * Switch and save CR3 in *@cr3 if PTI enabled. Return GSBASE related
  * information in *@gsbase depending on the availability of the FSGSBASE
@@ -311,3 +334,21 @@ void ist_paranoid_entry(unsigned long *cr3, unsigned long *gsbase)
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

