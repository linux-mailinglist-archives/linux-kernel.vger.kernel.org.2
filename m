Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514D53760D6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 09:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhEGHEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 03:04:25 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58997 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233451AbhEGHEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 03:04:21 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fc1cg1pnjz9sZV;
        Fri,  7 May 2021 09:03:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Ik4jigzwzjW; Fri,  7 May 2021 09:03:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fc1cg0qqVz9sZQ;
        Fri,  7 May 2021 09:03:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B64FB8B81A;
        Fri,  7 May 2021 09:03:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QX5DQUaCmmKM; Fri,  7 May 2021 09:03:14 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 49FAE8B764;
        Fri,  7 May 2021 09:03:14 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2583764909; Fri,  7 May 2021 07:03:14 +0000 (UTC)
Message-Id: <794ec59dc94cbc35a1ff0b11100f152e3af05634.1620370984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
References: <9c5f23642ac5900c8e83da795afac7041bf87cf6.1620370984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 3/5] powerpc/32s: Refactor update of user segment registers
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  7 May 2021 07:03:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUEP implements the update of user segment registers.

Move it into mmu-hash.h in order to use it from other places.

And inline kuep_lock() and kuep_unlock() and remove kuep.c
inlining kuep_lock() is important for system_call_exception(),
otherwise system_call_exception() has to save into stack the
system call parameters that are used just after, and doing
that takes more instructions than kuep_lock() itself.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/mmu-hash.h | 27 +++++++++++++
 arch/powerpc/include/asm/kup.h                | 11 ++++-
 arch/powerpc/mm/book3s32/Makefile             |  1 -
 arch/powerpc/mm/book3s32/kuep.c               | 40 -------------------
 4 files changed, 36 insertions(+), 43 deletions(-)
 delete mode 100644 arch/powerpc/mm/book3s32/kuep.c

diff --git a/arch/powerpc/include/asm/book3s/32/mmu-hash.h b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
index b85f8e114a9c..cc0284bbac86 100644
--- a/arch/powerpc/include/asm/book3s/32/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/32/mmu-hash.h
@@ -102,6 +102,33 @@ extern s32 patch__hash_page_B, patch__hash_page_C;
 extern s32 patch__flush_hash_A0, patch__flush_hash_A1, patch__flush_hash_A2;
 extern s32 patch__flush_hash_B;
 
+#include <asm/reg.h>
+#include <asm/task_size_32.h>
+
+#define UPDATE_TWO_USER_SEGMENTS(n) do {		\
+	if (TASK_SIZE > ((n) << 28))			\
+		mtsr(val1, (n) << 28);			\
+	if (TASK_SIZE > (((n) + 1) << 28))		\
+		mtsr(val2, ((n) + 1) << 28);		\
+	val1 = (val1 + 0x222) & 0xf0ffffff;		\
+	val2 = (val2 + 0x222) & 0xf0ffffff;		\
+} while (0)
+
+static __always_inline void update_user_segments(u32 val)
+{
+	int val1 = val;
+	int val2 = (val + 0x111) & 0xf0ffffff;
+
+	UPDATE_TWO_USER_SEGMENTS(0);
+	UPDATE_TWO_USER_SEGMENTS(2);
+	UPDATE_TWO_USER_SEGMENTS(4);
+	UPDATE_TWO_USER_SEGMENTS(6);
+	UPDATE_TWO_USER_SEGMENTS(8);
+	UPDATE_TWO_USER_SEGMENTS(10);
+	UPDATE_TWO_USER_SEGMENTS(12);
+	UPDATE_TWO_USER_SEGMENTS(14);
+}
+
 #endif /* !__ASSEMBLY__ */
 
 /* We happily ignore the smaller BATs on 601, we don't actually use
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index ec96232529ac..1da9fed5c321 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -47,8 +47,15 @@ static inline void setup_kuep(bool disabled) { }
 #endif /* CONFIG_PPC_KUEP */
 
 #if defined(CONFIG_PPC_KUEP) && defined(CONFIG_PPC_BOOK3S_32)
-void kuep_lock(void);
-void kuep_unlock(void);
+static inline void kuep_lock(void)
+{
+	update_user_segments(mfsr(0) | SR_NX);
+}
+
+static inline void kuep_unlock(void)
+{
+	update_user_segments(mfsr(0) & ~SR_NX);
+}
 #else
 static inline void kuep_lock(void) { }
 static inline void kuep_unlock(void) { }
diff --git a/arch/powerpc/mm/book3s32/Makefile b/arch/powerpc/mm/book3s32/Makefile
index 7f0c8a78ba0c..446d9de88ce4 100644
--- a/arch/powerpc/mm/book3s32/Makefile
+++ b/arch/powerpc/mm/book3s32/Makefile
@@ -9,4 +9,3 @@ endif
 obj-y += mmu.o mmu_context.o
 obj-$(CONFIG_PPC_BOOK3S_603) += nohash_low.o
 obj-$(CONFIG_PPC_BOOK3S_604) += hash_low.o tlb.o
-obj-$(CONFIG_PPC_KUEP) += kuep.o
diff --git a/arch/powerpc/mm/book3s32/kuep.c b/arch/powerpc/mm/book3s32/kuep.c
deleted file mode 100644
index 8ed1b8634839..000000000000
--- a/arch/powerpc/mm/book3s32/kuep.c
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-
-#include <asm/kup.h>
-#include <asm/reg.h>
-#include <asm/task_size_32.h>
-#include <asm/mmu.h>
-
-#define KUEP_UPDATE_TWO_USER_SEGMENTS(n) do {		\
-	if (TASK_SIZE > ((n) << 28))			\
-		mtsr(val1, (n) << 28);			\
-	if (TASK_SIZE > (((n) + 1) << 28))		\
-		mtsr(val2, ((n) + 1) << 28);		\
-	val1 = (val1 + 0x222) & 0xf0ffffff;		\
-	val2 = (val2 + 0x222) & 0xf0ffffff;		\
-} while (0)
-
-static __always_inline void kuep_update(u32 val)
-{
-	int val1 = val;
-	int val2 = (val + 0x111) & 0xf0ffffff;
-
-	KUEP_UPDATE_TWO_USER_SEGMENTS(0);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(2);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(4);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(6);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(8);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(10);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(12);
-	KUEP_UPDATE_TWO_USER_SEGMENTS(14);
-}
-
-void kuep_lock(void)
-{
-	kuep_update(mfsr(0) | SR_NX);
-}
-
-void kuep_unlock(void)
-{
-	kuep_update(mfsr(0) & ~SR_NX);
-}
-- 
2.25.0

