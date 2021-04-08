Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C2358871
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhDHPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:31:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64278 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231866AbhDHPaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:30:39 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FGQFF0xmkz9txf4;
        Thu,  8 Apr 2021 17:30:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id YW0x8LnnTY2Y; Thu,  8 Apr 2021 17:30:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FGQFF0BY1z9txf2;
        Thu,  8 Apr 2021 17:30:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8761C8B7D1;
        Thu,  8 Apr 2021 17:30:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xe3z9x8d8du6; Thu,  8 Apr 2021 17:30:26 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3272F8B7D4;
        Thu,  8 Apr 2021 17:30:26 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0EDC7679BA; Thu,  8 Apr 2021 15:30:26 +0000 (UTC)
Message-Id: <3fa903eb5a10b2bc7d99a8c559ffdaa05452d8e0.1617895813.git.christophe.leroy@csgroup.eu>
In-Reply-To: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
References: <7bf6f1600acad146e541a4e220940062f2e5b03d.1617895813.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/9] powerpc/mem: Declare __flush_dcache_icache() static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  8 Apr 2021 15:30:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__flush_dcache_icache() is only used in mem.c.

Move it before the functions that use it and declare it static.

And also fix the name of the parameter in the comment.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cacheflush.h |  1 -
 arch/powerpc/mm/cacheflush.c          | 60 +++++++++++++--------------
 2 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/cacheflush.h b/arch/powerpc/include/asm/cacheflush.h
index f63495109f63..9110489ea411 100644
--- a/arch/powerpc/include/asm/cacheflush.h
+++ b/arch/powerpc/include/asm/cacheflush.h
@@ -40,7 +40,6 @@ void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 #define flush_icache_user_page flush_icache_user_page
 
 void flush_dcache_icache_page(struct page *page);
-void __flush_dcache_icache(void *page);
 
 /**
  * flush_dcache_range(): Write any modified data cache blocks out to memory and
diff --git a/arch/powerpc/mm/cacheflush.c b/arch/powerpc/mm/cacheflush.c
index 40613d2fda37..742d3e0fb12f 100644
--- a/arch/powerpc/mm/cacheflush.c
+++ b/arch/powerpc/mm/cacheflush.c
@@ -135,6 +135,36 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
+/**
+ * __flush_dcache_icache(): Flush a particular page from the data cache to RAM.
+ * Note: this is necessary because the instruction cache does *not*
+ * snoop from the data cache.
+ *
+ * @p: the address of the page to flush
+ */
+static void __flush_dcache_icache(void *p)
+{
+	unsigned long addr = (unsigned long)p;
+
+	if (flush_coherent_icache(addr))
+		return;
+
+	clean_dcache_range(addr, addr + PAGE_SIZE);
+
+	/*
+	 * We don't flush the icache on 44x. Those have a virtual icache and we
+	 * don't have access to the virtual address here (it's not the page
+	 * vaddr but where it's mapped in user space). The flushing of the
+	 * icache on these is handled elsewhere, when a change in the address
+	 * space occurs, before returning to user space.
+	 */
+
+	if (mmu_has_feature(MMU_FTR_TYPE_44x))
+		return;
+
+	invalidate_icache_range(addr, addr + PAGE_SIZE);
+}
+
 static void flush_dcache_icache_hugepage(struct page *page)
 {
 	int i;
@@ -178,36 +208,6 @@ void flush_dcache_icache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_icache_page);
 
-/**
- * __flush_dcache_icache(): Flush a particular page from the data cache to RAM.
- * Note: this is necessary because the instruction cache does *not*
- * snoop from the data cache.
- *
- * @page: the address of the page to flush
- */
-void __flush_dcache_icache(void *p)
-{
-	unsigned long addr = (unsigned long)p;
-
-	if (flush_coherent_icache(addr))
-		return;
-
-	clean_dcache_range(addr, addr + PAGE_SIZE);
-
-	/*
-	 * We don't flush the icache on 44x. Those have a virtual icache and we
-	 * don't have access to the virtual address here (it's not the page
-	 * vaddr but where it's mapped in user space). The flushing of the
-	 * icache on these is handled elsewhere, when a change in the address
-	 * space occurs, before returning to user space.
-	 */
-
-	if (mmu_has_feature(MMU_FTR_TYPE_44x))
-		return;
-
-	invalidate_icache_range(addr, addr + PAGE_SIZE);
-}
-
 void clear_user_page(void *page, unsigned long vaddr, struct page *pg)
 {
 	clear_page(page);
-- 
2.25.0

