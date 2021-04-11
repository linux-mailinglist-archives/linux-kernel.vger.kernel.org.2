Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D101F35B615
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 18:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhDKQkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 12:40:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25832 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236406AbhDKQkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 12:40:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FJHdy6tXMzB09bC;
        Sun, 11 Apr 2021 18:39:50 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ccZeimTKb--K; Sun, 11 Apr 2021 18:39:50 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FJHdy5tmDzB09b7;
        Sun, 11 Apr 2021 18:39:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 638FD8B770;
        Sun, 11 Apr 2021 18:39:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oaTK-YMuW23J; Sun, 11 Apr 2021 18:39:54 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 229C68B75B;
        Sun, 11 Apr 2021 18:39:54 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C752D679DE; Sun, 11 Apr 2021 16:39:53 +0000 (UTC)
Message-Id: <aad2cb1801a3cc99bc27081022925b9fc18a0dfb.1618159169.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/signal32: Fix build failure with CONFIG_SPE
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 11 Apr 2021 16:39:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing fault exit label in unsafe_copy_from_user() in order to
avoid following build failure with CONFIG_SPE

  CC      arch/powerpc/kernel/signal_32.o
arch/powerpc/kernel/signal_32.c: In function 'restore_user_regs':
arch/powerpc/kernel/signal_32.c:565:36: error: macro "unsafe_copy_from_user" requires 4 arguments, but only 3 given
  565 |           ELF_NEVRREG * sizeof(u32));
      |                                    ^
In file included from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/percpu-rwsem.h:7,
                 from ./include/linux/fs.h:33,
                 from ./include/linux/huge_mm.h:8,
                 from ./include/linux/mm.h:707,
                 from arch/powerpc/kernel/signal_32.c:17:
./arch/powerpc/include/asm/uaccess.h:428: note: macro "unsafe_copy_from_user" defined here
  428 | #define unsafe_copy_from_user(d, s, l, e) \
      |
arch/powerpc/kernel/signal_32.c:564:3: error: 'unsafe_copy_from_user' undeclared (first use in this function); did you mean 'raw_copy_from_user'?
  564 |   unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
      |   ^~~~~~~~~~~~~~~~~~~~~
      |   raw_copy_from_user
arch/powerpc/kernel/signal_32.c:564:3: note: each undeclared identifier is reported only once for each function it appears in
make[3]: *** [arch/powerpc/kernel/signal_32.o] Error 1

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 627b72bee84d ("powerpc/signal32: Convert restore_[tm]_user_regs() to user access block")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/kernel/signal_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 23fdb364b511..d489ccea2ab3 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -562,7 +562,7 @@ static long restore_user_regs(struct pt_regs *regs,
 	if (msr & MSR_SPE) {
 		/* restore spe registers from the stack */
 		unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
-				      ELF_NEVRREG * sizeof(u32));
+				      ELF_NEVRREG * sizeof(u32), failed);
 		current->thread.used_spe = true;
 	} else if (current->thread.used_spe)
 		memset(current->thread.evr, 0, ELF_NEVRREG * sizeof(u32));
-- 
2.25.0

