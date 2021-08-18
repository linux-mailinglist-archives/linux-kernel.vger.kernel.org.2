Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81BEC3EFF79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhHRIsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:48:07 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:44205 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229474AbhHRIsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:48:05 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GqM3P68l9z9sVb;
        Wed, 18 Aug 2021 10:47:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8s1-bV9JJ4yX; Wed, 18 Aug 2021 10:47:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GqM3P57Fnz9sVX;
        Wed, 18 Aug 2021 10:47:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 911538B7E6;
        Wed, 18 Aug 2021 10:47:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qN7yykVfqkMP; Wed, 18 Aug 2021 10:47:29 +0200 (CEST)
Received: from po9473vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 56D0C8B7E5;
        Wed, 18 Aug 2021 10:47:29 +0200 (CEST)
Received: by po9473vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EC7E26694E; Wed, 18 Aug 2021 08:47:28 +0000 (UTC)
Message-Id: <c04cce578b97a76a9e69a096698b1d89f721768a.1629276437.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32: Remove unneccessary calculations in
 load_up_{fpu/altivec}
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 18 Aug 2021 08:47:28 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to re-read SPRN_THREAD, we can calculate thread address
from current (r2).

And remove a reload of value 1 into r4 as r4 is already 1.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/fpu.S    | 3 +--
 arch/powerpc/kernel/vector.S | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 6010adcee16e..ba4afe3b5a9c 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -91,8 +91,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	isync
 	/* enable use of FP after return */
 #ifdef CONFIG_PPC32
-	mfspr	r5,SPRN_SPRG_THREAD	/* current task's THREAD (phys) */
-	tovirt(r5, r5)
+	addi	r5,r2,THREAD
 	lwz	r4,THREAD_FPEXC_MODE(r5)
 	ori	r9,r9,MSR_FP		/* enable FP for current */
 	or	r9,r9,r4
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index fc120fac1910..ba03eedfdcd8 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -65,9 +65,8 @@ _GLOBAL(load_up_altivec)
 1:
 	/* enable use of VMX after return */
 #ifdef CONFIG_PPC32
-	mfspr	r5,SPRN_SPRG_THREAD		/* current task's THREAD (phys) */
+	addi	r5,r2,THREAD
 	oris	r9,r9,MSR_VEC@h
-	tovirt(r5, r5)
 #else
 	ld	r4,PACACURRENT(r13)
 	addi	r5,r4,THREAD		/* Get THREAD */
@@ -81,7 +80,6 @@ _GLOBAL(load_up_altivec)
 	li	r4,1
 	stb	r4,THREAD_LOAD_VEC(r5)
 	addi	r6,r5,THREAD_VRSTATE
-	li	r4,1
 	li	r10,VRSTATE_VSCR
 	stw	r4,THREAD_USED_VR(r5)
 	lvx	v0,r10,r6
-- 
2.25.0

