Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECC93754B0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhEFN2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:28:35 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36323 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233811AbhEFN2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:28:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FbZBW72S8z9sVL;
        Thu,  6 May 2021 15:27:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FUbtJ3WmSgka; Thu,  6 May 2021 15:27:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FbZBW68cWz9sV0;
        Thu,  6 May 2021 15:27:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B31AF8B801;
        Thu,  6 May 2021 15:27:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BIwZu-HeAFJI; Thu,  6 May 2021 15:27:31 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C6798B800;
        Thu,  6 May 2021 15:27:31 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 455096489F; Thu,  6 May 2021 13:27:31 +0000 (UTC)
Message-Id: <848f18d213b8341939add7302dc4ef80cc7a12e3.1620307636.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Speed up likely path of kuap_update_sr()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 May 2021 13:27:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In most cases, kuap_update_sr() will update a single segment
register.

We know that first update will always be done, if there is no
segment register to update at all, kuap_update_sr() is not
called.

Avoid recurring calculations and tests in that case.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/kup.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
index 1670dfe9d4f1..c1f7c2e625a6 100644
--- a/arch/powerpc/include/asm/book3s/32/kup.h
+++ b/arch/powerpc/include/asm/book3s/32/kup.h
@@ -15,11 +15,13 @@ static inline void kuap_update_sr(u32 sr, u32 addr, u32 end)
 {
 	addr &= 0xf0000000;	/* align addr to start of segment */
 	barrier();	/* make sure thread.kuap is updated before playing with SRs */
-	while (addr < end) {
+	for (;;) {
 		mtsr(sr, addr);
+		addr += 0x10000000;	/* address of next segment */
+		if (addr >= end)
+			break;
 		sr += 0x111;		/* next VSID */
 		sr &= 0xf0ffffff;	/* clear VSID overflow */
-		addr += 0x10000000;	/* address of next segment */
 	}
 	isync();	/* Context sync required after mtsr() */
 }
-- 
2.25.0

