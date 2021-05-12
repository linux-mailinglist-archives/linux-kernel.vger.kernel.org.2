Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081F837B81F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhELIgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:36:23 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39935 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231129AbhELIgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:36:20 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fg7QM1r1fz9sfC;
        Wed, 12 May 2021 10:35:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xN5JqW2ozEY9; Wed, 12 May 2021 10:35:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fg7QK5lwQz9sf9;
        Wed, 12 May 2021 10:35:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A87038B7D9;
        Wed, 12 May 2021 10:35:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eHs4-xWufSt8; Wed, 12 May 2021 10:35:05 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62DE68B7D8;
        Wed, 12 May 2021 10:35:05 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 42BE5641A1; Wed, 12 May 2021 08:35:05 +0000 (UTC)
Message-Id: <653d26ca1008a56561a111e655bb97916c5e795a.1620808468.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e457f345843aa36c6f9ef8e6cb988428ae908df5.1620808468.git.christophe.leroy@csgroup.eu>
References: <e457f345843aa36c6f9ef8e6cb988428ae908df5.1620808468.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 4/5] powerpc/kuap: Remove KUAP_CURRENT_XXX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 May 2021 08:35:05 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

book3s/32 was the only user of KUAP_CURRENT_XXX.

After rework of book3s/32 KUAP, it is not used anymore.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  1 -
 arch/powerpc/include/asm/kup.h           | 14 +++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index c67b91c1ca80..7b88f7bdd90f 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -102,7 +102,6 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 					      u32 size, unsigned long dir)
 {
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
-	BUILD_BUG_ON(dir & ~KUAP_READ_WRITE);
 	if (!(dir & KUAP_WRITE))
 		return;
 
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ea83970734cf..aa93eb4e3be5 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -5,14 +5,6 @@
 #define KUAP_READ	1
 #define KUAP_WRITE	2
 #define KUAP_READ_WRITE	(KUAP_READ | KUAP_WRITE)
-/*
- * For prevent_user_access() only.
- * Use the current saved situation instead of the to/from/size params.
- * Used on book3s/32
- */
-#define KUAP_CURRENT_READ	4
-#define KUAP_CURRENT_WRITE	8
-#define KUAP_CURRENT		(KUAP_CURRENT_READ | KUAP_CURRENT_WRITE)
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/kup.h>
@@ -139,17 +131,17 @@ static __always_inline void prevent_read_write_user(void __user *to, const void
 
 static __always_inline void prevent_current_access_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ_WRITE);
 }
 
 static __always_inline void prevent_current_read_from_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ);
 }
 
 static __always_inline void prevent_current_write_to_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_WRITE);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.0

