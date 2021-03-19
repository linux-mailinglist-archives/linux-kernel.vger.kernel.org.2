Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3277341B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCSLHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:07:14 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:55166 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229821AbhCSLG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:06:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LS3Gsvz9tx90;
        Fri, 19 Mar 2021 12:06:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Sktnd3Ls0YAy; Fri, 19 Mar 2021 12:06:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LS2FDZz9tx8s;
        Fri, 19 Mar 2021 12:06:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E4BD8B972;
        Fri, 19 Mar 2021 12:06:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1Ee4UbpWPsNw; Fri, 19 Mar 2021 12:06:55 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 374518B976;
        Fri, 19 Mar 2021 12:06:55 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D4718675FB; Fri, 19 Mar 2021 11:06:54 +0000 (UTC)
Message-Id: <a4b48b2f0be1ef13fc8e57452b7f8350da28d521.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 05/10] powerpc/signal32: Remove ifdefery in middle of if/else
 in sigreturn()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Mar 2021 11:06:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the same spirit as commit f1cf4f93de2f ("powerpc/signal32: Remove
ifdefery in middle of if/else")

MSR_TM_ACTIVE() is always defined and returns always 0 when
CONFIG_PPC_TRANSACTIONAL_MEM is not selected, so the awful
ifdefery in the middle of an if/else can be removed.

Make 'msr_hi' a 'long long' to avoid build failure on PPC32
due to the 32 bits left shift.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3b78748d6d85..8dfe4fe77706 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -740,6 +740,12 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 
 	return 0;
 }
+#else
+static long restore_tm_user_regs(struct pt_regs *regs, struct mcontext __user *sr,
+				 struct mcontext __user *tm_sr)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PPC64
@@ -1317,10 +1323,9 @@ SYSCALL_DEFINE0(sigreturn)
 	struct mcontext __user *sr;
 	void __user *addr;
 	sigset_t set;
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	struct mcontext __user *mcp, *tm_mcp;
-	unsigned long msr_hi;
-#endif
+	struct mcontext __user *mcp;
+	struct mcontext __user *tm_mcp = NULL;
+	unsigned long long msr_hi = 0;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -1343,19 +1348,18 @@ SYSCALL_DEFINE0(sigreturn)
 #endif
 	set_current_blocked(&set);
 
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	mcp = (struct mcontext __user *)&sf->mctx;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	tm_mcp = (struct mcontext __user *)&sf->mctx_transact;
 	if (__get_user(msr_hi, &tm_mcp->mc_gregs[PT_MSR]))
 		goto badframe;
+#endif
 	if (MSR_TM_ACTIVE(msr_hi<<32)) {
 		if (!cpu_has_feature(CPU_FTR_TM))
 			goto badframe;
 		if (restore_tm_user_regs(regs, mcp, tm_mcp))
 			goto badframe;
-	} else
-#endif
-	{
+	} else {
 		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
 		addr = sr;
 		if (!access_ok(sr, sizeof(*sr))
-- 
2.25.0

