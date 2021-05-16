Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92583381CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 07:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbhEPEze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 00:55:34 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:17280
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232769AbhEPEzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 00:55:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5ghua+lfxZub0A0rUTuVRbhglzyCcE1rOvazbCylcrzi/lAPMbu957s4GBmW+gV+enjjHFC+vV71vg1poMAR5RQ7a8nE3xA45bRGdIEKUf/DOnVE84fsVZBO9GBAwykrEcNVk86TZmbay3JlArjBqDMKCzcdUZf6d+QnVawr6nFMrT9T+vkVMRUNWy09Sj57I+x/D3JOy0aPk93kxScsjpeAJumZqpop/q6B0cdnUI9da826PvEi1qMPHBM85ihpKZrnTiHPaRQvMc+Ei++hgfmNh6gcQ11cedcUacgvDE3KyLwGo2cOTrrvME8O946Nt+HaQaSWPGfp62SFsl+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03t/cpoJXB9ig0OFWJB3nF1qK/8V8NZCg2LMkfr+TcU=;
 b=RSST/kz6CcD8Sg5xCkMePrTv9rQRxL9XrOOvPYrwXHYG1jbzCINzR6cLnDYTY5l5kWY+RvR7k3zh4SNGA7B6cGgbLLRpNgvkGHRz0sIk1aora/ZYsoBv0e5zdGPS5cIkPhZqJlaDfEDH80B1RlzEuDZJvwj3Xz85r6HuPqUTHN/JebNwkYc+EWs1cedUhb6NUyFc3WvOHnzFMCQGl5s4T38IvIyyYzvqs6zd3vEO9Ot65vn1cX8/uGWZ2B+HbEGregtAaft8U2e9TFG31gx2TQ0S5xfUglM6HMh8FuuR85OrlCnuM/IgxorscGI4En0LStBJWyKz/MZkkMePGGQNWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03t/cpoJXB9ig0OFWJB3nF1qK/8V8NZCg2LMkfr+TcU=;
 b=WAPO4kFbs6uSOpJ7VoeiDPJBBbbwrwko4sdfQ1TSnj/OogLR4WWX5Ru17+I66AKGyhQMXA36L2LFG+cz4eca/3rra4cLs9GQSyqUiiljrIzzk9UdMaYWJ1dGmJOaKwUow/lcvcDluwbLKqQ8s6oDvVzNitD+6JymXqjcs97DSpA=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM5PR11MB1305.namprd11.prod.outlook.com (2603:10b6:3:13::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Sun, 16 May
 2021 04:54:17 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4129.031; Sun, 16 May 2021
 04:54:17 +0000
From:   qiang.zhang@windriver.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, qiang.zhang@windriver.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal
Date:   Sun, 16 May 2021 12:53:54 +0800
Message-Id: <20210516045354.348117-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [240e:304:8181:8460:98c0:7881:2aa3:e507]
X-ClientProxiedBy: HKAPR03CA0025.apcprd03.prod.outlook.com
 (2603:1096:203:c9::12) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (240e:304:8181:8460:98c0:7881:2aa3:e507) by HKAPR03CA0025.apcprd03.prod.outlook.com (2603:1096:203:c9::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Sun, 16 May 2021 04:54:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7aba27b8-443a-461f-f4c7-08d91826a8f3
X-MS-TrafficTypeDiagnostic: DM5PR11MB1305:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB1305D0EE0B0A519EE89443FDFF2E9@DM5PR11MB1305.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:639;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ad8zkxgt7wq8DniddBYxQMvWP7+nl4obrGxLU3eg1i2ZS/mayH+hnSvMFSkpjpB/2yQb5KbErhUaczbmTUwKOmY5Gxjz3odKThtE0Mygp/KJP2aQoEQRhWu6Dp2WDUJaPylxHnH+Ab27zptHeiYBcNUuoX2JpxmhquHHvduNtSxoST8c1EfCw50UCPru4b2um5yFWSyFa3uF65EgB2M4AbfwV4Hn7v+26AdGXl00XyNLecpSkUT+kWE8yeghOqNV0uGA2dCH25Q7WcjXC+SwAcaizfzxdERD9lSpLQuA0WEDiT4/VY+gjubF7VHFH/LZhgJkAUI581/3NnlAv8RBJuJxf7A6JpQhBQKjc3SZYzktbNTpdFhFxef+XHuxPOpZLTYtWtI6h6v2szvqiAHipLyBwjCuOjkvaafVdv6UyhrvG7FWKhC7VmF6fXQK6zs50PdgcH0TQQvpoNXmuB2IXoE+XEkZrWZUeTHpA4jh2r/BDZRI2WB5nW7JQE9/oCn5gafdUYad6ZtICeRr58UeYIdOgqAhNMlA6ERccsP4AL75MMvXDw8CciWPcQSqOSd3DO0XgQbEBpKHAMS/jWXx5/qnnSwBARxVsCfnrKXB3ve4E9K77vXK+5um7P/00hEib8KFFhMdcUPitJ8MiAtreQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39830400003)(366004)(376002)(2616005)(6512007)(36756003)(6666004)(9686003)(83380400001)(1076003)(2906002)(5660300002)(4326008)(6506007)(316002)(38100700002)(6486002)(66946007)(186003)(478600001)(66556008)(8676002)(86362001)(16526019)(8936002)(66476007)(52116002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?22uvDN6yJkQtHtTGTCZk5ilXwd7gQXznKsup1ikb52j9CrcanOktVpZHqDPV?=
 =?us-ascii?Q?C+B8XRTeScE/JGIZfX695GWbbqYsnIKjB2hNiSbYJjTLP5Qifw3vDxG7IDVc?=
 =?us-ascii?Q?cOuygJrc8O9eL5sTaTEyK5mUolfzb8/5DznNG1K+cAHtWqCeyymqEhVAtjqa?=
 =?us-ascii?Q?Mu5Gv2eiGNIdASyfKAV/YQc4OMi4WcARw1Ml8q0TQ2spXacoqnmoXOpDjFWq?=
 =?us-ascii?Q?rv2Z87ICoCjqkMsL7Wu6qpnD+aIcGltkQfGOUM4DmflGTcfa61aRRYU79LFv?=
 =?us-ascii?Q?2TTCcnUtJsg20WUJ34yUENQPQLzemVmlr+xMFj86jIj9Tl2fLZDB8KqAJE59?=
 =?us-ascii?Q?r6cGQCvQY4ciq/+9ezR23WJhRQpLV+nFdvVfz7k6m/0AwdEU5c7B2CKd14JQ?=
 =?us-ascii?Q?E9Z9f4i1cf9ga9PcHI/kjAZK9MsuOhJMgs0//FjPXqnt/DZOcqAoz3spSrdW?=
 =?us-ascii?Q?BkjYWMwacO0k2PnsLkaAQM0JEg5XWccskmYtl5tkDQBD2ZydcHKvgBAA4LoQ?=
 =?us-ascii?Q?EckICkqkBdtiYV5VXNOMcKOFTIM7+GYrnxGWp4Cg9uOS2PadxX+Ge1SJAgLm?=
 =?us-ascii?Q?aZQy+2iaw3pdqSaQrSBiYb9iRNloeUB/fDsR+6YZPb+mv7rZ3unecpDKVNBV?=
 =?us-ascii?Q?UzoL7P37xRqF5cadyDaB3cSqCBQOyfqcBjyTvn6Ik3Hu9a9Zdnoxpqs8p8Hr?=
 =?us-ascii?Q?DjyTNREPyQxp6PHWgV6Zj09ai2t9sMKGXxH2397zjAKXQK6gB0TL407YxrGo?=
 =?us-ascii?Q?2eJLrGizxuWDiaOdfur+3mDVgxnEYSkz/5zeyr0+UAZ74XpajljuTNL7ljub?=
 =?us-ascii?Q?B0+ZUaAjIZAiJxNVgRH9yY1wakD7UawVl44jVe2CmEPf/ep2dqko+20nNzsN?=
 =?us-ascii?Q?P7qJbKIQRT3nDu88hHlAmvRbMGGkmny16nCB+TH/BxtHn8oVOvnI90TYsYRq?=
 =?us-ascii?Q?3XU9yIY2Sr/TfeteSX1yPdx0dHe7CiMZseKGXtm0m0O7VwlFCeKtHGyzaBRM?=
 =?us-ascii?Q?8iro7vvcWJysciVccQuraR9p1glJ3drz6WaNJ2tEEifGVhAYJxK1hyIuYY2+?=
 =?us-ascii?Q?UtdoV/mk8GTYFQMJv1nn2+OYmbeIuPzlGUABxVX7bf64yhKU8w2qWtHsfgK2?=
 =?us-ascii?Q?U8qyv30+nxL7fxr9Y1lO6ACDqYYdvlDs/31SZsyj6XmVPbMDc2RvyQsyYTWJ?=
 =?us-ascii?Q?r3p1jCLEDjbQ38zJKYIbqdcgBBMsL4Z2FXf0XyfasJnTm9BcFAfKMNs+8vWv?=
 =?us-ascii?Q?B6MOHo4qFwLM6Xf8Z9BI572CZDEGHeZWNMvQRxcwRyqIOIwq9zUkKfGxUlII?=
 =?us-ascii?Q?1f8bRtSbtPM8MZPai2p88lwcct9+oN1id8cEWgho9R7sDY2xCfYqDlPJUdre?=
 =?us-ascii?Q?Ex7nuQ31pbGBf0nY2NcGMs0Evj6z?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aba27b8-443a-461f-f4c7-08d91826a8f3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 04:54:17.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hh9Iire3kz1CBekfbXHLP2ZoCVD6MWp9BmQ/XEro12npo22SylbIqofX34GJubgv+7dqsqCrU+InN7qeu+EbFh1FJLqLbnHMFbXXC8nT8h8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1305
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When call mutex_lock_interruptible(), if after queue waiter to
lock->wait_list, exit cycle interrupted by signal without obtaining
lock, the waiter be del from lock->wait_list, if the lock->wait_list
is empty, and not clear MUTEX_FLAGS, when the lock is acquired again
, because the lock flags exist, the trylock_fast will be failed,
and enter slow path acqurie lock, so clear MUTEX_FLAGS when call
mutex_lock_interruptible() interrupted by a signal and the
lock->wait_list is empty,  in this way, when the lock is acquired
again, it will acquire succeed in the fast path.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 Make commit info clearer and modify the code again.

 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex-debug.h |  2 +-
 kernel/locking/mutex.c       | 16 +++++++++++-----
 kernel/locking/mutex.h       |  4 +---
 4 files changed, 15 insertions(+), 11 deletions(-)

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
index cb6b112ce155..4815162d04b1 100644
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
@@ -1061,10 +1070,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 			__ww_mutex_check_waiters(lock, ww_ctx);
 	}
 
-	mutex_remove_waiter(lock, &waiter, current);
-	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAGS);
-
+	__mutex_remove_waiter(lock, &waiter);
 	debug_mutex_free_waiter(&waiter);
 
 skip_wait:
@@ -1080,7 +1086,7 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 
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
2.25.1

