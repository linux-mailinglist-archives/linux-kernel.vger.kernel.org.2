Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4163E24AE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235006AbhHFIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52475 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243144AbhHFIEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nLC/W+5laxAYS54d78y35CCySVocVrT9DJqQfrxfIT0=;
        b=AZkT3jYDbpBuv52YTCm0XZF9xsfgkUhBaCQjXaZ1ZFPUopdD64sd/rUD46ySjodcOvLwju
        nMt0b4irSQT0ULBsB3hI4S4bdTsJmQNJWbGuYbECQJanCFeIDtIF9zvN13JGtkA5srYB+m
        pf1wxqAaXRHGo7SUXtXt+Mit7dHo2Yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-BQjsfWpZN6ukex7HK-8DrA-1; Fri, 06 Aug 2021 04:03:56 -0400
X-MC-Unique: BQjsfWpZN6ukex7HK-8DrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D1E21084F54;
        Fri,  6 Aug 2021 08:03:55 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B963B781EA;
        Fri,  6 Aug 2021 08:03:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 4/7] loop: add __loop_free_idle_workers() for covering freeing workers in clearing FD
Date:   Fri,  6 Aug 2021 16:02:59 +0800
Message-Id: <20210806080302.298297-5-ming.lei@redhat.com>
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
References: <20210806080302.298297-1-ming.lei@redhat.com>
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
index 6e65e46553f6..6e5c55d4552b 100644
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

