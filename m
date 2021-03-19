Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3A1341B1F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhCSLHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:07:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11241 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230081AbhCSLHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:07:02 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LX1c91z9tx8s;
        Fri, 19 Mar 2021 12:07:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5BZWUwXysFnB; Fri, 19 Mar 2021 12:07:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LW6k02z9tx94;
        Fri, 19 Mar 2021 12:06:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 16F4B8B972;
        Fri, 19 Mar 2021 12:07:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lg4zbuWVj8vk; Fri, 19 Mar 2021 12:07:01 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 449998B975;
        Fri, 19 Mar 2021 12:07:00 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 06A95675FB; Fri, 19 Mar 2021 11:07:00 +0000 (UTC)
Message-Id: <638fa99530beb29f82f94370057d110e91272acc.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 10/10] powerpc/signal32: Simplify logging in sigreturn()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Mar 2021 11:07:00 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same spirit as commit debf122c777f ("powerpc/signal32: Simplify logging
in handle_rt_signal32()"), remove this intermediate 'addr' local var.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 592b889e3836..5be267b3a13e 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1352,7 +1352,6 @@ SYSCALL_DEFINE0(sigreturn)
 	struct sigcontext __user *sc;
 	struct sigcontext sigctx;
 	struct mcontext __user *sr;
-	void __user *addr;
 	sigset_t set;
 	struct mcontext __user *mcp;
 	struct mcontext __user *tm_mcp = NULL;
@@ -1363,7 +1362,6 @@ SYSCALL_DEFINE0(sigreturn)
 
 	sf = (struct sigframe __user *)(regs->gpr[1] + __SIGNAL_FRAMESIZE);
 	sc = &sf->sctx;
-	addr = sc;
 	if (copy_from_user(&sigctx, sc, sizeof(sigctx)))
 		goto badframe;
 
@@ -1392,16 +1390,19 @@ SYSCALL_DEFINE0(sigreturn)
 			goto badframe;
 	} else {
 		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
-		addr = sr;
-		if (restore_user_regs(regs, sr, 1))
-			goto badframe;
+		if (restore_user_regs(regs, sr, 1)) {
+			signal_fault(current, regs, "sys_sigreturn", sr);
+
+			force_sig(SIGSEGV);
+			return 0;
+		}
 	}
 
 	set_thread_flag(TIF_RESTOREALL);
 	return 0;
 
 badframe:
-	signal_fault(current, regs, "sys_sigreturn", addr);
+	signal_fault(current, regs, "sys_sigreturn", sc);
 
 	force_sig(SIGSEGV);
 	return 0;
-- 
2.25.0

