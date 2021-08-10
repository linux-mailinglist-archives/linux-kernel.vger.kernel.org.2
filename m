Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029463E2154
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 03:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbhHFB57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 21:57:59 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13239 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhHFB54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 21:57:56 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GgpWv1HMtz1CSrh;
        Fri,  6 Aug 2021 09:57:31 +0800 (CST)
Received: from dggema762-chm.china.huawei.com (10.1.198.204) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 6 Aug 2021 09:57:39 +0800
Received: from huawei.com (10.175.127.227) by dggema762-chm.china.huawei.com
 (10.1.198.204) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 6 Aug
 2021 09:57:38 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <paolo.valente@linaro.org>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 1/4] block, bfq: add support to track if root_group have any pending requests
Date:   Fri, 6 Aug 2021 10:08:23 +0800
Message-ID: <20210806020826.1407257-2-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210806020826.1407257-1-yukuai3@huawei.com>
References: <20210806020826.1407257-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggema762-chm.china.huawei.com (10.1.198.204)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new member in bfq_data to track number of queues that are in
root_group with any pending requests. This will be used in next patch
to optmize queue idle judgment when root_group doesn't have any
pending requests.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c |  8 +++++++-
 block/bfq-iosched.h | 13 +++++++++++--
 block/bfq-wf2q.c    | 37 ++++++++++++++++++++++++-------------
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 727955918563..7c6b412f9a9c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -859,8 +859,14 @@ void __bfq_weights_tree_remove(struct bfq_data *bfqd,
 void bfq_weights_tree_remove(struct bfq_data *bfqd,
 			     struct bfq_queue *bfqq)
 {
-	struct bfq_entity *entity = bfqq->entity.parent;
+	struct bfq_entity *entity = &bfqq->entity;
+
+	if (entity->in_groups_with_pending_reqs) {
+		entity->in_groups_with_pending_reqs = false;
+		bfqd->num_queues_with_pending_reqs_in_root--;
+	}
 
+	entity = entity->parent;
 	for_each_entity(entity) {
 		struct bfq_sched_data *sd = entity->my_sched_data;
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb081e..610769214f72 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -195,7 +195,12 @@ struct bfq_entity {
 	/* flag, set to request a weight, ioprio or ioprio_class change  */
 	int prio_changed;
 
-	/* flag, set if the entity is counted in groups_with_pending_reqs */
+	/*
+	 * If entity represents bfq_group, this flag will set if the group is
+	 * not root_group and have any pending requests; If entity represents
+	 * bfq_queue, this flag will set if the queue is in root_group and have
+	 * any pending requests.
+	 */
 	bool in_groups_with_pending_reqs;
 
 	/* last child queue of entity created (for non-leaf entities) */
@@ -539,7 +544,11 @@ struct bfq_data {
 	 * with no request waiting for completion.
 	 */
 	unsigned int num_groups_with_pending_reqs;
-
+	/*
+	 * number of queues that are in root_group with at least one request
+	 * waiting for completion.
+	 */
+	unsigned int num_queues_with_pending_reqs_in_root;
 	/*
 	 * Per-class (RT, BE, IDLE) number of bfq_queues containing
 	 * requests (including the queue in service, even if it is
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 7a462df71f68..188c8f907219 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -946,6 +946,29 @@ static void bfq_update_fin_time_enqueue(struct bfq_entity *entity,
 	bfq_active_insert(st, entity);
 }
 
+static void bfq_update_groups_with_pending_reqs(struct bfq_entity *entity)
+{
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
+	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
+
+	if (bfqq) {
+		if (!entity->parent && !entity->in_groups_with_pending_reqs) {
+			entity->in_groups_with_pending_reqs = true;
+			bfqq->bfqd->num_queues_with_pending_reqs_in_root++;
+		}
+	} else {
+		if (!entity->in_groups_with_pending_reqs) {
+			struct bfq_group *bfqg =
+				container_of(entity, struct bfq_group, entity);
+			struct bfq_data *bfqd = bfqg->bfqd;
+
+			entity->in_groups_with_pending_reqs = true;
+			bfqd->num_groups_with_pending_reqs++;
+		}
+	}
+#endif
+}
+
 /**
  * __bfq_activate_entity - handle activation of entity.
  * @entity: the entity being activated.
@@ -999,19 +1022,7 @@ static void __bfq_activate_entity(struct bfq_entity *entity,
 		entity->on_st_or_in_serv = true;
 	}
 
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
-	if (!bfq_entity_to_bfqq(entity)) { /* bfq_group */
-		struct bfq_group *bfqg =
-			container_of(entity, struct bfq_group, entity);
-		struct bfq_data *bfqd = bfqg->bfqd;
-
-		if (!entity->in_groups_with_pending_reqs) {
-			entity->in_groups_with_pending_reqs = true;
-			bfqd->num_groups_with_pending_reqs++;
-		}
-	}
-#endif
-
+	bfq_update_groups_with_pending_reqs(entity);
 	bfq_update_fin_time_enqueue(entity, st, backshifted);
 }
 
-- 
2.31.1

