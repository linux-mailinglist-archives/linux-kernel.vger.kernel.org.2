Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D69632DA0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 20:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbhCDTHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 14:07:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236420AbhCDTGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 14:06:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9F6B64F72;
        Thu,  4 Mar 2021 19:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614884770;
        bh=vqA9dPEA/Pj4CLPwidd/pKhz1PePmiTsy7RdjkNEADU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIxMAUc3O0JyXVktHVhxRWwJbj3YU2UmNLhJE/rV0Hn03oMbbLx984rpZSihHyC+b
         pKtd+/g4J8+ts3O9xO0DPuYx6N0xSQ7SktBvqdf6DjwlQ1E4EvnmliajIVtjMdNlWg
         g3YFEoEOWN6QGVYBzuxsiCn6YBZkgq6mZrhxtS7nA98+8dqK7m9dhaxL1issGR6CI3
         0oJ+PAdOkfHu+9eJmeOPw7xPzrkEPGLc73gkijKLTHHst8BbVvcpnxb5Xf5RMILzqt
         Nb7PpNr5Xi+ALMeDFaPCdpht/sXh6TxZQmcitgQkRQSrevbeDPDuz4UVU+flw6DWhz
         qjOp2xRtbz7qg==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v3 04/11] x86/kthread,dumpstack: Set task_pt_regs->cs.RPL=3 for kernel threads
Date:   Thu,  4 Mar 2021 11:05:57 -0800
Message-Id: <c70a1a4632b976171ca5f3381ef84d40fd028861.1614884673.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1614884673.git.luto@kernel.org>
References: <cover.1614884673.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernel threads, task_pt_regs is currently all zeros, a valid user state
(if kernel_execve() has been called), or some combination thereof during
execution of kernel_execve().  If a stack trace is printed, the unwinder
might get confused and treat task_pt_regs as a kernel state.  Indeed,
forcing a stack dump results in an attempt to display _kernel_ code bytes
from a bogus address at the very top of kernel memory.

Fix the confusion by setting cs=3 so that user_mode(task_pt_regs(...)) ==
true for kernel threads.

Also improve the error when failing to fetch code bytes to show which type
of fetch failed.  This makes it much easier to understand what's happening.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/dumpstack.c |  4 ++--
 arch/x86/kernel/process.c   | 13 +++++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 55cf3c8325c6..9b7b69bb12e5 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -128,8 +128,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 		/* No access to the user space stack of other tasks. Ignore. */
 		break;
 	default:
-		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
-		       loglvl, prologue);
+		printk("%sCode: Unable to access %s opcode bytes at RIP 0x%lx.\n",
+		       loglvl, user_mode(regs) ? "user" : "kernel", prologue);
 		break;
 	}
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 145a7ac0c19a..f6f16df04cb9 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -163,6 +163,19 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		memset(childregs, 0, sizeof(struct pt_regs));
+
+		/*
+		 * Even though there is no real user state here, these
+		 * are were user regs belong, and kernel_execve() will
+		 * overwrite them with user regs.  Put an obviously
+		 * invalid value that nonetheless causes user_mode(regs)
+		 * to return true in CS.
+		 *
+		 * This also prevents the unwinder from thinking that there
+		 * is invalid kernel state at the top of the stack.
+		 */
+		childregs->cs = 3;
+
 		kthread_frame_init(frame, sp, arg);
 		return 0;
 	}
-- 
2.29.2

