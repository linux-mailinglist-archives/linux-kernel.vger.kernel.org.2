Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EDA44D464
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhKKJyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:54:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232611AbhKKJyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:54:05 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB8hchF015946;
        Thu, 11 Nov 2021 09:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9yzO3BN01R+xwzrsYOarJeAaAZRR7/sSADKUU1/AwUU=;
 b=Yl4IkLQNpU6cT1gSgFFV6IAdZVQrcTtnIFH5kKUQlEnhSvo43hIMII+rQQXAbvmFgs6U
 6/HM5mvAkv0qcelGhlsRBZiMScPoN/KbG2m3acmmEUOwseqlehFkGza/EDOUTbvMPZSJ
 GQiCvVHFYCMGwOMVe30zmi13ohNxiSGQl0PLrWU6kXNxaOAkJqpJXyIAhLtxtL6H8WlE
 9WxN5wcmYtVL0iGmumqRxDVN8QMQn9A2sY+CKYMCPuoUlqPyK9YusvAf/Bmo53PulagS
 pffpwXxsl4tbv1ZjD+e5h99ii/CuWPmbWn/aEq3PK7n0oQhp5DeUPXRrMgjLGOxDaYJO MA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8ywvskb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:31 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AB9Gt3v000675;
        Thu, 11 Nov 2021 09:50:31 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3c8ywvska3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:31 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9nJmM003941;
        Thu, 11 Nov 2021 09:50:29 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3c5hbasbxr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:29 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AB9oOxx51052872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 09:50:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8E9A4C05C;
        Thu, 11 Nov 2021 09:50:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7A734C066;
        Thu, 11 Nov 2021 09:50:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 09:50:22 +0000 (GMT)
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
Subject: [RFC v1 4/4] kernel/fork.c: process_mmput_async: stop OOM while freeing memory
Date:   Thu, 11 Nov 2021 10:50:08 +0100
Message-Id: <20211111095008.264412-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111095008.264412-1-imbrenda@linux.ibm.com>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B7S9vjvRQblh7Daa7g2JMtqFHEdIVmw4
X-Proofpoint-ORIG-GUID: JJjGFKWaQASuTc3y7iLoJeuCTRReAybx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements a simple OOM notifier to stop the OOM killer
while a mm is being reclaimed asynchronously using the
process_mmput_async syscall.

Tested on s390x.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 kernel/fork.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0da39b76005c..7279209eb69c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -118,6 +118,11 @@
  */
 #define MAX_THREADS FUTEX_TID_MASK
 
+/*
+ * Priority for the OOM notifier used in process_mmput_async
+ */
+#define PROCESS_MMPUT_ASYNC_OOM_NOTIFY_PRIORITY 70
+
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
@@ -3203,13 +3208,27 @@ int sysctl_max_threads(struct ctl_table *table, int write,
 	return 0;
 }
 
+/* Prevent the OOM from being triggered while we are cleaning up asynchronously */
+static int mmput_async_oom_notifier(struct notifier_block *nb, unsigned long dummy, void *parm)
+{
+	/*
+	 * We cannot know the speed at which pages are being freed, so we
+	 * fake it and say it's at least one. This is already enough to
+	 * stop the OOM killer.
+	 */
+	*(unsigned long *)parm += PAGE_SIZE;
+	return NOTIFY_OK;
+}
+
 SYSCALL_DEFINE2(process_mmput_async, int, pidfd, unsigned int, flags)
 {
 #ifdef CONFIG_MMU
+	struct notifier_block oom_nb;
 	struct mm_struct *mm = NULL;
 	struct task_struct *task;
 	unsigned int tmp;
 	struct pid *pid;
+	int r;
 
 	if (flags)
 		return -EINVAL;
@@ -3280,8 +3299,17 @@ SYSCALL_DEFINE2(process_mmput_async, int, pidfd, unsigned int, flags)
 	if (atomic_read(&mm->mm_users))
 		panic("mm_users not 0 but trying to __mmput anyway!");
 
+	/*
+	 * Register an OOM notifier, to stop the OOM while we are
+	 * asynchronously freeing the mm.
+	 */
+	oom_nb.priority = PROCESS_MMPUT_ASYNC_OOM_NOTIFY_PRIORITY;
+	oom_nb.notifier_call = mmput_async_oom_notifier;
+	r = register_oom_notifier(&oom_nb);
 	/* Do the actual work */
 	__mmput(mm);
+	if (!r)
+		unregister_oom_notifier(&oom_nb);
 	/* And put the extra reference taken above */
 	mmdrop(mm);
 
-- 
2.31.1

