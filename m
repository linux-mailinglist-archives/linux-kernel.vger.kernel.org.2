Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFE3DC1C5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 02:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhGaABz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 20:01:55 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56544 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234036AbhGaABx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 20:01:53 -0400
Received: from BJHW-Mail-Ex15.internal.baidu.com (unknown [10.127.64.38])
        by Forcepoint Email with ESMTPS id F2117307538119740B5C;
        Sat, 31 Jul 2021 08:01:37 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 31 Jul 2021 08:01:37 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 31 Jul 2021 08:01:37 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <jiangshanlai@gmail.com>, <htejun@gmail.com>, <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH v2] workqueue: Fix typo in comments
Date:   Sat, 31 Jul 2021 08:01:29 +0800
Message-ID: <20210731000129.647-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex13.internal.baidu.com (10.127.64.36) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex15_2021-07-31 08:01:37:944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo:
*assing  ==> assign
*alloced  ==> allocated
*Retun  ==> Return
*excute  ==> execute

v1->v2:
*reverse 'iff'
*update changelog

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 include/linux/workqueue.h |  2 +-
 kernel/workqueue.c        |  6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index d15a7730ee18..5fcf3d048a5a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -324,7 +324,7 @@ enum {
 	 * to execute and tries to keep idle cores idle to conserve power;
 	 * however, for example, a per-cpu work item scheduled from an
 	 * interrupt handler on an idle CPU will force the scheduler to
-	 * excute the work item on that CPU breaking the idleness, which in
+	 * execute the work item on that CPU breaking the idleness, which in
 	 * turn may lead to more scheduling choices which are sub-optimal
 	 * in terms of power consumption.
 	 *
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a..b9b86f730b82 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -524,7 +524,7 @@ static inline void debug_work_deactivate(struct work_struct *work) { }
 #endif
 
 /**
- * worker_pool_assign_id - allocate ID and assing it to @pool
+ * worker_pool_assign_id - allocate ID and assign it to @pool
  * @pool: the pool pointer of interest
  *
  * Returns 0 if ID in [0, WORK_OFFQ_POOL_NONE) is allocated and assigned
@@ -3763,7 +3763,7 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 }
 
-/* initialize newly alloced @pwq which is associated with @wq and @pool */
+/* initialize newly allocated @pwq which is associated with @wq and @pool */
 static void init_pwq(struct pool_workqueue *pwq, struct workqueue_struct *wq,
 		     struct worker_pool *pool)
 {
@@ -5331,7 +5331,7 @@ static int workqueue_apply_unbound_cpumask(void)
  *  the affinity of all unbound workqueues.  This function check the @cpumask
  *  and apply it to all unbound workqueues and updates all pwqs of them.
  *
- *  Retun:	0	- Success
+ *  Return:	0	- Success
  *  		-EINVAL	- Invalid @cpumask
  *  		-ENOMEM	- Failed to allocate memory for attrs or pwqs.
  */
-- 
2.25.1

