Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE0C375FD5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhEGFqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:46:54 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:33125 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230302AbhEGFqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:46:53 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FbzvP06vCz9sYf;
        Fri,  7 May 2021 07:45:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VC9JLFNKSe6A; Fri,  7 May 2021 07:45:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FbzvN6HXNz9sYd;
        Fri,  7 May 2021 07:45:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B97168B817;
        Fri,  7 May 2021 07:45:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mL3gFu1YspUD; Fri,  7 May 2021 07:45:52 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 890798B764;
        Fri,  7 May 2021 07:45:52 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 62463648FD; Fri,  7 May 2021 05:45:52 +0000 (UTC)
Message-Id: <62743846cbd493e5d9a02e197c2672a1d30df149.1620366342.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mmu: Don't duplicate radix_enabled()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 May 2021 05:45:52 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmu_has_feature(MMU_FTR_TYPE_RADIX) can be evaluated regardless of
CONFIG_PPC_RADIX_MMU.

When CONFIG_PPC_RADIX_MMU is not set, mmu_has_feature(MMU_FTR_TYPE_RADIX)
will evaluate to 'false' at build time because MMU_FTR_TYPE_RADIX
wont be included in MMU_FTRS_POSSIBLE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/mmu.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 607168b1aef4..0a6a77437ab8 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -324,7 +324,6 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 }
 #endif /* !CONFIG_DEBUG_VM */
 
-#ifdef CONFIG_PPC_RADIX_MMU
 static inline bool radix_enabled(void)
 {
 	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
@@ -334,17 +333,6 @@ static inline bool early_radix_enabled(void)
 {
 	return early_mmu_has_feature(MMU_FTR_TYPE_RADIX);
 }
-#else
-static inline bool radix_enabled(void)
-{
-	return false;
-}
-
-static inline bool early_radix_enabled(void)
-{
-	return false;
-}
-#endif
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static inline bool strict_kernel_rwx_enabled(void)
-- 
2.25.0

