Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8673E219B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 04:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242607AbhHFCf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 22:35:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42327 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242335AbhHFCfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 22:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628217305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6jJHlKcW8/yQJr4XHRKfNhEyBY/3snWuvxBCGcIA48=;
        b=TT76e2gbfZMYAeSPykpWkeqa+L/6DP0nMJK+8RM+MDE9/HJFgtymBna+E+WJ9QPhpJe7jv
        lHPqlGjKncgC6sADCaT/XUQwQJ71rNjY/NoGiEThF7GIvcN0tvVeYu7Uyq1x/566V1pHaw
        H+YRg5eCS1oepWSGvPhCBjMj3/k7bJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-JvtPjF0IOauZ2XVC8Jshhg-1; Thu, 05 Aug 2021 22:35:04 -0400
X-MC-Unique: JvtPjF0IOauZ2XVC8Jshhg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FAC9100CA8A;
        Fri,  6 Aug 2021 02:35:03 +0000 (UTC)
Received: from localhost (ovpn-12-45.pek2.redhat.com [10.72.12.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE8F6091B;
        Fri,  6 Aug 2021 02:34:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 4/7] loop: add __loop_free_idle_workers() for covering freeing workers in clearing FD
Date:   Fri,  6 Aug 2021 10:34:20 +0800
Message-Id: <20210806023423.131060-5-ming.lei@redhat.com>
In-Reply-To: <20210806023423.131060-1-ming.lei@redhat.com>
References: <20210806023423.131060-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the helper, so we can remove the duplicated code for freeing all
workers in clearing FD.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 61eda1db5b5c..6d9cfd47b7a2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1207,16 +1207,14 @@ static void loop_set_timer(struct loop_device *lo)
 	schedule_delayed_work(&lo->idle_work, LOOP_IDLE_WORKER_TIMEOUT);
 }
 
-static void loop_free_idle_workers(struct work_struct *work)
+static void __loop_free_idle_workers(struct loop_device *lo, bool force)
 {
-	struct loop_device *lo = container_of(work, struct loop_device,
-			idle_work.work);
 	struct loop_worker *pos, *worker;
 
 	spin_lock(&lo->lo_work_lock);
 	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
 				idle_list) {
-		if (time_is_after_jiffies(worker->last_ran_at +
+		if (!force && time_is_after_jiffies(worker->last_ran_at +
 						LOOP_IDLE_WORKER_TIMEOUT))
 			break;
 		list_del(&worker->idle_list);
@@ -1229,6 +1227,14 @@ static void loop_free_idle_workers(struct work_struct *work)
 	spin_unlock(&lo->lo_work_lock);
 }
 
+static void loop_free_idle_workers(struct work_struct *work)
+{
+	struct loop_device *lo = container_of(work, struct loop_device,
+			idle_work.work);
+
+	__loop_free_idle_workers(lo, false);
+}
+
 static int loop_configure(struct loop_device *lo, fmode_t mode,
 			  struct block_device *bdev,
 			  const struct loop_config *config)
@@ -1376,7 +1382,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	int err = 0;
 	bool partscan = false;
 	int lo_number;
-	struct loop_worker *pos, *worker;
 
 	/*
 	 * Flush loop_configure() and loop_change_fd(). It is acceptable for
@@ -1409,15 +1414,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	blk_mq_freeze_queue(lo->lo_queue);
 
 	destroy_workqueue(lo->workqueue);
-	spin_lock(&lo->lo_work_lock);
-	list_for_each_entry_safe(worker, pos, &lo->idle_worker_list,
-				idle_list) {
-		list_del(&worker->idle_list);
-		rb_erase(&worker->rb_node, &lo->worker_tree);
-		css_put(worker->blkcg_css);
-		kfree(worker);
-	}
-	spin_unlock(&lo->lo_work_lock);
+	__loop_free_idle_workers(lo, true);
 	cancel_delayed_work_sync(&lo->idle_work);
 
 	spin_lock_irq(&lo->lo_lock);
-- 
2.31.1

