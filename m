Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C93E3280
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhHGBED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:04:03 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:60316 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230023AbhHGBEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1628298224; bh=o4KbhPghRaFvtnL6R0pnWWU/e4yDdHIWSmM7oMiG7Ac=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mlJaXcDHXCrYt/vJiNMhyIwIijirS32OSo8d7lCzBbEP3K1ZXjS8uL19XEnmgdPti
         Ri0t8ZM5Y5QEtBrAc8aTYwBhoQ4K/tULjPh4/FeerOTIhwFrvAEDvHTqmQfdcyTf93
         YOAB6qLFgAGdwvphX0izvC9cOQd9raau9r/CQ7ouG1QT1CNZr4gYAXfgGdXujZxz63
         UGkIIowV/VAwcwqYLugMCvnbbruGdloAskrwW2SvxOXnmGhPc8jMs1NzBs+sfHlIxx
         d57+0F5NoCvJdwyN6ckYs23KoRas35wTaZ1YZV8OcHFdXvNaWQloKIjZib34zIRlZk
         Cmgvu8WJ8FHlg==
Received: from xiongwei.. (unknown [120.245.2.134])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id B7368B003C3;
        Sat,  7 Aug 2021 01:03:38 +0000 (UTC)
From:   sxwjean@me.com
To:     linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        efremov@linux.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 4/4] powerpc/64e: Get dear offset with _DEAR macro
Date:   Sat,  7 Aug 2021 09:02:39 +0800
Message-Id: <20210807010239.416055-5-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807010239.416055-1-sxwjean@me.com>
References: <20210807010239.416055-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_08:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=948 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2108070004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Use _DEAR to get the offset of dear register in pr_regs for 64e cpus.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c    | 13 +++----------
 arch/powerpc/kernel/exceptions-64e.S |  8 ++++----
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f4ebc435fd78..8357d5fcd09e 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -286,23 +286,16 @@ int main(void)
 	STACK_PT_REGS_OFFSET(_CCR, ccr);
 	STACK_PT_REGS_OFFSET(_XER, xer);
 	STACK_PT_REGS_OFFSET(_DAR, dar);
+	STACK_PT_REGS_OFFSET(_DEAR, dear);
 	STACK_PT_REGS_OFFSET(_DSISR, dsisr);
 	STACK_PT_REGS_OFFSET(_ESR, esr);
 	STACK_PT_REGS_OFFSET(ORIG_GPR3, orig_gpr3);
 	STACK_PT_REGS_OFFSET(RESULT, result);
 	STACK_PT_REGS_OFFSET(_TRAP, trap);
-#ifndef CONFIG_PPC64
-	/*
-	 * The PowerPC 400-class & Book-E processors have neither the DAR
-	 * nor the DSISR SPRs. Hence, we overload them to hold the similar
-	 * DEAR and ESR SPRs for such processors.  For critical interrupts
-	 * we use them to hold SRR0 and SRR1.
-	 */
-	STACK_PT_REGS_OFFSET(_DEAR, dar);
-#else /* CONFIG_PPC64 */
+#ifdef CONFIG_PPC64
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
 	STACK_PT_REGS_OFFSET(_PPR, ppr);
-#endif /* CONFIG_PPC64 */
+#endif
 
 #ifdef CONFIG_PPC_PKEY
 	STACK_PT_REGS_OFFSET(STACK_REGS_AMR, amr);
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index bf8c4c2f98ea..221e085e8c8c 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -545,7 +545,7 @@ __end_interrupts:
 				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	std	r14,_DAR(r1)
+	std	r14,_DEAR(r1)
 	std	r15,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
@@ -558,7 +558,7 @@ __end_interrupts:
 				PROLOG_ADDITION_2REGS)
 	li	r15,0
 	mr	r14,r10
-	std	r14,_DAR(r1)
+	std	r14,_DEAR(r1)
 	std	r15,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
@@ -575,7 +575,7 @@ __end_interrupts:
 				PROLOG_ADDITION_2REGS)
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
-	std	r14,_DAR(r1)
+	std	r14,_DEAR(r1)
 	std	r15,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
@@ -1057,7 +1057,7 @@ bad_stack_book3e:
 	std	r11,_CCR(r1)
 	mfspr	r10,SPRN_DEAR
 	mfspr	r11,SPRN_ESR
-	std	r10,_DAR(r1)
+	std	r10,_DEAR(r1)
 	std	r11,_ESR(r1)
 	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
 	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
-- 
2.30.2

