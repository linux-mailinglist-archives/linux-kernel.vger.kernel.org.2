Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268F83EEFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhHQQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:00:54 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:44337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhHQQAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:00:50 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GpwjC12S7z9sTl;
        Tue, 17 Aug 2021 18:00:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5FYl5G2Uzyb6; Tue, 17 Aug 2021 18:00:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GpwjC06SKz9sRj;
        Tue, 17 Aug 2021 18:00:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D57258B7C3;
        Tue, 17 Aug 2021 18:00:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id n39-hyA9LvO3; Tue, 17 Aug 2021 18:00:14 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A6B088B7A9;
        Tue, 17 Aug 2021 18:00:14 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 742D9667C7; Tue, 17 Aug 2021 16:00:14 +0000 (UTC)
Message-Id: <000a28c51808bbd802b505af42d2cb316c2be7d3.1629216000.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/ptrace: Make user_mode() common to PPC32 and PPC64
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 17 Aug 2021 16:00:14 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today we have:

	#ifdef __powerpc64__
	#define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
	#else
	#define user_mode(regs) (((regs)->msr & MSR_PR) != 0)
	#endif

With ppc64_defconfig, we get:

	if (!user_mode(regs))
    14b4:	e9 3e 01 08 	ld      r9,264(r30)
    14b8:	71 29 40 00 	andi.   r9,r9,16384
    14bc:	41 82 07 a4 	beq     1c60 <.emulate_instruction+0x7d0>

If taking the ppc32 definition of user_mode(), the exact same code
is generated for ppc64_defconfig.

So, only keep one version of user_mode(), preferably the one not
using MSR_PR_LG which should be kept internal to reg.h.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/ptrace.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 14422e851494..fd60538737a0 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -197,11 +197,7 @@ static inline unsigned long frame_pointer(struct pt_regs *regs)
 	return 0;
 }
 
-#ifdef __powerpc64__
-#define user_mode(regs) ((((regs)->msr) >> MSR_PR_LG) & 0x1)
-#else
 #define user_mode(regs) (((regs)->msr & MSR_PR) != 0)
-#endif
 
 #define force_successful_syscall_return()   \
 	do { \
-- 
2.25.0

