Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6238344D466
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhKKJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:54:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232818AbhKKJyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:54:14 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9hqYu010225;
        Thu, 11 Nov 2021 09:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FSi8nF5wttF33E9wgVxGAZhKsV5pV7mXAM/JTrIWIiw=;
 b=XTbXPemcoCtmj9JMsrGEOKtcltq8pDAbUgNQGg8GRbZ0zYw5kh5czV9IcNb0Xo/tFmHu
 uJAagHrMoWyuXhE6eFsU8a1xN10dQoe213CEAod5cL+Rtgv1WAAtZuN1vOsCuiIOuK4e
 j30hmD8fNqzWUbsB0cqOWTdaUNRloqmCFLdYxJeqD7JzoSGbEXxnZ+tIIFTyJyxyu4lV
 s+lTsswihh/sGl5KP/mdCDmASbIEEKhTPUOXwGbOmHWIYRl2i2B0aOX6EUnAfLED/qXL
 oMFC4Vw2Wdjmi4+UWRH38xn1rZAbi6VeSSnXBlraiGK+U4GBjY1LqRIqe06zciTs0vre Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90t4r321-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:27 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AB9i6ko011485;
        Thu, 11 Nov 2021 09:50:26 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90t4r310-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:26 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9m8Cc014429;
        Thu, 11 Nov 2021 09:50:24 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3c5hba1bm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AB9oIXq48562634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 09:50:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B94E24C062;
        Thu, 11 Nov 2021 09:50:18 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8321B4C044;
        Thu, 11 Nov 2021 09:50:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 09:50:17 +0000 (GMT)
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
Subject: [RFC v1 1/4] add arch mmput hook in exit.c
Date:   Thu, 11 Nov 2021 10:50:04 +0100
Message-Id: <20211111095008.264412-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111095008.264412-1-imbrenda@linux.ibm.com>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m_TBdmzdzkkBHlViyl3rU8FuaNQuV6Yv
X-Proofpoint-GUID: AP5XROjvqWy0OtQFPYwAfK001oy9Eiax
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=855 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110056
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

