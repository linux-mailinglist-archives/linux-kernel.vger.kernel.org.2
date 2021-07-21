Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59443D0E89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 14:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhGULX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 07:23:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59250 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238827AbhGULSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:18:17 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16LBY3rm119749;
        Wed, 21 Jul 2021 07:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=hIaOWjVZslmQvM4W1FyglIHwt1mu7HvLC6A4sGp79KE=;
 b=X1sRT62Kotx4sU+V1ENiJ96UVciSZckYdx+MxuOPqhn/WcG72xEjDTSrtrGAKigtUY4n
 40o/P84sWFcyAXS70CUhudvUQuRACl1yxfqxXIFNgE74bdya04KNd8u1qWcRV61Opp+t
 T9XRNvLERnycrnVmEwMPHLRolA9+t0byfqkHkzliiKT0PUXt0XdsA3X4/0UUzQVHNSQW
 JwKRdDkssyzeVNiNH3vAWN1cxdfwF1HRqKh3C9UhBbnL6LrlrX/RW8LNUkXZeTWvTmmS
 DPP26LfGPFCah7q0DiJlRHuT1gd6obFQ7ULekBKulWcFBEIkIl8UznALof+8S02EPPTL EA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xha62y93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 07:58:18 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16LBrGoi005703;
        Wed, 21 Jul 2021 11:58:16 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 39xhx481a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 11:58:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16LBwD1427197932
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 11:58:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 878FAA4053;
        Wed, 21 Jul 2021 11:58:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 730C5A4051;
        Wed, 21 Jul 2021 11:58:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jul 2021 11:58:13 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 15382E06C2; Wed, 21 Jul 2021 13:58:13 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH] ucounts: add missing data type changes
Date:   Wed, 21 Jul 2021 13:58:00 +0200
Message-Id: <20210721115800.910778-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OXsMxoK_bQs1FKEGSuzgNhkhtm1L47W7
X-Proofpoint-ORIG-GUID: OXsMxoK_bQs1FKEGSuzgNhkhtm1L47W7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_05:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210065
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
changed the data type of ucounts/ucounts_max to long, but missed to
adjust a few other places. This is noticeable on big endian platforms
from user space because the /proc/sys/user/max_*_names files all
contain 0.

Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 fs/notify/fanotify/fanotify_user.c | 11 +++++++----
 kernel/ucount.c                    | 18 ++++++++++--------
 kernel/user_namespace.c            |  2 +-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 64864fb40b40..995379ddce86 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -54,22 +54,25 @@ static int fanotify_max_queued_events __read_mostly;
 
 #include <linux/sysctl.h>
 
+static unsigned long long_max = LONG_MAX;
 struct ctl_table fanotify_table[] = {
 	{
 		.procname	= "max_user_groups",
 		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "max_user_marks",
 		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_MARKS],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= &long_max,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 87799e2379bd..681ea1b1a06f 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -58,14 +58,16 @@ static struct ctl_table_root set_root = {
 	.permissions = set_permissions,
 };
 
-#define UCOUNT_ENTRY(name)				\
-	{						\
-		.procname	= name,			\
-		.maxlen		= sizeof(int),		\
-		.mode		= 0644,			\
-		.proc_handler	= proc_dointvec_minmax,	\
-		.extra1		= SYSCTL_ZERO,		\
-		.extra2		= SYSCTL_INT_MAX,	\
+static unsigned long long_max = LONG_MAX;
+
+#define UCOUNT_ENTRY(name)					\
+	{							\
+		.procname	= name,				\
+		.maxlen		= sizeof(long),			\
+		.mode		= 0644,				\
+		.proc_handler	= proc_doulongvec_minmax,	\
+		.extra1		= SYSCTL_ZERO,			\
+		.extra2		= &long_max,			\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index ef82d401dde8..d8ad4c261253 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -120,7 +120,7 @@ int create_user_ns(struct cred *new)
 	ns->group = group;
 	INIT_WORK(&ns->work, free_user_ns);
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
-		ns->ucount_max[i] = INT_MAX;
+		ns->ucount_max[i] = LONG_MAX;
 	}
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
 	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
-- 
2.25.1

