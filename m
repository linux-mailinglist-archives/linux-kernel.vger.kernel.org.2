Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91624315D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbhBJCmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235107AbhBJCge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:36:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB8A864E79;
        Wed, 10 Feb 2021 02:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924437;
        bh=y/dOirvG5AtLV2tIfLLxXk9twm9gXZqV5HopLGhImfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TSSwq/4JBgfQT7OHlfplL7hzYMFUP4FHqvCbQaLsTQtvT65Bdrx2UqVAavWAGOMyW
         W5L/yTEjjKqN2O2KlVAV2YmJRrIuPFcTLq6EtEwodw23MWp6w9v0xS4jQT1wqINE3D
         03YIVGWh+bnOio+1p/hco8DVbo4CnjBsdWrufd4fQB6s8W4as3bu5edeV+bhZqz66z
         SzeVXFwqru4j6+oIAJrXj6bol4F6PEXglxV/P9jk4ITK7DtxbtFRPD0mcGw6VyMBQs
         5/Kuox1LRBAi9wDyi7D+7hvx8NEz4eAkPySxACUkF4zAmp/q99ygtNw52gpEydVRic
         CmMLZD/fhCo8Q==
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
Subject: [PATCH v2 10/14] x86/fault: Bypass no_context() for implicit kernel faults from usermode
Date:   Tue,  9 Feb 2021 18:33:42 -0800
Message-Id: <6e3d1129494a8de1e59d28012286e3a292a2296e.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can drop an indentation level and remove the last
user_mode(regs) == true caller of no_context() by directly OOPSing for
implicit kernel faults from usermode.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 59 ++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 8b8bd0a4f4b2..f735639455a5 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -825,44 +825,49 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
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

