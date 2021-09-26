Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0264189DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhIZPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhIZPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:14:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59AEC061570
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w14so13440259pfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugS8bA/s0zCTl44p7NI3ZbhevUgEbM6ROhkGdPcKES0=;
        b=cfHWjK9kE+gel6PKyWFKasdD9BTxktcBxx6b1kftfJQ6aJ0SqaztsMKQ/J0WrJGjaA
         vip1/rh+HtV7quWlq1/ydcIdPIvF3ku5nSTgi3OIC0bZtejEQj8XQIj+oqQ1+ENM0jCt
         oitrHIVjM7+85rhQ8IukzfAmMrmC5GG9Eb18cMlYN0d5bbfFlnpYStuYXS2iQF1rVzwo
         e1lrcMoX6HPOmRzxwKlIHgNYdYojOSdySIG+G2E3Wp2iUvz28Hmz3x09Pf9D52fleCRD
         7h0Z5tg8zhZhNOsMmuEslzRNeiQzN40Kj3atiYshtJELwqrkRnYBZgW2d4ThfnnSFEHz
         9C1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugS8bA/s0zCTl44p7NI3ZbhevUgEbM6ROhkGdPcKES0=;
        b=eWIUcd5evo3meXazGp3y3CvQRrbFVDRkiRzid5GxA+XDFy3Vy657hxigomIFy34ntR
         jbROD8WoSSQYa0nMyrsxlU2qqft6qn7kbmFSd6YRkz9IuIXOgBtD+iXNguXiTqf/xMa/
         cigXiwFECsmX3sm4ZwgqPb6akQ5Xih0ARwGDQoUcoN/iF3jvlGa8D+t4MjQPba4slfok
         rTYENhdv9/qe7uMNkHJKI5WrYXZDQsETea0DWehJIsy5PrgmcHb641zYTfNT2QZ9uogd
         eFp5V989Mwhwz4WEuUgmq02Nyf3rz0LF/CjZC0uozG2xm8lV/czI7+NGRWnHDgHWqCmA
         MolQ==
X-Gm-Message-State: AOAM532zRR70EmJvi4fhXmq0dn+twGwsKXDItYl1mo76GQ6B4U2dLYoJ
        XqxbRV/fjIzuzzCONNGU+9xj7bwNCZUYQw==
X-Google-Smtp-Source: ABdhPJx94Nu/XyafAMAhLCBnpKL9SfPielopAA3s6XMnqS5dODj5JPjdnPMhjiOqH1+LEFtalK+aDA==
X-Received: by 2002:a62:1b07:0:b0:438:db92:6db0 with SMTP id b7-20020a621b07000000b00438db926db0mr19390243pfb.29.1632669160003;
        Sun, 26 Sep 2021 08:12:40 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id y22sm13656430pju.41.2021.09.26.08.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:12:39 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Youquan Song <youquan.song@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V2 35/41] x86/sev: Add and use ist_vc_switch_off_ist()
Date:   Sun, 26 Sep 2021 23:08:32 +0800
Message-Id: <20210926150838.197719-36-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index db108f8cd554..8871f8ccf117 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -486,26 +486,26 @@ SYM_CODE_START(\asmsym)
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
index 0afa16ea3702..03347db4c2c4 100644
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

