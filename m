Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F2945EB8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377227AbhKZKbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377243AbhKZK3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:29:19 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B2DC0619E2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9625938pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 02:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGO5cbDUbonmJ12uzxTo/j6G80fhDSrdPc14PgDzgF8=;
        b=QAVbgil9unKiohR9iuh76OuAlxDhiljcMOBTa7S5fqdvEB3r/guXT83SuI38Cje9S4
         2pYnXoiK/KAEjZLTdz7ItcFkXYkpyx9rAmQBNBn7+tK9AyFlFYJ3/avef8cFgU9jhMwr
         ncgant7lwBqso69PGAyqFuSguHQ9ijStjfkmNRtoGTXjAAnzmczftFQOK+SAeuGbFfSa
         fV92Zy15Yc7KoeCOO46usz8zBsWz9qxifGFJiIs9ZQT/LwjLscbyRpQ/Vh/w0Nrrq6IY
         Q0ER47Nreu9CLWnshlRg0/3tGuEADuTTIa+heG+e6xsw6WDJsgRETDq4IWfJV1TkCSrb
         ZH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGO5cbDUbonmJ12uzxTo/j6G80fhDSrdPc14PgDzgF8=;
        b=HYo0CWlnMkPy0ZYXMHeEOeRgc3FgbQw0xO6biKhxcXXZLToGyT+LJjVmKovzHy4MRt
         B0qqerj100pZwwUqSr11DjEG9SnbdiK8eGK2sCdomchp+cEZs5iL56CqKPb7VeA73lx0
         nCEWQ/wcqezMtHPtuMjLxrKHOpk/70LLAWZ4UrPnp0kt2qVRtwStJSzD6BXxFDHupumS
         M6s5bFQYMaUh+wflThzLna/zWK2F7khv6AwIvfNXZPsMxy/5xXQXXh1fcruiTfmOsPwo
         YfH7hauBrJaHPCObX4OKODCvj6NJPic+rLPOnsQtXdzhrmJy4UEy/JS4C7m0GQNg7NoZ
         ON5g==
X-Gm-Message-State: AOAM531Zrqt8/9M4ao8Z/m+ibziBDMAxEYe+DG8JqHHvuNjIP81V7pSw
        WRxwBg0H6Cy3mDg13P5SaXBNaB89lYQ=
X-Google-Smtp-Source: ABdhPJxEPB2YO4FFe3v8AjHhBdK1v1oFV85y40E4V0zNK2EnayJ6k9jsuYdSqgAH8OuJY6jtSPThqA==
X-Received: by 2002:a17:90b:3890:: with SMTP id mu16mr14709007pjb.73.1637921799741;
        Fri, 26 Nov 2021 02:16:39 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id i5sm4719597pgo.36.2021.11.26.02.16.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:16:39 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V6 44/49] x86/sev: Add and use ist_vc_switch_off_ist()
Date:   Fri, 26 Nov 2021 18:12:04 +0800
Message-Id: <20211126101209.8613-45-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

ist_vc_switch_off_ist() is the same as vc_switch_off_ist(), but it is
called without CR3 or gsbase fixed.  It has to call ist_paranoid_entry()
by its own.

It is prepared for using C code for the other part of identry_vc and
remove ASM paranoid_entry() and paranoid_exit().

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S    | 20 ++++++++++----------
 arch/x86/include/asm/traps.h |  3 ++-
 arch/x86/kernel/traps.c      | 14 +++++++++++++-
 3 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 5a9738218722..b18df736b981 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -515,26 +515,26 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
-	/*
-	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
-	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
-	 */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
 	/*
 	 * Switch off the IST stack to make it free for nested exceptions. The
-	 * vc_switch_off_ist() function will switch back to the interrupted
+	 * ist_vc_switch_off_ist() function will switch back to the interrupted
 	 * stack if it is safe to do so. If not it switches to the VC fall-back
 	 * stack.
 	 */
 	movq	%rsp, %rdi		/* pt_regs pointer */
-	call	vc_switch_off_ist
+	call	ist_vc_switch_off_ist
 	movq	%rax, %rsp		/* Switch to new stack */
 
 	UNWIND_HINT_REGS
 
+	/*
+	 * paranoid_entry returns SWAPGS flag for paranoid_exit in EBX.
+	 * EBX == 0 -> SWAPGS, EBX == 1 -> no SWAPGS
+	 */
+	call	paranoid_entry
+
+	UNWIND_HINT_REGS
+
 	/* Update pt_regs */
 	movq	ORIG_RAX(%rsp), %rsi	/* get error code into 2nd argument*/
 	movq	$-1, ORIG_RAX(%rsp)	/* no syscall to restart */
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 686461ac9803..1aefc081d763 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -16,7 +16,8 @@ asmlinkage __visible notrace
 struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
 asmlinkage __visible notrace struct pt_regs *error_entry(struct pt_regs *eregs);
 void __init trap_init(void);
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
+asmlinkage __visible __entry_text
+struct pt_regs *ist_vc_switch_off_ist(struct pt_regs *eregs);
 #endif
 
 #ifdef CONFIG_X86_F00F_BUG
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 4e9d306f313c..1a84587cb4c7 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -717,7 +717,7 @@ asmlinkage __visible noinstr struct pt_regs *sync_regs(struct pt_regs *eregs)
 }
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
+static noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *regs)
 {
 	unsigned long sp, *stack;
 	struct stack_info info;
@@ -757,6 +757,18 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 
 	return regs_ret;
 }
+
+asmlinkage __visible __entry_text
+struct pt_regs *ist_vc_switch_off_ist(struct pt_regs *regs)
+{
+	unsigned long cr3, gsbase;
+
+	ist_paranoid_entry(&cr3, &gsbase);
+	regs = vc_switch_off_ist(regs);
+	ist_paranoid_exit(cr3, gsbase);
+
+	return regs;
+}
 #endif
 
 asmlinkage __visible noinstr
-- 
2.19.1.6.gb485710b

