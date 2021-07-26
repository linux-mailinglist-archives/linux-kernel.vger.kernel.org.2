Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215333D5BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhGZNvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:51:10 -0400
Received: from pv50p00im-hyfv10021501.me.com ([17.58.6.48]:57335 "EHLO
        pv50p00im-hyfv10021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234349AbhGZNvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1627309897; bh=Z986d0jG0R6/sOcB/aEQo+lWugHbqN3MMME1c54wvls=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=aFeB3t6C41Rx95XZgaouz2YjKDI0crSh93IBJ+6aaBr1kGA9vU0LAbC7GkrSlUz+J
         BK9E1zj25gsbmqQTvYDi6NkZRI8gojvSG1xnuOzo7sImixJjymTdLyTO5kzVuGgeMD
         0XBZB+qd8uqIrvFyaO37YeJ7yZTqNvCRPQsi3n1C0464r0FuJouQVXeFe0qkUTlLvz
         yRSDzyBC+TieI3gLLZ7B2n/8Q0dvoUhNsxSJCn8ff6U16v+CPWuVEZsOUgX9kbufvb
         ZTIQYEyVU5IJjl3SbZPTyfgCCVeP5pZmkHdicMAISB7Dw52NzZ61cHR/4yNyHfqfCA
         KFYvRhli3GaOg==
Received: from xiongwei.. (unknown [120.245.2.8])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id BD3BCB4051F;
        Mon, 26 Jul 2021 14:31:30 +0000 (UTC)
From:   sxwjean@me.com
To:     linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, ravi.bangoria@linux.ibm.com,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, sandipan@linux.ibm.com,
        efremov@linux.com, peterx@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [RFC PATCH 2/4] powerpc/64e: Get esr offset with _ESR macro
Date:   Mon, 26 Jul 2021 22:30:51 +0800
Message-Id: <20210726143053.532839-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726143053.532839-1-sxwjean@me.com>
References: <20210726143053.532839-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_06:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=890 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107260082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Use _ESR to get the offset of esr register in pr_regs for 64e cpus.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/kernel/asm-offsets.c    |  2 +-
 arch/powerpc/kernel/exceptions-64e.S | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index a47eefa09bcb..f4ebc435fd78 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -287,6 +287,7 @@ int main(void)
 	STACK_PT_REGS_OFFSET(_XER, xer);
 	STACK_PT_REGS_OFFSET(_DAR, dar);
 	STACK_PT_REGS_OFFSET(_DSISR, dsisr);
+	STACK_PT_REGS_OFFSET(_ESR, esr);
 	STACK_PT_REGS_OFFSET(ORIG_GPR3, orig_gpr3);
 	STACK_PT_REGS_OFFSET(RESULT, result);
 	STACK_PT_REGS_OFFSET(_TRAP, trap);
@@ -298,7 +299,6 @@ int main(void)
 	 * we use them to hold SRR0 and SRR1.
 	 */
 	STACK_PT_REGS_OFFSET(_DEAR, dar);
-	STACK_PT_REGS_OFFSET(_ESR, dsisr);
 #else /* CONFIG_PPC64 */
 	STACK_PT_REGS_OFFSET(SOFTE, softe);
 	STACK_PT_REGS_OFFSET(_PPR, ppr);
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 1401787b0b93..bf8c4c2f98ea 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -546,7 +546,7 @@ __end_interrupts:
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
 	std	r14,_DAR(r1)
-	std	r15,_DSISR(r1)
+	std	r15,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
 	EXCEPTION_COMMON(0x300)
@@ -559,7 +559,7 @@ __end_interrupts:
 	li	r15,0
 	mr	r14,r10
 	std	r14,_DAR(r1)
-	std	r15,_DSISR(r1)
+	std	r15,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
 	EXCEPTION_COMMON(0x400)
@@ -576,7 +576,7 @@ __end_interrupts:
 	mfspr	r14,SPRN_DEAR
 	mfspr	r15,SPRN_ESR
 	std	r14,_DAR(r1)
-	std	r15,_DSISR(r1)
+	std	r15,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	ld	r15,PACA_EXGEN+EX_R15(r13)
 	EXCEPTION_COMMON(0x600)
@@ -587,7 +587,7 @@ __end_interrupts:
 	NORMAL_EXCEPTION_PROLOG(0x700, BOOKE_INTERRUPT_PROGRAM,
 				PROLOG_ADDITION_1REG)
 	mfspr	r14,SPRN_ESR
-	std	r14,_DSISR(r1)
+	std	r14,_ESR(r1)
 	ld	r14,PACA_EXGEN+EX_R14(r13)
 	EXCEPTION_COMMON(0x700)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -1058,7 +1058,7 @@ bad_stack_book3e:
 	mfspr	r10,SPRN_DEAR
 	mfspr	r11,SPRN_ESR
 	std	r10,_DAR(r1)
-	std	r11,_DSISR(r1)
+	std	r11,_ESR(r1)
 	std	r0,GPR0(r1);		/* save r0 in stackframe */	    \
 	std	r2,GPR2(r1);		/* save r2 in stackframe */	    \
 	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe */    \
-- 
2.30.2

