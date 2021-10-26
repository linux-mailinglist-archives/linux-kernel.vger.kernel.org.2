Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256CB43B415
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbhJZObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236598AbhJZOb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:31:27 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39111C061220
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:29:04 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id v1-20020a17090a088100b001a21156830bso2436229pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 07:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4VbMG521+R+KwfRRt8bui7JnW4XiRBCByXrdv/ZKoz8=;
        b=jGFfHYo6PD0erpFbqnYfzRqk8IXk89l3RJQ4gyn9w5tQqBSp6QxpWaABi0FnhUCUab
         sVxWXtg/UI+hnDxwCEpg5qqhs6vYJX5igsJ5EkCthjso3ZAbnlciog1i9gDffMmV7BX/
         NjERVIqiFVWL1nWSyI4bXeP9Xpta5OKXibPxJe+PtjpKejZhEqUo8iOB3KIZ4iqunWB8
         lnR3DK/Ss9Uw54jEgXv0IalRd5NS660QykHjYvwYfcUmckBfrC35ClcGGX8Ty2GUPBOZ
         BRUb1401JXnGG/yyMellcsRroScXPv4A+IAyXemhSiTSQUz/ROCENFm0gO1znYEVu+0+
         bc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VbMG521+R+KwfRRt8bui7JnW4XiRBCByXrdv/ZKoz8=;
        b=l4YhGN5NFcZJRuS2Y8Gby0iBUegkbs39WifbYmVZjLngVP2emqqNkPixqYze4Nl1oc
         2eQF11tficDBYKeSS7f/MMATl0aTR1bv2IjyYRUCpXUXKI19h/0lhUgwEYj0IDBJU0zB
         m6kUcZFdYeddYbJ0lT6RZclLbGr0+ytrCnyuzvL2+HShDRY5w7iPQVehNl+y7H1SY6jU
         fU7ULCYFvQ/ZjAbeH4olySPtvps7z+mMj7JJcwgkFVD49M74PHFSUBEwR7uA4GNjQTdW
         WA71sZo3pvagEbMqdbK0TP5SVm7pxv4jrvGedtKczbMZTUDAXcfr0HHr8kKI0AnW+Lub
         aDyg==
X-Gm-Message-State: AOAM531GNZ8AnEVDil2aB4vVyGhtJM1vKRiq4+EyxPbvn86t/eI6+tcf
        U+wMgWN10BdWRvuKr0bw9IomyJp2FlE=
X-Google-Smtp-Source: ABdhPJx3x3HheO3tEJ9AYCsoTqy7cZcoMdOvk04yYZUYo0anyGOxzR9jJzUE8nRo6K+o3I1ny+WrvA==
X-Received: by 2002:a17:90b:4b85:: with SMTP id lr5mr29137102pjb.66.1635258543605;
        Tue, 26 Oct 2021 07:29:03 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id nn14sm1113808pjb.27.2021.10.26.07.29.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:29:03 -0700 (PDT)
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
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V4 18/50] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Tue, 26 Oct 2021 22:27:50 +0800
Message-Id: <20211026142824.18362-8-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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
index 95ac6a9e5ebc..f82f2584389a 100644
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

