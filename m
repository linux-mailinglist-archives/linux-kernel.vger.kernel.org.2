Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504263DB39A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhG3G3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:29:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237398AbhG3G3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:29:13 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16U645JJ163310;
        Fri, 30 Jul 2021 02:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=N3n8o8U5G1Exik9fyptpEp7xkG5QP1uKEt2i/YLJeiM=;
 b=gjiKpyAy1yl0Sera917CswGxnDMHHHjCgMqWrmMb5TwFLiGipkop/3P38abHykYvZ296
 m9U+o1GPWfF9ituwsVxxTSedls062xMg3gutK8bvLNAY0tVQ7LlZ6PwoTKbVNcdauAl5
 1MrNfcdQmKBzrAg2qST33vPZrv0mFdvBrkDRnz4uEU3+poQ8/W8EvReQkFdMPzt+KnVv
 dXzF9hPl2HeoOW8v/TWTVIITg8eoR2qWs5zeTibZkq0NuU8m4C8wezqhQFFu+znWbcVG
 Hp4B6S/fI/jaczJIie4IsR9kveirNlY2AN0Z8KE7/zwoXuNU5P5I52J7P+q51sR0lIRv +Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a49cqktem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 02:29:06 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16U6SBWE022046;
        Fri, 30 Jul 2021 06:29:04 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3a417ph0b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 06:29:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16U6T1P619136924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 06:29:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55E02A406D;
        Fri, 30 Jul 2021 06:29:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4AB9CA405D;
        Fri, 30 Jul 2021 06:29:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 30 Jul 2021 06:29:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id B75B1E07F7; Fri, 30 Jul 2021 08:28:59 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3] ucounts: add missing data type changes
Date:   Fri, 30 Jul 2021 08:28:54 +0200
Message-Id: <20210730062854.3601635-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z4s2R4V6mROYwMhtNmb6G3jHeRrmArba
X-Proofpoint-ORIG-GUID: Z4s2R4V6mROYwMhtNmb6G3jHeRrmArba
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_03:2021-07-29,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=1 bulkscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300036
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
 fs/notify/fanotify/fanotify_user.c | 10 ++++++----
 fs/notify/inotify/inotify_user.c   | 10 ++++++----
 kernel/ucount.c                    | 16 ++++++++--------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 64864fb40b40..6576657a1a25 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -58,18 +58,20 @@ struct ctl_table fanotify_table[] = {
 	{
 		.procname	= "max_user_groups",
 		.data	= &init_user_ns.ucount_max[UCOUNT_FANOTIFY_GROUPS],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
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
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 98f61b31745a..55fe7cdea2fb 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -59,18 +59,20 @@ struct ctl_table inotify_table[] = {
 	{
 		.procname	= "max_user_instances",
 		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "max_user_watches",
 		.data		= &init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES],
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(long),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
+		.proc_handler	= proc_doulongvec_minmax,
 		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_INT_MAX,
 	},
 	{
 		.procname	= "max_queued_events",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 87799e2379bd..f852591e395c 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -58,14 +58,14 @@ static struct ctl_table_root set_root = {
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
+#define UCOUNT_ENTRY(name)					\
+	{							\
+		.procname	= name,				\
+		.maxlen		= sizeof(long),			\
+		.mode		= 0644,				\
+		.proc_handler	= proc_doulongvec_minmax,	\
+		.extra1		= SYSCTL_ZERO,			\
+		.extra2		= SYSCTL_INT_MAX,		\
 	}
 static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_user_namespaces"),
-- 
2.25.1

