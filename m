Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A8C367143
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239412AbhDURYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:24:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36275 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239286AbhDURYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:24:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FQS8L3R0sz9vBmn;
        Wed, 21 Apr 2021 19:24:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DNRcKS_Bbf_r; Wed, 21 Apr 2021 19:24:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FQS8L2LN7z9vBmm;
        Wed, 21 Apr 2021 19:24:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 025DB8B831;
        Wed, 21 Apr 2021 19:24:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JlG_YwR7MWds; Wed, 21 Apr 2021 19:24:03 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BBA298B82B;
        Wed, 21 Apr 2021 19:24:03 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7966263955; Wed, 21 Apr 2021 17:24:03 +0000 (UTC)
Message-Id: <cb4cec9131c8577803367f1699209a7e104cec2a.1619025821.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/52xx: Fix an invalid ASM expression ('addi' used
 instead of 'add')
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 21 Apr 2021 17:24:03 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  AS      arch/powerpc/platforms/52xx/lite5200_sleep.o
arch/powerpc/platforms/52xx/lite5200_sleep.S: Assembler messages:
arch/powerpc/platforms/52xx/lite5200_sleep.S:184: Warning: invalid register expression

In the following code, 'addi' is wrong, has to be 'add'

	/* local udelay in sram is needed */
  udelay: /* r11 - tb_ticks_per_usec, r12 - usecs, overwrites r13 */
	mullw	r12, r12, r11
	mftb	r13	/* start */
	addi	r12, r13, r12 /* end */

Fixes: ee983079ce04 ("[POWERPC] MPC5200 low power mode")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/52xx/lite5200_sleep.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200_sleep.S b/arch/powerpc/platforms/52xx/lite5200_sleep.S
index 11475c58ea43..afee8b1515a8 100644
--- a/arch/powerpc/platforms/52xx/lite5200_sleep.S
+++ b/arch/powerpc/platforms/52xx/lite5200_sleep.S
@@ -181,7 +181,7 @@ sram_code:
   udelay: /* r11 - tb_ticks_per_usec, r12 - usecs, overwrites r13 */
 	mullw	r12, r12, r11
 	mftb	r13	/* start */
-	addi	r12, r13, r12 /* end */
+	add	r12, r13, r12 /* end */
     1:
 	mftb	r13	/* current */
 	cmp	cr0, r13, r12
-- 
2.25.0

