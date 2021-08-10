Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56753D8999
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbhG1IRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235093AbhG1IRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8YJw8+F1TBIFo8R8D6g0qlj3TwIlMvqdRJF3PSNlwyE=;
        b=HnOakYZ2Tmq+t/xNq8mywuPcVDT3uOQzCE7H2XIQbfDONy+Mo2t3BCNcbrnzkB5z4Aqory
        Ac2TpaKl2kDTzzLRER3fGJnuG2PX2iCn6LJaIDj4l2tYPxNO00QAaD6S/lqPBodg1LJckD
        7q6UYKHhdF1lN5caFt0EvLDIcFP28c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-zDS5kkOPNmGLJ_MuUjivqA-1; Wed, 28 Jul 2021 04:17:11 -0400
X-MC-Unique: zDS5kkOPNmGLJ_MuUjivqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFD7880124F;
        Wed, 28 Jul 2021 08:17:10 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29B7B60862;
        Wed, 28 Jul 2021 08:17:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 4/7] loop: add __loop_free_idle_workers() for covering freeing workers in clearing FD
Date:   Wed, 28 Jul 2021 16:16:35 +0800
Message-Id: <20210728081638.1500953-5-ming.lei@redhat.com>
In-Reply-To: <20210728081638.1500953-1-ming.lei@redhat.com>
References: <20210728081638.1500953-1-ming.lei@redhat.com>
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
index f63bd75e80ba..4c524c72d976 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1154,16 +1154,14 @@ static void loop_set_timer(struct loop_device *lo)
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
@@ -1176,6 +1174,14 @@ static void loop_free_idle_workers(struct work_struct *work)
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
@@ -1324,7 +1330,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 	int err = 0;
 	bool partscan = false;
 	int lo_number;
-	struct loop_worker *pos, *worker;
 
 	mutex_lock(&lo->lo_mutex);
 	if (WARN_ON_ONCE(lo->lo_state != Lo_rundown)) {
@@ -1345,15 +1350,7 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
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

