Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9633E327C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 03:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhHGBDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 21:03:45 -0400
Received: from pv50p00im-zteg10011501.me.com ([17.58.6.42]:59534 "EHLO
        pv50p00im-zteg10011501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229886AbhHGBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 21:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1628298207; bh=95sebF4HCA3wepyhnfdQmcNGewqvLlTJsmb0uW7vxQM=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=KGVwbV/sAv6ySs046qNy0dEmmXWw+6SCjrUulonBrrgcwtlIaoNEyLhThylTUlgdY
         uHmVVhyibBjGj8OLiSqrSC7qkBtZhOEXeN8uHzYt9kZXYiCNp2nRlDJTCfAoYgDFyJ
         Lk0uvwFELKkxEnWTDKm0LugOl66iwmcPdVod7LZPbEJtUSnV1Bs9PyrEb/ApoDox4t
         nQiHQljqwU+1jmGpVDxUryRVLj7QFv/JpEo6CjaDXitcxpb1grzAmakGMua/E4LN/S
         T31+5kTXrJVaIJr9D5dtWLnHN6wievDv3zX5VuTsB2OgWgZ0f4OFgLigv7fZDph3Tz
         8u3ffPT11FM6w==
Received: from xiongwei.. (unknown [120.245.2.134])
        by pv50p00im-zteg10011501.me.com (Postfix) with ESMTPSA id 5954AB00396;
        Sat,  7 Aug 2021 01:03:23 +0000 (UTC)
From:   sxwjean@me.com
To:     linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        efremov@linux.com, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH v2 1/4] powerpc: Optimize register usage for esr register
Date:   Sat,  7 Aug 2021 09:02:36 +0800
Message-Id: <20210807010239.416055-2-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210807010239.416055-1-sxwjean@me.com>
References: <20210807010239.416055-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-06_08:2021-08-06,2021-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=757 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2108070004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Create an anonymous union for dsisr and esr regsiters, we can reference
esr to get the exception detail when CONFIG_4xx=y or CONFIG_BOOKE=y.
Otherwise, reference dsisr. This makes code more clear.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h          | 5 ++++-
 arch/powerpc/kernel/process.c              | 2 +-
 arch/powerpc/kernel/ptrace/ptrace.c        | 2 ++
 arch/powerpc/kernel/traps.c                | 2 +-
 arch/powerpc/platforms/44x/machine_check.c | 4 ++--
 arch/powerpc/platforms/4xx/machine_check.c | 2 +-
 6 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 3e5d470a6155..c252d04b1206 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -44,7 +44,10 @@ struct pt_regs
 #endif
 			unsigned long trap;
 			unsigned long dar;
-			unsigned long dsisr;
+			union {
+				unsigned long dsisr;
+				unsigned long esr;
+			};
 			unsigned long result;
 		};
 	};
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 185beb290580..f74af8f9133c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
 	    trap == INTERRUPT_DATA_STORAGE ||
 	    trap == INTERRUPT_ALIGNMENT) {
 		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
-			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
+			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->esr);
 		else
 			pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
 	}
diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
index 0a0a33eb0d28..a222fd4d6334 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -375,6 +375,8 @@ void __init pt_regs_check(void)
 		     offsetof(struct user_pt_regs, dar));
 	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
 		     offsetof(struct user_pt_regs, dsisr));
+	BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
+		     offsetof(struct user_pt_regs, dsisr));
 	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
 		     offsetof(struct user_pt_regs, result));
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index dfbce527c98e..2164f5705a0b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -562,7 +562,7 @@ static inline int check_io_access(struct pt_regs *regs)
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 /* On 4xx, the reason for the machine check or program exception
    is in the ESR. */
-#define get_reason(regs)	((regs)->dsisr)
+#define get_reason(regs)	((regs)->esr)
 #define REASON_FP		ESR_FP
 #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
 #define REASON_PRIVILEGED	ESR_PPR
diff --git a/arch/powerpc/platforms/44x/machine_check.c b/arch/powerpc/platforms/44x/machine_check.c
index a5c898bb9bab..5d19daacd78a 100644
--- a/arch/powerpc/platforms/44x/machine_check.c
+++ b/arch/powerpc/platforms/44x/machine_check.c
@@ -11,7 +11,7 @@
 
 int machine_check_440A(struct pt_regs *regs)
 {
-	unsigned long reason = regs->dsisr;
+	unsigned long reason = regs->esr;
 
 	printk("Machine check in kernel mode.\n");
 	if (reason & ESR_IMCP){
@@ -48,7 +48,7 @@ int machine_check_440A(struct pt_regs *regs)
 #ifdef CONFIG_PPC_47x
 int machine_check_47x(struct pt_regs *regs)
 {
-	unsigned long reason = regs->dsisr;
+	unsigned long reason = regs->esr;
 	u32 mcsr;
 
 	printk(KERN_ERR "Machine check in kernel mode.\n");
diff --git a/arch/powerpc/platforms/4xx/machine_check.c b/arch/powerpc/platforms/4xx/machine_check.c
index a71c29892a91..a905da1d6f41 100644
--- a/arch/powerpc/platforms/4xx/machine_check.c
+++ b/arch/powerpc/platforms/4xx/machine_check.c
@@ -10,7 +10,7 @@
 
 int machine_check_4xx(struct pt_regs *regs)
 {
-	unsigned long reason = regs->dsisr;
+	unsigned long reason = regs->esr;
 
 	if (reason & ESR_IMCP) {
 		printk("Instruction");
-- 
2.30.2

