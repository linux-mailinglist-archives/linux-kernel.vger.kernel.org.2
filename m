Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8863D4181E4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Sep 2021 14:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244991AbhIYM0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 08:26:08 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:46137 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244901AbhIYM0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 08:26:06 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HGp4D4DHxz9sWB;
        Sat, 25 Sep 2021 14:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1DwdK34FIWs6; Sat, 25 Sep 2021 14:24:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HGp4C2Wv2z9sW6;
        Sat, 25 Sep 2021 14:24:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 439E38B76D;
        Sat, 25 Sep 2021 14:24:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OcVrmQgfaN-d; Sat, 25 Sep 2021 14:24:27 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.8])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A00B8B763;
        Sat, 25 Sep 2021 14:24:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18P8VmQ81326004
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 25 Sep 2021 10:31:49 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18P8VmZP1326003;
        Sat, 25 Sep 2021 10:31:48 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 3/3] powerpc: Remove init_mem_is_free
Date:   Sat, 25 Sep 2021 10:31:44 +0200
Message-Id: <285bdad6b27146a4fc7237eefa7227b14b8366e0.1632558672.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632558672.git.christophe.leroy@csgroup.eu>
References: <a7a35416ddab4b42617e2c81fe5816c7f8d0c63f.1632558672.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_mem_is_free is not used anymore. Remove it.

Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/setup.h | 1 -
 arch/powerpc/mm/mem.c            | 2 --
 2 files changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 6c1a7d217d1a..426a2d8d028f 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -9,7 +9,6 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
-extern bool init_mem_is_free;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 struct device_node;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index c3c4e31462ec..5b1eae6c0356 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -26,7 +26,6 @@
 #include <mm/mmu_decl.h>
 
 unsigned long long memory_limit;
-bool init_mem_is_free;
 
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
@@ -312,7 +311,6 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	mark_initmem_nx();
-	init_mem_is_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-- 
2.31.1

