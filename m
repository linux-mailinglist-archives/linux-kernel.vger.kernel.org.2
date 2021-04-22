Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E93368313
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbhDVPLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:11:50 -0400
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:48052 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236975AbhDVPLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1619104273; bh=M+0qUtqyvLH8bRJU+2RUGsxt0cH8oZQEevTYM/PgVkE=;
        h=From:To:Subject:Date:Message-Id;
        b=kvleFWx7KDAgkBt6ASs8Z9UYSczMSzxbloJ7M+GXxsamVOplCgq4BMmrUcWeiF5sC
         iL4Z8GngBaIDg/t7+AxTUYnh/7lUuG/4u8XGob1nzHvd35Qgnkoxl0ZNd39Grh99f2
         6raCzyDrhb09bTWa3afiWZR76p5jO/yAl+6Tw7GCr/u9qjsIYqEy9FH60x+yN4hQJr
         dS2GmbIHV7hlfCLGuZvA6oto50JHiXZ9MRCzm1/uDA/qZfI35H4csQ/lGrR9oD3Vga
         T0gNOVnanAbmANQp4n0uWEQh63+TQzaIFj51hqgNMdu/xQmB/dNqY646s56EhOe6gD
         92yLAtzAOh3fQ==
Received: from localhost.localdomain (unknown [120.245.2.61])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 235EE380263;
        Thu, 22 Apr 2021 15:11:08 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, 0x7f454c46@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH 1/2] powerpc: Make the code in __show_regs nice-looking
Date:   Thu, 22 Apr 2021 23:10:21 +0800
Message-Id: <20210422151022.17868-1-sxwjean@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-22_06:2021-04-22,2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=794 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2104220120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Create a new function named interrupt_detail_printable to judge which
interrupts can print esr/dsisr register.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/kernel/process.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 89e34aa273e2..5c3830837f3a 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1453,9 +1453,23 @@ static void print_msr_bits(unsigned long val)
 #define REGS_PER_LINE	8
 #endif
 
+static bool interrupt_detail_printable(int trap)
+{
+	switch (trap) {
+	case INTERRUPT_MACHINE_CHECK:
+	case INTERRUPT_DATA_STORAGE:
+	case INTERRUPT_ALIGNMENT:
+		return true;
+	default:
+		return false;
+	}
+
+	return false;
+}
+
 static void __show_regs(struct pt_regs *regs)
 {
-	int i, trap;
+	int i;
 
 	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
 	       regs->nip, regs->link, regs->ctr);
@@ -1464,12 +1478,9 @@ static void __show_regs(struct pt_regs *regs)
 	printk("MSR:  "REG" ", regs->msr);
 	print_msr_bits(regs->msr);
 	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
-	trap = TRAP(regs);
 	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
 		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
-	if (trap == INTERRUPT_MACHINE_CHECK ||
-	    trap == INTERRUPT_DATA_STORAGE ||
-	    trap == INTERRUPT_ALIGNMENT) {
+	if (interrupt_detail_printable(TRAP(regs))) {
 		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
 			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 		else
-- 
2.17.1

