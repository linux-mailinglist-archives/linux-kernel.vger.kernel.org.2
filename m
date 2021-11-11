Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622EB44D465
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhKKJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:54:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42358 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232611AbhKKJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:54:08 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9gqiA023254;
        Thu, 11 Nov 2021 09:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bKdhg9Gb6K7KpjmSeWRokfTQvQTvpxc1xwEDUvD3EfA=;
 b=ekaqFmvqo3LJBdmkfUcOrdH5GH83fPERilRix/c0CTGsvOPx1tYWI8mrFH2n1FvmPkav
 hPU3eDd5K3F3SrHf13JH1NbvNSA6IdkPeWrTidiMEO14XNEfZZFCXyfb8o69mYvZkdRA
 AIk1GddbxiRqwV5YVNR60+RyNDeAZ9Jhli5r0xHqTh0zInF/oSb1QsCsZpmYKj/XiDd5
 aXct30h/GVpoDoVhNTiTmwA2MgsAtGkOTqwcIE68sj35/emFa6+JpoMDpLy29jrUbVf7
 DmGXnyDxBW30ws/l5T6EVd9cG8RbfjZHHhFAYb5Oob72/IhocQvIC0gdlJnVksmd9/Oz 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90sp85d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:30 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AB9gpXL023206;
        Thu, 11 Nov 2021 09:50:29 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c90sp85cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:29 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AB9n9u4027421;
        Thu, 11 Nov 2021 09:50:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3c5hbauqrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 09:50:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AB9hbWU46334262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 09:43:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA504C046;
        Thu, 11 Nov 2021 09:50:21 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 254FF4C05A;
        Thu, 11 Nov 2021 09:50:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.11.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Nov 2021 09:50:20 +0000 (GMT)
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
Subject: [RFC v1 2/4] kernel/fork.c: implement new process_mmput_async syscall
Date:   Thu, 11 Nov 2021 10:50:06 +0100
Message-Id: <20211111095008.264412-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111095008.264412-1-imbrenda@linux.ibm.com>
References: <20211111095008.264412-1-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wo1ZC9ZfZPI0gR0GLIm88cmTflN3RQqr
X-Proofpoint-ORIG-GUID: KWan9gBZ8_nmYld4DZ6voFMR-T6Tknlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_02,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=944
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111110056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal of this new syscall is to be able to asynchronously free the
mm of a dying process. This is especially useful for processes that use
huge amounts of memory (e.g. databases or KVM guests). The process is
allowed to terminate immediately, while its mm is cleaned/reclaimed
asynchronously.

A separate process needs use the process_mmput_async syscall to attach
itself to the mm of a running target process. The process will then
sleep until the last user of the target mm has gone.

When the last user of the mm has gone, instead of synchronously free
the mm, the attached process is awoken. The syscall will then continue
and clean up the target mm.

This solution has the advantage that the cleanup of the target mm can
happen both be asynchronous and properly accounted for (e.g. cgroups).

Tested on s390x.

