Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77240382323
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 05:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhEQDlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 23:41:22 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:62177
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhEQDlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 23:41:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkcprhXPtFVpa/0gAujFWeq101ksQ4ngDad1GEOIptQwMqK6q28Y3ow6JHzURp9CjJLMjSLOj5Z7ZB33kBRJQcyVv+LXOteAg4ABKc+Y3Pb6abgqii7FjXcNISLgQ1i7xLCWAOVhVY1uQLvcEq4lWQAv7AN7m7usL/emCBe/6GI8SGA9LpUz1CLBpKW/YVipocuK9oYnA1kBQHdtaHw+Fwxa9ZPu+RtYA21AgKyvyNxR4VRAH0PFbBG8/7x1SYqMY1zGblUVwmq36pD+nRCxVo1JuET9D69hPDvrZVnUnY6EeTJs1da82P1LdW0JHITKzPId9+63hxTMBPPrtLNa8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBecinzL8ISB6yPGPwF7RdCxB7A+liWh5OcSdkfzI64=;
 b=Dhv7gGKupzI54Unk3/wHFm+/pmhyuzViYrhW7ra+veCeX4xYWvm0aLOFjmGd7mre926w2IkvWmnPGlfrcAoQJgtDt0mbx1zSLmFqTq7Kfs060e0YgB61+h+KrqqbKESR6tchnnHeNhjtFIxNzh9xoF4TPBYtlRZCBHGCVu2StvrdDdBwEQSII05feTFCRT5VD6xhFYZzwXbi1eMb0mPsx3Z/z+nrl+RxLnSGrwwMOKOO7nqI2NExWr84vKizRR0/CO4CK/SU9GGAPIt2npwLym7nd23zU5RJMqQTtuAMmx3cKt8JBb6HNoW1jnzyBkna0RYCzb+0x4LsceYSu+gCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBecinzL8ISB6yPGPwF7RdCxB7A+liWh5OcSdkfzI64=;
 b=WNnl2GrqSyRIVAsifF6LMOmG+ibN5B5G6R1eDlWMY0N8etNMB3Diar8Sy2MRgJzxYZ52WGK59NSX3UzRCIk48IV7pg2cTcDfdmzn6+00kHXGqLp1PDEXvUkxaRPqzHn5ZLHZwxAThX8O1RwoMnNuONts9b0e645thr5a7/ZnlHk=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM4PR11MB5294.namprd11.prod.outlook.com (2603:10b6:5:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 03:40:02 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 03:40:01 +0000
From:   qiang.zhang@windriver.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal
Date:   Mon, 17 May 2021 11:40:05 +0800
Message-Id: <20210517034005.30828-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:180::39) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BY5PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:180::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Mon, 17 May 2021 03:39:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78914cb-f2f3-49aa-42ba-08d918e57395
X-MS-TrafficTypeDiagnostic: DM4PR11MB5294:
X-Microsoft-Antispam-PRVS: <DM4PR11MB5294502FBA7BA0B25F6662DAFF2D9@DM4PR11MB5294.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYRAAFzmCsmXLMCZjWu2uHrSMTG9veObvRfoA/r2uvOC4j7ilOyKieQSUqBl4PS5/bQ0WRsIQ6qrF7+Z6wKTcjHMIuzQoQzFxBVdIxbe7z4XCSWw2uEKPAfZ1DI4NSmISMSRAzBEU7kvUkEU44N8NhQW1l6fTF6Q8y93ap0dsszgiS1yaAPMh0gJ6M3N0KukHCE+D57UBuWmPboC6WzwjtpySUalCgmIo9GyobGMkD4kG/OkddsqgyH04ezVWo79NQ352WRL47OwxCtwwP02919a7/8jnOkKv78iMhFUgFyaMaVfG7r3sv7VVAp4OsXeRa+ZE4JDfWIUnABpUm0Qu5IecIhI7s4hwfk2mnWQ9OTgUyMwmkQiOeCgDDsxxoWq7Ezr8v0Ff4N2G3Dh/5OzGTqVnI47QCd9UVFDESz7oxOkmaW4a4HXSRPVAId6lPCjyWV67BXiT1uS8UQYuCKC5TJjsZ7qelVrrJZ5TABBkn+Ika9YvX0IVL7uOlpz0TJD7wLqRJvHMzDKXtPTi5zH0BCpS35ryI0Re2JurFEBN3r2XIZ4RAS4XYgkAsFNkln6BigRFFFbNtFKKZDe36UI/2HL+j58K88kKKgFNJYtCH5jOGkJRnJ5xab25bXyLSnLN9hcDuEngmdeqvAyyZ47Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39840400004)(136003)(396003)(346002)(52116002)(1076003)(66476007)(36756003)(5660300002)(316002)(66946007)(186003)(66556008)(86362001)(6666004)(8936002)(6506007)(26005)(16526019)(6486002)(38100700002)(9686003)(6512007)(38350700002)(2906002)(8676002)(2616005)(956004)(83380400001)(4326008)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?VJ/NJII1dwZQuFTR5xmEz+haXb+KnREcjpWAHwcHl8zI9EQFeUHtiLA2SGXT?=
 =?us-ascii?Q?o7zgRsnHfvEFFDS03iCvZ3uR5MwyIaHkuQsWkaz0YMwwgyZZWwicZ4DO9iYF?=
 =?us-ascii?Q?Wsem7BvmrCtbuNzi0B6/UBQWLO8ayZqPCmpgYsmyGQi1YPbTFBEJe9Fr+Fyu?=
 =?us-ascii?Q?RUShpbcx/+AiSR5B7GaoiA7KJB8w8lvv4VYgzXh54jab/brqHVphQJ9zCMX9?=
 =?us-ascii?Q?FOvPCb9nCN5tSfxi/D4pF19qw9ZGrQWwZDlvqY+UHh37mvOfDAblTV2V/0Jc?=
 =?us-ascii?Q?YkKWO4Fn3nJ6wX3AGG9ER4F3ZDblF/WD/8J1GECF8DQRN7cw4WldBP1eNyjf?=
 =?us-ascii?Q?v90pzELdDGpp8aevJH39xx1tp/dGXR3p9uypnR5ulw7x6El5eEAqQqPTe+Ye?=
 =?us-ascii?Q?KX0Fsk8rB7iVwyl3mWlXuHeAOG6gd1jW4u0GS87TEB7MUhAJxonmmOQpw8kN?=
 =?us-ascii?Q?CXtYRg5d4tOMLItZpoZz/U85HU7y5isKTbCJB+UgO0i+mcbWTi5HAYSQh/Bj?=
 =?us-ascii?Q?QcyCQJZoEmmV+GgTQlAqbbS1Wh/d/rxJf0SXL8U0/XTts94xIQl5uP8DPQXb?=
 =?us-ascii?Q?fucC/3lP5aRd6dbhYwuuUNStJhTmRppFUjgPaE96JOIWuoXiDOQauqBKtwmM?=
 =?us-ascii?Q?FBkRRG+KOUDWBtijFdfF7nHu+dGJ9M5K8IWMF/g2zXvGnPXIoJrvcVCd5npc?=
 =?us-ascii?Q?ShuzneR+YcDE5JRVCRLDo3cA4mvgo8B9Uq48PGxmqs+XgHZUrQtw92Q7eyQU?=
 =?us-ascii?Q?ZeRS8R+ZCGIZsp1XsrXY0q5PCk3h0P/oO8zZ8fDhfVrAwUsHrG7YH+jrUyhB?=
 =?us-ascii?Q?HQFDE6p6XUHJRcYSCoFdrjVRIrq2vrQeHJJBGu37lJqM2KPkbiRv6tf92ZTI?=
 =?us-ascii?Q?oTYUXymqqkDZ0f53BANIyMfITEZVzhp4G2aRPBWJ+26fG509kTi5BIAeuSwy?=
 =?us-ascii?Q?YhtH3NKxMqgtwp4tVCWC8Fn9KGg2K+/h8WIHh3WIF28ZXVsHbfUJmv/ufxhI?=
 =?us-ascii?Q?VROirR1jzo6Tx7Fyfw9miBLGbS0dNfvcFTA2RAXEu3lobo41pNasySZUKVjq?=
 =?us-ascii?Q?HyuhTb0O6gLFxCUzIBA63g68QaP7TYgQ56RclvhON7nLuxhyi49VkVix4gx6?=
 =?us-ascii?Q?galp+vi/o8WrLlM9AkOABTSdXTI1fv3tfkLVRDvQx9Gb44jUF76EdjakKoXe?=
 =?us-ascii?Q?v+6j9lKDkGvIP46QC2zlM2/yUONohxSMRDQih9AtabLFF9sW4eDl92oa0G/p?=
 =?us-ascii?Q?Ny3kJvqYpP98zjfAbpHFkS+LS3fUtKCEj50y0dqmARuG2x5AxQZ1p0NFcC+N?=
 =?us-ascii?Q?/1XTNt5I9oZjgU0HMDG/CanM?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78914cb-f2f3-49aa-42ba-08d918e57395
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 03:40:01.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm+rJLaclVWEgJWpPz9svCYDAGBHQ/1JTzAh1tHF7mDYMoqHEdh6d2xafkiue7SuyhKEi8M9EcfzrsUuDHQZjeOVScG3igBO5fNc76c8Zbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5294
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When a interruptible mutex locker is interrupted by a signal
without acquiring this lock and removed from the wait queue.
if the mutex isn't contended enough to have a waiter
put into the wait queue again, the setting of the WAITER
bit will force mutex locker to go into the slowpath to
acquire the lock every time, so if the wait queue is empty,
the WAITER bit need to be clear.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Make commit info clearer and modify the code again.
 v2->v3:
 Better description of submission and add 'Suggested-by' tags

 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex-debug.h |  2 +-
 kernel/locking/mutex.c       | 15 +++++++++++----
 kernel/locking/mutex.h       |  4 +---
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index a7276aaf2abc..db9301591e3f 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -57,7 +57,7 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	task->blocked_on = waiter;
 }
 
