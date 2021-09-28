Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EEC41ACFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhI1Kcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:32:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:40944 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240124AbhI1Kcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:32:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18S9XtWN011480;
        Tue, 28 Sep 2021 10:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=RwZmMliA2wFSVeHCQAFKAvvxRmyrsTGsxn7rlEy1Jwg=;
 b=zBMEby5H2iaaR0P/Ln2kHmr47YpTTgTCN38Fy1Na6DGFL9ygk4CBOZzGWzV598WRJV9D
 tV4Rd+1oivZOLFruRD/I69JUK/8/nLvgbljNTuaHYOzthiXacEYVzqVL9y80moLIzMa4
 XPkxa3sH+Mb7sMYer7MKwwxCNJS6pqVeVK4tCX3CIIodDixsQCMBUi9XOm3DspOlQp/Y
 8AFKslQv0lAqBYDA4v1SfS+P+c0nf7FMZRWMZs58AqDzCz3wDZkzB2DGQzg84bnUIVqQ
 XWKTBvci8mn83nk5rxpdAh12UXxksy8XrRGQ9swT6S6KEbT+c2CVJESvKjAf5NSuscKe 4A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bbh6np00t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 10:31:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18SAUHOC003729;
        Tue, 28 Sep 2021 10:31:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3030.oracle.com with ESMTP id 3b9rvv711v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 10:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjmssXLNo+UihUYh9OoiT2hVNZYh+/JVLiqgy/Pwk8/P7gDmv097ZysKxphR/7NGo1/M9KX53PoCt3AfV/UzEk1Xoukq8TRYb8scXZWvgOssdjMc5yrOzbCF9yRXoUkx6F48P6VpbcDyFvHqzef1FbIBCgiByxEHdc9zcJcZ4bNnstDgMZDeXbyWZV5jqpBpOzDDYq5JtuBC1ZzotS2ItxvFdzgkNFhKBKhp7I3ozsK7AakGyro24tUrwnpt5/RL7HdNQeBx4RiPeKSKRJRfZjJDjfKoZCQFYgtD91TlZBro4BmEe6zEG4hOL5XBb/jHTq8+s7aH8jPQDHcbKhf+VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=RwZmMliA2wFSVeHCQAFKAvvxRmyrsTGsxn7rlEy1Jwg=;
 b=l4KqPOtR18WCeV6+s2mX2xyYFJN4nv7gazG3QGdMaFpgcnO31ENJGWcQXc6JEnNinrmDR5JFTJqiJe4K0uST/ZM/g4js6+tGqzQAKZN8kozvsvO3SLFeTevWj9oXeWP2+Z8P5vTJFp/6pvS4/NLWKtD0oDrwZtq0s2xRBDDvfB+nLTuYeNC0n7hncoThN+YirpbbZ7ig2X5jqsdxyBh7cJDoZRfrpS1qMJXd+DgGQyk5VdABFm19hDd9EY68/tgzPYIpBsXMT8HBLJRr9ugINSWLjHKTpwisUQCm0/sA8owEHqQfQsETkIE1GfFfTycS/mpNLcK/sj+BVuz1NWPHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwZmMliA2wFSVeHCQAFKAvvxRmyrsTGsxn7rlEy1Jwg=;
 b=mtvcAZt2T4OgLTnI05PdYtc5JTSV50kOIw6cvRv0CIP5PNfsB5FF8zE52Qh48/bbmVzEr07CAXPjoXqgzYKH4g+ShjWMks/J+k+baaG03RQEQ+UOunEKeU7SZYuI801ZLGK2DufAIHdHpO8veDj8EqNKYhrsQBA6dypyD6KZ2qk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO6PR10MB5425.namprd10.prod.outlook.com (2603:10b6:5:35f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 10:30:59 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::f091:1dd2:38a8:e986]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::f091:1dd2:38a8:e986%6]) with mapi id 15.20.4544.021; Tue, 28 Sep 2021
 10:30:59 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH] workqueue: Introduce __show_worker_pool_state and __show_workqueue_state.