A separate patch will actually wire up the syscall.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 include/linux/mm_types.h |   1 +
 kernel/fork.c            | 103 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index bb8c6f5f19bc..adc62cba3e91 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -631,6 +631,7 @@ struct mm_struct {
 		atomic_long_t hugetlb_usage;
 #endif
 		struct work_struct async_put_work;
+		struct task_struct *mmput_async_task;
 
 #ifdef CONFIG_IOMMU_SUPPORT
 		u32 pasid;
diff --git a/kernel/fork.c b/kernel/fork.c
index 5de23f3e08bf..0da39b76005c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1062,6 +1062,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+	mm->mmput_async_task = NULL;
 
 	if (current->mm) {
 		mm->flags = current->mm->flags & MMF_INIT_MASK;
@@ -1130,7 +1131,12 @@ void mmput(struct mm_struct *mm)
 {
 	might_sleep();
 
-	if (atomic_dec_and_test(&mm->mm_users))
+	if (!atomic_dec_and_test(&mm->mm_users))
+		return;
+
+	if (READ_ONCE(mm->mmput_async_task))
+		wake_up_process(mm->mmput_async_task);
+	else
 		__mmput(mm);
 }
 EXPORT_SYMBOL_GPL(mmput);
@@ -1146,7 +1152,12 @@ static void mmput_async_fn(struct work_struct *work)
 
 void mmput_async(struct mm_struct *mm)
 {
-	if (atomic_dec_and_test(&mm->mm_users)) {
+	if (!atomic_dec_and_test(&mm->mm_users))
+		return;
+
+	if (READ_ONCE(mm->mmput_async_task)) {
+		wake_up_process(mm->mmput_async_task);
+	} else {
 		INIT_WORK(&mm->async_put_work, mmput_async_fn);
 		schedule_work(&mm->async_put_work);
 	}
@@ -3191,3 +3202,91 @@ int sysctl_max_threads(struct ctl_table *table, int write,
 
 	return 0;
 }
+
+SYSCALL_DEFINE2(process_mmput_async, int, pidfd, unsigned int, flags)
+{
+#ifdef CONFIG_MMU
+	struct mm_struct *mm = NULL;
+	struct task_struct *task;
+	unsigned int tmp;
+	struct pid *pid;
+
+	if (flags)
+		return -EINVAL;
+
+	pid = pidfd_get_pid(pidfd, &tmp);
+	if (IS_ERR(pid))
+		return PTR_ERR(pid);
+
+	task = get_pid_task(pid, PIDTYPE_TGID);
+	/* The PID is not needed once we have the tast_struct */
+	put_pid(pid);
+	if (!task)
+		return -ESRCH;
+
+	/*
+	 * The struct_mm is guaranteed to be there as long as we are holding
+	 * a reference to the task_struct. This also guarantees that we
+	 * will not race with mmput, since we are now holding one additional
+	 * reference.
+	 */
+	if (mmget_not_zero(task->mm))
+		mm = task->mm;
+	/* The task_struct is not needed once we have the mm_struct */
+	put_task_struct(task);
+	/* If the target process no longer has an mm, there is nothing we can do. */
+	if (!mm)
+		return -ENXIO;
+
+	/* Use TASK_IDLE instead of TASK_UNINTERRUPTIBLE to avoid stall notifications. */
+	set_current_state(TASK_IDLE);
+	/*
+	 * Return an error if another task had already set itself as async
+	 * cleanup for the target mm.
+	 */
+	if (cmpxchg(&mm->mmput_async_task, NULL, current) != NULL) {
+		set_current_state(TASK_RUNNING);
+		return -EEXIST;
+	}
+
+	/*
+	 * The target mm now has an extra reference to current.
+	 * Is this useless?
+	 */
+	get_task_struct(current);
+	/*
+	 * We will now do mmput, and we no longer have a reference to the
+	 * task; we need mmgrab to be able to reference the mm_struct even
+	 * after its last user is gone.
+	 */
+	mmgrab(mm);
+	/*
+	 * If the target mm has been discarded after we got its reference,
+	 * then we are holding the last reference to it, and doing mmput
+	 * here will cause us to be schedulable again.
+	 */
+	mmput(mm);
+
+	/*
+	 * Go to sleep; we are set to TASK_IDLE, so nothing will wake us up
+	 * except an explicit wake_up_process from mmput.
+	 */
+	schedule();
+
+	/* Put the extra reference taken above */
+	put_task_struct(current);
+
+	/* Should this be a warning instead? */
+	if (atomic_read(&mm->mm_users))
+		panic("mm_users not 0 but trying to __mmput anyway!");
+
+	/* Do the actual work */
+	__mmput(mm);
+	/* And put the extra reference taken above */
+	mmdrop(mm);
+
+	return 0;
+#else
+	return -ENOSYS;
+#endif /* CONFIG_MMU */
+}
-- 
2.31.1

