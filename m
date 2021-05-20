Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A438B07F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241456AbhETNxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:53:11 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235053AbhETNwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:52:54 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FmB34138bz9sT8;
        Thu, 20 May 2021 15:50:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zsyqIHuVtvHF; Thu, 20 May 2021 15:50:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FmB2t4pkfz9sTW;
        Thu, 20 May 2021 15:50:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D9F08B815;
        Thu, 20 May 2021 15:50:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id E7wjcO-zgxc6; Thu, 20 May 2021 15:50:46 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66E8C8B767;
        Thu, 20 May 2021 15:50:46 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 5C16B64C40; Thu, 20 May 2021 13:50:46 +0000 (UTC)
Message-Id: <d54c63dcac6d190e1cc0d2fe3259d6e621928cdf.1621516826.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621516826.git.christophe.leroy@csgroup.eu>
References: <cover.1621516826.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 09/12] powerpc/inst: Refactor PPC32 and PPC64 versions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 20 May 2021 13:50:46 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc_inst() ppc_inst_prefixed() ppc_inst_swab() can easily
be made common to both PPC32 and PPC64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h | 49 +++++++++------------------------
 1 file changed, 13 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 32d318c3b180..e009e94e90b2 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -60,9 +60,9 @@ static inline int ppc_inst_primary_opcode(struct ppc_inst x)
 	return ppc_inst_val(x) >> 26;
 }
 
-#ifdef CONFIG_PPC64
 #define ppc_inst(x) ((struct ppc_inst){ .val = (x) })
 
+#ifdef CONFIG_PPC64
 #define ppc_inst_prefix(x, y) ((struct ppc_inst){ .val = (x), .suffix = (y) })
 
 static inline u32 ppc_inst_suffix(struct ppc_inst x)
@@ -70,57 +70,34 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
 	return x.suffix;
 }
 
-static inline bool ppc_inst_prefixed(struct ppc_inst x)
-{
-	return ppc_inst_primary_opcode(x) == OP_PREFIX;
-}
+#else
+#define ppc_inst_prefix(x, y) ppc_inst(x)
 
-static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
+static inline u32 ppc_inst_suffix(struct ppc_inst x)
 {
-	return ppc_inst_prefix(swab32(ppc_inst_val(x)), swab32(ppc_inst_suffix(x)));
+	return 0;
 }
 
+#endif /* CONFIG_PPC64 */
+
 static inline struct ppc_inst ppc_inst_read(const unsigned int *ptr)
 {
-	u32 val, suffix;
-
-	val = *ptr;
-	if ((val >> 26) == OP_PREFIX) {
-		suffix = *(ptr + 1);
-		return ppc_inst_prefix(val, suffix);
-	} else {
-		return ppc_inst(val);
-	}
+	if (IS_ENABLED(CONFIG_PPC64) && (*ptr >> 26) == OP_PREFIX)
+		return ppc_inst_prefix(*ptr, *(ptr + 1));
+	else
+		return ppc_inst(*ptr);
 }
 
-#else
-
-#define ppc_inst(x) ((struct ppc_inst){ .val = x })
-
-#define ppc_inst_prefix(x, y) ppc_inst(x)
-
 static inline bool ppc_inst_prefixed(struct ppc_inst x)
 {
-	return false;
-}
-
-static inline u32 ppc_inst_suffix(struct ppc_inst x)
-{
-	return 0;
+	return IS_ENABLED(CONFIG_PPC64) && ppc_inst_primary_opcode(x) == OP_PREFIX;
 }
 
 static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
 {
-	return ppc_inst(swab32(ppc_inst_val(x)));
-}
-
-static inline struct ppc_inst ppc_inst_read(const unsigned int *ptr)
-{
-	return ppc_inst(*ptr);
+	return ppc_inst_prefix(swab32(ppc_inst_val(x)), swab32(ppc_inst_suffix(x)));
 }
 
-#endif /* CONFIG_PPC64 */
-
 static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
 {
 	if (ppc_inst_val(x) != ppc_inst_val(y))
-- 
2.25.0

