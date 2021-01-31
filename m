Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D85309F0C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhAaVKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:10:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhAaVDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:03:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09DFB64E3E;
        Sun, 31 Jan 2021 17:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113893;
        bh=wyJOIMqfy6bpIafa5t0YFAYaqCcPgkGd3Ld8Ak0s+4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYMmUmNNSToSJ9gFwLv/mu6xNkgP035KUck5/33bz4STmHKwwtzm5mMabUnTtdZad
         vwNhHo26h8b4x9YRjQhy4R7MS+xTxK5IG0+Bdxs1QTnxQ5mmHKu6Q3Aob4iZfypiQk
         ULU19rz2g0VcuXiMEuCS4TBwOFyJMMnWpq76PI+h+uKGIQrRRrC6WIn3mDWwEDmVeu
         kEazVEk+4tQThEn2/W6LescJnukW4udMbxB4A9xg4cMt2CPzg3JDrZ7NMUXwvrkRGi
         IKhS21uU32A+YOiTw28j/Vv7xNrSx5CCPPd3Ew8i8t8PCfa3Ub9Sb4DO/WDla3AJd5
         AvW+WkK0rqfeA==
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
Subject: [PATCH 08/11] x86/fault: Bypass no_context() for implicit kernel faults from usermode
Date:   Sun, 31 Jan 2021 09:24:39 -0800
Message-Id: <df70b39a495b927a2ae4d4947fa4a30adc5637e7.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can drop an indentation level and remove the last user_mode(regs) == true
caller of no_context() by directly OOPSing for implicit kernel faults from
usermode.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 59 ++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6f43d080e1e8..177b612c7f33 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -789,44 +789,49 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 {
 	struct task_struct *tsk = current;
 
-	/* User mode accesses just cause a SIGSEGV */
-	if (user_mode(regs) && (error_code & X86_PF_USER)) {
-		/*
-		 * It's possible to have interrupts off here:
-		 */
-		local_irq_enable();
+	if (!user_mode(regs)) {
+		no_context(regs, error_code, address, pkey, si_code);
+		return;
+	}
 
-		/*
-		 * Valid to do another page fault here because this one came
-		 * from user space:
-		 */
-		if (is_prefetch(regs, error_code, address))
-			return;
+	if (!(error_code & X86_PF_USER)) {
+		/* Implicit user access to kernel memory -- just oops */
+		page_fault_oops(regs, error_code, address);
+		return;
+	}
 
-		if (is_errata100(regs, address))
-			return;
+	/*
+	 * User mode accesses just cause a SIGSEGV.
+	 * It's possible to have interrupts off here:
+	 */
+	local_irq_enable();
 
-		sanitize_error_code(address, &error_code);
+	/*
+	 * Valid to do another page fault here because this one came
+	 * from user space:
+	 */
+	if (is_prefetch(regs, error_code, address))
+		return;
 
-		if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
-			return;
+	if (is_errata100(regs, address))
+		return;
 
-		if (likely(show_unhandled_signals))
-			show_signal_msg(regs, error_code, address, tsk);
+	sanitize_error_code(address, &error_code);
 
-		set_signal_archinfo(address, error_code);
+	if (fixup_vdso_exception(regs, X86_TRAP_PF, error_code, address))
+		return;
 
-		if (si_code == SEGV_PKUERR)
-			force_sig_pkuerr((void __user *)address, pkey);
+	if (likely(show_unhandled_signals))
+		show_signal_msg(regs, error_code, address, tsk);
 
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
+	set_signal_archinfo(address, error_code);
 
-		local_irq_disable();
+	if (si_code == SEGV_PKUERR)
+		force_sig_pkuerr((void __user *)address, pkey);
 
-		return;
-	}
+	force_sig_fault(SIGSEGV, si_code, (void __user *)address);
 
-	no_context(regs, error_code, address, SIGSEGV, si_code);
+	local_irq_disable();
 }
 
 static noinline void
-- 
2.29.2

