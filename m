Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869F03760D9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbhEGHEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:04:31 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58997 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235072AbhEGHE2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:04:28 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fc1ck5k6Dz9sZW;
        Fri,  7 May 2021 09:03:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U3k5b2q0CRK9; Fri,  7 May 2021 09:03:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fc1cj0fjsz9sZQ;
        Fri,  7 May 2021 09:03:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B293F8B81A;
        Fri,  7 May 2021 09:03:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id g3WkuwK_Hg4C; Fri,  7 May 2021 09:03:16 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 533F48B764;
        Fri,  7 May 2021 09:03:16 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 32C1964909; Fri,  7 May 2021 07:03:16 +0000 (UTC)
Message-Id: <7192b82166cf45a20493c2f03e19789db7b5949f.1620370984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
References: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 5/5] powerpc/32s: Simplify calculation of segment register
 content
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 May 2021 07:03:16 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

segment register has VSID on bits 8-31.
Bits 4-7 are reserved, there is no requirement to set them to 0.

VSIDs are calculated from VSID of SR0 by adding 0x111.

Even with highest possible VSID which would be 0xFFFFF0,
adding 16 times 0x111 results in 0x1001100.

So, the reserved bits are never overflowed, no need to clear
the reserved bits after each calculation.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 37 ++++++++++---------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index cc0284bbac86..6f83dbfc7cfa 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -105,28 +105,31 @@ extern s32 patch__flush_hash_B;
 #include <asm/reg.h>
 #include <asm/task_size_32.h>
 
-#define UPDATE_TWO_USER_SEGMENTS(n) do {		\
+#define UPDATE_USER_SEGMENT(n, val) do {		\
 	if (TASK_SIZE > ((n) << 28))			\
-		mtsr(val1, (n) << 28);			\
-	if (TASK_SIZE > (((n) + 1) << 28))		\
-		mtsr(val2, ((n) + 1) << 28);		\
-	val1 = (val1 + 0x222) & 0xf0ffffff;		\
-	val2 = (val2 + 0x222) & 0xf0ffffff;		\
+		mtsr(val + (n) * 0x111, (n) << 28);	\
 } while (0)
 
 static __always_inline void update_user_segments(u32 val)
 {
-	int val1 = val;
-	int val2 = (val + 0x111) & 0xf0ffffff;
-
-	UPDATE_TWO_USER_SEGMENTS(0);
-	UPDATE_TWO_USER_SEGMENTS(2);
-	UPDATE_TWO_USER_SEGMENTS(4);
-	UPDATE_TWO_USER_SEGMENTS(6);
-	UPDATE_TWO_USER_SEGMENTS(8);
-	UPDATE_TWO_USER_SEGMENTS(10);
-	UPDATE_TWO_USER_SEGMENTS(12);
-	UPDATE_TWO_USER_SEGMENTS(14);
+	val &= 0xf0ffffff;
+
+	UPDATE_USER_SEGMENT(0, val);
+	UPDATE_USER_SEGMENT(1, val);
+	UPDATE_USER_SEGMENT(2, val);
+	UPDATE_USER_SEGMENT(3, val);
+	UPDATE_USER_SEGMENT(4, val);
+	UPDATE_USER_SEGMENT(5, val);
+	UPDATE_USER_SEGMENT(6, val);
+	UPDATE_USER_SEGMENT(7, val);
+	UPDATE_USER_SEGMENT(8, val);
+	UPDATE_USER_SEGMENT(9, val);
+	UPDATE_USER_SEGMENT(10, val);
+	UPDATE_USER_SEGMENT(11, val);
+	UPDATE_USER_SEGMENT(12, val);
+	UPDATE_USER_SEGMENT(13, val);
+	UPDATE_USER_SEGMENT(14, val);
+	UPDATE_USER_SEGMENT(15, val);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.25.0

