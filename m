Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F244C07A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 13:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhKJMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 07:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhKJMCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:02:11 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093AAC061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:24 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id u17so2764733plg.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 03:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IRcX9/4DsEL06yZmPu44sV1ke3FMuW26ByS7nP9L7To=;
        b=WjqhhQmDisQV0EdyZQTuwhMLHOtk7DREicVvI9hrW8yWAQC1nm5Upy4mdHQ4PgC6HD
         ixxJwyUp1UwOnaCEXVEJzdfYdj4n0Rxh8z4m3je9i8h27w/EBYexGsqeb/zaIR63kAvO
         YbQTCFuMNzyXho3jUzv7yiFJtsYF/v77kKj6xyVFbbnQ5ue3qF1kfV1xei+GNPgJnoAe
         VmG0L0HST+8vSoJYfzhwf8E8G3YE+IhwmPfc8OYMFgFj9AllsLp32EEtW7lUal1uRU5d
         0E84jYWSTwyWv80vOXtFcMSBOMfeAKo4xvi4XVR2RjYxCqktOgI9ZIvReODdP8uFbywv
         /saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IRcX9/4DsEL06yZmPu44sV1ke3FMuW26ByS7nP9L7To=;
        b=Wx2tXdK4TEO6k1A6qaisE8KkoWbJl7NisZxyxVfow4ZLO3MKs35p23GDfboOVje29N
         eiykLIUK2evXSdabv9F5imGIMr2q0+9Z/Ezu+I5z1jDMeih2Zb4ysxxtMFybRM4uSqpR
         JiKJUwILyjKbWXbK0KHqJHBrdLjRxbfvk7VPIYtzK0YMLwFlfaqMgLMWb7R1MmEnbexc
         MRquAJg/YpE0q1gZ54bZCI6QbDdFBPlv1iFR/tbyEDXgfrMEdT4RAlohS/t03hOnW5N2
         pbZuUYERiot5gpHXtTLxETwusZq8K9djFJcXvA38dTK66uXX8Pv2yurJt6KO0yQlrrJI
         ucGg==
X-Gm-Message-State: AOAM5329bZHgjjAcJbodA+DWqcjImAB67ya4oHQu3O/AOZiSj0fPtIM7
        3GzvW+K8nA9tNLDb1Brl18dcG/8lRXw=
X-Google-Smtp-Source: ABdhPJyU/FGAmHghQ/uCb3rPreN8HGbHonHBWfD3cVFL6HWhqz7wxVdMP8VDf4cmDKlizyM/sO9gaA==
X-Received: by 2002:a17:90a:c394:: with SMTP id h20mr16256027pjt.136.1636545563462;
        Wed, 10 Nov 2021 03:59:23 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id 9sm2142818pgq.57.2021.11.10.03.59.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 03:59:23 -0800 (PST)
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
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [PATCH V5 18/50] x86/traps: Move pt_regs only in fixup_bad_iret()
Date:   Wed, 10 Nov 2021 19:57:04 +0800
Message-Id: <20211110115736.3776-19-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index e7e56665daa2..c6b617c19fe1 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1048,9 +1048,12 @@ SYM_CODE_START_LOCAL(error_entry)
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
index 1be5c1edad6b..4e9d306f313c 100644
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

