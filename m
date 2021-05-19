Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156EA3891B3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354709AbhESOqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:46:01 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35235 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354572AbhESOpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:45:12 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FlbGD1vfGz9sWY;
        Wed, 19 May 2021 16:43:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RU-yWx7ZBIuV; Wed, 19 May 2021 16:43:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FlbGD10blz9sWQ;
        Wed, 19 May 2021 16:43:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F02BC8B7F5;
        Wed, 19 May 2021 16:43:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6Ysovq5ve9o7; Wed, 19 May 2021 16:43:31 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B4EC58B7E0;
        Wed, 19 May 2021 16:43:31 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8B78364C3A; Wed, 19 May 2021 14:43:31 +0000 (UTC)
Message-Id: <11041e7529ab4268f961e83ccf92040a0da961bf.1621435024.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1621435024.git.christophe.leroy@csgroup.eu>
References: <cover.1621435024.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 04/12] powerpc/inst: Avoid pointer dereferencing in
 ppc_inst_equal()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com, jniethe5@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 19 May 2021 14:43:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid casting/dereferencing ppc_inst() as u64* , check each member
of the struct when relevant.

And remove the 0xff initialisation of the suffix for non
prefixed instruction. An instruction with 0xff as a suffix
might be invalid, but still is a prefixed instruction and
has to be considered as this.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/inst.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index 17f74429d5d6..b49f11c69ed5 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -62,7 +62,7 @@ static inline int ppc_inst_primary_opcode(struct ppc_inst x)
 }
 
 #ifdef CONFIG_PPC64
-#define ppc_inst(x) ((struct ppc_inst){ .val = (x), .suffix = 0xff })
+#define ppc_inst(x) ((struct ppc_inst){ .val = (x) })
 
 #define ppc_inst_prefix(x, y) ((struct ppc_inst){ .val = (x), .suffix = (y) })
 
@@ -73,7 +73,7 @@ static inline u32 ppc_inst_suffix(struct ppc_inst x)
 
 static inline bool ppc_inst_prefixed(struct ppc_inst x)
 {
-	return ppc_inst_primary_opcode(x) == OP_PREFIX && ppc_inst_suffix(x) != 0xff;
+	return ppc_inst_primary_opcode(x) == OP_PREFIX;
 }
 
 static inline struct ppc_inst ppc_inst_swab(struct ppc_inst x)
@@ -94,11 +94,6 @@ static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
 	}
 }
 
-static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
-{
-	return *(u64 *)&x == *(u64 *)&y;
-}
-
 #else
 
 #define ppc_inst(x) ((struct ppc_inst){ .val = x })
@@ -125,13 +120,17 @@ static inline struct ppc_inst ppc_inst_read(const struct ppc_inst *ptr)
 	return *ptr;
 }
 
+#endif /* CONFIG_PPC64 */
+
 static inline bool ppc_inst_equal(struct ppc_inst x, struct ppc_inst y)
 {
-	return ppc_inst_val(x) == ppc_inst_val(y);
+	if (ppc_inst_val(x) != ppc_inst_val(y))
+		return false;
+	if (!ppc_inst_prefixed(x))
+		return true;
+	return ppc_inst_suffix(x) == ppc_inst_suffix(y);
 }
 
-#endif /* CONFIG_PPC64 */
-
 static inline int ppc_inst_len(struct ppc_inst x)
 {
 	return ppc_inst_prefixed(x) ? 8 : 4;
-- 
2.25.0

