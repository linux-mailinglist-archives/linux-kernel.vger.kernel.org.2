Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0E641445D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 10:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhIVJAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:00:45 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:19996 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbhIVJAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:00:38 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HDsYr1y28zbmcT;
        Wed, 22 Sep 2021 16:54:56 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 16:59:07 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 16:59:07 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: Make cookie functions static
Date:   Wed, 22 Sep 2021 16:57:35 +0800
Message-ID: <20210922085735.52812-1-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make cookie functions static as these are no longer invoked directly
by other code.

No functional change intended.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 kernel/sched/core_sched.c | 9 +++++----
 kernel/sched/sched.h      | 5 -----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9a80e9a474c0..48ac72696012 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -11,7 +11,7 @@ struct sched_core_cookie {
 	refcount_t refcnt;
 };
 
-unsigned long sched_core_alloc_cookie(void)
+static unsigned long sched_core_alloc_cookie(void)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
@@ -23,7 +23,7 @@ unsigned long sched_core_alloc_cookie(void)
 	return (unsigned long)ck;
 }
 
-void sched_core_put_cookie(unsigned long cookie)
+static void sched_core_put_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -33,7 +33,7 @@ void sched_core_put_cookie(unsigned long cookie)
 	}
 }
 
-unsigned long sched_core_get_cookie(unsigned long cookie)
+static unsigned long sched_core_get_cookie(unsigned long cookie)
 {
 	struct sched_core_cookie *ptr = (void *)cookie;
 
@@ -53,7 +53,8 @@ unsigned long sched_core_get_cookie(unsigned long cookie)
  *
  * Returns: the old cookie
  */
-unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+static unsigned long sched_core_update_cookie(struct task_struct *p,
+					      unsigned long cookie)
 {
 	unsigned long old_cookie;
 	struct rq_flags rf;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cae475ff28b5..a09d11d41e4c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1260,11 +1260,6 @@ extern void sched_core_dequeue(struct rq *rq, struct task_struct *p);
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
-extern unsigned long sched_core_alloc_cookie(void);
-extern void sched_core_put_cookie(unsigned long cookie);
-extern unsigned long sched_core_get_cookie(unsigned long cookie);
-extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
-
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.33.0

