Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51D0315D7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhBJCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235186AbhBJCge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A985864E74;
        Wed, 10 Feb 2021 02:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924437;
        bh=t0IxQpiZd2ecLW5vT9ANQvXuJW5MMKcovWkVP4FN5BM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kvkumOMH0D2pPIReHxStqF0Y1twB3gDZLA52mOJrMytEERVtqYKavvb0Q3su5PDMW
         7+KEeYR7AmSB2GPasOwBlgY9CY2i0MRHLZZcfqdKYF+vXzcxKy/Oj1pWXLe/Ckghpx
         Nj0yvqItbnnnUxlVTThSkls+vOTlgg3SbHHyVh2rnos2nxzhtrWEu3u7Pu8D5fiExV
         wZYtKHt6STGv9726MX0QHfQPGnD3CMPDSVEM/O7vPge/b7jvSQnz1DvRz2H3gah3rv
         pqq2V2qWEMdOrdfdkrbHXydCKaDJ5bGtis2v50ImR5ykpv+q9JetX4avxHA4l70ZQi
         OdIPwpTstdg9g==
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
Subject: [PATCH v2 11/14] x86/fault: Rename no_context() to kernelmode_fixup_or_oops()
Date:   Tue,  9 Feb 2021 18:33:43 -0800
Message-Id: <c21940efe676024bb4bc721f7d70c29c420e127e.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
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
index f735639455a5..9fb636b2a3da 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -729,17 +729,10 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
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
@@ -779,7 +772,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
-oops:
 	page_fault_oops(regs, error_code, address);
 }
 
@@ -826,7 +818,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	if (!user_mode(regs)) {
-		no_context(regs, error_code, address, pkey, si_code);
+		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
 		return;
 	}
 
@@ -958,7 +950,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 {
 	/* Kernel mode? Handle exceptions or die: */
 	if (!user_mode(regs)) {
-		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
+		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
 
@@ -1420,8 +1412,8 @@ void do_user_addr_fault(struct pt_regs *regs,
 		 * has unlocked the mm for us if we get here.
 		 */
 		if (!user_mode(regs))
-			no_context(regs, error_code, address, SIGBUS,
-				   BUS_ADRERR);
+			kernelmode_fixup_or_oops(regs, error_code, address,
+						 SIGBUS, BUS_ADRERR);
 		return;
 	}
 
@@ -1441,15 +1433,15 @@ void do_user_addr_fault(struct pt_regs *regs,
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

