Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91B94232ED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236218AbhJEVkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:40:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10926 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235679AbhJEVk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:40:29 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195L46rg010303;
        Tue, 5 Oct 2021 21:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=i2eqRO0GtFTL2HOU5h5+cVZTA8eLRw3AYVdHEim0AUI=;
 b=mDjt/Ea8/yF32nk5puIsynL8aoO7zbAo6qZmi/j/V41NfvTtna3PbusbOCzVtnkMygFT
 pHyiwhMhcQKeOHagn6E3rEcyC/1/biyioFvPNWWozl4RW95WRFPTV76aPZdMFHxhRXY8
 nygfbDSeyYEm0FqWPvRx+YLJSjZ1osRWS85Adhszr83CmhyHaAUMonYOCfP6L4+jE/k1
 zQ87w793XZduVnVorf6kq4BBK7BrY98MBK1RmYFHgiQB/tgTxG6YuT3x9P630APDWk2k
 RwqA8UDWyfnRcyMT0YKbF09CnBz/VLmD1xcdCzkyxqoNpzrtCVKryHkt0mggIPO+SfoX PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3uq3pfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 21:38:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195LaKlD008446;
        Tue, 5 Oct 2021 21:38:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by aserp3020.oracle.com with ESMTP id 3bev8xcvrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 21:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbjMcqJVzg9BfuJshlc1eLK9z9M5mqUneHZtUV2L1EeYCYr1DKCfFZW0F9PvICgYqi/VQBScy8EwNd0a6w+s9cjbNIHhalSFezuG0u5kINSOA2qYbgyT1e7YQCpxKWR/5SCpM+hwH36Qgbzs7+cKIIGHV3jgAeC0XBxitvdCYk4SdzMvnfrzZJ9yfLsnRfgkZLGADRgXHBl5LBAH4tsJqGXHWbPsg/mape1g8ObSTI5Xo1MFTk4OCMPcbDHiGHU+umH+bj9+OKWk0FLsTU9geKfo4qHyxjN/j7NO+DfADbh2yCBxW56wtFE4c2iBNDYd8XNr9h1bDSxFX5uFvSp/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2eqRO0GtFTL2HOU5h5+cVZTA8eLRw3AYVdHEim0AUI=;
 b=ltT87MWAr6POGKjS6vp5INIAeDrPjJ1kJBJHYbjcxbKWuMRY9yUjrgr/ClPPBUtchOY4ygQAU+VUYrpDGHKGnl310u0tWSIDvhtW6A9EeiN7GsQ10yrIqWZIHKLksfvDKG47oQaha0I5I+xpE1cR6FX9XCMkBduonPzUUHeyJdaNVKicARNJiuX0fuXRzHERQXWV4GAaDNDjLgXMrzXxdzZVM6eLb1fBw2X15Pq6A183Pe04xc2pXuZzvLI7mvc+xi1zHl3ex+8jFCMD8rVwZbN+iQyDuPuYuG0tXmsqFH34lJiJSljkWJJeREt9jnpjhlISrXhT0IG7tAsGdxtKFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2eqRO0GtFTL2HOU5h5+cVZTA8eLRw3AYVdHEim0AUI=;
 b=z0i3NIwPlYFCRt4ZJnwW9U5W0J0+b+BGZ+GjsRRuhSp3oz7lLFygmL6bdxwUrOib2uKe2q8xDu3SBTh8+bdWJX9xjmYkJStJZdVqKCXwOwFhJ1QrFsEK74/cdLz5R0TdyE+bMVRTQ3ceu5xCvZf9lTsoOtYq68y52ZF9w+fyArQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1566.namprd10.prod.outlook.com (2603:10b6:300:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 21:38:28 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 21:38:28 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2] workqueue: Introduce __show_worker_pool_state and __show_workqueue_state.
