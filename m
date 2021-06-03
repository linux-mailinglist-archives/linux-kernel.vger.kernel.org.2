Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5C3399CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFCIoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:44:07 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:48707 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230030AbhFCIoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:44:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FwfWw412GzBC50;
        Thu,  3 Jun 2021 10:41:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TqaRi3W4ZU_J; Thu,  3 Jun 2021 10:41:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FwfWv48j5zBC60;
        Thu,  3 Jun 2021 10:41:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B33A8B848;
        Thu,  3 Jun 2021 10:41:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rmc4yPZKRbOe; Thu,  3 Jun 2021 10:41:47 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 253D98B767;
        Thu,  3 Jun 2021 10:41:47 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 01FE164BD2; Thu,  3 Jun 2021 08:41:46 +0000 (UTC)
Message-Id: <549214ecf6887d965645e664520d4886663c5ffb.1622708530.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1622708530.git.christophe.leroy@csgroup.eu>
References: <cover.1622708530.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 11/12] powerpc/kuap: Remove KUAP_CURRENT_XXX
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  3 Jun 2021 08:41:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

book3s/32 was the only user of KUAP_CURRENT_XXX.

After rework of book3s/32 KUAP, it is not used anymore.

Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h |  1 -
 arch/powerpc/include/asm/kup.h           | 14 +++-----------
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index bac7edae64bf..eb5ef59a406b 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -145,7 +145,6 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 		return;
 
 	BUILD_BUG_ON(!__builtin_constant_p(dir));
-	BUILD_BUG_ON(dir & ~KUAP_READ_WRITE);
 
 	if (!(dir & KUAP_WRITE))
 		return;
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 4b94d4293777..2c47feee9482 100644
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
@@ -129,17 +121,17 @@ static inline void prevent_read_write_user(void __user *to, const void __user *f
 
 static inline void prevent_current_access_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ_WRITE);
 }
 
 static inline void prevent_current_read_from_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_READ);
 }
 
 static inline void prevent_current_write_to_user(void)
 {
-	prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
+	prevent_user_access(NULL, NULL, ~0UL, KUAP_WRITE);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.0

