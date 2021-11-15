Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D024500D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhKOJJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:09:13 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:54229 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237697AbhKOJIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:08:51 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Ht3Fb4jLKz9sSH;
        Mon, 15 Nov 2021 10:05:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 23Jkjqa8PDsV; Mon, 15 Nov 2021 10:05:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Ht3Fb3Ts8z9sSB;
        Mon, 15 Nov 2021 10:05:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 631328B767;
        Mon, 15 Nov 2021 10:05:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vYt0LtQYyl6m; Mon, 15 Nov 2021 10:05:55 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4092D8B763;
        Mon, 15 Nov 2021 10:05:55 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 1AF95jiL136901
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 10:05:45 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 1AF95jhV136900;
        Mon, 15 Nov 2021 10:05:45 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] powerpc/book3e: Fix TLBCAM preset at boot
Date:   Mon, 15 Nov 2021 10:05:32 +0100
Message-Id: <d319f2a9367d4d08fd2154e506101bd5f100feeb.1636967119.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1636967130; l=2048; s=20211009; h=from:subject:message-id; bh=UkVSGT3r0lZYtsOemswUnqSkhTNjQKOQEhjWVTHKcoY=; b=8aZCsj5qx3yqs8pm5bTdJlxec2S/WaewNn8VpChIp91Dq0ejGnqCK3vY/gKfU/cg6oRPYKsFaIEL Tvd5OowBDD4qJaSlagvZn8Sxia6cy7PKKLLHhbe7XP61ljJck8V/
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 52bda69ae8b5 ("powerpc/fsl_booke: Tell map_mem_in_cams() if
init is done") was supposed to just add an additional parameter to
map_mem_in_cams() and always set it to 'true' at that time.

But a few call sites were messed up. Fix them.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Fixes: 52bda69ae8b5 ("powerpc/fsl_booke: Tell map_mem_in_cams() if init is done")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/kaslr_booke.c | 2 +-
 arch/powerpc/mm/nohash/tlb.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/nohash/kaslr_booke.c b/arch/powerpc/mm/nohash/kaslr_booke.c
index 8fc49b1b4a91..6ec978967da0 100644
--- a/arch/powerpc/mm/nohash/kaslr_booke.c
+++ b/arch/powerpc/mm/nohash/kaslr_booke.c
@@ -314,7 +314,7 @@ static unsigned long __init kaslr_choose_location(void *dt_ptr, phys_addr_t size
 		pr_warn("KASLR: No safe seed for randomizing the kernel base.\n");
 
 	ram = min_t(phys_addr_t, __max_low_memory, size);
-	ram = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, true, false);
+	ram = map_mem_in_cams(ram, CONFIG_LOWMEM_CAM_NUM, true, true);
 	linear_sz = min_t(unsigned long, ram, SZ_512M);
 
 	/* If the linear size is smaller than 64M, do not randmize */
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 89353d4f5604..647bf454a0fa 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -645,7 +645,7 @@ static void early_init_this_mmu(void)
 
 		if (map)
 			linear_map_top = map_mem_in_cams(linear_map_top,
-							 num_cams, true, true);
+							 num_cams, false, true);
 	}
 #endif
 
@@ -766,7 +766,7 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
 
 		linear_sz = map_mem_in_cams(first_memblock_size, num_cams,
-					    false, true);
+					    true, true);
 
 		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
 	} else
-- 
2.31.1

