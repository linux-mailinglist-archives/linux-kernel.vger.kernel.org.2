Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7E3BF795
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhGHJa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:30:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60766 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhGHJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 759A12019C;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5VwJX1eWn9Inbb0pgjqnO2NeXEAl/NCz0WSLGRvteI=;
        b=sc5YOILhVrkbL6XNABgCDJZBxWHo6H1xiw2xwtCGobIBuIyX8SM9VUml5nrPRKZdjYOsxP
        6CpXJJBB0lUfon2gZfv5Hon6yw4Hrx4Xg9QXWAAm6b/KhUOjHbgjXERujzQGLvOfc6cCWP
        sEBRm7Pvak3NGFKcPChTy3E+ASEpMyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625736488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5VwJX1eWn9Inbb0pgjqnO2NeXEAl/NCz0WSLGRvteI=;
        b=a4XRPi0Ymnw79wZWBpHJINiEUi0bc7FnkzZZAD2nR825jZr7D7GCrR5oR4WTpgy1eOD+ZU
        gcvJ4D/OjkNPEyDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6E38EA3B89;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 5ECE45171150; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 3/5] nvme-rdma: Update number of hardware queues before using them
Date:   Thu,  8 Jul 2021 11:27:53 +0200
Message-Id: <20210708092755.15660-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708092755.15660-1-dwagner@suse.de>
References: <20210708092755.15660-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of hardware queues changes during resetting we should
update the tagset first before using it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3a296fd34bef..9825112bd9f4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -967,6 +967,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
+	u32 prior_q_cnt = ctrl->ctrl.queue_count;
 
 	ret = nvme_rdma_alloc_io_queues(ctrl);
 	if (ret)
@@ -984,13 +985,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
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
@@ -1006,6 +1001,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
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

