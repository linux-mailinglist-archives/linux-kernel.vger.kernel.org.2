Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650A43DD4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhHBL1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:27:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbhHBL1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:27:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0279821E9C;
        Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+zgSqIkcez6QRZOoh03QIraHBKZrpt4BlrZg6ObJF0=;
        b=em/eQo603TbM/sNhvVhkBoLMoLd8U8vQyNZIt9s083wDhkv3KjD6Og7j+1bP4s/gQ4KxDN
        941j8xVsZ2YFIVdHatHIvgbZj5sZQVhf95/Hx8GRE2jgbaS+KGtd4diIMW9DVtPCn2vsI0
        jO0wuVNlh1O+H4O9ngULMnolaZgzY/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627903628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+zgSqIkcez6QRZOoh03QIraHBKZrpt4BlrZg6ObJF0=;
        b=sSo1dtL0T8UcRG+bDKOO2LzX4gdccw+/liEvOC3hDZI9xKxOJ/yJ05s72iau4jry6jrGVZ
        4AkX2TFJnrAbS4AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EF493A3BC3;
        Mon,  2 Aug 2021 11:27:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id DC3AD518C0AA; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 3/8] nvme-rdma: Update number of hardware queues before using them
Date:   Mon,  2 Aug 2021 13:26:53 +0200
Message-Id: <20210802112658.75875-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802112658.75875-1-dwagner@suse.de>
References: <20210802112658.75875-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of hardware queues changes during resetting we should
update the tagset first before using it.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 69ae67652f38..de2a8950d282 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -965,6 +965,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
+	u32 prior_q_cnt = ctrl->ctrl.queue_count;
 
 	ret = nvme_rdma_alloc_io_queues(ctrl);
 	if (ret)
@@ -982,13 +983,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->ctrl.connect_q);
 			goto out_free_tag_set;
 		}
-	}
-
-	ret = nvme_rdma_start_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	if (!new) {
+	} else if (prior_q_cnt != ctrl->ctrl.queue_count) {
 		nvme_start_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
@@ -1004,6 +999,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_unfreeze(&ctrl->ctrl);
 	}
 
+	ret = nvme_rdma_start_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.29.2

