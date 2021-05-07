Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA6375FFD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 08:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhEGGCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 02:02:03 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:43153 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEGGCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 02:02:00 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fc0Dq5w4qz9sZQ;
        Fri,  7 May 2021 08:00:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7Mt_Wth8UqvN; Fri,  7 May 2021 08:00:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fc0Dq51PTz9sZP;
        Fri,  7 May 2021 08:00:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2390E8B81A;
        Fri,  7 May 2021 08:00:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LZX6P8dbh5Tq; Fri,  7 May 2021 08:00:59 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E58C58B764;
        Fri,  7 May 2021 08:00:58 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3A61464908; Fri,  7 May 2021 06:00:58 +0000 (UTC)
Message-Id: <594fa3cc0df11e21644fd6a584851ae4f164b2bf.1620367249.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mmu: Remove leftover CONFIG_E200
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 May 2021 06:00:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 39c8bf2b3cc1 ("powerpc: Retire e200 core (mpc555x processor)")
removed CONFIG_E200.
Commit f9158d58a4e1 ("powerpc/mm: Add mask of always present MMU
features") was merged in the same cycle and added a new use of
CONFIG_E200.

Remove that use.

Fixes: f9158d58a4e1 ("powerpc/mm: Add mask of always present MMU features")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 0a6a77437ab8..998fe01dd1a8 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -220,7 +220,7 @@ enum {
 #elif defined(CONFIG_44x)
 #define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_44x
 #endif
-#if defined(CONFIG_E200) || defined(CONFIG_E500)
+#ifdef CONFIG_E500
 #define MMU_FTRS_ALWAYS		MMU_FTR_TYPE_FSL_E
 #endif
 
-- 
2.25.0

