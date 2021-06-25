Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14EF3B4244
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbhFYLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:15:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:38220 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYLPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:15:42 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4GBDrb3qDbzBBst;
        Fri, 25 Jun 2021 13:13:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Culj7UlqLg-y; Fri, 25 Jun 2021 13:13:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4GBDrZ2z97zBBft;
        Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52F4F8B7FF;
        Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Er4ktLbhQQd7; Fri, 25 Jun 2021 13:13:18 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA7238B802;
        Fri, 25 Jun 2021 13:13:17 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 53D5666377; Fri, 25 Jun 2021 11:13:17 +0000 (UTC)
Message-Id: <baf64a91557d3811c155616a6aa23ed7b3b21da4.1624619582.git.christophe.leroy@csgroup.eu>
In-Reply-To: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
References: <49f4fb051a3e1cb69f7305d5b6768aec14727c32.1624619582.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/2] powerpc/ptrace: Refactor regs_set_return_{msr/ip}
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jun 2021 11:13:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regs_set_return_msr() and regs_set_return_ip() have a copy
of the code of set_return_regs_changed().

Call the later instead.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ptrace.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 14b8105a1e27..3e5d470a6155 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -146,19 +146,13 @@ static inline void set_return_regs_changed(void)
 static inline void regs_set_return_ip(struct pt_regs *regs, unsigned long ip)
 {
 	regs->nip = ip;
-#ifdef CONFIG_PPC_BOOK3S_64
-	local_paca->hsrr_valid = 0;
-	local_paca->srr_valid = 0;
-#endif
+	set_return_regs_changed();
 }
 
 static inline void regs_set_return_msr(struct pt_regs *regs, unsigned long msr)
 {
 	regs->msr = msr;
-#ifdef CONFIG_PPC_BOOK3S_64
-	local_paca->hsrr_valid = 0;
-	local_paca->srr_valid = 0;
-#endif
+	set_return_regs_changed();
 }
 
 static inline void regs_add_return_ip(struct pt_regs *regs, long offset)
-- 
2.25.0

