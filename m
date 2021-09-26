Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301044189BE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 17:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhIZPLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 11:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhIZPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 11:11:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3423C061604
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:02 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id rm6-20020a17090b3ec600b0019ece2bdd20so1713909pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Sep 2021 08:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POV4dFplbw6ELJOl+41DrdMsw0y9hP8afh20IruESsQ=;
        b=DZ33ufHHvkvwef2Wf9KZOHEBYBDzUmajwq2xjDGdXQnIy358TrtirHA0DqhpV+wonG
         BieR6M3POemWYPFyS8Wa+qO7uUF3cPXLrttjKYEfJ2JVUT1pax15GU8O/Gpl7TnGiJZX
         V2DX++yBaBTIxkDbWqbsQxweL2tXGwd0tFX13yvgHBPTS9m72sBJs6MOkMv1/iGhP3tK
         roKWAtM/LOQ7bk9o9KOc9y5Kum/9e/DYFrSCIUq6DKJQjwOFfJOI0xKw+yTY5ydXfkg6
         PaacLpabA843V+p5XJU8VanD6nPhQdcc8K16lFa4JrZcDKlIK07EOPSQ2ftNdlVSKZvY
         Y0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POV4dFplbw6ELJOl+41DrdMsw0y9hP8afh20IruESsQ=;
        b=zmQQnHLVFGHZBN/iFPbrEJKXSqdz6il4PBXLXagnws66dadzc8oxxP+PYxXC5gWNO0
         2z+F3+V9VsbLpxxdg4a/F7SziHEmxlfJJCO4+EuMiZ+/WfgxB14TdHcC7MYv9sLxBctM
         QOB6ouCo+EVYGlGSuA1hlIqvRfUKviW+UHtTH5zvzOw/z820nzpf3oFw8qg43u0lzn5T
         8UJCoDCwB/yS735EGwVtD4luocytRirr9SsreDrFz8CHJ/w8rahf6SZOoPks3/cPztE4
         SETikfyzhEAI+GqLX9aQ/pz8x095PXDe+86Dz/7RxsRf6qhbTiYtN+2EUZjFotmN8Q+T
         dfSQ==
X-Gm-Message-State: AOAM531wSXSXLLjiMZpJW3xyHMlce3CxzmR5jq7XmQEK5rjOzdm7972d
        rP2cGJfj5NZ1nA9Ae/IKjDR7nDKAJ5KoQw==
X-Google-Smtp-Source: ABdhPJyIIOD3gKj9VnwMpLHTRUSTMr3oM9DBxO1UjAi3K0BsMoX7bCCK2Vymkutpc4EnHW7h9ZYUqg==
X-Received: by 2002:a17:902:e54f:b0:13c:a004:bc86 with SMTP id n15-20020a170902e54f00b0013ca004bc86mr18119331plf.78.1632669002106;
        Sun, 26 Sep 2021 08:10:02 -0700 (PDT)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id i19sm14254954pfo.101.2021.09.26.08.10.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Sep 2021 08:10:01 -0700 (PDT)
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
Subject: [PATCH V2 12/41] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Sun, 26 Sep 2021 23:08:09 +0800
Message-Id: <20210926150838.197719-13-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210926150838.197719-1-jiangshanlai@gmail.com>
References: <20210926150838.197719-1-jiangshanlai@gmail.com>
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
index 291732f571a7..9921a823b2c6 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1037,9 +1037,12 @@ SYM_CODE_START_LOCAL(error_entry)
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

