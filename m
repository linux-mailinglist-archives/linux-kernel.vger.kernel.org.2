Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726353D899D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhG1IRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:17:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235286AbhG1IRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tiKN7ZMX6RFq85lNKK9U+YCGtNyqxmDw2V9siNIiayo=;
        b=RrKK25AeRuDYR5lX9gHw8L3hs6tXbIhF3K5TtUL+/6y7kigj6yJRby0vKAT0YBkaMldpX4
        DlSuRmzY/zyl8YoDOaGdPK8TYbaXvJk9G26HIKoj0rzVX6faLJh4S/fuUn4U8cidKig/la
        /GNKlti6aJyNeCDzH70KfbBa6nTnS4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-oh3VfoJ0PNSfH9RozqK2ng-1; Wed, 28 Jul 2021 04:17:30 -0400
X-MC-Unique: oh3VfoJ0PNSfH9RozqK2ng-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D946E39381;
        Wed, 28 Jul 2021 08:17:28 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C53D19C79;
        Wed, 28 Jul 2021 08:17:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 6/7] loop: use xarray to store workers
Date:   Wed, 28 Jul 2021 16:16:37 +0800
Message-Id: <20210728081638.1500953-7-ming.lei@redhat.com>
In-Reply-To: <20210728081638.1500953-1-ming.lei@redhat.com>
References: <20210728081638.1500953-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

css->id is unique in io controller wide, so replace rbtree with xarray
for querying/storing 'blkcg_css' by using css->id as key, then code is
simplified a lot.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 36 ++++++++++++++----------------------
 drivers/block/loop.h |  3 ++-
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 74682c0f3f86..9b22e5469ed3 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -918,7 +918,6 @@ static void loop_config_discard(struct loop_device *lo)
 }
 
 struct loop_worker {
-	struct rb_node rb_node;
 	struct work_struct work;
 	struct list_head cmd_list;
 	struct list_head idle_list;
@@ -966,35 +965,23 @@ static struct cgroup_subsys_state *loop_rq_get_memcg_css(
 
 static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 {
-	struct rb_node **node = &(lo->worker_tree.rb_node), *parent = NULL;
-	struct loop_worker *cur_worker, *worker = NULL;
+	struct loop_worker *worker = NULL;
 	struct work_struct *work;
 	struct list_head *cmd_list;
 	struct cgroup_subsys_state *blkcg_css = loop_rq_blkcg_css(cmd);
+	gfp_t gfp = GFP_NOWAIT | __GFP_NOWARN;
 
 	spin_lock(&lo->lo_work_lock);
 
 	if (queue_on_root_worker(blkcg_css))
 		goto queue_work;
 
-	node = &lo->worker_tree.rb_node;
-
-	while (*node) {
-		parent = *node;
-		cur_worker = container_of(*node, struct loop_worker, rb_node);
-		if (cur_worker->blkcg_css == blkcg_css) {
-			worker = cur_worker;
-			break;
-		} else if ((long)cur_worker->blkcg_css < (long)blkcg_css) {
-			node = &(*node)->rb_left;
-		} else {
-			node = &(*node)->rb_right;
-		}
-	}
+	/* css->id is unique in each cgroup subsystem */
+	worker = xa_load(&lo->workers, blkcg_css->id);
 	if (worker)
 		goto queue_work;
 
-	worker = kzalloc(sizeof(struct loop_worker), GFP_NOWAIT | __GFP_NOWARN);
+	worker = kzalloc(sizeof(*worker), gfp);
 	/*
 	 * In the event we cannot allocate a worker, just queue on the
 	 * rootcg worker and issue the I/O as the rootcg
@@ -1008,8 +995,12 @@ static void loop_queue_work(struct loop_device *lo, struct loop_cmd *cmd)
 	INIT_LIST_HEAD(&worker->cmd_list);
 	INIT_LIST_HEAD(&worker->idle_list);
 	worker->lo = lo;
-	rb_link_node(&worker->rb_node, parent, node);
-	rb_insert_color(&worker->rb_node, &lo->worker_tree);
+
+	if (xa_err(xa_store(&lo->workers, blkcg_css->id, worker, gfp))) {
+		kfree(worker);
+		worker = NULL;
+	}
+
 queue_work:
 	if (worker) {
 		/*
@@ -1165,7 +1156,7 @@ static void __loop_free_idle_workers(struct loop_device *lo, bool force)
 						LOOP_IDLE_WORKER_TIMEOUT))
 			break;
 		list_del(&worker->idle_list);
-		rb_erase(&worker->rb_node, &lo->worker_tree);
+		xa_erase(&lo->workers, worker->blkcg_css->id);
 		css_put(worker->blkcg_css);
 		kfree(worker);
 	}
@@ -1260,7 +1251,7 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
 	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
 	INIT_LIST_HEAD(&lo->idle_worker_list);
-	lo->worker_tree = RB_ROOT;
+	xa_init(&lo->workers);
 	INIT_DELAYED_WORK(&lo->idle_work, loop_free_idle_workers);
 	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
@@ -1352,6 +1343,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	destroy_workqueue(lo->workqueue);
 	__loop_free_idle_workers(lo, true);
 	cancel_delayed_work_sync(&lo->idle_work);
+	xa_destroy(&lo->workers);
 
 	spin_lock_irq(&lo->lo_lock);
 	lo->lo_backing_file = NULL;
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index 9df889af1bcf..cab34da1e1bb 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -14,6 +14,7 @@
 #include <linux/blk-mq.h>
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/xarray.h>
 #include <uapi/linux/loop.h>
 
 /* Possible states of device */
@@ -59,7 +60,7 @@ struct loop_device {
 	struct work_struct      rootcg_work;
 	struct list_head        rootcg_cmd_list;
 	struct list_head        idle_worker_list;
-	struct rb_root          worker_tree;
+	struct xarray		workers;
 	struct delayed_work	idle_work;
 	bool			use_dio;
 	bool			sysfs_inited;
-- 
2.31.1

