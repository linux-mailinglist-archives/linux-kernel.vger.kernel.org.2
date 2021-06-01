Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2539782D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbhFAQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234533AbhFAQjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:39:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0EAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:37:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z4so7167016plg.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+TfC5LHXVVyW520zzrtzcUPch/a01ewIaFo4rhG3QnQ=;
        b=ArCgCtww/DCJrjqLlxGoZmyL5vVYRQq9HhGuYJCyRuzYQVqDMzDPUq6qJMGxj/MIPA
         ey9aTdUAZTGmcmC+dq0RANrc3FGifbYb4LHqPRU22ggDgMUEvZISIRmI7FCtQ8+nmmI1
         ESHeDhd5s0+JuuyOHudhVdwLU57Zk7kvOGexoQAC4xwBQM9tRSTUuZSlK6Qbh2T7xUJX
         uyNRVmx1dKEhhlEzq/z9SO9ncLYfE8jVtf+e7rzAEFQxBVDz81CHh+LPoxfChKtfMGPK
         hzgEZkNEsF5rKdcjC/vidv3A/aUCd5T14JKXhPW8aDIfjkVdyCJNOA38WMF95RLrE4GD
         WWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+TfC5LHXVVyW520zzrtzcUPch/a01ewIaFo4rhG3QnQ=;
        b=VeJ+pge9cCup2LEnmPw2pAvvPYzaJ+I4GoqJYT8VyWBw3rLB1hnOmzS372a30D2rrS
         cSSuainFqzsqlqXORoNqJzQrgurWHVwMbHeuJ+dxRUT+9tWsIAoKp6o7fW/p1+dBAX0a
         HZ9tkcQfmoyUnZW8AhnEeusNIqXW2Rdob2zUOdI/kLa22Z1BlLYFEobuUYFuTLmgdCZl
         4MkKZZ1ZCZvZbeTtNAoUAINZM80DVU5Lepe5ST18kZJwpWmiAirrIev4lH1OKYK0Htky
         mo/OAG2uP8fDjXcMj1mM3wDCJlY26rcL8NBgCkX4g5kCCfo6xTxJyE91NJ1+KIN8mVn1
         n3Ew==
X-Gm-Message-State: AOAM530hEuXcCwJw+fx6jD9xi1wWSXc6iv19Elg+BDgGMselpoUIJR+2
        LnRYj5Ky3N4QTkOt3v6mwt7VitQWkXE=
X-Google-Smtp-Source: ABdhPJz+/4Tgb7BCb8p4KUH/CyzGJ+bIU9L0fvJvnlI+thg/aX3TY3y08v1tYt7BDdoTLL603GpkAA==
X-Received: by 2002:a17:90a:e409:: with SMTP id hv9mr752457pjb.126.1622565452264;
        Tue, 01 Jun 2021 09:37:32 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id m13sm14381527pgq.1.2021.06.01.09.37.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:37:31 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH 2/4] x86/entry/nmi: Use normal idtentry macro for NMI from userspace
Date:   Tue,  1 Jun 2021 14:52:15 +0800
Message-Id: <20210601065217.23540-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210601065217.23540-1-jiangshanlai@gmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Before tglx made huge refactor on entry code, high level code is called
from ASM code including idtentry exit path which might reopen IRQ,
reschedule, do signal among other works and made normal entry path not
suitable for userspace NMI entry.  So when the commit 9b6e6a8334d56
("x86/nmi/64: Switch stacks on userspace NMI entry") added special code
for userspace NMI entry, it didn't use normal entry code.

After the said refactor on entry code, high level code was moved into
C code, and the idtentry macros are really low level and fit for
userspace NMI entry after it switches to entry stack, so this
patch uses idtentry_body macro for NMI from userspace.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 42 ++++++---------------------------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4190e668f346..f54e06139d4b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1113,11 +1113,7 @@ SYM_CODE_START(asm_exc_nmi)
 	jz	.Lnmi_from_kernel
 
 	/*
-	 * NMI from user mode.  We need to run on the thread stack, but we
-	 * can't go through the normal entry paths: NMIs are masked, and
-	 * we don't want to enable interrupts, because then we'll end
-	 * up in an awkward situation in which IRQs are on but NMIs
-	 * are off.
+	 * NMI from user mode.  We need to run on the thread stack.
 	 *
 	 * We also must not push anything to the stack before switching
 	 * stacks lest we corrupt the "NMI executing" variable.
@@ -1137,46 +1133,20 @@ SYM_CODE_START(asm_exc_nmi)
 		  +SIZEOF_entry_stack	/* to entry stack top */	\
 		), %rsp
 
-	/* Stash exception frame and %rdx to entry stack */
+	/* Stash exception frame and restore %rdx */
 	pushq	5*8(%rdx)	/* pt_regs->ss */
 	pushq	4*8(%rdx)	/* pt_regs->rsp */
 	pushq	3*8(%rdx)	/* pt_regs->flags */
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
-	pushq	0*8(%rdx)	/* %rdx */
-
-	swapgs
-	cld
-	FENCE_SWAPGS_USER_ENTRY
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
-	movq	%rsp, %rdx
-	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-	UNWIND_HINT_IRET_REGS base=%rdx offset=8
-	pushq	5*8(%rdx)	/* pt_regs->ss */
-	pushq	4*8(%rdx)	/* pt_regs->rsp */
-	pushq	3*8(%rdx)	/* pt_regs->flags */
-	pushq	2*8(%rdx)	/* pt_regs->cs */
-	pushq	1*8(%rdx)	/* pt_regs->rip */
-	UNWIND_HINT_IRET_REGS
-	pushq   $-1		/* pt_regs->orig_ax */
-	PUSH_AND_CLEAR_REGS rdx=(%rdx)
-	ENCODE_FRAME_POINTER
+	movq	0*8(%rdx), %rdx	/* %rdx */
 
 	/*
 	 * At this point we no longer need to worry about stack damage
-	 * due to nesting -- we're on the normal thread stack and we're
-	 * done with the NMI stack.
-	 */
-
-	movq	%rsp, %rdi
-	movq	$-1, %rsi
-	call	exc_nmi
-
-	/*
-	 * Return back to user mode.  We must *not* do the normal exit
-	 * work, because we don't want to enable interrupts.
+	 * due to nesting -- we're done with the NMI stack.
 	 */
-	jmp	swapgs_restore_regs_and_return_to_usermode
+	pushq	$-1		/* pt_regs->orig_ax */
+	idtentry_body exc_nmi has_error_code=0
 
 .Lnmi_from_kernel:
 	/*
-- 
2.19.1.6.gb485710b

