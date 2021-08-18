Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650333F0341
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbhHRMGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:06:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35652 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhHRMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:06:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2DD8E22031;
        Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swJyPQGAzH4b6Jy9/zoJjKAUe/5cuKhRUPwssLPQDNI=;
        b=fY0cVzRp1TgEEVqpu1uqOorozEh1y0bq3L0laRdffvWVXPId4yL39WEC+x/Oeb9CtHqHq0
        i5NSjIZelR0x1fXCRyO++ophmnLzrLk1xzDCPG3vRZ5Ep8tPkRQcAVN2hf/HCIY+AmJ84N
        q5TC+tM4OqeVZQN16tg+AOXZLEAtvQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629288333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=swJyPQGAzH4b6Jy9/zoJjKAUe/5cuKhRUPwssLPQDNI=;
        b=mWRRoR5npJuDr87GIBuBmboaqbt7VHyqQ2nbrVAp/Pbf++cJzcoCrHuXlqPF5v8sv5cMgB
        PFqwsKXm7QAfcHBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 5557CA3B9C;
        Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 84E4D518CF7F; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
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
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 3/3] nvme-fc: fix controller reset hang during traffic
Date:   Wed, 18 Aug 2021 14:05:30 +0200
Message-Id: <20210818120530.130501-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
exposed an issue where we may hang trying to wait for queue freeze
during I/O. We call blk_mq_update_nr_hw_queues which may attempt to freeze
the queue. However we never started queue freeze when starting the
reset, which means that we have inflight pending requests that entered the
queue that we will not complete once the queue is quiesced.

So start a freeze before we quiesce the queue, and unfreeze the queue
after we successfully connected the I/O queues (the unfreeze is already
present in the code). blk_mq_update_nr_hw_queues will be called only
after we are sure that the queue was already frozen.

This follows to how the pci driver handles resets.

This patch added logic introduced in commit 9f98772ba307 "nvme-rdma: fix
controller reset hang during traffic".

Signed-off-by: James Smart <jsmart2021@gmail.com>
CC: Sagi Grimberg <sagi@grimberg.me>
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 3ff783a2e9f7..99dadab2724c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2974,9 +2974,10 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 			return -ENODEV;
 		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
 
+	nvme_unfreeze(&ctrl->ctrl);
+
 	return 0;
 
 out_delete_hw_queues:
@@ -3215,6 +3216,9 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	ctrl->iocnt = 0;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
+	if (ctrl->ctrl.queue_count > 1)
+		nvme_start_freeze(&ctrl->ctrl);
+
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
 
 	/* kill the aens as they are a separate path */
-- 
2.29.2

