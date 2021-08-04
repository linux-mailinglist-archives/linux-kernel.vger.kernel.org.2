Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F7A3DFA1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 05:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbhHDDva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 23:51:30 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13228 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhHDDv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 23:51:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gfd7w1Zp7z1CNwj;
        Wed,  4 Aug 2021 11:51:08 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 11:51:13 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 11:51:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] workqueue: Replace deprecated ida_simple_*() with ida_alloc()/ida_free()
Date:   Wed, 4 Aug 2021 11:50:36 +0800
Message-ID: <20210804035036.2211-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace ida_simple_get() with ida_alloc() and ida_simple_remove() with
ida_free(), the latter is more concise and intuitive.

In addition, if ida_alloc() fails, NULL is returned directly. This
eliminates unnecessary initialization of two local variables and an 'if'
judgment.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/workqueue.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 542c2d03dab6..80595556e525 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1912,14 +1912,14 @@ static void worker_detach_from_pool(struct worker *worker)
  */
 static struct worker *create_worker(struct worker_pool *pool)
 {
-	struct worker *worker = NULL;
-	int id = -1;
+	struct worker *worker;
+	int id;
 	char id_buf[16];
 
 	/* ID is needed to determine kthread name */
-	id = ida_simple_get(&pool->worker_ida, 0, 0, GFP_KERNEL);
+	id = ida_alloc(&pool->worker_ida, GFP_KERNEL);
 	if (id < 0)
-		goto fail;
+		return NULL;
 
 	worker = alloc_worker(pool->node);
 	if (!worker)
@@ -1954,8 +1954,7 @@ static struct worker *create_worker(struct worker_pool *pool)
 	return worker;
 
 fail:
-	if (id >= 0)
-		ida_simple_remove(&pool->worker_ida, id);
+	ida_free(&pool->worker_ida, id);
 	kfree(worker);
 	return NULL;
 }
@@ -2378,7 +2377,7 @@ static int worker_thread(void *__worker)
 		set_pf_worker(false);
 
 		set_task_comm(worker->task, "kworker/dying");
-		ida_simple_remove(&pool->worker_ida, worker->id);
+		ida_free(&pool->worker_ida, worker->id);
 		worker_detach_from_pool(worker);
 		kfree(worker);
 		return 0;
-- 
2.25.1

