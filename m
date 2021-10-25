Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9139643A628
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhJYVwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 17:52:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42243 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhJYVwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:52:34 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4HdTBf2xv1z9s2N;
        Mon, 25 Oct 2021 23:49:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6LZY9ZqoPQxH; Mon, 25 Oct 2021 23:49:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.117])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by pegase1.c-s.fr (Postfix) with ESMTPS id 4HdTBb51tkz9s2h;
        Mon, 25 Oct 2021 23:49:43 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 19PLnAJ9007255
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 Oct 2021 23:49:12 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 19PLiVaF007026;
        Mon, 25 Oct 2021 23:44:31 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 02/10] powerpc/book3e: Fix set_memory_x() and set_memory_nx()
Date:   Mon, 25 Oct 2021 23:44:14 +0200
Message-Id: <2379d6769c4ca7328ed6ea7bb6776efa1e10bd34.1635198209.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <f34898e2edb21db1bcb1c9a96ac7433a141d50c2.1635198209.git.christophe.leroy@csgroup.eu>
References: <f34898e2edb21db1bcb1c9a96ac7433a141d50c2.1635198209.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1635198260; l=6098; s=20211009; h=from:subject:message-id; bh=+JF61Ce6JHyRyIeD9UAFSFok133pa1B8BEDmy6vM+As=; b=cfFmvXKaXBeVIXVZbgEdVDCfBhpg2+4QGbmZZKn3cyv5Gu3qu2kh9YI6zrke46FeC157St0bZa11 G3QcMAiNCcDom+UMkXmi6ONMqB3yY/POunRz0U96Gz9wNxn6YG0Q
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_memory_x() calls pte_mkexec() which sets _PAGE_EXEC.
set_memory_nx() calls pte_exprotec() which clears _PAGE_EXEC.

Book3e has 2 bits, UX and SX, which defines the exec rights
resp. for user (PR=1) and for kernel (PR=0).

_PAGE_EXEC is defined as UX only.

An executable kernel page is set with either _PAGE_KERNEL_RWX
or _PAGE_KERNEL_ROX, which both have SX set and UX cleared.

So set_memory_nx() call for an executable kernel page does
nothing because UX is already cleared.

And set_memory_x() on a non-executable kernel page makes it
executable for the user and keeps it non-executable for kernel.

Also, pte_exec() always returns 'false' on kernel pages, because
it checks _PAGE_EXEC which doesn't include SX, so for instance
the W+X check doesn't work.

To fix this:
- change tlb_low_64e.S to use _PAGE_BAP_UX instead of _PAGE_USER
- sets both UX and SX in _PAGE_EXEC so that pte_user() returns
true whenever one of the two bits is set and pte_exprotect()
clears both bits.
- Define a book3e specific version of pte_mkexec() which sets
either SX or UX based on UR.

Fixes: 1f9ad21c3b38 ("powerpc/mm: Implement set_memory() routines")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v3: Removed pte_mkexec() from nohash/64/pgtable.h
v2: New
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  5 -----
 arch/powerpc/include/asm/nohash/pte-book3e.h | 18 ++++++++++++++----
 arch/powerpc/mm/nohash/tlb_low_64e.S         |  8 ++++----
 4 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index ac0a5ff48c3a..d6ba821a56ce 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -193,10 +193,12 @@ static inline pte_t pte_wrprotect(pte_t pte)
 }
 #endif
 
+#ifndef pte_mkexec
 static inline pte_t pte_mkexec(pte_t pte)
 {
 	return __pte(pte_val(pte) | _PAGE_EXEC);
 }
+#endif
 
 #define pmd_none(pmd)		(!pmd_val(pmd))
 #define	pmd_bad(pmd)		(pmd_val(pmd) & _PMD_BAD)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index d081704b13fb..9d2905a47410 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -118,11 +118,6 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~_PAGE_RW);
 }
 