Date:   Wed,  6 Oct 2021 08:38:41 +1100
Message-Id: <20211005213841.736834-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0158.ausprd01.prod.outlook.com
 (2603:10c6:10:d::26) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SYBPR01CA0158.ausprd01.prod.outlook.com (2603:10c6:10:d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 21:38:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b99bc7d-e1e3-47ff-5ca1-08d9884877b0
X-MS-TrafficTypeDiagnostic: MWHPR10MB1566:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1566878C6DD4D10D05FAE072B0AF9@MWHPR10MB1566.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A4tDggMvJ/I7AH6UJpOPhE9Jb4gGHm9kuJKSgJESHrF4cAAppayBFe3my9z/recAHY7GrG7W5VpcHFx4rDOOfhydTNqjGrxa5QSXu5sxqdJ0A/ZoJ82Zjwk1Wgix48K28rrpj3BJYNoNAhTC3/JEKkGhMk7d6yt3OrI5tHdSUF+b9QWJlatlTMb3kVX2PaW+wLh1XoJOY0+HdBR9IAD0qZK+KRbd2Iz0Rc+rQqW0XmFUN85kj+ViMI2EWLmAK30L8tI2iN/QxqOhyjTZFgiCXTSKuOKJ+c0w31Hzpex16RCnAQYIpNquAN3PsHQhX2gQSRdDKrK06Gyqwjsh2YI06xkvzrN2pBe4IhCwwavtrFRECcC7myhJcOcjR3acJ9SOC8UOxNmd+I1PsRSaIJnAKidKNq+hp9Id0b9zN1+SRDmuyQ4a15DmSCdZnFK1ImVAANsbXIf8xtDdB5ifN0CCzfs96mTNnMVLFuZloC6CXNNWSpL+YKthX3h2c61ipglf0ZKL4V1lab4mkQKjwdn5XLFydGRZMq3B7v6l3PBaw62j2MXQVupAwguFQIMXYgjFr0sBDg1jZHL2M0pMDc0NCEJVCKcEdp+xeyrXj+Xa5rG7lY3k3kwTPt8qtD4KpuS3CjTaHH8EdYa/p8Kh4AvHRTNb5SCxNpt3pKSpzWZz4VJcx9AbQEE7kiS/OiT0QUO1b7nljOiYABpZnzM4MXoWRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(83380400001)(36756003)(8676002)(86362001)(6486002)(316002)(2616005)(956004)(186003)(38350700002)(38100700002)(8936002)(6666004)(5660300002)(26005)(6506007)(66556008)(66946007)(2906002)(6512007)(52116002)(1076003)(66476007)(4326008)(103116003)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g9I2W7IlI3MLtDXKktqjNx2jVeLX/PjEVUsTK8rwJV6aVxhtiN50a15OBcg7?=
 =?us-ascii?Q?f/uVB2x+P97sa7uwn13OufOwNibFgU7YvMr6nt8a/y1DNTvQZXfu8X9QIWpX?=
 =?us-ascii?Q?rBuY6KJl72r8SyPmbzRJxlOjF2c6Msy/O1qiW2JHka4OJjVMiTZXzopYBD+W?=
 =?us-ascii?Q?t12X6/ytjwkY3d4a/LKc7JbUrIe459XwdlZk/QqhL94GzHmtjPlnKpXi91bz?=
 =?us-ascii?Q?IH3bW9zrRgT4s0dPF9pOuD+kqq+1gUbPpKBmZT8JRSaakR7EtaY7gBglM6b/?=
 =?us-ascii?Q?7nIUIDSJZDWa0dok9NKwlRxSkII2UTrHbwj4jMxWpOS/orTgKWGu0vT4zYNR?=
 =?us-ascii?Q?ebM2+igXH67ayjek0PprI4/pOQAOCzV9U9zWbRNtzIy2MK6TFC5P2vXYDQqp?=
 =?us-ascii?Q?KWbYq5bWBN/gGsfkFCNTDObT3WcLfCdOs+EO8/bfoTdv1IqezegA0DcHJIsm?=
 =?us-ascii?Q?AWTPwGFvAgeo65t1XY/Mv6PB7Up1fLRNH3kmFZq8cyLCDG6FCAf94OBs7yjy?=
 =?us-ascii?Q?WHwgo3io/qEheRW5QY8x6V2gETBCL5GFAwYwqOC9Xl6gmpuKjSr4UtTTDEt2?=
 =?us-ascii?Q?2Ji4OA3fb75IQNttR7TdJhyvEsn9xiZW+7sr6dJRVIMYDEL64Irji+lNtL8O?=
 =?us-ascii?Q?eO+XcgLUf/4ouD4zkQM6JU0T6jVpjJJ44ZF7v9v9pJHr219LqmyUyyXKEKO6?=
 =?us-ascii?Q?VSw7sHDp17opM2Sa1JQ422IuL4DiGESdcmPVVyUuIUW3bpQA+C3T5AQCpi1t?=
 =?us-ascii?Q?U2YyG2NxlC+czkiUYGFOx2ADMq8vR22PeJevN67WZOF61Ma6CEhDlii7tRXA?=
 =?us-ascii?Q?z/Qx8uPJF5QQ16OKqWPUbjKeCD10WOYiIpIS3mvv3pbbWu3rI06X6no7U/AN?=
 =?us-ascii?Q?fYkHXbYYgH5vOyO36VkJnojpgaivUZ/xn7KxPLjDbRqHtBN7sl+IpKNRSFPj?=
 =?us-ascii?Q?kLePKkILi1zqAzYdj6cp5zUcKCma6GDMfG+GCoE6Sz8lJMcJRTnQK3qPMzk3?=
 =?us-ascii?Q?+JWxor+wKjfSagb07Lp0I36rMagyAUnxeXCM/ctkXDRPANrrOkZ7PTgYvawR?=
 =?us-ascii?Q?tEi0hR5v2fwOw8u5YcD5R7kuNv0bzRo0mjh65w2b9vkz3PbUBjRjYcpsNPJU?=
 =?us-ascii?Q?c4CVy1VmDRz52TuK2FMuxcLz0RamaTUGAO2a6Mb0Mqdzpljc7FgWSy71xq4I?=
 =?us-ascii?Q?pR2PeLSh7dus7Z/QWfM5+XHhRvhyQnoG6OiOA/JVZCga39QJNN7xzb6jEPBw?=
 =?us-ascii?Q?Vxrx1bQ7rwhxQ6k4iMpLV076KRx6B1ONW6ecabXSWOIwFWG/O/Y+xJ5gtFiX?=
 =?us-ascii?Q?+qZvMpS4xf+q6NVeio4oIf8g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b99bc7d-e1e3-47ff-5ca1-08d9884877b0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 21:38:27.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJgspqh93QfV5w16H6XpdH8PrNcEfhHkVb7qdekLmNcrYlzvOXcL5Ny9akA/5pD6j0ygyyNGJHhR4Bh1GRJK0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1566
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050126
X-Proofpoint-ORIG-GUID: 5KoGm2rd_fZk5j2_bFspZelA99iM0u2y
X-Proofpoint-GUID: 5KoGm2rd_fZk5j2_bFspZelA99iM0u2y
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently show_workqueue_state shows the state of all workqueues and of
all worker pools. In certain cases we may need to dump state of only a
specific workqueue or worker pool. For example in destroy_workqueue we
only need to show state of the workqueue which is getting destroyed.

So divide show_workqueue_state into more granular functions
(__show_workqueue_state and __show_worker_pool_state), that would show
states of individual workqueues and worker pools and can be used in
cases such as the one mentioned above.

Also, as mentioned earlier, make destroy_workqueue dump data pertaining
to only the workqueue that is being destroyed.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
Changes in v2:
  - Update patch description
  - Dump state of only relevant workqueue in destroy_workqueue

 include/linux/workqueue.h |   1 +
 kernel/workqueue.c        | 142 ++++++++++++++++++++++----------------
 2 files changed, 82 insertions(+), 61 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2ebef6b1a3d6..e7b7c3f231e5 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -471,6 +471,7 @@ extern unsigned int work_busy(struct work_struct *work);
 extern __printf(1, 2) void set_worker_desc(const char *fmt, ...);
 extern void print_worker_info(const char *log_lvl, struct task_struct *task);
 extern void show_workqueue_state(void);
+extern void __show_workqueue_state(struct workqueue_struct *wq);
 extern void wq_worker_comm(char *buf, size_t size, struct task_struct *task);
 
 /**
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9a042a449002..21f9b615c255 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -375,6 +375,7 @@ EXPORT_SYMBOL_GPL(system_freezable_power_efficient_wq);
 static int worker_thread(void *__worker);
 static void workqueue_sysfs_unregister(struct workqueue_struct *wq);
 static void show_pwq(struct pool_workqueue *pwq);
+static void __show_worker_pool_state(struct worker_pool *pool);
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/workqueue.h>
@@ -4447,7 +4448,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 			raw_spin_unlock_irq(&pwq->pool->lock);
 			mutex_unlock(&wq->mutex);
 			mutex_unlock(&wq_pool_mutex);
-			show_workqueue_state();
+			__show_workqueue_state(wq);
 			return;
 		}
 		raw_spin_unlock_irq(&pwq->pool->lock);
@@ -4796,6 +4797,81 @@ static void show_pwq(struct pool_workqueue *pwq)
 	}
 }
 
+/**
+ * __show_workqueue_state - dump state of specified workqueue
+ * @wq: workqueue whose state will be printed
+ */
+void __show_workqueue_state(struct workqueue_struct *wq)
+{
+	struct pool_workqueue *pwq;
+	bool idle = true;
+	unsigned long flags;
+
+	for_each_pwq(pwq, wq) {
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+			idle = false;
+			break;
+		}
+	}
+	if (idle) /* Nothing to print for idle workqueue */
+		return;
+
+	pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
+
+	for_each_pwq(pwq, wq) {
+		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+		if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+			show_pwq(pwq);
+		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+		/*
+		 * We could be printing a lot from atomic context, e.g.
+		 * sysrq-t -> show_workqueue_state(). Avoid triggering
+		 * hard lockup.
+		 */
+		touch_nmi_watchdog();
+	}
+
+}
+
+/**
+ * __show_worker_pool_state - dump state of specified worker pool
+ * @pool: worker pool whose state will be printed
+ */
+static void __show_worker_pool_state(struct worker_pool *pool)
+{
+	struct worker *worker;
+	bool first = true;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pool->lock, flags);
+	if (pool->nr_workers == pool->nr_idle)
+		goto next_pool;
+
+	pr_info("pool %d:", pool->id);
+	pr_cont_pool_info(pool);
+	pr_cont(" hung=%us workers=%d",
+		jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
+		pool->nr_workers);
+	if (pool->manager)
+		pr_cont(" manager: %d",
+			task_pid_nr(pool->manager->task));
+	list_for_each_entry(worker, &pool->idle_list, entry) {
+		pr_cont(" %s%d", first ? "idle: " : "",
+			task_pid_nr(worker->task));
+		first = false;
+	}
+	pr_cont("\n");
+next_pool:
+	raw_spin_unlock_irqrestore(&pool->lock, flags);
+	/*
+	 * We could be printing a lot from atomic context, e.g.
+	 * sysrq-t -> show_workqueue_state(). Avoid triggering
+	 * hard lockup.
+	 */
+	touch_nmi_watchdog();
+
+}
+
 /**
  * show_workqueue_state - dump workqueue state
  *
@@ -4806,73 +4882,17 @@ void show_workqueue_state(void)
 {
 	struct workqueue_struct *wq;
 	struct worker_pool *pool;
-	unsigned long flags;
 	int pi;
 
 	rcu_read_lock();
 
 	pr_info("Showing busy workqueues and worker pools:\n");
 
-	list_for_each_entry_rcu(wq, &workqueues, list) {
-		struct pool_workqueue *pwq;
-		bool idle = true;
-
-		for_each_pwq(pwq, wq) {
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
-				idle = false;
-				break;
-			}
-		}
-		if (idle)
-			continue;
-
-		pr_info("workqueue %s: flags=0x%x\n", wq->name, wq->flags);
-
-		for_each_pwq(pwq, wq) {
-			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works))
-				show_pwq(pwq);
-			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-			/*
-			 * We could be printing a lot from atomic context, e.g.
-			 * sysrq-t -> show_workqueue_state(). Avoid triggering
-			 * hard lockup.
-			 */
-			touch_nmi_watchdog();
-		}
-	}
-
-	for_each_pool(pool, pi) {
-		struct worker *worker;
-		bool first = true;
+	list_for_each_entry_rcu(wq, &workqueues, list)
+		__show_workqueue_state(wq);
 
-		raw_spin_lock_irqsave(&pool->lock, flags);
-		if (pool->nr_workers == pool->nr_idle)
-			goto next_pool;
-
-		pr_info("pool %d:", pool->id);
-		pr_cont_pool_info(pool);
-		pr_cont(" hung=%us workers=%d",
-			jiffies_to_msecs(jiffies - pool->watchdog_ts) / 1000,
-			pool->nr_workers);
-		if (pool->manager)
-			pr_cont(" manager: %d",
-				task_pid_nr(pool->manager->task));
-		list_for_each_entry(worker, &pool->idle_list, entry) {
-			pr_cont(" %s%d", first ? "idle: " : "",
-				task_pid_nr(worker->task));
-			first = false;
-		}
-		pr_cont("\n");
-	next_pool:
-		raw_spin_unlock_irqrestore(&pool->lock, flags);
-		/*
-		 * We could be printing a lot from atomic context, e.g.
-		 * sysrq-t -> show_workqueue_state(). Avoid triggering
-		 * hard lockup.
-		 */
-		touch_nmi_watchdog();
-	}
+	for_each_pool(pool, pi)
+		__show_worker_pool_state(pool);
 
 	rcu_read_unlock();
 }

base-commit: 29616f67fcbd6b26242440372a3b0f0a085109c6
-- 
2.30.2

