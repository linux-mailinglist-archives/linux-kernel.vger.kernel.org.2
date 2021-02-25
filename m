Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421153254E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhBYRyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:54:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:39632 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232538AbhBYRvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:51:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DmgLJ6nLtz9v1B4;
        Thu, 25 Feb 2021 18:50:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id esIdMWZFTTJU; Thu, 25 Feb 2021 18:50:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DmgLJ58Lsz9v19y;
        Thu, 25 Feb 2021 18:50:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AD708B895;
        Thu, 25 Feb 2021 18:50:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id L4apmeSrjImP; Thu, 25 Feb 2021 18:50:34 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 216488B88B;
        Thu, 25 Feb 2021 18:50:34 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F1B0C67442; Thu, 25 Feb 2021 17:50:33 +0000 (UTC)
Message-Id: <3767191de157574915387986d1498e50e5ecd36e.1614275314.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1614275314.git.christophe.leroy@csgroup.eu>
References: <cover.1614275314.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 04/15] powerpc/uaccess: Move get_user_instr helpers in
 asm/inst.h
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 25 Feb 2021 17:50:33 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those helpers use get_user helpers but they don't participate
in their implementation, so they do not belong to asm/uaccess.h

Move them in asm/inst.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h    | 34 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/uaccess.h | 34 ------------------------------
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index cc73c1267572..19e18af2fac9 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -4,6 +4,40 @@
 
 #include <asm/ppc-opcode.h>
 
+#ifdef CONFIG_PPC64
+
+#define ___get_user_instr(gu_op, dest, ptr)				\
+({									\
+	long __gui_ret = 0;						\
+	unsigned long __gui_ptr = (unsigned long)ptr;			\
+	struct ppc_inst __gui_inst;					\
+	unsigned int __prefix, __suffix;				\
+	__gui_ret = gu_op(__prefix, (unsigned int __user *)__gui_ptr);	\
+	if (__gui_ret == 0) {						\
+		if ((__prefix >> 26) == OP_PREFIX) {			\
+			__gui_ret = gu_op(__suffix,			\
+				(unsigned int __user *)__gui_ptr + 1);	\
+			__gui_inst = ppc_inst_prefix(__prefix,		\
+						     __suffix);		\
+		} else {						\
+			__gui_inst = ppc_inst(__prefix);		\
+		}							\
+		if (__gui_ret == 0)					\
+			(dest) = __gui_inst;				\
+	}								\
+	__gui_ret;							\
+})
+#else /* !CONFIG_PPC64 */
+#define ___get_user_instr(gu_op, dest, ptr)				\
+	gu_op((dest).val, (u32 __user *)(ptr))
+#endif /* CONFIG_PPC64 */
+
+#define get_user_instr(x, ptr) \
+	___get_user_instr(get_user, x, ptr)
+
+#define __get_user_instr(x, ptr) \
+	___get_user_instr(__get_user, x, ptr)
+
 /*
  * Instruction data type for POWER
  */
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 01aea0df4dd0..eaa828a6a419 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -53,40 +53,6 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 #define __put_user(x, ptr) \
 	__put_user_nocheck((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)))
 
-#ifdef CONFIG_PPC64
-
-#define ___get_user_instr(gu_op, dest, ptr)				\
-({									\
-	long __gui_ret = 0;						\
-	unsigned long __gui_ptr = (unsigned long)ptr;			\
-	struct ppc_inst __gui_inst;					\
-	unsigned int __prefix, __suffix;				\
-	__gui_ret = gu_op(__prefix, (unsigned int __user *)__gui_ptr);	\
-	if (__gui_ret == 0) {						\
-		if ((__prefix >> 26) == OP_PREFIX) {			\
-			__gui_ret = gu_op(__suffix,			\
-				(unsigned int __user *)__gui_ptr + 1);	\
-			__gui_inst = ppc_inst_prefix(__prefix,		\
-						     __suffix);		\
-		} else {						\
-			__gui_inst = ppc_inst(__prefix);		\
-		}							\
-		if (__gui_ret == 0)					\
-			(dest) = __gui_inst;				\
-	}								\
-	__gui_ret;							\
-})
-#else /* !CONFIG_PPC64 */
-#define ___get_user_instr(gu_op, dest, ptr)				\
-	gu_op((dest).val, (u32 __user *)(ptr))
-#endif /* CONFIG_PPC64 */
-
-#define get_user_instr(x, ptr) \
-	___get_user_instr(get_user, x, ptr)
-
-#define __get_user_instr(x, ptr) \
-	___get_user_instr(__get_user, x, ptr)
-
 extern long __put_user_bad(void);
 
 #define __put_user_size(x, ptr, size, retval)			\
-- 
2.25.0

