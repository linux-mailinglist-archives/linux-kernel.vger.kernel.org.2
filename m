Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D4C3F033D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhHRMGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:06:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53500 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhHRMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:06:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2CC7620070;
        Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tn6D90iiLsb4IxhJIealrzVbHO75LAAXZtFjemxcuD4=;
        b=udQdDomnjekz6QUNNwMDFN28CjCjQvZ0QXTUx9+PrBk/JhLepukkr8O7Rfd/O2KVuh1cnT
        mcoq2uJ4RIix3tL2snllpZBRRLXzRmksVtqFGdRFyeYjsAx4Mbo6hV9HPXXgg9S/TbHAf8
        Og7muASTPiSqM6O6lJ8Bqj8+OhV4HPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629288333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tn6D90iiLsb4IxhJIealrzVbHO75LAAXZtFjemxcuD4=;
        b=4zw1AW6MuUlFmI0bELHcQ0k4510gePTHt/IJQRRBu86rvNHyDAt/nYsaO9qsxQkG4gHz27
        Hwygz6/j7O23tBAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 55558A3B9A;
        Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 7FD2E518CF7D; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>,
        Chao Leng <lengchao@huawei.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 2/3] nvme-fc: avoid race between time out and tear down
Date:   Wed, 18 Aug 2021 14:05:29 +0200
Message-Id: <20210818120530.130501-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

To avoid race between time out and tear down, in tear down process,
first we quiesce the queue, and then delete the timer and cancel
the time out work for the queue.

This patch merges the admin and io sync ops into the queue teardown logic
as shown in the RDMA patch 3017013dcc "nvme-rdma: avoid race between time
out and tear down". There is no teardown_lock in nvme-fc.

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Chao Leng <lengchao@huawei.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
[dwagner: updated commit id referenced in commit message]
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8e59e6d142c1..3ff783a2e9f7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2487,6 +2487,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
+		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
@@ -2510,6 +2511,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * clean up the admin queue. Same thing as above.
 	 */
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
-- 
2.29.2

