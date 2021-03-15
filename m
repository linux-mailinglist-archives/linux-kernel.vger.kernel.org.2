Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC633B08C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 12:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCOLCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 07:02:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:44831 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhCOLBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:01:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DzYPz3dmwz9tyQv;
        Mon, 15 Mar 2021 12:01:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Yu5e6q0CTUoz; Mon, 15 Mar 2021 12:01:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DzYPz2D0Rz9tyQt;
        Mon, 15 Mar 2021 12:01:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 104538B773;
        Mon, 15 Mar 2021 12:01:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3iqYG8FYfEae; Mon, 15 Mar 2021 12:01:31 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A4B018B75B;
        Mon, 15 Mar 2021 12:01:26 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1860165D4D; Mon, 15 Mar 2021 11:01:26 +0000 (UTC)
Message-Id: <9881c68fbca004f9ea18fc9473f630e11ccd6417.1615806071.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/asm-offsets: GPR14 is not needed either
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, rashmicy@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 15 Mar 2021 11:01:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit aac6a91fea93 ("powerpc/asm: Remove unused symbols in
asm-offsets.c") removed GPR15 to GPR31 but kept GPR14,
probably because it pops up in a couple of comments when doing
a grep.

However, it was never used either, so remove it as well.

Fixes: aac6a91fea93 ("powerpc/asm: Remove unused symbols in asm-offsets.c")
Cc: Rashmica Gupta <rashmicy@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/asm-offsets.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f3a662201a9f..4d230c5c7099 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -323,9 +323,6 @@ int main(void)
 	STACK_PT_REGS_OFFSET(GPR11, gpr[11]);
 	STACK_PT_REGS_OFFSET(GPR12, gpr[12]);
 	STACK_PT_REGS_OFFSET(GPR13, gpr[13]);
-#ifndef CONFIG_PPC64
-	STACK_PT_REGS_OFFSET(GPR14, gpr[14]);
-#endif /* CONFIG_PPC64 */
 	/*
 	 * Note: these symbols include _ because they overlap with special
 	 * register names
-- 
2.25.0

