Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7749381C63
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 06:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhEPEUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 00:20:38 -0400
Received: from mail-dm6nam10on2071.outbound.protection.outlook.com ([40.107.93.71]:27233
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229643AbhEPEUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 00:20:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGP2HJB1lnPAQzcq8x+erDEDohz3PE6Y5nYecW5KmZzHQyMIrEfBF9SNeRFIbuGYtMKnBV7wYI+C9FAr5cYr/bvvnbRNNpGjVodkZShCPoQe0aJ4rNH6JoePoR4PiG/oJnj8SmHdmKN0StQWsfSCHCNAVAIJrGEdencHIQsg4mqS23JLlBWJzcEYply2z7+d9iurITwQ0M3DDe8WoW96naro5No2NOG0RUIQmUZoWbCIxZ7HPmL0V1UU/qYSihp/Rnrs8cSSH2wyeZ4PT7Q7WAnStCEG9HlsFbBnTkAIX0ksP6EmbqALJk+YwZsnAeAXdkDQ6QfWdE3KgEuRwHH51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub3HqQrzsVdlmMoIXhT8he/2K5Qi/RPAwVTUTMdHDKY=;
 b=LQ1sQhMG9W8UdZroNaux1hwp6QiJIrOLgzFW3uHUFS/HY9ESsNP60yAorLEgoGl6fdtg9a99MzQk12y1r+u5LfimpDMU86nMANC0IBQJMO3nFWgEa/UaSlhxvJdoj20eTFELJ3sHFqBoUjjrm49/UsA0k++EQKVEK2AODg9+TVrlXRk60CJw5I0cQuREVPg1idfCpn5si/Xia0SRtrca5s1L+1/noMLq4tu/07ORsJDzpbrCkOSYYfXQ/TfRWKkYGWJf+ajjIB0dPgc6SjijbH017W8HPdJfjOfdyjMK5mKUBT5Yk8RwLYK8Da1v74YwBrGQK77cinohCuqyv6CvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ub3HqQrzsVdlmMoIXhT8he/2K5Qi/RPAwVTUTMdHDKY=;
 b=JmBnpRnzhSt9SaYhsCSu1ZrqCaHuWB2Fp3RUkRowbMSBLDc9QQg8/RG7BWLmXW6+yZHzM0tc6fLm9RcXG0vOgUzjj5vNRikxOQ0S3pE6ztRB5tw2OjRTDZxGIHWEW/zUH+w3lf+hGD58okzZCz1S1nEKTe+NBefX6o4/AiFBkSI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM4PR11MB5472.namprd11.prod.outlook.com (2603:10b6:5:39e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Sun, 16 May
 2021 04:19:20 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4129.031; Sun, 16 May 2021
 04:19:20 +0000
From:   qiang.zhang@windriver.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal
Date:   Sun, 16 May 2021 12:18:57 +0800
Message-Id: <20210516041857.313601-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [240e:304:8181:8460:98c0:7881:2aa3:e507]
X-ClientProxiedBy: HK2PR04CA0054.apcprd04.prod.outlook.com
 (2603:1096:202:14::22) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (240e:304:8181:8460:98c0:7881:2aa3:e507) by HK2PR04CA0054.apcprd04.prod.outlook.com (2603:1096:202:14::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sun, 16 May 2021 04:19:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff591a7-fcd7-4e5c-2551-08d91821c6a0
X-MS-TrafficTypeDiagnostic: DM4PR11MB5472:
X-Microsoft-Antispam-PRVS: <DM4PR11MB5472FB0479A31BD3E0D7EF8CFF2E9@DM4PR11MB5472.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2dW9uklNW6pus1Ea/zFbUevu1i11W4scRLVfXGBNsiXzHprVAhHylVug5vZemFEO73U7IBbZBL5Q1XQ76BYSIF9cofxaA/vNDsyqKZlDnGYUQqYr5k+0OuYTmGv2iwTZkRtWnJ7lU6tsu8lhg4nAqjf411bW2nf/mJuSyBccjKdloV/wkbIIkvcPRDkJ9pNVAyiew/yaMD/WMwj+5eNG3+A6XNVQMSzRS+yA6u6h188LVQESX93Uj+0DX4QVBJSiFoqRlHyrctSZs5/WYxVzmiPwI5JQmO+GE4GRei01o0XwPsl6y3iSm0+/MDMW/3S2CkEL8jKphW73XMGYrrM7FlK9KuvqH1OIzvVVlDdq9hTEXP0yWC7eYHRYkaJ+B1CP5dwOtLD4kDH7cy6olAli9QYqwHrB7OkJC4xEdhPEmiuMXJPyfI5KCR6aV6KAj6EhZ7UdpdpqF7oR2DY4wHBuygZ85hjdJXoPMQ1PJ+F44TRIhDhG0qrJ+RfSEkvEa0OPNmb4mLU6Zj2BoP06SBKwJ6c5mM+AFT3CZSdUdNDvzAR8vqE4E6KwUujyihYNsZTrzRN04l/LdTG25zjSa3E6dtprD9SPVwXmw68qfG19o97gK6ife7RlP9hlB4aqrXl+iZyXeQRMPcp18qKj+PKfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(136003)(376002)(346002)(396003)(1076003)(6666004)(52116002)(38100700002)(2616005)(2906002)(478600001)(8936002)(36756003)(86362001)(6512007)(66476007)(66946007)(16526019)(5660300002)(6486002)(83380400001)(186003)(66556008)(9686003)(8676002)(316002)(4326008)(6506007)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oztqECNGRk8iYfkP/wUREjw5OE8Ksspcqhyjh0WFpuZZIVpKvjOGTJ/aGi1e?=
 =?us-ascii?Q?lec6GDnvOJr+E2LiKUofalsDaBR9iOCdQIr3WTBtFzJUIghkuM19gN3P77ag?=
 =?us-ascii?Q?4Ox4etBbhoRzuh9T/jbbllDx2gfUPYERT+DsVd1pxMa4OqoBx+oo/VSpWCsW?=
 =?us-ascii?Q?iDg/RzsmXs7+70tiXJCA+xRy2dSuGoY8ntKuEjIHrwmNKoV0F9Wetsi/YkYt?=
 =?us-ascii?Q?V51J9QYKSzxRadSAmpSZjHPRTyYdlZu9EgipHwQFJ3kfcelG1LO1pWPFuf2t?=
 =?us-ascii?Q?ydMLHNiQQfzI4UNidaTW7Lr/2r0weu3D+/YQknQIyN/6XNzCJYPzQyHolBMr?=
 =?us-ascii?Q?CJQCaIe4/avpB/MMaDcLFFl059w++yTozKNRpc/vRajRxEG5FCvCn5p1k5OO?=
 =?us-ascii?Q?ZN6Z3eaSzxb5NQzUEfP1WPCpl3hKT6ClCZd1JL0GrF/oVNq3GVclKXv28YAD?=
 =?us-ascii?Q?DpZtuWmGl3zeynNGBV/6XHeNJz0xByqTo9XSH9POyCU6XFVtQIWSvOVYc03Q?=
 =?us-ascii?Q?BBrdpKIvuZahdksWS687DhUCf1G9xWU+8Bv7JV4iJzNpAqUhpG+P+lNcWF0Y?=
 =?us-ascii?Q?mcmfySzMfO70WGANkP/lzrXsRjtUj9yWxipUOhFmugFrYzPqkpiry0tsUBGr?=
 =?us-ascii?Q?nhlXE4qs2tnVHsD9zy/dFRHN5wtCoL2el0Ag9o1bcM40TjE/p9E1fLbqZYMH?=
 =?us-ascii?Q?rxx8GOevPa8yQnn0E8+zRLp7HM1H8MaixEK2n43E/Hro+pk1zhYWWrV25mqM?=
 =?us-ascii?Q?qN0QTav191fiLlAuFcxNJLrIzWff3Ki8iDq6WQ1+q0z2WSbd7UJsc++HjZhj?=
 =?us-ascii?Q?+CrqwkRJD7Vk1NdvnQ/O/Ts2yV82/7e+VFRruE5FheZBvERWJCxEO1pmgkjQ?=
 =?us-ascii?Q?ZNY/wD23Rlpw5bVxy9Z70fdFjgK6nq/Ax1dlHfldvQHqTMeBRXvDReAoG/Y1?=
 =?us-ascii?Q?AfNERbfm4xb/d7vGdaywYa8GmD0KtxxzmVNMXorr7H80qgRDHkb6PHblIgTf?=
 =?us-ascii?Q?/aSi5auNurEFR3DqPYeELHyKeJfNuGNYdTaDMzVIUinsOVr6Ln3O2E2QfQG7?=
 =?us-ascii?Q?AT3YHHdEQTG+LEiR0mu6mELSYKnnNeUwjm2zFH/8eocpv1CpO/S6ApeEAT+E?=
 =?us-ascii?Q?GsHd2DluU2EH+qdMvDWNAe5eeLIkCoae9Rvzy4SvNxITsutYrTeYYblEiEiN?=
 =?us-ascii?Q?tOQdMENl9ZpHITlqVaPW59ZyZPReZ1q2eyzzRXXVBjWrEdZBm5aV1DARqDfL?=
 =?us-ascii?Q?alQ1GUsMqDAjQ59SMIV0woiZ+coeGR5JUG+GLlfO/sY8xL8lXPon5zPoQm33?=
 =?us-ascii?Q?eNk0Kq/ck+Ov4IhLcMNhgdDjKcPGaRCsv5D4uRVoqnwuE/xrIRJCCYs+Aw4I?=
 =?us-ascii?Q?cN5zQfH0e1+/dxyxM2S4ppM/2cUw?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff591a7-fcd7-4e5c-2551-08d91821c6a0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 04:19:19.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AekhhODIt63YXntj4uFkhItCJgWCPaKKtmkHBnRqV1xCL/PBkZyMmm1Hce//6Ka70APrAcXNGOvO5PWTjVJ4OYVs4v8l2LZLg89ewEOYOyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5472
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

