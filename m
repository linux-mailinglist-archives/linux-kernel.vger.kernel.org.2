Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D13A7911
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 10:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFOIfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 04:35:32 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42890 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhFOIf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 04:35:28 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G41mf1KvFzB2jf;
        Tue, 15 Jun 2021 10:33:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QOjuT_NED3GT; Tue, 15 Jun 2021 10:33:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G41mf0PFcz9s4w;
        Tue, 15 Jun 2021 10:33:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CD7E08B7B5;
        Tue, 15 Jun 2021 10:33:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wrfP-ZaDscOS; Tue, 15 Jun 2021 10:33:21 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BC9C8B7A5;
        Tue, 15 Jun 2021 10:33:21 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3DE0266264; Tue, 15 Jun 2021 08:33:21 +0000 (UTC)
Message-Id: <8071cd2e2f2bdc0711e6ac435dff4a09ff21fee2.1623745949.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 1/5] powerpc/interrupt: Rename and lightly change
 syscall_exit_prepare_main()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 15 Jun 2021 08:33:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename syscall_exit_prepare_main() into interrupt_exit_prepare_main()

Make it static as it is not used anywhere else.

Pass it the 'ret' so that it can 'or' it directly instead of
oring twice, once inside the function and once outside.

And remove 'r3' parameter which is not used.

Also fix a typo where CONFIG_PPC_BOOK3S should be CONFIG_PPC_BOOK3S_64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
This series applies on top of Nic's series speeding up interrupt return on 64s

 arch/powerpc/kernel/interrupt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 74c995a42399..ba2d602d2da6 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -243,11 +243,10 @@ static notrace void booke_load_dbcr0(void)
 #endif
 }
 
-notrace unsigned long syscall_exit_prepare_main(unsigned long r3,
-						struct pt_regs *regs)
+static notrace unsigned long
+interrupt_exit_user_prepare_main(struct pt_regs *regs, unsigned long ret)
 {
 	unsigned long ti_flags;
-	unsigned long ret = 0;
 
 again:
 	ti_flags = READ_ONCE(current_thread_info()->flags);
@@ -269,7 +268,7 @@ notrace unsigned long syscall_exit_prepare_main(unsigned long r3,
 		ti_flags = READ_ONCE(current_thread_info()->flags);
 	}
 
-	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && IS_ENABLED(CONFIG_PPC_FPU)) {
+	if (IS_ENABLED(CONFIG_PPC_BOOK3S_64) && IS_ENABLED(CONFIG_PPC_FPU)) {
 		if (IS_ENABLED(CONFIG_PPC_TRANSACTIONAL_MEM) &&
 				unlikely((ti_flags & _TIF_RESTORE_TM))) {
 			restore_tm_state(regs);
@@ -365,7 +364,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	}
 
 	local_irq_disable();
-	ret |= syscall_exit_prepare_main(r3, regs);
+	ret = interrupt_exit_user_prepare_main(regs, ret);
 
 #ifdef CONFIG_PPC64
 	regs->exit_result = ret;
@@ -393,7 +392,7 @@ notrace unsigned long syscall_exit_restart(unsigned long r3, struct pt_regs *reg
 
 	BUG_ON(!user_mode(regs));
 
-	regs->exit_result |= syscall_exit_prepare_main(r3, regs);
+	regs->exit_result = interrupt_exit_user_prepare_main(regs, regs->exit_result);
 
 	return regs->exit_result;
 }
-- 
2.25.0

