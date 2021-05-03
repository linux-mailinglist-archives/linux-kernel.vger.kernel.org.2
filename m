Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51DF371E0C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhECRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:08:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235161AbhECRD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 13:03:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 66064AF0F;
        Mon,  3 May 2021 17:03:04 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme-multipath: Reset bdev to ns head when failover
Date:   Mon,  3 May 2021 19:03:03 +0200
Message-Id: <20210503170303.10443-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a request finally completes in end_io() after it has failed over,
the bdev pointer can be stale and thus the system can crash. Set the
bdev back to ns head, so the request is map to an active path when
resubmitted.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v2:
 - commit header fix s/bi_disk/bdev/
 - new commit message (hopefully it's better English this time.)
 - dropped bdget_disk, use >disk->part0 directly as
   suggested by hch

The patch is against nvme-5.13.

[ 6552.155244] Call Trace:
[ 6552.155251]  bio_endio+0x74/0x120
[ 6552.155260]  nvme_ns_head_submit_bio+0x36f/0x3e0 [nvme_core]
[ 6552.155266]  ? __switch_to_asm+0x34/0x70
[ 6552.155269]  ? __switch_to_asm+0x40/0x70
[ 6552.155271]  submit_bio_noacct+0x175/0x490
[ 6552.155274]  ? __switch_to_asm+0x34/0x70
[ 6552.155277]  ? __switch_to_asm+0x34/0x70
[ 6552.155284]  ? nvme_requeue_work+0x5a/0x70 [nvme_core]
[ 6552.155290]  nvme_requeue_work+0x5a/0x70 [nvme_core]
[ 6552.155296]  process_one_work+0x1f4/0x3e0
[ 6552.155299]  worker_thread+0x2d/0x3e0
[ 6552.155302]  ? process_one_work+0x3e0/0x3e0
[ 6552.155305]  kthread+0x10d/0x130
[ 6552.155307]  ? kthread_park+0xa0/0xa0
[ 6552.155311]  ret_from_fork+0x35/0x40


 drivers/nvme/host/multipath.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d0de3433f37..0551796517e6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -70,6 +70,7 @@ void nvme_failover_req(struct request *req)
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status & 0x7ff;
 	unsigned long flags;
+	struct bio *bio;
 
 	nvme_mpath_clear_current_path(ns);
 
@@ -84,6 +85,8 @@ void nvme_failover_req(struct request *req)
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	for (bio = req->bio; bio; bio = bio->bi_next)
+		bio_set_dev(bio, ns->head->disk->part0);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 
-- 
2.29.2