Date:   Tue, 28 Sep 2021 20:31:06 +1000
Message-Id: <20210928103106.391694-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0002.ausprd01.prod.outlook.com (2603:10c6:1::14)
 To CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SYAPR01CA0002.ausprd01.prod.outlook.com (2603:10c6:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 10:30:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eb75df6-8a18-458c-6c25-08d9826b0fee
X-MS-TrafficTypeDiagnostic: CO6PR10MB5425:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5425774D2404A40352ACC748B0A89@CO6PR10MB5425.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ddlN3f8NyCn0+MUP5MndligCM7x8wgwADSnE8DVpL+ThQl2LHd2oarVcF6hnV8JpgDeN+XGDgRg2skbFzO1g7oBdpmx+QMY+Nnj+Rma+FVaxcVcVtfyedugxw1xPX/yGlEiOfbTwwm7WcNBzqJslB1eq1mtcyHE1Dh/7oBwims+GdGntyoK2/gr/iWtnhZQXsvgFuqntm2U8IrPEYDRa/sT1LsH0foKY5EV6yHiXtTbb2fJ7PKf8yHjWEdyd0m7YAcW7L5ALOaMHjpouDNrIBaZnKFCxRA+cd7mVtCgoIjCWzCDK22kosu5BDt/TjyvHCHsacIsiIYpBtcJ0PYBSZnBcYmUknF8QomTLDh3ErOskKV/cH5Nhc//8aCgYnxTehqVv//gu8OCH/xzE+omBHDSRou32Eef+e2bDvCm9Z0z5Iro23bL8owb9+kl+5AgD0H7KzKfz9lM5rKvZDR0hfSq++WZQrQ2LmMkeQX7tiMSAWrUBRn5h1sJv9tHSoVoy81mfXtONy0+qdYrVbygIAzKckT2x9gxwq20i5T7qYS0fWuSn8qxKcnOAgEinLcds/G2LbmTUGdQ2uRWxcJrfG5NaVhmNWvV4/kmoP1YDqN+UcZi2jfForUo4/5d6NEmphj1wCcR3fGGkKAjQpWFRZBDAH9/W2whVyFIJPo7lIKwnr1j125saUDXiVhRl6EsDS6yZiWRzR959E8805KU/zg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(5660300002)(508600001)(6486002)(52116002)(83380400001)(38350700002)(38100700002)(4326008)(1076003)(86362001)(26005)(6512007)(66946007)(2906002)(66476007)(36756003)(66556008)(6666004)(316002)(956004)(186003)(103116003)(8676002)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7qetGqQx0TBxrJyXB2pf7hr8GuqHgtjCCLSTnNY+Sr7MCNCQ9xPVGAtgUto?=
 =?us-ascii?Q?+R69PgqUTovuYZBuH9xdNKJb5e+vMHWMm74qa4lpiuRnmCPZIC9PvgIG2sN8?=
 =?us-ascii?Q?YYsCSHATZAjJQKR+DX6gQ0IsO6RqBpNDHIiLOojhSCVPscpdiEvOpWWcSF0J?=
 =?us-ascii?Q?8dVHX4OTqej1jeDk28VfbwXgsspcTBlx9i82RjXSSVgW5JvxtSkCnSnYnZk0?=
 =?us-ascii?Q?PqC0ptUaB31LWZI87LAmafW1pvrQ7SiRS0NLJVA0S42syM1/tGEf9JPUAZH/?=
 =?us-ascii?Q?/1OHr/XuhvbysjWa+watTbfQ0X2QOrCGUKDkh1u2tI/AWb3cslVUqtBzARsV?=
 =?us-ascii?Q?rJ++CrEeq5VmSfaT5kwXfQkD6unK6O4+5YNb1OVURHeZdCe9hRXbchP0Qfe5?=
 =?us-ascii?Q?85GfY0brm/uxLxv22EIE8yjD1FP2aNNWDMbosaOTHujLS8NhPgjFOj4DlEqI?=
 =?us-ascii?Q?mwsGeISARAnfURepngqnSrO1bvWSkL50tRC65cZj7tHIX3Fz4OuTRv5StUWE?=
 =?us-ascii?Q?r8AjscWC8jUy3WBNrVq4h6sNspHMuMcpgmk/6pUt1gA03M3h1L1lmFZ6cV4G?=
 =?us-ascii?Q?Vg2ROml0xsPTw1Wt8ZCDFtZcmFnrTxYWfHtb9yV9WiJk1J+0pEQs4pplCS5P?=
 =?us-ascii?Q?ccQNRsbdykb8qgVCYVS3T/Dedol9L9oNP/ty/v5w7nDeB4JpfZ50xua0a1zl?=
 =?us-ascii?Q?fkyubATHGPp1vTISv+x1HRj2r4zShZYhy1b0y0YHpzviNLPR60HivUYB0wHH?=
 =?us-ascii?Q?iCK2tMTuDcFoM+3EbuEUlR2G/um2l77AU9/Wr2py3BpFU9mCjsevgHZ1hdNw?=
 =?us-ascii?Q?RdZefO4lD0/5EP0u5oTxhlkEBuU/rA9X83h4jWfiq8ojI0gXP/ik1Gpp95n7?=
 =?us-ascii?Q?Lj85H87bAvGFrlgDZc89i3Y4DZfgXiK/Rw7+JwmdRSjs9uOyeMBa5WDTDEtk?=
 =?us-ascii?Q?bmNubrwLTLcJMIJVI0RarOnHoMeXNGjr3HfC+CWm2gwBHWKkzZcbIthNnmD5?=
 =?us-ascii?Q?ItHFA4N8/fo6xxif3Pu25yb/GCKiPKViLsA+EZ0Stdp96ZNcfVKis90jxm2W?=
 =?us-ascii?Q?zQn32BkLC/B0Q73039h4ZsSZVxyMZjPlVWjqVZQVPo7yEFK42xUXifer9+oc?=
 =?us-ascii?Q?hXEcHQzoRRKoI76si91SHL08LhVuwvjEWSEQcOVIFs7KTNSJPGTyEWBfT/4d?=
 =?us-ascii?Q?JaKHcDDixqM8sztYdJoZ+XpAr2vPhNVTl859mEBDGWcQKscmkYlB2ImyfEh0?=
 =?us-ascii?Q?fGOswXvGM/Y16EjQpSUmLzzkTzZnfFko1G4MDjozUeOlxWBtge2909ZjErmo?=
 =?us-ascii?Q?fH+UnsSUCkFj9V+LS1U8GO58?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb75df6-8a18-458c-6c25-08d9826b0fee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 10:30:59.0956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNMPH2ULFyfy7U0X8U7Ejh63uGcfV0ivsQg5y5rQ4S/7f66sLvT+l98Qan4mFU3WM3+z/hbF3I+siQF4vx2Bfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5425
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10120 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2109280061
X-Proofpoint-ORIG-GUID: eecbZ93vHmdzgL9sVYtqBanrXlJI8uYX
X-Proofpoint-GUID: eecbZ93vHmdzgL9sVYtqBanrXlJI8uYX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently show_workqueue_state shows the state of all workqueues and of
all worker pools.
Divide it into more granular functions (__show_workqueue_state and
__show_worker_pool_state), that would show states of individual workqueues
and worker pools.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/workqueue.c | 139 ++++++++++++++++++++++++++-------------------
 1 file changed, 79 insertions(+), 60 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9a042a449002..cfae0c8d5e2e 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4796,6 +4796,81 @@ static void show_pwq(struct pool_workqueue *pwq)
 	}
 }
 
+/**
+ * __show_workqueue_state - dump state of specified workqueue
+ * @wq: workqueue whose state will be printed
+ */
+static void __show_workqueue_state(struct workqueue_struct *wq)
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
@@ -4806,73 +4881,17 @@ void show_workqueue_state(void)
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

base-commit: 64f28502801aad0cb4f97102b4b5a81df315c2aa
-- 
2.30.2

