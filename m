Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D3C44D463
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhKKJx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:53:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229649AbhKKJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:53:57 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9IS7Z021006;
        Thu, 11 Nov 2021 09:50:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FSi8nF5wttF33E9wgVxGAZhKsV5pV7mXAM/JTrIWIiw=;
 b=sES0q8W/tjRlpDAi+C9NI5dLSv3V8Krdto3gEi4eJNKt3x0PVTH01Hqdw85aUgY7gUf5
 vP/W/3pjo/b1JbbUOwsPdqfRQ8G5VByJdkRfzB/VfXlqi5NxEOx/cc3S3HPiwnXPgfXU
 go0G3IEj+wBtcJ7W9o0T1gQwQSfH8dB5KjHymbCvzIszkDkPCAKiNbJjEofdjQGQtZoe
 +dmhN9iy4yO/7cpP6OqtOHbxu0BosfIGKQVArewqIS7nn8ouLyaGs6ZnVW0YcjZaXZzn
 6prUe0OQk3cPp6v0JivSc1v7tqqLb6brj68ARBrz6rjmCikKGMQBz+mbBnhViHB51Hpk fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c90e80pcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:27 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AB9lpbf004875;
        Thu, 11 Nov 2021 09:50:27 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c90e80pc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9mqPx020080;
        Thu, 11 Nov 2021 09:50:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3c5hbaur9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:25 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AB9oKcI41353644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 09:50:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 101544C04A;
        Thu, 11 Nov 2021 09:50:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D23E24C064;
        Thu, 11 Nov 2021 09:50:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 09:50:18 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     thuth@redhat.com, frankja@linux.ibm.com, borntraeger@de.ibm.com,
        Ulrich.Weigand@de.ibm.com, heiko.carstens@de.ibm.com,
        david@redhat.com, ultrachin@163.com, akpm@linux-foundation.org,
        vbabka@suse.cz, brookxu.cn@gmail.com, xiaoggchen@tencent.com,
        linuszeng@tencent.com, yihuilu@tencent.com, mhocko@suse.com,
        daniel.m.jordan@oracle.com, axboe@kernel.dk, legion@kernel.org,
        peterz@infradead.org, aarcange@redhat.com, christian@brauner.io,
        ebiederm@xmission.com, tglx@linutronix.de
Subject: [RFC v1 1/4] exit: add arch mmput hook in exit_mm
Date:   Thu, 11 Nov 2021 10:50:05 +0100
Message-Id: <20211111095008.264412-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111095008.264412-1-imbrenda@linux.ibm.com>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bwRiliviVrvAScIBWTLvzmJnAaPO8Fsb
X-Proofpoint-ORIG-GUID: 14pCVOk4SHyEK6qP3Tb520e2M6mm0Di6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=855 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simple patch adds a hook for the mmput in exit_mm. This allows
archs to perform the mmput in custom ways if desired (e.g.
asynchronously)

No functional change intended.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 include/asm-generic/mmu_context.h | 4 ++++
 kernel/exit.c                     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
index 91727065bacb..900931a6a105 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -73,4 +73,8 @@ static inline void deactivate_mm(struct task_struct *tsk,
 }
 #endif
 
+#ifndef arch_exit_mm_mmput
+#define arch_exit_mm_mmput mmput
+#endif
+
 #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index f702a6a63686..6eb1fdcc434e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -504,7 +504,7 @@ static void exit_mm(void)
 	task_unlock(current);
 	mmap_read_unlock(mm);
 	mm_update_next_owner(mm);
-	mmput(mm);
+	arch_exit_mm_mmput(mm);
 	if (test_thread_flag(TIF_MEMDIE))
 		exit_oom_victim();
 }
-- 
2.31.1

