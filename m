Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370DC35730C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354840AbhDGRW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:22:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:21301 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354797AbhDGRWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FFrnD5tF4zB09Zd;
        Wed,  7 Apr 2021 19:22:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ARjndTOPdYxl; Wed,  7 Apr 2021 19:22:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FFrnD530bzB09ZS;
        Wed,  7 Apr 2021 19:22:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 66EE08B7B6;
        Wed,  7 Apr 2021 19:22:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id H3O39hLoOR4i; Wed,  7 Apr 2021 19:22:42 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1BC388B75F;
        Wed,  7 Apr 2021 19:22:42 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F062B6799B; Wed,  7 Apr 2021 17:22:41 +0000 (UTC)
Message-Id: <0838c473de92bc87826710cc2a35e0f05c98bbd9.1617816138.git.christophe.leroy@csgroup.eu>
In-Reply-To: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
References: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 8/8] powerpc/mem: Use kmap_local_page() in flushing
 functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  7 Apr 2021 17:22:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flushing functions don't rely on preemption being disabled, so
use kmap_local_page() instead of kmap_atomic().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 65b2205839fe..1895bd64191a 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -464,16 +464,16 @@ static void flush_dcache_icache_hugepage(struct page *page)
 {
 	int i;
 	int nr = compound_nr(page);
-	void *start;
 
 	if (!PageHighMem(page)) {
 		for (i = 0; i < nr; i++)
 			__flush_dcache_icache(lowmem_page_address(page + i));
 	} else {
 		for (i = 0; i < nr; i++) {
-			start = kmap_atomic(page+i);
+			void *start = kmap_local_page(page + i);
+
 			__flush_dcache_icache(start);
-			kunmap_atomic(start);
+			kunmap_local(start);
 		}
 	}
 }
@@ -489,9 +489,10 @@ void flush_dcache_icache_page(struct page *page)
 	if (!PageHighMem(page)) {
 		__flush_dcache_icache(lowmem_page_address(page));
 	} else if (IS_ENABLED(CONFIG_BOOKE) || sizeof(phys_addr_t) > sizeof(void *)) {
-		void *start = kmap_atomic(page);
+		void *start = kmap_local_page(page);
+
 		__flush_dcache_icache(start);
-		kunmap_atomic(start);
+		kunmap_local(start);
 	} else {
 		flush_dcache_icache_phys(page_to_phys(page));
 	}
@@ -564,11 +565,11 @@ void copy_user_page(void *vto, void *vfrom, unsigned long vaddr,
 void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 			     unsigned long addr, int len)
 {
-	unsigned long maddr;
+	void *maddr;
 
-	maddr = (unsigned long) kmap(page) + (addr & ~PAGE_MASK);
-	flush_icache_range(maddr, maddr + len);
-	kunmap(page);
+	maddr = kmap_local_page(page) + (addr & ~PAGE_MASK);
+	flush_icache_range((unsigned long)maddr, (unsigned long)maddr + len);
+	kunmap_local(maddr);
 }
 
 /*
-- 
2.25.0

