Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7339FD87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbhFHRYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:24:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36493 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231493AbhFHRYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:24:48 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Fzxrs618rzBDn2;
        Tue,  8 Jun 2021 19:22:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8PRSQCAx5M4h; Tue,  8 Jun 2021 19:22:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Fzxrr3xWSzBDnF;
        Tue,  8 Jun 2021 19:22:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 690408B7C2;
        Tue,  8 Jun 2021 19:22:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4w2f-pULmofi; Tue,  8 Jun 2021 19:22:52 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D0768B7BF;
        Tue,  8 Jun 2021 19:22:52 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B10DF64C49; Tue,  8 Jun 2021 17:22:51 +0000 (UTC)
Message-Id: <d01028f8166b98584eec536b52f14c5e3f98ff6b.1623172922.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Remove __main()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  8 Jun 2021 17:22:51 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment says that __main() is there to make GCC happy.

It's been there since the implementation of ppc arch in Linux 1.3.45.

ppc32 is the only architecture having that. Even ppc64 doesn't have it.

Seems like GCC is still happy without it.

Drop it for good.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/misc_32.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 6a076bef2932..39ab15419592 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -388,9 +388,3 @@ _GLOBAL(start_secondary_resume)
 	bl	start_secondary
 	b	.
 #endif /* CONFIG_SMP */
-	
-/*
- * This routine is just here to keep GCC happy - sigh...
- */
-_GLOBAL(__main)
-	blr
-- 
2.25.0

