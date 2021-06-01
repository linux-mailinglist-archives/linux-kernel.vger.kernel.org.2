Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C56539782C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbhFAQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbhFAQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:39:08 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502AFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 09:37:26 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id d5-20020a17090ab305b02901675357c371so1433804pjr.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQJslojffKkax4uFDdyVkRNQtHdNt+JYFVrHprzH6Cc=;
        b=j2cqmCJR+/C0NhhMg+TAvu7rAP2yCWQhhkBnqjYAZstXMAPwKONlqzMBbHEcVfgtfD
         yNhhBA2orHb5fJXCmC8caDHFSDdH7pYdaM7fEKjALlz2FVU6lEkBrXVQYh8cAoFZLRU6
         NTmScvsvzxdvok0kuIQ3VTdrg2FLE+Yh+QrUrJYljA0nnWeg8J6eve8zKoukyPvszjTe
         sBUxE2tOFRnIAitL/unj+gcWQiB7Vf4Lik1tDr9GMY6y+Wp/7J7Ta/NYrgOHAObjZjk+
         bAqLB1vBw8+W28fgma0ATs1YAq8qtMKDhBadTLaBwLBW8CoFOEDNvHj4RmIrJKdvd3RJ
         MWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQJslojffKkax4uFDdyVkRNQtHdNt+JYFVrHprzH6Cc=;
        b=ZEHFTAZYi+foD6SillfoChgDthR/IT7nqttXtnwktbDaf9z3/4KG4s9HmaLP/SMa3e
         byWgjBYewz1uB078/2TN9Grk2+uUH1oMBQfp3bjSAYXPq0ez8QH+SiDpODj3WakVWTsG
         6Sni8EDgpwuodk3fK4m1qcfnColdeK59Gf6fPL9f38iJQqE2+O+fqSpXCbU4cQLDlyUe
         3I+DmfsoxCPB2QZLOq/bdx8ZxiAdtU71j+gTBbSyr0kBfSSZv4lMBDXz3oAzJ62ELedd
         7lndK1euoMdm1KdnxIwRh1v9e7jOXErX2WxmLFcSo7Xv2V7lf7KRFA6ahc+HZZoffEFR
         Ibgw==
X-Gm-Message-State: AOAM531PQx8tJUcfDc6tyhjI85312yTcRbzrAYmRypFY3cR8aV7YuFR8
        bOOxuTGOKTb7h1B9O8BByL2PIne4o+I=
X-Google-Smtp-Source: ABdhPJxZ8zS+0fRTwc6n92iz0kLJ/2W4/W6SnTJW6rTO9dy5V9iOEFw4V6XUsYznxIoGNJaEtvLlCA==
X-Received: by 2002:a17:902:7c94:b029:fc:5e8b:e645 with SMTP id y20-20020a1709027c94b02900fc5e8be645mr26591700pll.18.1622565445714;
        Tue, 01 Jun 2021 09:37:25 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id 21sm13513589pfh.103.2021.06.01.09.37.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:37:25 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: [RFC PATCH 1/4] x86/entry/nmi: Switch to the entry stack before switching to the thread stack
Date:   Tue,  1 Jun 2021 14:52:14 +0800
Message-Id: <20210601065217.23540-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210601065217.23540-1-jiangshanlai@gmail.com>
References: <20210601065217.23540-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Current kernel has no code to enforce data breakpoint not on the thread
stack.  If there is any data breakpoint on the top area of the thread
stack, there might be problem.

For example, when NMI hits on userspace in this setting, the code copies
the exception frame from the NMI stack to the thread stack and it will
cause #DB and after #DB is handled, the not yet copied portion on the
NMI stack is in danger of corruption because the NMI is unmasked.

Stashing the exception frame on the entry stack before touching the
entry stack can fix the problem.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S     | 22 ++++++++++++++++++++++
 arch/x86/kernel/asm-offsets.c |  1 +
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index a5f02d03c585..4190e668f346 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1121,8 +1121,30 @@ SYM_CODE_START(asm_exc_nmi)
 	 *
 	 * We also must not push anything to the stack before switching
 	 * stacks lest we corrupt the "NMI executing" variable.
+	 *
+	 * Before switching to the thread stack, it switches to the entry
+	 * stack first lest there is any data breakpoint in the thread
+	 * stack and the iret of #DB will cause NMI unmasked before
+	 * finishing switching.
 	 */
 
+	/* Switch stack to entry stack */
+	movq	%rsp, %rdx
+	addq	$(+6*8			/* to NMI stack top */		\
+		  -EXCEPTION_STKSZ	/* to NMI stack bottom */	\
+		  -CPU_ENTRY_AREA_nmi_stack /* to entry area */		\
+		  +CPU_ENTRY_AREA_entry_stack /* to entry stack bottom */\
+		  +SIZEOF_entry_stack	/* to entry stack top */	\
+		), %rsp
+
+	/* Stash exception frame and %rdx to entry stack */
+	pushq	5*8(%rdx)	/* pt_regs->ss */
+	pushq	4*8(%rdx)	/* pt_regs->rsp */
+	pushq	3*8(%rdx)	/* pt_regs->flags */
+	pushq	2*8(%rdx)	/* pt_regs->cs */
+	pushq	1*8(%rdx)	/* pt_regs->rip */
+	pushq	0*8(%rdx)	/* %rdx */
+
 	swapgs
 	cld
 	FENCE_SWAPGS_USER_ENTRY
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index ecd3fd6993d1..dfafa0c7e887 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -88,6 +88,7 @@ static void __used common(void)
 	OFFSET(CPU_ENTRY_AREA_entry_stack, cpu_entry_area, entry_stack_page);
 	DEFINE(SIZEOF_entry_stack, sizeof(struct entry_stack));
 	DEFINE(MASK_entry_stack, (~(sizeof(struct entry_stack) - 1)));
+	OFFSET(CPU_ENTRY_AREA_nmi_stack, cpu_entry_area, estacks.NMI_stack);
 
 	/* Offset for fields in tss_struct */
 	OFFSET(TSS_sp0, tss_struct, x86_tss.sp0);
-- 
2.19.1.6.gb485710b

