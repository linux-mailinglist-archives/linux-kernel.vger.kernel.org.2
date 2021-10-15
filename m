Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC7642F663
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhJOO61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 10:58:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbhJOO6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 10:58:23 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19FD3XSs032694;
        Fri, 15 Oct 2021 10:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XaCiZuw1BubnJr0Z4Dt6ytQJZdkI7+Z5gdfi41cR/cY=;
 b=fcjwt+tc+UDIKN9YVAzZAQZTuneQg9vAWGH9rhETG5+ihVJTX5MGt88A+hd3NxPtMrMp
 sFdWQp0w3myf4fdCWTdKW332DLyiBHshxjdt80tQ+znpzTu/02w2rIutHEJUSasGDS7b
 AxayHJWlwGmtOtJuVzZohVglfOE7N54Nhfo+nP867CWRcYbdjs64H3NeCHL1tXaUiZ5A
 Sofc4EPaAHWHGk+M20qiJLCRFX4XUMKlhmFJZ/+5FYEJD534crPm1iAid6Q1sy+b19QS
 tOMshyS/a14Oync9TB/FrePEs/5J3lnGVNZNdxe0dTIBAe1wZbUh9/DwqslwNZRzSZHB +w== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bps2tqqw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 10:55:51 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19FElQxQ002686;
        Fri, 15 Oct 2021 14:55:50 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01dal.us.ibm.com with ESMTP id 3bpsfgwe47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Oct 2021 14:55:50 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19FEtmKj51839374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 14:55:48 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C47567806B;
        Fri, 15 Oct 2021 14:55:48 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96FAC7805E;
        Fri, 15 Oct 2021 14:55:48 +0000 (GMT)
Received: from localhost (unknown [9.211.119.24])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 15 Oct 2021 14:55:48 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, srikar@linux.vnet.ibm.com,
        valentin.schneider@arm.com, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, clg@kaod.org
Subject: [PATCH] powerpc/smp: do not decrement idle task preempt count in CPU offline
Date:   Fri, 15 Oct 2021 09:55:48 -0500
Message-Id: <20211015145548.2269836-1-nathanl@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -DMNoWInjHigIxmmdCBPQPlZMJS6fN_z
X-Proofpoint-ORIG-GUID: -DMNoWInjHigIxmmdCBPQPlZMJS6fN_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_04,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=978 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PREEMPT_COUNT=y, when a CPU is offlined and then onlined again, we
get:

BUG: scheduling while atomic: swapper/1/0/0x00000000
no locks held by swapper/1/0.
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.15.0-rc2+ #100
Call Trace:
 dump_stack_lvl+0xac/0x108
 __schedule_bug+0xac/0xe0
 __schedule+0xcf8/0x10d0
 schedule_idle+0x3c/0x70
 do_idle+0x2d8/0x4a0
 cpu_startup_entry+0x38/0x40
 start_secondary+0x2ec/0x3a0
 start_secondary_prolog+0x10/0x14

This is because powerpc's arch_cpu_idle_dead() decrements the idle task's
preempt count, for reasons explained in commit a7c2bb8279d2 ("powerpc:
Re-enable preemption before cpu_die()"), specifically "start_secondary()
expects a preempt_count() of 0."

However, since commit 2c669ef6979c ("powerpc/preempt: Don't touch the idle
task's preempt_count during hotplug") and commit f1a0a376ca0c ("sched/core:
Initialize the idle task with preemption disabled"), that justification no
longer holds.

The idle task isn't supposed to re-enable preemption, so remove the
vestigial preempt_enable() from the CPU offline path.

Tested with pseries and powernv in qemu, and pseries on PowerVM.

Fixes: 2c669ef6979c ("powerpc/preempt: Don't touch the idle task's preempt_count during hotplug")
Fixes: f1a0a376ca0c ("sched/core: Initialize the idle task with preemption disabled")
Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
 arch/powerpc/kernel/smp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9cc7d3dbf439..605bab448f84 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1730,8 +1730,6 @@ void __cpu_die(unsigned int cpu)
 
 void arch_cpu_idle_dead(void)
 {
-	sched_preempt_enable_no_resched();
-
 	/*
 	 * Disable on the down path. This will be re-enabled by
 	 * start_secondary() via start_secondary_resume() below
-- 
2.31.1

