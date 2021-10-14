Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1E42D108
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 05:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhJNDhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 23:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhJNDhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 23:37:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA73C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:48 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id q10-20020a17090a1b0a00b001a076a59640so4753042pjq.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 20:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOlDNUyUmV+aU6NdyXgV94Mp8+Idq7csHzMAIqbkNNc=;
        b=DhlI3QGrHg+wiwXeYjlbADirWAwdoTikUl4vC5ccxAuI9wFR88f3PrKEKqG7KjJqKR
         Is/iUins/+hOGaIfMwgf3mAdq8EPkScztyLae7+oMryXLYh3TeRSX1/w6k08VNeNISu3
         2SV92tDcp6glEexBGuwVSUqgLG1jnGbrEHqjHPqTLmBMlpXoqcNKweDC4N2lndWDEmLJ
         F7GRCNv423Y0pWgZRp7WM9zgTL1NY+izq1LjI+CWCG/76X9AAbX9FK2F84ZXjRa1fXOk
         SJGlQjXPh65SDYCDSgphd7Wn63hAqntMDT++hxfOMnqjrD/luIEKxjcZRKRbrVj1WDun
         VAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOlDNUyUmV+aU6NdyXgV94Mp8+Idq7csHzMAIqbkNNc=;
        b=U4/UMl1PG67BAUlTOAo1nS7mD2MhCNTHZcbi4uIlIiavUZUpbaRgv9yicOEW3no3gp
         CzG71POqE8i8PhOr5RfgjyHZ3K3Mv1lLLq5CP3WaShKwta9SB6Uq06AsFA1KhiWNfy+9
         EztzKzBppkz62tMWEdniFeeAwBPY+r9/iX4lzYUTj92V/t30muA6ClI4OYVvPIk7T7WN
         56m+6V+YAKszjA3xyK9T52ok5IUamLoioHc2rVXKOmD4FPHbbh2UR8xLuAzqJN8MVKTw
         jlC+l5A3mii0ycVg4dFW2zLvoOtE7E5j4jIgOjMY/9SpPuqjajUaqnzo032gL19e4rn9
         10Ew==
X-Gm-Message-State: AOAM531W+zBwwuBhurDUEl5oKczXYjiRiYbGicmMPANAsCgH1gLFMVq/
        juyETJJnlG7iuXiUaascqQ9yp6A05Qo=
X-Google-Smtp-Source: ABdhPJwYy3SO71hSGT+fOYE3waL1DdiaaNTvbvc2ORgVIu55tsSCaNpp1jgUNMh93lZ9nr2Mak9SGQ==
X-Received: by 2002:a17:90b:1646:: with SMTP id il6mr3539221pjb.129.1634182547535;
        Wed, 13 Oct 2021 20:35:47 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d21sm849962pfl.135.2021.10.13.20.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:35:47 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V3 18/49] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Thu, 14 Oct 2021 11:33:41 +0800
Message-Id: <20211014033414.16321-13-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Make fixup_bad_iret() works like sync_regs() which doesn't
move the return address of error_entry().

It is prepared later patch which implements the body of error_entry()
in C code.  The fixup_bad_iret() can't handle return address when it
is called from C code.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S    |  5 ++++-
 arch/x86/include/asm/traps.h |  2 +-
 arch/x86/kernel/traps.c      | 17 ++++++-----------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index daaeeb8acd22..7f2338c3b676 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1047,9 +1047,12 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * Pretend that the exception came from user mode: set up pt_regs
 	 * as if we faulted immediately after IRET.
 	 */
-	mov	%rsp, %rdi
+	popq	%r12				/* save return addr in %12 */
+	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
 	mov	%rax, %rsp
+	ENCODE_FRAME_POINTER
+	pushq	%r12
 	jmp	.Lerror_entry_from_usermode_after_swapgs
 SYM_CODE_END(error_entry)
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 6221be7cafc3..1cdd7e8bcba7 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -13,7 +13,7 @@
 #ifdef CONFIG_X86_64
 asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs);
 asmlinkage __visible notrace
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s);
+struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs);
 void __init trap_init(void);
 asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *eregs);
 #endif
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index cf852b5e347f..0afa16ea3702 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -759,13 +759,8 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 }
 #endif
 
-struct bad_iret_stack {
-	void *error_entry_ret;
-	struct pt_regs regs;
-};
-
 asmlinkage __visible noinstr
-struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
+struct pt_regs *fixup_bad_iret(struct pt_regs *bad_regs)
 {
 	/*
 	 * This is called from entry_64.S early in handling a fault
@@ -775,19 +770,19 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	 * just below the IRET frame) and we want to pretend that the
 	 * exception came from the IRET target.
 	 */
-	struct bad_iret_stack tmp, *new_stack =
-		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+	struct pt_regs tmp, *new_stack =
+		(struct pt_regs *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__memcpy(&tmp.ip, (void *)bad_regs->sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	__memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__memcpy(&tmp, bad_regs, offsetof(struct pt_regs, ip));
 
 	/* Update the entry stack */
 	__memcpy(new_stack, &tmp, sizeof(tmp));
 
-	BUG_ON(!user_mode(&new_stack->regs));
+	BUG_ON(!user_mode(new_stack));
 	return new_stack;
 }
 #endif
-- 
2.19.1.6.gb485710b

