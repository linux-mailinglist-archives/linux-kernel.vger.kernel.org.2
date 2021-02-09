Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA10314C65
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 11:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhBIKDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 05:03:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40773 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbhBIJ7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:59:55 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZdZh6bzKz9tx41;
        Tue,  9 Feb 2021 10:56:28 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HXqmx-ZAu8Aw; Tue,  9 Feb 2021 10:56:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZdZh5Yk4z9tx3b;
        Tue,  9 Feb 2021 10:56:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 738FB8B7D6;
        Tue,  9 Feb 2021 10:56:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DddPV_xeqpiE; Tue,  9 Feb 2021 10:56:29 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3AA608B7D4;
        Tue,  9 Feb 2021 10:56:29 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 15E5267342; Tue,  9 Feb 2021 09:56:29 +0000 (UTC)
Message-Id: <2d07d666e8e32f5eafd5bef16652b284524c3222.1612864003.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1612864003.git.christophe.leroy@csgroup.eu>
References: <cover.1612864003.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 05/41] powerpc/40x: Reorder a few instructions in
 critical exception prolog
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  9 Feb 2021 09:56:29 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ease preparation for CONFIG_VMAP_STACK, reorder
a few instruction, especially save r1 into stack frame earlier.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_40x.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 067ae1302c1c..5b337bf49bcb 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -119,6 +119,9 @@ _ENTRY(saved_ksp_limit)
 	lwz	r11,TASK_STACK-THREAD(r11) /* this thread's kernel stack */
 1:	addi	r11,r11,THREAD_SIZE-INT_FRAME_SIZE /* Alloc an excpt frm  */
 	tophys(r11,r11)
+	stw	r1,GPR1(r11)
+	stw	r1,0(r11)
+	tovirt(r1,r11)
 	stw	r10,_CCR(r11)		/* save various registers	   */
 	stw	r12,GPR12(r11)
 	stw	r9,GPR9(r11)
@@ -129,14 +132,11 @@ _ENTRY(saved_ksp_limit)
 	stw	r10,GPR10(r11)
 	stw	r12,GPR11(r11)
 	mfspr	r12,SPRN_DEAR		/* save DEAR and ESR in the frame  */
-	stw	r12,_DEAR(r11)		/* since they may have had stuff   */
 	mfspr	r9,SPRN_ESR		/* in them at the point where the  */
+	stw	r12,_DEAR(r11)		/* since they may have had stuff   */
 	stw	r9,_ESR(r11)		/* exception was taken		   */
 	mfspr	r12,SPRN_SRR2
-	stw	r1,GPR1(r11)
 	mfspr	r9,SPRN_SRR3
-	stw	r1,0(r11)
-	tovirt(r1,r11)
 	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?)	   */
 	stw	r0,GPR0(r11)
 	lis	r10, STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
-- 
2.25.0

