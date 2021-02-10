Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416C2315D73
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 03:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhBJCj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 21:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235337AbhBJCfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 21:35:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1F2764E53;
        Wed, 10 Feb 2021 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612924433;
        bh=Nzexq/XyDFebEMVO5dSL6NGgsndSa73SNRAf6SSfnGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hm9mLP9ZH3eoHENJRXxoikxInGXE1VCXAZVZ/1/vpSrU6xQ5um5ACAP4ld+MPmyTf
         zN0hOqJBNnQjZ6r3qOXaLhJGbLJ5Ex+ESzprjt5R252UBll8M3OuNNVlDP04K4lsCY
         A3smHrIn5at+Nw+lqK8YU2MPOBZKnscG+cHApoSkQ/I2LDqsXb86b1AP8DXPCC+TL6
         kn/fNXSb4v67uSqS28MYuz5dAveJ8hSYCDAl0Xnezc6TCgJeS2Qr6xCBZdhAwjdFY1
         iUWXQwDZjJ8JOtEMD2K4u+sNvog4WIulB5MebWqxV1XsQU4c/NdCiLIYZpZwF6oUBK
         xMSWavK1zXEfw==
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
Subject: [PATCH v2 06/14] x86/fault: Correct a few user vs kernel checks wrt WRUSS
Date:   Tue,  9 Feb 2021 18:33:38 -0800
Message-Id: <a7b7bcea730bd4069e6b7e629236bb2cf526c2fb.1612924255.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612924255.git.luto@kernel.org>
References: <cover.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, page fault errors for WRUSS should be just like get_user(),
etc.  Fix three bugs in this area:

There is a comment that says that, if the kernel can't handle a page fault
on a user address due to OOM, the OOM-kill-and-retry logic would be
skipped.  The code checked kernel *privilege*, not kernel mode, so it
missed WRUSS.  This means that the kernel would malfunction if it got OOM
on a WRUSS fault -- this would be a kernel-mode, user-privilege fault, and
the OOM killer would be invoked and the handler would retry the faulting
instruction.

A failed user access from kernel while a fatal signal is pending should
fail even if the instruction in question was WRUSS.

do_sigbus() should not send SIGBUS for WRUSS -- it should handle it like
any other kernel mode failure.

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 013910b7b93f..b1104844260d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -945,7 +945,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  vm_fault_t fault)
 {
 	/* Kernel mode? Handle exceptions or die: */
-	if (!(error_code & X86_PF_USER)) {
+	if (!user_mode(regs)) {
 		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
@@ -1217,7 +1217,14 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
 }
 NOKPROBE_SYMBOL(do_kern_addr_fault);
 
-/* Handle faults in the user portion of the address space */
+/*
+ * Handle faults in the user portion of the address space.  Nothing in here
+ * should check X86_PF_USER without a specific justification: for almost
+ * all purposes, we should treat a normal kernel access to user memory
+ * (e.g. get_user(), put_user(), etc.) the same as the WRUSS instruction.
+ * The one exception is AC flag handling, which is, per the x86
+ * architecture, special for WRUSS.
+ */
 static inline
 void do_user_addr_fault(struct pt_regs *regs,
 			unsigned long error_code,
@@ -1406,14 +1413,14 @@ void do_user_addr_fault(struct pt_regs *regs,
 	if (likely(!(fault & VM_FAULT_ERROR)))
 		return;
 
-	if (fatal_signal_pending(current) && !(error_code & X86_PF_USER)) {
+	if (fatal_signal_pending(current) && !user_mode(regs)) {
 		no_context(regs, error_code, address, 0, 0);
 		return;
 	}
 
 	if (fault & VM_FAULT_OOM) {
 		/* Kernel mode? Handle exceptions or die: */
-		if (!(error_code & X86_PF_USER)) {
+		if (!user_mode(regs)) {
 			no_context(regs, error_code, address,
 				   SIGSEGV, SEGV_MAPERR);
 			return;
-- 
2.29.2

