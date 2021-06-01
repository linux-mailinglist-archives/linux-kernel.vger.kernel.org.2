Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6A53972EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhFAMEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:04:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48376 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230308AbhFAME2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:04:28 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 151BYMYm134190;
        Tue, 1 Jun 2021 08:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=vPA3PDUwEuKtgSgAgRvkDVFlr1Pse6ixBK+3HAEcIEw=;
 b=Bn02fDuXREkdxi+sDf6jVM+P9JSxjLH1wnKMupFQGd11Ra3i04qPdYf/xzk3XkbYJzta
 CnXmTiO9yOexiM84/c/hFXK9iAxMVR7TuzcJOqSAeyjwEezfrScOOsAYm/frdfWKJYBX
 0yeKPELmN0aEZiNHnfolVuaJRj9cZve4iZULW8y6IEBCTpmTQpsLUtJgwntwAGbYgMGR
 +LkYvR1xKTJ+kqekwHFa9pFln3Gk+6Cu47w4Gk/DEmeuzMeSu5m+JTqgO0MrdZAx1MKm
 9HmZcdlQpm+WPtYvkhmelcWRSE/kd3rWYjZw/6fvn6Ne4wN3+8SqpC8GByrroGHKohiA rw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38wk5qaagt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 08:02:09 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 151C23Tt004786;
        Tue, 1 Jun 2021 12:02:07 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 38ud87rwvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Jun 2021 12:02:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 151C24NN19857708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Jun 2021 12:02:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E26A152057;
        Tue,  1 Jun 2021 12:02:03 +0000 (GMT)
Received: from naverao1-tp.in.ibm.com (unknown [9.85.73.71])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D5A0D52054;
        Tue,  1 Jun 2021 12:02:00 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     mhiramat@kernel.org, Peter Zijlstra <peterz@infradead.org>
Cc:     ananth@linux.ibm.com, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        rostedt@goodmis.org, x86@kernel.org
Subject: [PATCH] kprobes: Do not increment probe miss count in the fault handler
Date:   Tue,  1 Jun 2021 17:31:50 +0530
Message-Id: <20210601120150.672652-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525073213.561116662@infradead.org>
References: <20210525073213.561116662@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6H1OyUP1bFG5--4Z7Ie_ttpxLaKztCFv
X-Proofpoint-GUID: 6H1OyUP1bFG5--4Z7Ie_ttpxLaKztCFv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-01_06:2021-05-31,2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes has a counter 'nmissed', that is used to count the number of
times a probe handler was not called. This generally happens when we hit
a kprobe while handling another kprobe.

However, if one of the probe handlers causes a fault, we are currently
incrementing 'nmissed'. The comment in fault handler indicates that this
can be used to account faults taken by the probe handlers. But, this has
never been the intention as is evident from the comment above 'nmissed'
in 'struct kprobe':

	/*count the number of times this probe was temporarily disarmed */
	unsigned long nmissed;

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
I'm posting this here so that these can go together, if the patch is ok 
otherwise.

Thanks,
- Naveen


 arch/arc/kernel/kprobes.c          |  6 ------
 arch/arm/probes/kprobes/core.c     | 14 --------------
 arch/arm64/kernel/probes/kprobes.c |  7 -------
 arch/csky/kernel/probes/kprobes.c  |  7 -------
 arch/ia64/kernel/kprobes.c         |  7 -------
 arch/powerpc/kernel/kprobes.c      |  7 -------
 arch/riscv/kernel/probes/kprobes.c |  7 -------
 arch/s390/kernel/kprobes.c         |  7 -------
 arch/sh/kernel/kprobes.c           |  7 -------
 arch/sparc/kernel/kprobes.c        |  7 -------
 arch/x86/kernel/kprobes/core.c     |  8 --------
 11 files changed, 84 deletions(-)

diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index 9f5b39f387362e..5f0415fc73287b 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -317,12 +317,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned long trapnr)
 		 * caused the fault.
 		 */
 
-		/* We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned zero,
 		 * try to fix up.
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index 7b9b9a5a409bb8..27e0af78e88b02 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -348,20 +348,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 			reset_current_kprobe();
 		}
 		break;
-
-	case KPROBE_HIT_ACTIVE:
-	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
-		break;
-
-	default:
-		break;
 	}
 
 	return 0;
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index f6b088e9fa70e6..004b86eff9c2d9 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -276,13 +276,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index e0e973e4977037..68b22b499aebf7 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -294,13 +294,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index 6efed4ecff9e92..441ed04b103785 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -843,13 +843,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 75b4e874269d48..3f700830169fad 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -501,13 +501,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 39eaa2091efd5d..247e33fa5bc75f 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -278,13 +278,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index ad631e33df24f3..74b0bd2c24d4c1 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -445,13 +445,6 @@ static int kprobe_trap_handler(struct pt_regs *regs, int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(p);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 58263420ad2a58..1c7f358ef0be1c 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -382,13 +382,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index db4e341b4b6ea8..4c05a4ee6a0e71 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -345,13 +345,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		break;
 	case KPROBE_HIT_ACTIVE:
 	case KPROBE_HIT_SSDONE:
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
-
 		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index cfcdf4b8a306f3..1b3fe0edd3299f 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1102,14 +1102,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 			restore_previous_kprobe(kcb);
 		else
 			reset_current_kprobe();
-	} else if (kcb->kprobe_status == KPROBE_HIT_ACTIVE ||
-		   kcb->kprobe_status == KPROBE_HIT_SSDONE) {
-		/*
-		 * We increment the nmissed count for accounting,
-		 * we can also use npre/npostfault count for accounting
-		 * these specific fault cases.
-		 */
-		kprobes_inc_nmissed_count(cur);
 	}
 
 	return 0;

base-commit: c2131f7e73c9e9365613e323d65c7b9e5b910f56
prerequisite-patch-id: 78c74d348e7072bc263e19753ca25e04dda45981
-- 
2.31.1

