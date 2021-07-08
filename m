Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008FB3BF792
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhGHJay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:30:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35998 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbhGHJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7650321FD0;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8YJIsE3iLagZyuQOT17sD+vfGs7zD3HYjrCRZNATSo=;
        b=WTKm6mkrqMjIObAGesY5mCgO7/xfq+av30sVHJULZ0DeahFtu1roCGxDKpFdp2k54RtRaJ
        VWE+KwAMmLqlaASko1IZ8LCR0dTHRdDqVSbBzNN8wwoTSlWUziOldlvBL+1nkrZFaXe4JL
        /E1755XVvaGATpF6YNuPhXfRjMP+bjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625736488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8YJIsE3iLagZyuQOT17sD+vfGs7zD3HYjrCRZNATSo=;
        b=ZjRVerlPWo10ziij3r69lyZR0QzDXcGetnrwQEOwudcHQitE+et5BY0T5tWh2E2cIqaMHx
        ouw44DnZQZ884oAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 6A619A3B87;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 5AD50517114E; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/5] nvme-tcp: Update number of hardware queues before using them
Date:   Thu,  8 Jul 2021 11:27:52 +0200
Message-Id: <20210708092755.15660-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708092755.15660-1-dwagner@suse.de>
References: <20210708092755.15660-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

When the number of hardware queues changes during resetting we should
update the tagset first before using it.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/tcp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0125463b7d77..a0f15e94c7a6 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1784,6 +1784,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 {
 	int ret;
+	u32 prior_q_cnt = ctrl->queue_count;
 
 	ret = nvme_tcp_alloc_io_queues(ctrl);
 	if (ret)
@@ -1801,14 +1802,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			ret = PTR_ERR(ctrl->connect_q);
 			goto out_free_tag_set;
 		}
-	}
-
-	ret = nvme_tcp_start_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	if (!new) {
-		nvme_start_queues(ctrl);
+	} else if (prior_q_cnt != ctrl->queue_count) {
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
@@ -1823,6 +1817,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		nvme_unfreeze(ctrl);
 	}
 
+	ret = nvme_tcp_start_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
 	return 0;
 
 out_wait_freeze_timed_out:
-- 
2.29.2

