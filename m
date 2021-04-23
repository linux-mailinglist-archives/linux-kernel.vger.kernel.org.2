Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9A1369410
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 15:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhDWNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 09:52:50 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28601 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhDWNwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:52:49 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FRbLx0RLgz9ttC6;
        Fri, 23 Apr 2021 15:52:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id nksP2VPKskja; Fri, 23 Apr 2021 15:52:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FRbLw6llJz9ttC5;
        Fri, 23 Apr 2021 15:52:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E9C678B865;
        Fri, 23 Apr 2021 15:52:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id iidl2mxlih71; Fri, 23 Apr 2021 15:52:10 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B435C8B765;
        Fri, 23 Apr 2021 15:52:10 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 763D96397D; Fri, 23 Apr 2021 13:52:10 +0000 (UTC)
Message-Id: <a29aadc54c93bcbf069a83615fa102ca0f59c3ae.1619185912.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/signal32: Fix erroneous SIGSEGV on RT signal return
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 23 Apr 2021 13:52:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return of user_read_access_begin() is tested the wrong way,
leading to a SIGSEGV when the user address is valid and likely
an Oops when the user address is bad.

Fix the test.

Fixes: 887f3ceb51cd ("powerpc/signal32: Convert do_setcontext[_tm]() to user access block")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index fc41c58f0cbb..8f05ed0da292 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -967,7 +967,7 @@ static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int
 	sigset_t set;
 	struct mcontext __user *mcp;
 
-	if (user_read_access_begin(ucp, sizeof(*ucp)))
+	if (!user_read_access_begin(ucp, sizeof(*ucp)))
 		return -EFAULT;
 
 	unsafe_get_sigset_t(&set, &ucp->uc_sigmask, failed);
@@ -1005,7 +1005,7 @@ static int do_setcontext_tm(struct ucontext __user *ucp,
 	u32 cmcp;
 	u32 tm_cmcp;
 
-	if (user_read_access_begin(ucp, sizeof(*ucp)))
+	if (!user_read_access_begin(ucp, sizeof(*ucp)))
 		return -EFAULT;
 
 	unsafe_get_sigset_t(&set, &ucp->uc_sigmask, failed);
-- 
2.25.0

