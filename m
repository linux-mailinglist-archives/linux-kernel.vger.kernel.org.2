Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5A341B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCSLHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:07:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4219 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhCSLHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:07:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LV1R6Dz9tx92;
        Fri, 19 Mar 2021 12:06:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 6jWfJQRsBY2E; Fri, 19 Mar 2021 12:06:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LV0gp5z9tx91;
        Fri, 19 Mar 2021 12:06:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F8748B975;
        Fri, 19 Mar 2021 12:06:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bAj5KcmCNjIk; Fri, 19 Mar 2021 12:06:58 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 984DD8B974;
        Fri, 19 Mar 2021 12:06:56 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DBFD0675FB; Fri, 19 Mar 2021 11:06:55 +0000 (UTC)
Message-Id: <c106eb2f37c3040f1fd38b40e50c670feb7cb835.1616151715.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1616151715.git.christophe.leroy@csgroup.eu>
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 06/10] powerpc/signal32: Perform access_ok() inside
 restore_user_regs()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 19 Mar 2021 11:06:55 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of using user_access_begin/end in restore_user_regs(),
move the access_ok() inside the function.

It makes no difference as the behaviour on a failed access_ok() is
the same as on failed restore_user_regs().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 8dfe4fe77706..e2b1d2a0abad 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -492,6 +492,8 @@ static long restore_user_regs(struct pt_regs *regs,
 	int i;
 #endif
 
+	if (!access_ok(sr, sizeof(*sr)))
+		return 1;
 	/*
 	 * restore general registers but not including MSR or SOFTE. Also
 	 * take care of keeping r2 (TLS) intact if not a signal
@@ -963,13 +965,10 @@ static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int
 		if (__get_user(cmcp, &ucp->uc_regs))
 			return -EFAULT;
 		mcp = (struct mcontext __user *)(u64)cmcp;
-		/* no need to check access_ok(mcp), since mcp < 4GB */
 	}
 #else
 	if (__get_user(mcp, &ucp->uc_regs))
 		return -EFAULT;
-	if (!access_ok(mcp, sizeof(*mcp)))
-		return -EFAULT;
 #endif
 	set_current_blocked(&set);
 	if (restore_user_regs(regs, mcp, sig))
@@ -1362,8 +1361,7 @@ SYSCALL_DEFINE0(sigreturn)
 	} else {
 		sr = (struct mcontext __user *)from_user_ptr(sigctx.regs);
 		addr = sr;
-		if (!access_ok(sr, sizeof(*sr))
-		    || restore_user_regs(regs, sr, 1))
+		if (restore_user_regs(regs, sr, 1))
 			goto badframe;
 	}
 
-- 
2.25.0

