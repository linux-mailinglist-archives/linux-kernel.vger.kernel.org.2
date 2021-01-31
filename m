Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBB0309E78
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhAaUAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:00:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhAaTyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:54:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD19364E4A;
        Sun, 31 Jan 2021 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113893;
        bh=qlemc0Ip7t8ZrpTpREowl+iyGtccMyRXqTe0uwhHJ68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YnITeL+vDPB2yKJbB4mBIf/17Vv0mVRjP9lelbGUZC9LLitLvCebxdcTOlTa2mp66
         VA+g9Hp9Vt9wy2bwhEPbR0ce2kssoGNBdQEfDA5O/j57UfpwDfZGlgYmJWD6J/6wLX
         iJqDCy2r871Beqx5riBPz35Jgc+PKnkT2skqhaYNclFzgsvsSRZWPamSzOiZfpq5Ya
         CkaNHreSvzQxzg+5WgmVMZKUof/H6te9z8ofIJo88e7XZo2E97f6cYYcEF2niJYJc4
         wQAzOat4Ee0Tqb4J+nhMBGDzPCpvQRX+lw5/OE3es/bQHV4lq/mK+IjxB/YNcEcbkx
         3nMikhbtb8YWg==
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 09/11] x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
Date:   Sun, 31 Jan 2021 09:24:40 -0800
Message-Id: <5b0ad34afeeee15032393367b0945a5032903162.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name no_context() has never been very clear.  It's only called for
faults from kernel mode, so rename it and change the no-longer-useful
user_mode(regs) check to a WARN_ON_ONCE.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 177b612c7f33..04cc98ec2423 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -693,17 +693,10 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 }
 
 static noinline void
-no_context(struct pt_regs *regs, unsigned long error_code,
-	   unsigned long address, int signal, int si_code)
+kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
+			 unsigned long address, int signal, int si_code)
 {
-	if (user_mode(regs)) {
-		/*
-		 * This is an implicit supervisor-mode access from user
-		 * mode.  Bypass all the kernel-mode recovery code and just
-		 * OOPS.
-		 */
-		goto oops;
-	}
+	WARN_ON_ONCE(user_mode(regs));
 
 	/* Are we prepared to handle this kernel fault? */
 	if (fixup_exception(regs, X86_TRAP_PF, error_code, address)) {
@@ -743,7 +736,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-oops:
 	page_fault_oops(regs, error_code, address);
 }
 
@@ -790,7 +782,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	if (!user_mode(regs)) {
-		no_context(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
 		return;
 	}
 
@@ -922,7 +914,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
 
@@ -1382,8 +1374,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * has unlocked the mm for us if we get here.
 		 */
 		if (!user_mode(regs))
-			no_context(regs, error_code, address, SIGBUS,
-				   BUS_ADRERR);
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR);
 		return;
 	}
 
@@ -1403,15 +1395,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 		return;
 
 	if (fatal_signal_pending(current) && !user_mode(regs)) {
-		no_context(regs, error_code, address, 0, 0);
+		kernelmode_fixup_or_oops(regs, error_code, address, 0, 0);
 		return;
 	}
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
 		if (!user_mode(regs)) {
-			no_context(regs, error_code, address,
-				   SIGSEGV, SEGV_MAPERR);
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGSEGV, SEGV_MAPERR);
 			return;
 		}
 
-- 
2.29.2

