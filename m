Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632DD3FA1DA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhH0Xfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:35:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55978 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232558AbhH0Xfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:35:31 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RKPA9A002206
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=to6XlBVoz3ZdxLpSpAv/1JS8uz+g7BXVUtuDFX4u9bTAOY3ygMhMd6vQmyo0ehrKE2K9
 4N/HQzJR/2bnqxVkd95VF7bE797LePRJ9AXsHZpmQeoTrfIkFAv+WXAOOTV1d8e2lWnz
 AN752k2IP4HnO+d21Z8xSQL1s/WZjfoIkFZubjhryf0FB6HT6PnQ9GrsxdrG4UeuYK1d
 GYCwVyJar8e9aXAHxZtPmOIpmXVdUCbLRdnY4/BoVq3UlGMTWzRZv+aaP98PmBifODnT
 uzH7g+R9Yp5UeQyUkW0/vf3dwAelIiS9r+HV3t4N/UJ7z9mXszcjBC59jnrJvl4J3oN6 Eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=Kf7eIjB7c9f/LSea9ksXN/guokOVkaBa295MBqC9EFbQzDat0VtbQknKHB5piJygbIPG
 pn3nYm9e23a9vJGSye0/n5E1PmxnQHC4FUFhhHTRqnnL7kOUn74ESAAsKNAyGRRa2Kcn
 pGeOar19zr4zFCu9GNfqk8wkebm8R6L926c+MMp76JUJtDzctCYf3o3Hpsv0r4U3llQr
 uSWkq/EANIGaRXB1sjHD2bimjgsbTRU+1tNrjp9FqN3YEr5iVdqSmTQ/++UUxfkHv7Ii
 1mkiBroFNq6ge7hhfyd2oyKRRDtrwW2u0KXE1L3ib/7HtMnAJhn/3ZBRUtgkQogO14k2 OA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3apvjr1sj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RNFe7m124537
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172] (may be forged))
        by userp3020.oracle.com with ESMTP id 3akb92yg6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8vSAotZPTLhJd4ir2v1Hrq388EaACfFxrvfod3lmUXHjqzhL46ax5do7cQPYqILuB8BI+LJJ5WnN/9SVQOUlWniwre9CgeGOJagKAnsrnACPYxhfMwosv0Yys0aGpkjOZUTd80wK9eFzXTzFReGMd/WURfAt15o1ewJ5TtaDJNUOR8mrw0ToC+Fgf4/IOulrIzS/3uQWHcXk1AKhhpTIg9o9yaHknSLXOiOFzfjpmjYj70OTUBpjYaPLeJ5XWX9kIY6d+sjVJDKJdQ//2qiCh6eYTwb1VUSswBv/fUSbq7+xm8rQheQxop7ZB0GS2C6ATdfCUapFiewxqRY1I0TXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=Qte5f1NhHijp9twfM7AGxpC6jRb6HyUEZFgDWSWWak1HE0qVtJWRmuMZK9S+C4o8hKqbN5tHzz3rRpA9Tbh3Vz4x2iv3prNRqsQvSjkYQVsNGUSrIgLCSo7NwuiEqFtdrqMVsYWquOB3G90Sn0vyptmI8UiOITZXMLCLvBSUSaF1pJeIiEALLR0x/W0IlmF3rwhcyeY3qwEKE7BEnxcDFeMIiRhByy+1GP3HcCZ2Hy2zaG3LL7hTTtd4D/kZFya+WBNp/ffYCNy5LmsCUSHgIskCp0C9cycRHDwd+JVXqiTv0IzfizWGyP2ACVuea6n9LXo3RVJaC8KYbEZO+jxI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKsGW3YNtdCT3n76iLsj/+P0SaF9vTCcqb6gTdBfnuE=;
 b=ollg2rVkJZmaXHhBmyeAz8r2XQCrb0tMH5OrZ/1rBmopnqPCjmtbEY6TiPgkAlZunkdlVTeCuXoSwJojj0eXn0YoI9MNUIXENAMqbezzXfhINLWglAtNKm6Jmdm01NdW4zRRFSG9iTtZpKZF/LqHLE2glrRyRL7CJi2ulFX/owM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5520.namprd10.prod.outlook.com (2603:10b6:a03:3fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 23:34:37 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4415.024; Fri, 27 Aug 2021
 23:34:37 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     prakash.sangappa@oracle.com
Subject: [RFC PATCH 2/3] Publish tasks's scheduler stats thru the shared structure
Date:   Fri, 27 Aug 2021 16:42:15 -0700
Message-Id: <1630107736-18269-3-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
References: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0034.namprd07.prod.outlook.com
 (2603:10b6:803:2d::15) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::1501) by SN4PR0701CA0034.namprd07.prod.outlook.com (2603:10b6:803:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4457.19 via Frontend Transport; Fri, 27 Aug 2021 23:34:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a90c2185-3152-456d-0d1c-08d969b33bca
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5520715191FA539D6DC0CB87E4C89@SJ0PR10MB5520.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LB6HFoHYQq1mEDLb9n+0yabL6vpSHrN1yIZiGRovnyUrnXavnDH45s9X/OUb9HpdYeAkjeJvV61YnrvFMZjIW8onbOR+wms66yLtWvVEuP6UO0k/13OCK+qLE7DgzXe6bgUEo3eVR3PAgn998fShli2n2ljuxq8HPDvF8RoFSh/GvgYNyMGpm/7finCG1w7Ex1dgR/lX6gMI7vY6e2m5Jq5ltD4zh/zh8cJ25IuhS+QAS+olFl6UeCotnSvoqO45mTQ2XoMalL+nIy4eIEFKw6lhi7bLhWA75phnmiNe3QOmFty7X2PsSwC+xo/ryR3oUm0lgpAlCfDA7X2DQzD6wtyqeT7IP4fjtc8/br/RvwhyPxoD7oxjzg5pxXTk+t9Hjj785ayq29l3fZq16dCoyiAo8v7z9KV0DwgraXjJjjydHuVH5CLssCtGy3f8Pywa05LLUbiM9qh6QR4MDhvj0eLCovTlOnAuJ5OWdwcbp+Z6vFeCzhWNSgtQQpzcpEBD6JwDVqcD0gGtn533fkMJ8Wi0okv/M0BDy4OBLc7p1ksIbficVtax4vDn+YhB4sFOIdTOknfY1Jg34FTYcdBYz8u3rPwHsOmRCtdNOuFku8haT9EHNlk1/yg0iy5s4SxH4D2iLIWmpn6pGUobZUuTQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(7696005)(52116002)(38100700002)(8676002)(83380400001)(186003)(6486002)(107886003)(4326008)(66476007)(2616005)(44832011)(2906002)(6666004)(478600001)(86362001)(8936002)(5660300002)(66556008)(36756003)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jxd1R2DMYnQgMBEZihqAH6+I3ZkWQBdYhTuf9nutyVXkuB+V5cqzgJfvUCd6?=
 =?us-ascii?Q?KzUXIQkf/TQ7vByGisWz6tPgb1K8U4tPxe4CMbs5Ty/bKMM7D2vMMP8jU3ab?=
 =?us-ascii?Q?c6MCpkENOI5THV2eaFNGz5G+LuA5rQXh6FKbHPRsxwItNXZFwZVP2g3L1m+p?=
 =?us-ascii?Q?HkSdgPldvIYzkMsi29uXuTRPPl43L3UPfp7KlgeL//pSs6Jp/v+Q8B7Kmyd1?=
 =?us-ascii?Q?lAih6uNzjDsRS7YkrmzOgt1m26C0M/fe3Pq4YXuFITeszSqgIfwVY3wTFe32?=
 =?us-ascii?Q?X91VdO51gLKaJZKFmbsADbYLRART0Iam1dA8engZzKBMNcliqaTp9j0igMPe?=
 =?us-ascii?Q?sU9dXYH9Yd5KhUtqy9BqmQa670piX53wBO/jAy6DkqAZr1kh6hAMr1PFmMKW?=
 =?us-ascii?Q?5f8qp7UfpjXWf2/obJo2HCbPRboxC4vo+qyIJfDd2Xj+Sq67ERuJ697yzuj6?=
 =?us-ascii?Q?kK/ctu4o6wkNHWP0xBgKYkKizsc48hdSl9HWSjwcVsDM9y0hBSCuBmLHnLjp?=
 =?us-ascii?Q?98NjLgjPemkhO5lAT6/Z2qQyd2qghx3yKVPncG2b3lZsia1epXeZp0j4mpTT?=
 =?us-ascii?Q?OzHAasz5iqIXbXr5wfnKsmqmCr0HxTXWDeU+rfosbKf1TCfIGYFAOskJAfXh?=
 =?us-ascii?Q?cto03sc0fDUERyy6CPXy1yhUa6VMUki+yFplAU70QBBAyQquk/3m2/nhAuKv?=
 =?us-ascii?Q?7ItZ6yT+26jPzWTYSJarEhkMwyRu5KVLhyXLCqOOUfi+AEUAlYukPr7u+cno?=
 =?us-ascii?Q?w+CcB3Yu/ngRZFxlr87d1eoYQ1oJ46CpXYSKJ3OC829gJieJ8wBYeghuYtor?=
 =?us-ascii?Q?bMs6nXIyeF38UlsN5yiNyz3o3wUc7oGDDQK6on+U+eX2k/p4jNHsyDgI1kSH?=
 =?us-ascii?Q?ipJzZSCugFdRb4VYTZOU0WTDRJ3k1P2/LrZ+X8yCqwmKjZU4WAvhLiETB3Wx?=
 =?us-ascii?Q?ZGd4SypPH5eScv44jdZbmRtQhIxmCD3hrrkTdpXPgwyHGHmFf9xYl8rFR+uI?=
 =?us-ascii?Q?ZUtfM6b0IaZPipyR+XJ5PKjLmcRRsb4tkni19StSNAWP24bFpQZU38UAv1fu?=
 =?us-ascii?Q?/PZMHQ3EDlYS3Kpd8ssbGipzoy4xLE5qZr5Zb7btdO23QLYpGGlmXPwcyemh?=
 =?us-ascii?Q?51iKZFerF4RufCz9NklhJwCfBZDGyTV2dohw0NENsUHYOrkzDK4MymjFda3E?=
 =?us-ascii?Q?hr4ueZFlFoQxQmhp/cQ9pM7Pg88VQXUPPBvD8BInLm8tTuxN+NFWqhVr39k3?=
 =?us-ascii?Q?rC3vFAjOKbLsyUsUR+l+WcE9Ti/SmeV8QChqV9gfoca7kVBo67LuRrgGv/7S?=
 =?us-ascii?Q?X1JuPTE/gm3Yxu9iUdjw+y5IA/NK2JigciN98HJusRUl0+Xx8uuQ/58c/1Ug?=
 =?us-ascii?Q?w4x6GtM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a90c2185-3152-456d-0d1c-08d969b33bca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 23:34:37.6213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzW+CwOE4JLaarnNFOxPAlqcHzXL9FUsmvoxT2xemTnfOWzBEZb/2QqpK3mq5iuBNYUSpy4Y1ZBvStDeGOtOjTnRom/fAiAu0Q+vqRcnIGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5520
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270139
X-Proofpoint-GUID: eHEtYgfstMOSYlZCpNfGi8UU85M4_slF
X-Proofpoint-ORIG-GUID: eHEtYgfstMOSYlZCpNfGi8UU85M4_slF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a 'struct task_schedstat' which contains members corresponding to
scheduler stats that are currently available thru /proc/pid/tasks/pid
/schedstats. Update scheduler stats in this structure in kernel at the
same time stats in the 'struct task_struct' are updated. Add a
TASK_SCHEDSTAT option to task_getshared system call to request these per
thread scheduler stats thru the shared structure.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/task_shared.h      | 35 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/task_shared.h | 22 ++++++++++++++++++++++
 kernel/sched/deadline.c          |  1 +
 kernel/sched/fair.c              |  1 +
 kernel/sched/rt.c                |  1 +
 kernel/sched/sched.h             |  1 +
 kernel/sched/stats.h             |  3 +++
 kernel/sched/stop_task.c         |  1 +
 mm/task_shared.c                 | 13 +++++++++++++
 9 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 include/uapi/linux/task_shared.h

diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
index de17849..62793e4 100644
--- a/include/linux/task_shared.h
+++ b/include/linux/task_shared.h
@@ -3,6 +3,7 @@
 #define	__TASK_SHARED_H__
 
 #include <linux/mm_types.h>
+#include <uapi/linux/task_shared.h>
 
 /*
  * Track user-kernel shared pages referred by mm_struct
@@ -18,7 +19,7 @@ struct ushared_pages {
  * fast communication.
  */
 struct task_ushared {
-	long version;
+	struct task_schedstat ts;
 };
 
 /*
@@ -52,6 +53,38 @@ struct task_ushrd_struct {
 	struct ushared_pg *upg;
 };
 
+
+#ifdef CONFIG_SCHED_INFO
+
+#define task_update_exec_runtime(t)					\
+	do {								\
+		struct task_ushrd_struct *shrdp = t->task_ushrd;	\
+		if (shrdp != NULL && shrdp->kaddr != NULL)		\
+			shrdp->kaddr->ts.sum_exec_runtime =		\
+				 t->se.sum_exec_runtime;		\
+	} while (0)
+
+#define task_update_runq_stat(t, p)					\
+	do {								\
+		struct task_ushrd_struct *shrdp = t->task_ushrd;	\
+		if (shrdp != NULL && shrdp->kaddr != NULL) {		\
+			shrdp->kaddr->ts.run_delay =			\
+				 t->sched_info.run_delay;		\
+			if (p) {					\
+				shrdp->kaddr->ts.pcount =		\
+					 t->sched_info.pcount;		\
+			}						\
+		}							\
+	} while (0)
+#else
+
+#define task_update_exec_runtime(t)	do { } while (0)
+#define task_update_runq_stat(t, p)	do { } while (0)
+
+#endif
+
+
+
 extern void task_ushared_free(struct task_struct *t);
 extern void mm_ushared_clear(struct mm_struct *mm);
 #endif /* __TASK_SHARED_H__ */
diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
new file mode 100644
index 0000000..06a8522
--- /dev/null
+++ b/include/uapi/linux/task_shared.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef LINUX_TASK_SHARED_H
+#define LINUX_TASK_SHARED_H
+
+/*
+ * Per task user-kernel mapped structure for faster communication.
+ */
+
+/*
+ * Following is the option to request struct task_schedstats shared structure,
+ * in which kernel shares the task's exec time and time on run queue & number
+ * of times it was scheduled to run on a cpu. Requires kernel with
+ * CONFIG_SCHED_INFO enabled.
+ */
+#define TASK_SCHEDSTAT 1
+
+struct task_schedstat {
+	volatile u64	sum_exec_runtime;
+	volatile u64	run_delay;
+	volatile u64	pcount;
+};
+#endif
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index aaacd6c..189c74c 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1270,6 +1270,7 @@ static void update_curr_dl(struct rq *rq)
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
+	task_update_exec_runtime(curr);
 
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 44c4520..cbd182b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -817,6 +817,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (entity_is_task(curr)) {
 		struct task_struct *curtask = task_of(curr);
 
+		task_update_exec_runtime(curtask);
 		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3daf42a..61082fc 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1014,6 +1014,7 @@ static void update_curr_rt(struct rq *rq)
 
 	curr->se.sum_exec_runtime += delta_exec;
 	account_group_exec_runtime(curr, delta_exec);
+	task_update_exec_runtime(curr);
 
 	curr->se.exec_start = now;
 	cgroup_account_cputime(curr, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 14a41a2..4ebbd8f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,6 +67,7 @@
 #include <linux/syscalls.h>
 #include <linux/task_work.h>
 #include <linux/tsacct_kern.h>
+#include <linux/task_shared.h>
 
 #include <asm/tlb.h>
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index d8f8eb0..6b2d69c 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
 #ifdef CONFIG_SCHEDSTATS
+#include <linux/task_shared.h>
 
 /*
  * Expects runqueue lock to be held for atomicity of update
@@ -166,6 +167,7 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 	delta = rq_clock(rq) - t->sched_info.last_queued;
 	t->sched_info.last_queued = 0;
 	t->sched_info.run_delay += delta;
+	task_update_runq_stat(t, 0);
 
 	rq_sched_info_dequeue(rq, delta);
 }
@@ -188,6 +190,7 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 	t->sched_info.run_delay += delta;
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcount++;
+	task_update_runq_stat(t, 1);
 
 	rq_sched_info_arrive(rq, delta);
 }
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index f988ebe..7b9b60f 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -82,6 +82,7 @@ static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
 			max(curr->se.statistics.exec_max, delta_exec));
 
 	curr->se.sum_exec_runtime += delta_exec;
+	task_update_exec_runtime(curr);
 	account_group_exec_runtime(curr, delta_exec);
 
 	curr->se.exec_start = rq_clock_task(rq);
diff --git a/mm/task_shared.c b/mm/task_shared.c
index 3ec5eb6..7169ccd 100644
--- a/mm/task_shared.c
+++ b/mm/task_shared.c
@@ -275,6 +275,14 @@ static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
 {
 	struct task_ushrd_struct *ushrd = current->task_ushrd;
 
+	/* Currently only TASK_SCHEDSTAT supported */
+#ifdef CONFIG_SCHED_INFO
+	if (opt != TASK_SCHEDSTAT)
+		return (-EINVAL);
+#else
+	return (-EOPNOTSUPP);
+#endif
+
 	/* We have address, return. */
 	if (ushrd != NULL && ushrd->upg != NULL) {
 		if (copy_to_user(uaddr, &ushrd->uaddr,
@@ -286,6 +294,11 @@ static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
 	task_ushared_alloc();
 	ushrd = current->task_ushrd;
 	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (opt == TASK_SCHEDSTAT) {
+			/* init current values */
+			task_update_exec_runtime(current);
+			task_update_runq_stat(current, 1);
+		}
 		if (copy_to_user(uaddr, &ushrd->uaddr,
 			sizeof(struct task_ushared *)))
 			return (-EFAULT);
-- 
2.7.4

