Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91983D5BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhGZNvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:51:18 -0400
Received: from pv50p00im-hyfv10021501.me.com ([17.58.6.48]:57783 "EHLO
        pv50p00im-hyfv10021501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234201AbhGZNvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1627309903; bh=5LoKxpiOaCX8VNLa2cka/PO0i9FkUE10bIa3XTPRxU0=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=HUlQhDYKtl9TNTp0Zk5JJ/B1nfOdSdSzFeHisHn3T86rFTUs4ZY34P/yLeK2STaVv
         x7/zhdkitjTgm6lRyI0MmAydyaLcRXi1tAwvJ6Rqt36Qv/9woaRvNAONWCtW589bfX
         1NLTnUtC9tzmwSLsXYHO+lb4DmbAyiGwUL0Cgu+4nHnl/f71/vHpPKOBVPp2vxToja
         q8IQO/ErUA+SdNk9Y2QDb7zAZm7T8tkX0OUZvCH9PwOmkyFsa2Z4th9vSjebMmocX3
         bb1ivHLkWTHYb4pFh+t/ZCwYXfpQYoPZtyHnSHXFOBeSyZm1j+bJxKYXkIqd3cwyJq
         6vXF6o9T6ncLg==
Received: from xiongwei.. (unknown [120.245.2.8])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 6F94BB4031D;
        Mon, 26 Jul 2021 14:31:38 +0000 (UTC)
From:   sxwjean@me.com
To:     linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, ravi.bangoria@linux.ibm.com,
        christophe.leroy@csgroup.eu, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, sandipan@linux.ibm.com,
        efremov@linux.com, peterx@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [RFC PATCH 3/4] powerpc: Optimize register usage for dear register
Date:   Mon, 26 Jul 2021 22:30:52 +0800
Message-Id: <20210726143053.532839-3-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726143053.532839-1-sxwjean@me.com>
References: <20210726143053.532839-1-sxwjean@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_06:2021-07-26,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=522 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2107260082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Create an anonymous union for dar and dear regsiters, we can reference
dear to get the effective address when CONFIG_4xx=y or CONFIG_BOOKE=y.
Otherwise, reference dar. This makes code more clear.

Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 arch/powerpc/include/asm/ptrace.h      | 5 ++++-
 arch/powerpc/include/uapi/asm/ptrace.h | 5 ++++-
 arch/powerpc/kernel/process.c          | 2 +-
 arch/powerpc/kernel/ptrace/ptrace.c    | 2 ++
 arch/powerpc/kernel/traps.c            | 5 ++++-
 arch/powerpc/mm/fault.c                | 2 +-
 6 files changed, 16 insertions(+), 5 deletions(-)

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
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index e357288b5f34..9ae150fb4c4b 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -52,7 +52,10 @@ struct pt_regs
 	unsigned long trap;		/* Reason for being here */
 	/* N.B. for critical exceptions on 4xx, the dar and dsisr
 	   fields are overloaded to hold srr0 and srr1. */
-	unsigned long dar;		/* Fault registers */
+	union {
+		unsigned long dar;		/* Fault registers */
+		unsigned long dear;
+	};
 	union {
 		unsigned long dsisr;		/* on Book-S used for DSISR */
 		unsigned long esr;		/* on 4xx/Book-E used for ESR */
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
index 00789ad2c4a3..969dca8b0718 100644
--- a/arch/powerpc/kernel/ptrace/ptrace.c
+++ b/arch/powerpc/kernel/ptrace/ptrace.c
@@ -373,6 +373,8 @@ void __init pt_regs_check(void)
 		     offsetof(struct user_pt_regs, trap));
 	BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=
 		     offsetof(struct user_pt_regs, dar));
+	BUILD_BUG_ON(offsetof(struct pt_regs, dear) !=
+		     offsetof(struct user_pt_regs, dear));
 	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
 		     offsetof(struct user_pt_regs, dsisr));
 	BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2164f5705a0b..0796630d3d23 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1609,7 +1609,10 @@ DEFINE_INTERRUPT_HANDLER(alignment_exception)
 	}
 bad:
 	if (user_mode(regs))
-		_exception(sig, regs, code, regs->dar);
+		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
+			_exception(sig, regs, code, regs->dear);
+		else
+			_exception(sig, regs, code, regs->dar);
 	else
 		bad_page_fault(regs, sig);
 }
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 62953d4e7c93..3db6b39a1178 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -542,7 +542,7 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
 	long err;
 
 	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
-		err = ___do_page_fault(regs, regs->dar, regs->esr);
+		err = ___do_page_fault(regs, regs->dear, regs->esr);
 	else
 		err = ___do_page_fault(regs, regs->dar, regs->dsisr);
 
-- 
2.30.2

