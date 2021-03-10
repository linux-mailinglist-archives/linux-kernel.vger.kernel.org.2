Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5A2334593
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhCJRrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:47:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:32068 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233521AbhCJRqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:46:44 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Dwfdr1Vvdz9tytV;
        Wed, 10 Mar 2021 18:46:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id R75kHyzI-lgr; Wed, 10 Mar 2021 18:46:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Dwfdr0gTTz9tytQ;
        Wed, 10 Mar 2021 18:46:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D40EE8B78D;
        Wed, 10 Mar 2021 18:46:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id S7bjhWVaob99; Wed, 10 Mar 2021 18:46:41 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BB458B77E;
        Wed, 10 Mar 2021 18:46:41 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7AFD567568; Wed, 10 Mar 2021 17:46:41 +0000 (UTC)
Message-Id: <e02f83ec74f26d76df2874f0ce4d5cc69c3469ae.1615398265.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1615398265.git.christophe.leroy@csgroup.eu>
References: <cover.1615398265.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 02/15] powerpc/uaccess: Define ___get_user_instr() for
 ppc32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 10 Mar 2021 17:46:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define simple ___get_user_instr() for ppc32 instead of
defining ppc32 versions of the three get_user_instr()
helpers.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/include/asm/uaccess.h | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 8cbf3e3874f1..a08c482b1315 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -81,6 +81,10 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 	}								\
 	__gui_ret;							\
 })
+#else /* !CONFIG_PPC64 */
+#define ___get_user_instr(gu_op, dest, ptr)				\
+	gu_op((dest).val, (u32 __user *)(ptr))
+#endif /* CONFIG_PPC64 */
 
 #define get_user_instr(x, ptr) \
 	___get_user_instr(get_user, x, ptr)
@@ -91,18 +95,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 #define __get_user_instr_inatomic(x, ptr) \
 	___get_user_instr(__get_user_inatomic, x, ptr)
 
-#else /* !CONFIG_PPC64 */
-#define get_user_instr(x, ptr) \
-	get_user((x).val, (u32 __user *)(ptr))
-
-#define __get_user_instr(x, ptr) \
-	__get_user_nocheck((x).val, (u32 __user *)(ptr), sizeof(u32), true)
-
-#define __get_user_instr_inatomic(x, ptr) \
-	__get_user_nosleep((x).val, (u32 __user *)(ptr), sizeof(u32))
-
-#endif /* CONFIG_PPC64 */
-
 extern long __put_user_bad(void);
 
 #define __put_user_size(x, ptr, size, retval)			\
-- 
2.25.0

