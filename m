Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9B83E327F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhHGBDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:03:55 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:60054 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229976AbhHGBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1628298218; bh=G20sjdPi/op3pAshzrZ7wcSCo/+E1ubXJyBUNeyTABs=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=mJxmzl3OLT/SdEk9sdKk23Pm32bNHfbOtuPgucet4MDzmXPD0DV/blp3ua9ZgfJVQ
         pjEiLg7zslyL7BJ56BcpXDICwW8QhIoF8MjzLH7MsCWglo/b7kh+6qFhe2btL3h7/K
         nNERqvgrJlrKM/Wb+VTK9/3/8G47GHSjPx07rLLm1E1bOCjCzZL1bsUoygvlI5qJlW
         m6HOIwUkGpKEshOXhOkkk8oMVg4hXtyi3FV8838FONCagbzsjI9j5UKb4Jgn8i2yvW
         prmU0qwMBhVWY95y6tnMKnGlZVzTLO1ZTiz3fQqJMdyNYolMFjP3i/wpo2H9R7LNHw
         bY5b3gbWWUfAA==
Received: from xiongwei.. (unknown [120.245.2.134])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id C5486B003BF;
        Sat,  7 Aug 2021 01:03:33 +0000 (UTC)
From:   sxwjean@me.com
To:     linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        efremov@linux.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 3/4] powerpc: Optimize register usage for dear register
Date:   Sat,  7 Aug 2021 09:02:38 +0800
Message-Id: <20210807010239.416055-4-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807010239.416055-1-sxwjean@me.com>
References: <20210807010239.416055-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_08:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=744 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2108070004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Create an anonymous union for dar and dear regsiters, we can reference
dear to get the effective address when CONFIG_4xx=y or CONFIG_BOOKE=y.
Otherwise, reference dar. This makes code more clear.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h   | 5 ++++-
 arch/powerpc/kernel/process.c       | 2 +-
 arch/powerpc/kernel/ptrace/ptrace.c | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index c252d04b1206..fa725e3238c2 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -43,7 +43,10 @@ struct pt_regs
 			unsigned long mq;
 #endif
 			unsigned long trap;
-			unsigned long dar;
+			union {
+				unsigned long dar;
+				unsigned long dear;
+			};
 			union {
 				unsigned long dsisr;
 				unsigned long esr;
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f74af8f9133c..50436b52c213 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
 	    trap == INTERRUPT_DATA_STORAGE ||
 	    trap == INTERRUPT_ALIGNMENT) {
 		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
-			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->esr);
+			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dear, regs->esr);
 		else
 			pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
 	}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index a222fd4d6334..7c7093c17c45 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -373,6 +373,8 @@ void __init pt_regs_check(void)
 		     offsetof(struct user_pt_regs, trap));
 	BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=
 		     offsetof(struct user_pt_regs, dar));
+	BUILD_BUG_ON(offsetof(struct pt_regs, dear) !=
+		     offsetof(struct user_pt_regs, dar));
 	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
 		     offsetof(struct user_pt_regs, dsisr));
 	BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
-- 
2.30.2

