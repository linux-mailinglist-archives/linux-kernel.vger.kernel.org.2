Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F442357300
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347825AbhDGRWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:22:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:26196 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229845AbhDGRWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:22:46 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FFrn55lxRzB09ZL;
        Wed,  7 Apr 2021 19:22:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Xl5J5gFclfmx; Wed,  7 Apr 2021 19:22:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FFrn54pckz9v3fh;
        Wed,  7 Apr 2021 19:22:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 45AFC8B75F;
        Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xw1ramYXneey; Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0B8558B7B6;
        Wed,  7 Apr 2021 19:22:35 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9CADD6799B; Wed,  7 Apr 2021 17:22:34 +0000 (UTC)
Message-Id: <311235752428dacbee81728767aacc2bf4222384.1617816138.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/8] powerpc/mem: Declare __flush_dcache_icache() static
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  7 Apr 2021 17:22:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__flush_dcache_icache() is only used in mem.c.

Declare it static.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/cacheflush.h | 1 -
 arch/powerpc/mm/mem.c                 | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 7a59a5c9aa5d..ce6c81ce4362 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -472,6 +472,8 @@ void flush_dcache_page(struct page *page)
 }
 EXPORT_SYMBOL(flush_dcache_page);
 
+static void __flush_dcache_icache(void *p);
+
 static void flush_dcache_icache_hugepage(struct page *page)
 {
 	int i;
@@ -522,7 +524,7 @@ EXPORT_SYMBOL(flush_dcache_icache_page);
  *
  * @page: the address of the page to flush
  */
-void __flush_dcache_icache(void *p)
+static void __flush_dcache_icache(void *p)
 {
 	unsigned long addr = (unsigned long)p;
 
-- 
2.25.0