-void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -65,7 +65,7 @@ void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
 	task->blocked_on = NULL;
 
-	list_del_init(&waiter->list);
+	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
 }
 
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 1edd3f45a4ec..53e631e1d76d 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -22,7 +22,7 @@ extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
 extern void debug_mutex_add_waiter(struct mutex *lock,
 				   struct mutex_waiter *waiter,
 				   struct task_struct *task);
-extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112ce155..5de85a575dac 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -205,6 +205,15 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
 }
 
+static void
+__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+{
+	__list_del(waiter->list.prev, waiter->list.next);
+	debug_mutex_remove_waiter(lock, waiter, current);
+	if (likely(list_empty(&lock->wait_list)))
+		__mutex_clear_flag(lock, MUTEX_FLAGS);
+}
+
 /*
  * Give up ownership to a specific task, when @task = NULL, this is equivalent
  * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
@@ -1061,9 +1070,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			__ww_mutex_check_waiters(lock, ww_ctx);
 	}
 
-	mutex_remove_waiter(lock, &waiter, current);
-	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAGS);
+	__mutex_remove_waiter(lock, &waiter);
 
 	debug_mutex_free_waiter(&waiter);
 
@@ -1080,7 +1087,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
 err:
 	__set_current_state(TASK_RUNNING);
-	mutex_remove_waiter(lock, &waiter, current);
+	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 1c2287d3fa71..f0c710b1d192 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -10,12 +10,10 @@
  * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
-#define mutex_remove_waiter(lock, waiter, task) \
-		__list_del((waiter)->list.prev, (waiter)->list.next)
-
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 
-- 
2.17.1

