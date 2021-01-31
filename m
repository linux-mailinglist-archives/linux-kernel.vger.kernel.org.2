Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D472309F35
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 23:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhAaWUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 17:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhAaWNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 17:13:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AFB164E35;
        Sun, 31 Jan 2021 17:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612113891;
        bh=SlJl7V376aZ1Rpgyzy0rzdmTxaqS15CuLY6HqKTGLU4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=caSEFYOWvDKVcEZ/oMYFnRX++pneJ6kTvdaHby1sx8LrOj5SPwd8XWmmnn8C/GWts
         U66BMOj7IjR6mon1jWhk5y4yuR8wZDtG8PQHsOCKH+L2HrKStpCyPE9IkdNZSBwgPC
         zNp26sx9H8ryl7mXsXOS4qDaAqKcwy+U3p/bdbu/gQ2ck7vM2qe8EjxL5f6m0xRdBt
         RnHkMijkrqgw1GLTySofDzjFkhoWJvm/xeuH24/9p4sR8DIg/DumAo2UDrL+Fhh2Ix
         XmkrZA9q5V+STaBXZ5aUqzH3tX+9nDP2PZ5oe2crxzMzc5mmVGhmDWNPhRl1StIjgR
         zc5ybo1cQ4sWg==
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
Subject: [PATCH 05/11] x86/fault: Correct a few user vs kernel checks wrt WRUSS
Date:   Sun, 31 Jan 2021 09:24:36 -0800
Message-Id: <d5a32187f77197c8adddf9008c085c50d548bae2.1612113550.git.luto@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1612113550.git.luto@kernel.org>
References: <cover.1612113550.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, page fault errors for WRUSS should be just like get_user(),
etc.  Fix three bugs in this area:

We have a comment that says that, if we can't handle a page fault on a user
address due to OOM, we will skip the OOM-kill-and-retry logic.  The code
checked kernel *privilege*, not kernel mode, so it missed WRUSS.  This
means that we would malfunction if we got OOM on a WRUSS fault -- this
would be a kernel-mode, user-privilege fault, and we would invoke the OOM
killer and retry.

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
index b52064920f0d..602cdf8e070a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -908,7 +908,7 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	  vm_fault_t fault)
 {
 	/* Kernel mode? Handle exceptions or die: */
-	if (!(error_code & X86_PF_USER)) {
+	if (!user_mode(regs)) {
 		no_context(regs, error_code, address, SIGBUS, BUS_ADRERR);
 		return;
 	}
@@ -1180,7 +1180,14 @@ do_kern_addr_fault(struct pt_regs *regs, unsigned long hw_error_code,
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
@@ -1369,14 +1376,14 @@ void do_user_addr_fault(struct pt_regs *regs,
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

