Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45F63166F6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhBJMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhBJMjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:39:42 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F55C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:02 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id x136so1191714pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 04:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JYaGyPsE3Q7eejkXPPgWBuxHXVlDYj0MP41m5sZqcsE=;
        b=vLOU1+hkux1SmrHlHrvbbx5xdsSWegYQmmxy71Gq06z7q1ngzjYGq2fkwDY71JnpN6
         btQ2xygWnTm6TegYLryFCVkiYOuoHhAQEEYrcTqDWJNbH0LagjQ5pIM3TYSpp5wVjQzM
         grgsvGx7d5arEnI+QaW2hOSIg0oQkeDl72gLv0kDr4DT9e70/LMU3i7AAaun+ubdK78R
         Jz1N9s00scwvDL+QvuAH6Jkp5B4rdHF+IlyTNvPdt/7A+j0nJYHlnI4WcFEyT3RRlDZf
         rOysXeiI05d1pjXC3zEBFna/fFQj+W8JXzoTHiBrOjTcVAtCzx3JVzBLjuxGoXbDrS9j
         7wQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYaGyPsE3Q7eejkXPPgWBuxHXVlDYj0MP41m5sZqcsE=;
        b=eniNJdP+ORWM0SijYoRY39KZi/Ed/guJV+NEEazMZz6Gn9FIDku7ptUhYHQkyw6pfJ
         12BCvceIIUSd9sb5mRdTPeQ1sYVq3kY2M1HKRZFT/3YQrzrY2EAEIuWF/hhWfszORyFS
         bLFvGadXHurJoeY2A6dgxWWliGQkHMs1OdxWUaS4P6ZCT52utTMI7eykLwq8CXxnQQJK
         S8xnwgWlBu8BBl7tVNEi98KJWdDOddK+uD06XmmVvJStOSoyaWMmTyBQNxgBQoptl6u7
         BOa7iBUiYEI6KuGSTYWP00/uAL1kuvHeLyDJHG4V8fjMhO0sQLkGVK61tGUl1jwLAmz2
         YkTQ==
X-Gm-Message-State: AOAM532UfuJuYWukk5+lgKHpW+ea7vjFDPugrZnaOXbVTQnAGqFNslAu
        ERxw5vKyXvIjelbbvX+HssjcCMpGjlI=
X-Google-Smtp-Source: ABdhPJxb8DLxHPUFpGimy1e3z9VJLDWAcb5lk6bnupoQCx/U5j1OMj+fNmb/oKjSu9j1E3y+B1zUUw==
X-Received: by 2002:a63:5904:: with SMTP id n4mr783847pgb.446.1612960741934;
        Wed, 10 Feb 2021 04:39:01 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id c188sm2341565pfa.98.2021.02.10.04.39.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:39:01 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Balbir Singh <sblbir@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Kees Cook <keescook@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>, Mike Hommey <mh@glandium.org>,
        Mark Gross <mgross@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Jay Lang <jaytlang@mit.edu>,
        "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: [PATCH V4 3/6] x86/entry/32: Switch to the task stack without emptying the entry stack
Date:   Wed, 10 Feb 2021 21:39:14 +0800
Message-Id: <20210210133917.2414-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210210133917.2414-1-jiangshanlai@gmail.com>
References: <20210210133917.2414-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Like the way x86_64 uses the entry stack when switching to the task stack,
entry_SYSENTER_32 can also save the entry stack pointer to a register and
then switch to the task stack.  So that it doesn't need to empty the entry
stack by poping contents to registers and it has more space on the entry
stack to save stuffs or scratch registers.

It is a preparation for next patches which need to save user %fs in the
entry stack before restoring kernel %fs and loading the task stack for
stack switching.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_32.S | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 3b4d1a63d1f0..3e693db0963d 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -905,19 +905,18 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	pushl	%eax
 	BUG_IF_WRONG_CR3 no_user_check=1
 	SWITCH_TO_KERNEL_CR3 scratch_reg=%eax
-	popl	%eax
-	popfl
 
-	/* Stack empty again, switch to task stack */
-	movl	TSS_entry2task_stack(%esp), %esp
+	/* Switch to task stack */
+	movl	%esp, %eax
+	movl	(2*4+TSS_entry2task_stack)(%esp), %esp
 
 .Lsysenter_past_esp:
 	pushl	$__USER_DS		/* pt_regs->ss */
 	pushl	$0			/* pt_regs->sp (placeholder) */
-	pushfl				/* pt_regs->flags (except IF = 0) */
+	pushl	%ss:4(%eax)		/* pt_regs->flags (except IF = 0) */
 	pushl	$__USER_CS		/* pt_regs->cs */
 	pushl	$0			/* pt_regs->ip = 0 (placeholder) */
-	pushl	%eax			/* pt_regs->orig_ax */
+	pushl	%ss:(%eax)		/* pt_regs->orig_ax */
 	SAVE_ALL pt_regs_ax=$-ENOSYS	/* save rest, stack already switched */
 
 	/*
-- 
2.19.1.6.gb485710b

