Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9983DD2B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhHBJOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:14:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44222 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhHBJOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:31 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0A5F21F8C;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+zgSqIkcez6QRZOoh03QIraHBKZrpt4BlrZg6ObJF0=;
        b=WXJQQ8PVIkJom85HkUFoxRw09wedFo0GiglcwcCmqLMJPOeSRgj5JScWemBqElguzm4BYx
        e1Vi9TFwJ2tbM/coL52ylBPawc22jsmwWFeMtCSAjVAPTRNt4miOKUePWXsBUFH3kJ7oiv
        RMUdUtyBh0jpASXkz9vAp4gKIqkpQMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+zgSqIkcez6QRZOoh03QIraHBKZrpt4BlrZg6ObJF0=;
        b=XaKYI8TuFM5MoIjjmrWaxUlACIpJ1dEcGF1qKK9Q4EthKQgdtJEcXASzOp8kAqn3f3+reW
        lQlO+nXijyH26XAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 181D4A3BB0;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 07B1E518C08D; Mon,  2 Aug 2021 11:14:21 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 3/8] nvme-rdma: Update number of hardware queues before using them
Date:   Mon,  2 Aug 2021 11:14:14 +0200
Message-Id: <20210802091419.56425-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
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

