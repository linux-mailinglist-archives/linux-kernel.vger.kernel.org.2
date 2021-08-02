Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9753DD2B8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbhHBJOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:14:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44244 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhHBJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DAA6C21F93;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuFuvhKlUfFYXf6FmlE9wh0koABi63V3tWPF92dXgDs=;
        b=tFICB7oD3cVVuZqLA+Cahm07iv50wIWEbEYzsqSy+lABYBcZeiarz4YyRPtL6v07cEZd02
        3txH6P+gWR7cofehHMauug2yeQ67lf06kSrWg4CFRXcxDEEumJhDukmQj7sG2YiJJEOrT5
        dQf7wYcdlkWzyg7todZL/zIkwB+GI4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vuFuvhKlUfFYXf6FmlE9wh0koABi63V3tWPF92dXgDs=;
        b=Y8wMmtqNir+qc/FI7Gms5YlHXzkdhTOWbVe0nRZr+TmiKTz5WgTpSfYVGiFdqP02p6sA1n
        R/V7I1IR9F7qflBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D11A3A3BB4;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 18ED7518C093; Mon,  2 Aug 2021 11:14:21 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Date:   Mon,  2 Aug 2021 11:14:17 +0200
Message-Id: <20210802091419.56425-7-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
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
[dwagner: call nvme_unfreeze() unconditionally in
          nvme_fc_recreate_io_queues() to match the nvme_start_freeze()]
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 133b87db4f1d..b292af0fd655 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2486,6 +2486,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * (but with error status).
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_stop_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -2966,8 +2967,8 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 			return -ENODEV;
 		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
+	nvme_unfreeze(&ctrl->ctrl);
 
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
 	if (ret)
-- 
2.29.2

