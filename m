Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA5E34BCA1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 16:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhC1Olm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 10:41:42 -0400
Received: from pv50p00im-zteg10021401.me.com ([17.58.6.47]:40720 "EHLO
        pv50p00im-zteg10021401.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229950AbhC1Olk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:41:40 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Mar 2021 10:41:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1616942155; bh=Ow0/kmASW8C17u8xlB5YZpkDJsBZ6QXmxxYqzlWdjE0=;
        h=From:To:Subject:Date:Message-Id;
        b=uyVCtTQQk6fMjMILnAMKvYGL5WBdz3SaHw7q2bQeA+uTlvI2Z9YIEAttpb7lC+fCL
         dBdSFCbrRQvmM/od9PF5mJfW8WdOv46Cfqyig0BWakJeLneY3Hvi2Xs9iZgO+kTxMS
         lTsl4SuyZMcBuAxSGfDE1bgNOdOQMXRopFOp2YPtCfzQJxIhIZKFe0uGcyRl0VVc5o
         9K+oHSx+MyBRqDpSLaskpeR2KvpmqdL98ou9jqqbpPfHQMczgef0Mz9Zx8OPDlbD58
         AiHJLAjLMYLbGY5JpwDvOD70727ZL8VK289CJcxOGDjbO514wGQNbITuNITEb3kz/T
         b0nWSpEbFJzjQ==
Received: from localhost.localdomain (unknown [120.245.2.89])
        by pv50p00im-zteg10021401.me.com (Postfix) with ESMTPSA id BD265480408;
        Sun, 28 Mar 2021 14:35:51 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, haren@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] powerpc/process: Enhance readability for trap types.
Date:   Sun, 28 Mar 2021 22:35:45 +0800
Message-Id: <20210328143545.24324-1-sxwjean@me.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-28_07:2021-03-26,2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=802 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2103280113
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Define macros to enhance the code readability on ppc trap types.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/kernel/process.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 3231c2df9e26..3bbd3cf353a7 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1451,6 +1451,10 @@ static void print_msr_bits(unsigned long val)
 #define LAST_VOLATILE	12
 #endif
 
+#define TRAP_MC  0x200 /* Machine Check */
+#define TRAP_DSI 0x300 /* DSI exception */
+#define TRAP_AM  0x600 /* Alignment exception */
+
 static void __show_regs(struct pt_regs *regs)
 {
 	int i, trap;
@@ -1465,7 +1469,7 @@ static void __show_regs(struct pt_regs *regs)
 	trap = TRAP(regs);
 	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
 		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
-	if (trap == 0x200 || trap == 0x300 || trap == 0x600) {
+	if (trap == TRAP_MC || trap == TRAP_DSI || trap == TRAP_AM) {
 		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
 			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
 		else
-- 
2.17.1

