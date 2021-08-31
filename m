Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BBA3FCC95
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbhHaRw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbhHaRw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:52:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35A1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so72157pjz.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yaLxIE498RquAUZ6O49NEILeVVIBrtpt4yPttHVKWdU=;
        b=vhh3AdNpRxwruUztS2jGInowa3cXHZNgyQCFYwMNpEZcBYeWBV4SkwxDvTWJFmW/mg
         qSzvr1bgqV8Kru1EyDpcbAJowQ18cGeR25qiF3P24cJG+i3H7omy0tHLPT+w1369nhvZ
         lhsihTZjcZHWO63kpXvi1CGfFkt5nT/UW+4yeM0ImCkBrO3dF/D1gkeXNzGTgBQDVfSO
         TR73C38uy78uRgdhy/Gm3bCFv7YQhmQCzskkDsD7c32nua8q7t+lOqcJJxLm7s5meGVO
         tUIiuc3EVI0GQtg0sT5nDZQEf5rvQ4McFVvyR6j/r0VNc7qUSKYaeqek5rmrsAEdniNU
         ostQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yaLxIE498RquAUZ6O49NEILeVVIBrtpt4yPttHVKWdU=;
        b=HFiSgIa0ojTfscQnykzGvQCa8mRxWA2/+ROkwm1gE8B1I+IpO1+V36ffYp/qmsHXgy
         pnMzXZ4so0aH2rxffPRj8QzLMgMiFSNDASt59h1ZKsrmwtUTmDqCuPdzCfukwNKdnGTH
         Hp1CbWXu2jDHtgVwHkNvFvmyMikXRoPCvk8AZ96sXWnIMmEp24/jGNaS8ehJAK1/ZbfD
         lnqRqJfUqoZKG+Pe3W3uDhF9+mERphHQoMQi57BTYw9JlcY9MRHGjp2QTvBWIulaoYnm
         D5T6iy+EJ8XKaDhQS9F+dJ6VWkRB8xbXI/347bom6OoW5kqzeBAlDGJ4GwFqVtSq6Xz+
         G5MA==
X-Gm-Message-State: AOAM532jx7fhYnekMS+tFsbf3E5RCsvt9c9t+YoaxKYs/qUElPpfmmNV
        8GTJ293W16/zqejsDXTFIY/dRAaAJPo=
X-Google-Smtp-Source: ABdhPJxRJu263k5RMnJqg9kLHD49L/MJC0tlXTryC+Z/e/cUWLNiQpzxr2/CowkpSMbg82m86VUeoA==
X-Received: by 2002:a17:90a:2c0c:: with SMTP id m12mr6740155pjd.107.1630432290953;
        Tue, 31 Aug 2021 10:51:30 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id u24sm19846189pfm.27.2021.08.31.10.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Aug 2021 10:51:30 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Joerg Roedel <jroedel@suse.de>,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 10/24] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Wed,  1 Sep 2021 01:50:11 +0800
Message-Id: <20210831175025.27570-11-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210831175025.27570-1-jiangshanlai@gmail.com>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
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
 arch/x86/entry/traps.c       | 17 ++++++-----------
 arch/x86/include/asm/traps.h |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9164e85b36b8..42d2918f5646 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1042,9 +1042,12 @@ SYM_CODE_START_LOCAL(error_entry)
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
 
diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
index efec3b4eaa5f..c718663e57ef 100644
--- a/arch/x86/entry/traps.c
+++ b/arch/x86/entry/traps.c
@@ -734,13 +734,8 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
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
@@ -750,19 +745,19 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
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
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 7f7200021bd1..e9e3801391d5 100644
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
-- 
2.19.1.6.gb485710b

