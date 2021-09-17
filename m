Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159CE40F9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241589AbhIQOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:00:07 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:55551 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245694AbhIQN7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:59:09 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H9wWV63PWz9sTL;
        Fri, 17 Sep 2021 15:57:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Vvp1TjPwSN4; Fri, 17 Sep 2021 15:57:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H9wWV5Bb0z9sT4;
        Fri, 17 Sep 2021 15:57:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9E7908B799;
        Fri, 17 Sep 2021 15:57:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gyuS0UJzf1no; Fri, 17 Sep 2021 15:57:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.36])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 514108B768;
        Fri, 17 Sep 2021 15:57:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18HDvWBM675083
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 15:57:32 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18HDvWBk675082;
        Fri, 17 Sep 2021 15:57:32 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/32: Don't use a struct based type for pte_t
Date:   Fri, 17 Sep 2021 15:57:31 +0200
Message-Id: <c904599f33aaf6bb7ee2836a9ff8368509e0d78d.1631887042.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Long time ago we had a config item called STRICT_MM_TYPECHECKS
to build the kernel with pte_t defined as a structure in order
to perform additional build checks or build it with pte_t
defined as a simple type in order to get simpler generated code.

Commit 670eea924198 ("powerpc/mm: Always use STRICT_MM_TYPECHECKS")
made the struct based definition the only one, considering that the
generated code was similar in both cases.

That's right on ppc64 because the ABI is such that the content of a
struct having a single simple type element is passed as register,
but on ppc32 such a structure is passed via the stack like any
structure.

Simple test function:

	pte_t test(pte_t pte)
	{
		return pte;
	}

Before this patch we get

	c00108ec <test>:
	c00108ec:	81 24 00 00 	lwz     r9,0(r4)
	c00108f0:	91 23 00 00 	stw     r9,0(r3)
	c00108f4:	4e 80 00 20 	blr

So, for PPC32, restore the simple type behaviour we got before
commit 670eea924198, but instead of adding a config option to
activate type check, do it when __CHECKER__ is set so that type
checking is performed by 'sparse' and provides feedback like:

	arch/powerpc/mm/pgtable.c:466:16: warning: incorrect type in return expression (different base types)
	arch/powerpc/mm/pgtable.c:466:16:    expected unsigned long
	arch/powerpc/mm/pgtable.c:466:16:    got struct pte_t [usertype] x

With this patch we now get

	c0010890 <test>:
	c0010890:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Properly handle 8xx 16k pages
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/pgtable-types.h     | 14 +++++++++++++-
 arch/powerpc/mm/pgtable.c                    |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index f06ae00f2a65..34ce50da1850 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -245,7 +245,7 @@ static int number_of_cells_per_pte(pmd_t *pmd, pte_basic_t val, int huge)
 static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, pte_t *p,
 				     unsigned long clr, unsigned long set, int huge)
 {
-	pte_basic_t *entry = &p->pte;
+	pte_basic_t *entry = (pte_basic_t *)p;
 	pte_basic_t old = pte_val(*p);
 	pte_basic_t new = (old & ~(pte_basic_t)clr) | set;
 	int num, i;
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index d11b4c61d686..c60199fc6fa6 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -5,14 +5,26 @@
 /* PTE level */
 #if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
 typedef struct { pte_basic_t pte, pte1, pte2, pte3; } pte_t;
-#else
+#elif defined(__CHECKER__) || !defined(CONFIG_PPC32)
 typedef struct { pte_basic_t pte; } pte_t;
+#else
+typedef pte_basic_t pte_t;
 #endif
+
+#if defined(__CHECKER__) || !defined(CONFIG_PPC32) || \
+    (defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES))
 #define __pte(x)	((pte_t) { (x) })
 static inline pte_basic_t pte_val(pte_t x)
 {
 	return x.pte;
 }
+#else
+#define __pte(x)	((pte_t)(x))
+static inline pte_basic_t pte_val(pte_t x)
+{
+	return x;
+}
+#endif
 
 /* PMD level */
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index cd16b407f47e..ce9482383144 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -271,7 +271,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_
 {
 	pmd_t *pmd = pmd_off(mm, addr);
 	pte_basic_t val;
-	pte_basic_t *entry = &ptep->pte;
+	pte_basic_t *entry = (pte_basic_t *)ptep;
 	int num, i;
 
 	/*
-- 
2.31.1

