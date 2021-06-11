Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945D43A494D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 21:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhFKTM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 15:12:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64288 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229685AbhFKTM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 15:12:57 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4G1r6B1QDYzBB8Q;
        Fri, 11 Jun 2021 21:10:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id eH9Pu4L-O0Yk; Fri, 11 Jun 2021 21:10:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4G1r6B0HwCzBB8B;
        Fri, 11 Jun 2021 21:10:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA6B98B84C;
        Fri, 11 Jun 2021 21:10:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id v8zQL_Vn6FaM; Fri, 11 Jun 2021 21:10:57 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 91F748B848;
        Fri, 11 Jun 2021 21:10:57 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4D97366132; Fri, 11 Jun 2021 19:10:57 +0000 (UTC)
Message-Id: <1fff2054e5dfc00329804dbd3f2a91667c9a8aff.1623438544.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/64: drop redundant defination of spin_until_cond
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Sudeep Holla <sudeep.holla@arm.com>
Date:   Fri, 11 Jun 2021 19:10:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

linux/processor.h has exactly same defination for spin_until_cond.
Drop the redundant defination in asm/processor.h

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 That's just a rebase

 arch/powerpc/include/asm/processor.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 7bf8a15af224..0819854eeab9 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -339,17 +339,6 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
 
 #define spin_end()	HMT_medium()
 
-#define spin_until_cond(cond)					\
-do {								\
-	if (unlikely(!(cond))) {				\
-		spin_begin();					\
-		do {						\
-			spin_cpu_relax();			\
-		} while (!(cond));				\
-		spin_end();					\
-	}							\
-} while (0)
-
 #endif
 
 /* Check that a certain kernel stack pointer is valid in task_struct p */
-- 
2.25.0

