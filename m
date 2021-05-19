Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174C53891B1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354633AbhESOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:45:56 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35235 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354565AbhESOpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:45:10 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FlbGC1h2Fz9sWX;
        Wed, 19 May 2021 16:43:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u8KA2KZPhzEv; Wed, 19 May 2021 16:43:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbGC0mbVz9sWQ;
        Wed, 19 May 2021 16:43:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F06D98B7F5;
        Wed, 19 May 2021 16:43:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id sfXrpm0gtMym; Wed, 19 May 2021 16:43:30 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A7B808B7E0;
        Wed, 19 May 2021 16:43:30 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 81BE964C3A; Wed, 19 May 2021 14:43:30 +0000 (UTC)
Message-Id: <150c2bd4fb197e1b769ce95780586d9d2948dfc6.1621435024.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621435024.git.christophe.leroy@csgroup.eu>
References: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 03/12] powerpc/inst: Improve readability of
 get_user_instr() and friends
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 19 May 2021 14:43:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use get_op() instead of open coding, and remove unneeded line splits.

And remove unneeded local variable initialisation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 57c31e712e67..17f74429d5d6 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -3,12 +3,13 @@
 #define _ASM_POWERPC_INST_H
 
 #include <asm/ppc-opcode.h>
+#include <asm/disassemble.h>
 
 #ifdef CONFIG_PPC64
 
 #define ___get_user_instr(gu_op, dest, ptr)				\
 ({									\
-	long __gui_ret = 0;						\
+	long __gui_ret;							\
 	unsigned int __user *__gui_ptr = (unsigned int __user *)ptr;	\
 	struct ppc_inst __gui_inst;					\
 	unsigned int __prefix, __suffix;				\
@@ -16,10 +17,9 @@
 	__chk_user_ptr(ptr);						\
 	__gui_ret = gu_op(__prefix, __gui_ptr);				\
 	if (__gui_ret == 0) {						\
-		if ((__prefix >> 26) == OP_PREFIX) {			\
+		if (get_op(__prefix) == OP_PREFIX) {			\
 			__gui_ret = gu_op(__suffix, __gui_ptr + 1);	\
-			__gui_inst = ppc_inst_prefix(__prefix,		\
-						     __suffix);		\
+			__gui_inst = ppc_inst_prefix(__prefix, __suffix); \
 		} else {						\
 			__gui_inst = ppc_inst(__prefix);		\
 		}							\
@@ -36,11 +36,9 @@
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
@@ -60,7 +58,7 @@ static inline u32 ppc_inst_val(struct ppc_inst x)
 
 static inline int ppc_inst_primary_opcode(struct ppc_inst x)
 {
-	return ppc_inst_val(x) >> 26;
+	return get_op(ppc_inst_val(x));
 }
 
 #ifdef CONFIG_PPC64
@@ -75,13 +73,12 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
 
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
@@ -89,7 +86,7 @@ static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
 	u32 val, suffix;
 
 	val = *(u32 *)ptr;
-	if ((val >> 26) == OP_PREFIX) {
+	if (get_op(val) == OP_PREFIX) {
 		suffix = *((u32 *)ptr + 1);
 		return ppc_inst_prefix(val, suffix);
 	} else {
-- 
2.25.0

