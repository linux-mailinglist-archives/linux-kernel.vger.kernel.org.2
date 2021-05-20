Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6FF38B070
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241424AbhETNwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:52:13 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241193AbhETNwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:52:07 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FmB2r0gBWz9sTj;
        Thu, 20 May 2021 15:50:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YkUNlopGdymH; Thu, 20 May 2021 15:50:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2m4ZnSz9sTN;
        Thu, 20 May 2021 15:50:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 776178B808;
        Thu, 20 May 2021 15:50:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QyH_CX4cZUSU; Thu, 20 May 2021 15:50:40 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 360E68B814;
        Thu, 20 May 2021 15:50:40 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2B85E64C40; Thu, 20 May 2021 13:50:40 +0000 (UTC)
Message-Id: <fb097fda78cc6852905ef00f8f7bf371b6cc66f7.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 03/12] powerpc/inst: Improve readability of
 get_user_instr() and friends
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 13:50:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded line splits.

And remove unneeded local variable initialisation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Don't use get_op() for now as including asm/disassemble.h conflicts with drivers/staging/rtl8723bs/include/wifi.h
---
 arch/powerpc/include/asm/inst.h | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 57c31e712e67..fc6adef528a5 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -8,7 +8,7 @@
 
 #define ___get_user_instr(gu_op, dest, ptr)				\
 ({									\
-	long __gui_ret = 0;						\
+	long __gui_ret;							\
 	unsigned int __user *__gui_ptr = (unsigned int __user *)ptr;	\
 	struct ppc_inst __gui_inst;					\
 	unsigned int __prefix, __suffix;				\
@@ -18,8 +18,7 @@
 	if (__gui_ret == 0) {						\
 		if ((__prefix >> 26) == OP_PREFIX) {			\
 			__gui_ret = gu_op(__suffix, __gui_ptr + 1);	\
-			__gui_inst = ppc_inst_prefix(__prefix,		\
-						     __suffix);		\
+			__gui_inst = ppc_inst_prefix(__prefix, __suffix); \
 		} else {						\
 			__gui_inst = ppc_inst(__prefix);		\
 		}							\
@@ -36,11 +35,9 @@
 })
 #endif /* CONFIG_PPC64 */
 
-#define get_user_instr(x, ptr) \
-	___get_user_instr(get_user, x, ptr)
+#define get_user_instr(x, ptr) ___get_user_instr(get_user, x, ptr)
 
-#define __get_user_instr(x, ptr) \
-	___get_user_instr(__get_user, x, ptr)
+#define __get_user_instr(x, ptr) ___get_user_instr(__get_user, x, ptr)
 
 /*
  * Instruction data type for POWER
@@ -75,13 +72,12 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
 
 static inline bool ppc_inst_prefixed(struct ppc_inst x)
 {
-	return (ppc_inst_primary_opcode(x) == 1) && ppc_inst_suffix(x) != 0xff;
+	return ppc_inst_primary_opcode(x) == OP_PREFIX && ppc_inst_suffix(x) != 0xff;
 }
 
 static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
 {
-	return ppc_inst_prefix(swab32(ppc_inst_val(x)),
-			       swab32(ppc_inst_suffix(x)));
+	return ppc_inst_prefix(swab32(ppc_inst_val(x)), swab32(ppc_inst_suffix(x)));
 }
 
 static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
-- 
2.25.0

