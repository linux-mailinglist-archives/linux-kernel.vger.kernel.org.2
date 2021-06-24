Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858AF3B2549
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 05:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhFXDKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 23:10:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6914 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229800AbhFXDKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 23:10:50 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15O35m5u015781;
        Thu, 24 Jun 2021 03:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=HlU9IF7b5wKBQqKBshzRgZ8nkUoS58wH4nvnD4Z4eo4=;
 b=bGcoe9TqzBN8Qi19had8CtA+qTAswFMTXgoqjUPSirF2FIKDsq1lgIdfFYyQhKt37Vw/
 C8E+TopZOQ5vPH//X4NTKMlZhAkIFIpWgJET/c9xzOamwGJLITXwpFZdLl6ePIu6lf/5
 Mcz895ofXHJyXaT2KrdrI3+kjywt7ccwMoruU7znyvSILD05tJ6rx0b33jF1Fg1z2w0b
 Qjyfl3rGhCl9hC7ZDFvEeTrlJnnzXt0/uoRjUMCmDtPe+4QukpQd7MpkmMmWAsGUM9B5
 M4NFWMmoONFO8fUXZ5GGCT+hKXiKnQEZQ3eO32FIOXQwJoQddpxFTWAI1QeURJB5+KgR Aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c8tw8v7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 03:08:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15O31J1r094310;
        Thu, 24 Jun 2021 03:08:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3030.oracle.com with ESMTP id 3995q0571v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Jun 2021 03:08:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1akpzUmIVnH2tZga7dXw9fJ77oCX9CO9VcA9P5Q/LrsWTf+CRJjRSrvgRSlOw2pqffoucNRt+CF0cTrvRqCXfMRVko06Ivx7yk2tWAXa7SY0a/T1SIGR2G953GSEpzrIN82omv8i3BykAm9EjIFMC0inlGoNFZdUcPFxGRjoQ7FTxwTPrn7ByVHkP+mQAooL4ikiDWbLQrtLAUg3lQhC/PIlyecyq8HoKyi6Gdx151AX7c+ewFMm4Rzp4hw9U4KQ1AIVwy5OezTmDPAKr/gHn2Szc3F18j+gjlQZzGvGCg57lS+UloVH7zvF1KwDKfAWlAUJBCrpPV4biTi7VX35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlU9IF7b5wKBQqKBshzRgZ8nkUoS58wH4nvnD4Z4eo4=;
 b=YlwXgdKnD9wejTBjEx9BXFZfCKO4re8swg9lhG6vJws0/f0Rd9nQlVF/Og+DvllqB01I5/Lid2TxqqIl6opA7jSkRchQ3diuLFs9mEfH78J8QFX3d/JFAqR9azhjUhgVvBl4oqsQ+nTWO9BB/zYBLdaSaAiEX9aghMNF88Ea5RSDF7CT4ja4VSCUekBkYjVZgXE9C3gzA+N0Fdp7r8lQJhVplSRkcEmGwGEaaUuNrvb2YHCmmwld6rE69as5SIGPdmZOIFe+4/PP/G9tmYIsoj6qPjOGAp8F/Qu2dPcjE304mBHki1v/4bVjEGeopY9UiRZDFXdmDymb1zRJOm8Xgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlU9IF7b5wKBQqKBshzRgZ8nkUoS58wH4nvnD4Z4eo4=;
 b=ua3labEmESO2jjopmu7DX+LKo4uxTZn8VE6loUt/lFev3dwlq+BLP1ROjxfWC0obqJglkZy8k0xV/boNlbbu/FzBUthXepid+kALiiaDsr6M/ughV3i9Fge/IgPMAGbZRjQwR2VO/YdxOZRTv2w6WyKARGq1shp4BffaHM7Khiw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2837.namprd10.prod.outlook.com (2603:10b6:a03:81::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Thu, 24 Jun
 2021 03:08:18 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::b09d:e36a:4258:d3d0%7]) with mapi id 15.20.4242.025; Thu, 24 Jun 2021
 03:08:19 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        christian@brauner.io, akpm@linux-foundation.org,
        peterz@infradead.org, christian.brauner@ubuntu.com
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/3] kernel/fork, cred.c: allow copy_process to take user
Date:   Wed, 23 Jun 2021 22:08:03 -0500
Message-Id: <20210624030804.4932-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624030804.4932-1-michael.christie@oracle.com>
References: <20210624030804.4932-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [73.88.28.6]
X-ClientProxiedBy: DM5PR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:4:16::18) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (73.88.28.6) by DM5PR2001CA0008.namprd20.prod.outlook.com (2603:10b6:4:16::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Thu, 24 Jun 2021 03:08:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6119420-46db-475f-4b51-08d936bd510f
X-MS-TrafficTypeDiagnostic: BYAPR10MB2837:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB28373D29AB9622DDFB3592B4F1079@BYAPR10MB2837.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NIw278r8kRhdGcv2u6jTRp+XQZq6tG6H65BMTFHihYUyzn3unHswePwOM0J56cVf4UU3ChKuAmdSnpga5Won6kGxbJr8+bA26MeqgYp7aUAwwPWb24MtjPlhAelxJ9vETbsmBLmBnrW0ln+ckgQXyKae/c/d2NVOZHZUCbHpnBxZQE/F2Y1MifdXDdcx3cGAOvYqrlnKEtVW97zymYKQdMLbUMfYGW5Ll/NAsrXJ+Ok2a/luSB/tkWIuSz7MmSsYv1KHpX+9tnwBi+z4weOoA5MNpWlyfSfeYW/6a1vlx1pDi3NKwSpWqAyTitYqZxpxxiJhJ0YY2WI0givoN3YTZpyUrGG7o8n8OGhWsX1drKr9NOI1IVO8UHfR/MaGXIKk5/Z+w3F1P1GsRG78H58cJQG2qhrAcAxTTsFqGSfVn3eAMZBZdZAAOs9K2+3CJc8XiOQp50hqvAACxGcAYIQi02uyUdKskEU9IzHmQJotsW0zG3b8V8G8kzSrC7MsTGhwDt4z4IBT89fFyzascnULtCuWdJt8B10iIt2sPIy2E+n7ECq7ALNfZcuIaNqbpVaAEMNqPcXO1Afb6K7NN2/yGoHJhRXowrkLNqKmvWFR3rgflfGOjakiEj6yxoq+dI3HxGiEC86Sl5AjIiA76uwDMWazKGOWW/DWeUv+gabKIgOAwDhiBg3j6dDZbI2TztUoTJSOZ2GbCWYjb5/kby0FCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3573.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(346002)(376002)(39860400002)(66946007)(66476007)(66556008)(5660300002)(2906002)(2616005)(6512007)(4326008)(26005)(6506007)(316002)(186003)(52116002)(16526019)(956004)(1076003)(7416002)(8676002)(478600001)(38350700002)(38100700002)(921005)(83380400001)(6666004)(8936002)(6486002)(107886003)(36756003)(86362001)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7wiYT5FJv76UijvuxAQhpQ/qFAo7K5XT3egkq98LxMAvSsvmWTGULK3wiwl?=
 =?us-ascii?Q?i1MN7wbWkypWuQcAw+pCATBO+N6rB/lPGObT703nT9kHwQHMt1CnGrWU8A9g?=
 =?us-ascii?Q?e5AMBw8ZGh+GeGVgb4YBCEO5LDo0VVmuxloWBVBitWVmgmwHdBxuJIQvhzrG?=
 =?us-ascii?Q?aUo91pT30c6OI3TbkjlGWWEhfiqYgaKXT7PsGtEjpjjTHICwTmGVwTanCkk0?=
 =?us-ascii?Q?JXcUtQ3CuIZnTzrfeRP6LIEpdGvhPvVYCfXMIZbEZW88J40fQRehO4h8Hr+o?=
 =?us-ascii?Q?L9HlWU6aj9ekGPQTwOv7hPdl/DzZF3nFCtu4GfKeN/nGe22QTnelqc9o77Vk?=
 =?us-ascii?Q?O+F7NFKgcPf/teALqCJR2uUZwPXI0/R0KJ7GHP6wT54jI8fDwFunfIkskdcl?=
 =?us-ascii?Q?did8FlaKGQmIb4sUSjmfdcLqxqYf2wcD5I1HXaTC3ecdmN+ewFd+KX2qznLh?=
 =?us-ascii?Q?uMDDhkTFqhTgdE8leS+tMuu/PtUtdImfNWI9I6PwbSxFAQ0I/nHDjAbdXlbx?=
 =?us-ascii?Q?brEmwwb9DhAlZquz73EDJuO9PUDacW3bkVOpB7Rs+Bq1Le+P6MQ23IogbE/X?=
 =?us-ascii?Q?2HyqWiasseRb5lzCIpFkaxU/LTuJ6e6UNnbCeTj+NAJ26Jay/bynMyswfENT?=
 =?us-ascii?Q?kvtX25gIZUQCpcSEQxqgER8WruQ79gaBj2NVSYOAtO+aHabPD1MGnwJimXHS?=
 =?us-ascii?Q?7UhrPPzuEcGDI4aU/O914hkVHV7pwurR+7/FtTBzEI4hOWkVsuSjCFt4LoSN?=
 =?us-ascii?Q?/K0eFEuvHbzpFfJhh7sRLUybXYfJ+yQgVk6M4/Cfm0/w0e8smm2+wkW97lG1?=
 =?us-ascii?Q?n7ihfne5GZX3BFDQu/VV6j30dgm8OqBfZuxj0i3bDjTFlktb6e6WvPnB9NMw?=
 =?us-ascii?Q?xdBF95Ro7gzwS3e/sYdc6xU9KoT0PKLAA4NKE52RwRJhfeZOpT3B5Tbk+u+r?=
 =?us-ascii?Q?Rg+7Z5409jh3uie4FHyv6p9qEU+cD7szGvIQHaD0dEt0ZUlg3Egp9MQ721uP?=
 =?us-ascii?Q?ndZAanAqnxle1IhjX+kNSjBZavShRHMuW864H3HS8+9pesrdViprcfTqkbha?=
 =?us-ascii?Q?2j0P6BAOiItD5aRw9wy+rUWhvCPZkSFuhhVvvYaHIc7tI/pcNYxGjE5p5zOt?=
 =?us-ascii?Q?3InqljU6Q2RBUpCCQAU3cOrOq164zLw6t7egEncdbRU8oVHoXWCnEWbsYFn9?=
 =?us-ascii?Q?DXqHzu5zmpisiOPb5tIguspOrSzX66kiEiYoCBF8PbBk45LBr3RdaInZblq0?=
 =?us-ascii?Q?oQp6xao6mQYf5iqLqjfyydxj+s8+TN7j1c7XbNUEtcYI637JjhbCGCC99a2i?=
 =?us-ascii?Q?qeFQ0CPvE9Wr3Py58xGwQp4U?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6119420-46db-475f-4b51-08d936bd510f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2021 03:08:18.9159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjQT9f/5DM/NiElw6hzoLeL03kXyuQVd1bZHHgYoWo9eZKSuZeADBBSnyQ9/Qyzq2H9EEOLhG+U+yXy0X1d87aBCmkN8f4EKuC4cFPtmqdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2837
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10024 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxscore=0 mlxlogscore=950 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106240016
X-Proofpoint-ORIG-GUID: 9_svnwZTcDyTdcAzp4RCIy-37KXnn4iu
X-Proofpoint-GUID: 9_svnwZTcDyTdcAzp4RCIy-37KXnn4iu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows kthread to pass copy_process the user we want to check for the
RLIMIT_NPROC limit for and also charge for the new process. It will be used
by vhost where userspace has that driver create threads but the kthreadd
thread is checked/charged.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/cred.h |  3 ++-
 kernel/cred.c        |  7 ++++---
 kernel/fork.c        | 12 +++++++-----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 14971322e1a0..9a2c1398cdd4 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -153,7 +153,8 @@ struct cred {
 
 extern void __put_cred(struct cred *);
 extern void exit_creds(struct task_struct *);
-extern int copy_creds(struct task_struct *, unsigned long);
+extern int copy_creds(struct task_struct *, unsigned long,
+		      struct user_struct *);
 extern const struct cred *get_task_cred(struct task_struct *);
 extern struct cred *cred_alloc_blank(void);
 extern struct cred *prepare_creds(void);
diff --git a/kernel/cred.c b/kernel/cred.c
index e1d274cd741b..e006aafa8f05 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -330,7 +330,8 @@ struct cred *prepare_exec_creds(void)
  * The new process gets the current process's subjective credentials as its
  * objective and subjective credentials
  */
-int copy_creds(struct task_struct *p, unsigned long clone_flags)
+int copy_creds(struct task_struct *p, unsigned long clone_flags,
+	       struct user_struct *user)
 {
 	struct cred *new;
 	int ret;
@@ -351,7 +352,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
-		atomic_inc(&p->cred->user->processes);
+		atomic_inc(&user->processes);
 		return 0;
 	}
 
@@ -384,7 +385,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 	}
 #endif
 
-	atomic_inc(&new->user->processes);
+	atomic_inc(&user->processes);
 	p->cred = p->real_cred = get_cred(new);
 	alter_cred_subscribers(new, 2);
 	validate_creds(new);
diff --git a/kernel/fork.c b/kernel/fork.c
index dc06afd725cb..6389aea6d3eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1860,6 +1860,7 @@ static __latent_entropy struct task_struct *copy_process(
 	struct file *pidfile = NULL;
 	u64 clone_flags = args->flags;
 	struct nsproxy *nsp = current->nsproxy;
+	struct user_struct *user = args->user;
 
 	/*
 	 * Don't allow sharing the root directory with processes in a different
@@ -1976,16 +1977,17 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_PROVE_LOCKING
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
+	if (!user)
+		user = p->real_cred->user;
 	retval = -EAGAIN;
-	if (atomic_read(&p->real_cred->user->processes) >=
-			task_rlimit(p, RLIMIT_NPROC)) {
-		if (p->real_cred->user != INIT_USER &&
+	if (atomic_read(&user->processes) >= task_rlimit(p, RLIMIT_NPROC)) {
+		if (user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_free;
 	}
 	current->flags &= ~PF_NPROC_EXCEEDED;
 
-	retval = copy_creds(p, clone_flags);
+	retval = copy_creds(p, clone_flags, user);
 	if (retval < 0)
 		goto bad_fork_free;
 
@@ -2385,7 +2387,7 @@ static __latent_entropy struct task_struct *copy_process(
 #endif
 	delayacct_tsk_free(p);
 bad_fork_cleanup_count:
-	atomic_dec(&p->cred->user->processes);
+	atomic_dec(&user->processes);
 	exit_creds(p);
 bad_fork_free:
 	p->state = TASK_DEAD;
-- 
2.25.1

