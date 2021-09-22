Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E19414AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhIVNjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:39:07 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:47407 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhIVNjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:39:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HDzqx2Yttz9sSc;
        Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zfoYlC92YagZ; Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HDzqx1ck8z9sSS;
        Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 22C1E8B775;
        Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5nqDyEowOTTE; Wed, 22 Sep 2021 15:37:33 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC4A98B763;
        Wed, 22 Sep 2021 15:37:32 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1) with ESMTPS id 18MDbN9V1129358
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 15:37:23 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.16.1/8.16.1/Submit) id 18MDbM631129357;
        Wed, 22 Sep 2021 15:37:22 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/breakpoint: Cleanup
Date:   Wed, 22 Sep 2021 15:37:18 +0200
Message-Id: <6184b08088312a7d787d450eb902584e4ae77f7a.1632317816.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cache_op_size() does exactly the same as l1_dcache_bytes().

Remove it.

MSR_64BIT already exists, no need to enclode the check
around #ifdef __powerpc64__

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/hw_breakpoint_constraints.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint_constraints.c b/arch/powerpc/kernel/hw_breakpoint_constraints.c
index 675d1f66ab72..42b967e3d85c 100644
--- a/arch/powerpc/kernel/hw_breakpoint_constraints.c
+++ b/arch/powerpc/kernel/hw_breakpoint_constraints.c
@@ -127,15 +127,6 @@ bool wp_check_constraints(struct pt_regs *regs, struct ppc_inst instr,
 	return false;
 }
 
-static int cache_op_size(void)
-{
-#ifdef __powerpc64__
-	return ppc64_caches.l1d.block_size;
-#else
-	return L1_CACHE_BYTES;
-#endif
-}
-
 void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 			 int *type, int *size, unsigned long *ea)
 {
@@ -147,14 +138,14 @@ void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 	analyse_instr(&op, regs, *instr);
 	*type = GETTYPE(op.type);
 	*ea = op.ea;
-#ifdef __powerpc64__
+
 	if (!(regs->msr & MSR_64BIT))
 		*ea &= 0xffffffffUL;
-#endif
+
 
 	*size = GETSIZE(op.type);
 	if (*type == CACHEOP) {
-		*size = cache_op_size();
+		*size = l1_dcache_bytes();
 		*ea &= ~(*size - 1);
 	} else if (*type == LOAD_VMX || *type == STORE_VMX) {
 		*ea &= ~(*size - 1);
-- 
2.31.1