-static inline pte_t pte_mkexec(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_EXEC);
-}
-
 #define PMD_BAD_BITS		(PTE_TABLE_SIZE-1)
 #define PUD_BAD_BITS		(PMD_TABLE_SIZE-1)
 
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 813918f40765..f798640422c2 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -48,7 +48,7 @@
 #define _PAGE_WRITETHRU	0x800000 /* W: cache write-through */
 
 /* "Higher level" linux bit combinations */
-#define _PAGE_EXEC		_PAGE_BAP_UX /* .. and was cache cleaned */
+#define _PAGE_EXEC		(_PAGE_BAP_SX | _PAGE_BAP_UX) /* .. and was cache cleaned */
 #define _PAGE_RW		(_PAGE_BAP_SW | _PAGE_BAP_UW) /* User write permission */
 #define _PAGE_KERNEL_RW		(_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY)
 #define _PAGE_KERNEL_RO		(_PAGE_BAP_SR)
@@ -93,11 +93,11 @@
 /* Permission masks used to generate the __P and __S table */
 #define PAGE_NONE	__pgprot(_PAGE_BASE)
 #define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW)
-#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_EXEC)
+#define PAGE_SHARED_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_RW | _PAGE_BAP_UX)
 #define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_BAP_UX)
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
-#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
+#define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_BAP_UX)
 
 #ifndef __ASSEMBLY__
 static inline pte_t pte_mkprivileged(pte_t pte)
@@ -113,6 +113,16 @@ static inline pte_t pte_mkuser(pte_t pte)
 }
 
 #define pte_mkuser pte_mkuser
+
+static inline pte_t pte_mkexec(pte_t pte)
+{
+	if (pte_val(pte) & _PAGE_BAP_UR)
+		return __pte((pte_val(pte) & ~_PAGE_BAP_SX) | _PAGE_BAP_UX);
+	else
+		return __pte((pte_val(pte) & ~_PAGE_BAP_UX) | _PAGE_BAP_SX);
+}
+#define pte_mkexec pte_mkexec
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/nohash/tlb_low_64e.S b/arch/powerpc/mm/nohash/tlb_low_64e.S
index bf24451f3e71..9235e720e357 100644
--- a/arch/powerpc/mm/nohash/tlb_low_64e.S
+++ b/arch/powerpc/mm/nohash/tlb_low_64e.S
@@ -222,7 +222,7 @@ tlb_miss_kernel_bolted:
 
 tlb_miss_fault_bolted:
 	/* We need to check if it was an instruction miss */
-	andi.	r10,r11,_PAGE_EXEC|_PAGE_BAP_SX
+	andi.	r10,r11,_PAGE_BAP_UX|_PAGE_BAP_SX
 	bne	itlb_miss_fault_bolted
 dtlb_miss_fault_bolted:
 	tlb_epilog_bolted
@@ -239,7 +239,7 @@ itlb_miss_fault_bolted:
 	srdi	r15,r16,60		/* get region */
 	bne-	itlb_miss_fault_bolted
 
-	li	r11,_PAGE_PRESENT|_PAGE_EXEC	/* Base perm */
+	li	r11,_PAGE_PRESENT|_PAGE_BAP_UX	/* Base perm */
 
 	/* We do the user/kernel test for the PID here along with the RW test
 	 */
@@ -614,7 +614,7 @@ itlb_miss_fault_e6500:
 
 	/* We do the user/kernel test for the PID here along with the RW test
 	 */
-	li	r11,_PAGE_PRESENT|_PAGE_EXEC	/* Base perm */
+	li	r11,_PAGE_PRESENT|_PAGE_BAP_UX	/* Base perm */
 	oris	r11,r11,_PAGE_ACCESSED@h
 
 	cmpldi	cr0,r15,0			/* Check for user region */
@@ -734,7 +734,7 @@ normal_tlb_miss_done:
 
 normal_tlb_miss_access_fault:
 	/* We need to check if it was an instruction miss */
-	andi.	r10,r11,_PAGE_EXEC
+	andi.	r10,r11,_PAGE_BAP_UX
 	bne	1f
 	ld	r14,EX_TLB_DEAR(r12)
 	ld	r15,EX_TLB_ESR(r12)
-- 
2.31.1

