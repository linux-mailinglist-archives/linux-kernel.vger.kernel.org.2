Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B633DD2BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhHBJO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:14:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhHBJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D20BA1FF56;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZOuzvx1phja24aAWw8Llh5el782SjhEfTlnpRDPjWI=;
        b=P6hL87aJlTwaD428scHOsV2Oeb7gctZHNGULPgcBDwvx93QJ9/O3scEalKz3eBr7xS5k6w
        qeX50QLCophPPDcqv9q+xgOJawBgP49PN0lTMShQLqPHaciq9uYv4EifbHE9KKQ9c+4SM2
        fvQ9M+GFsg322mPH5J//AvOF8sraGDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZOuzvx1phja24aAWw8Llh5el782SjhEfTlnpRDPjWI=;
        b=B/K3wKlJ0QTvVtaAQcd2acy5s8Y96c1dFCEVTx/IwcUGnn6GCRmDh0XiBbNQEcgNQ+Z03v
        XtwfuUcaTpsDO5AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 0BBABA3B85;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id F0157518C089; Mon,  2 Aug 2021 11:14:20 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: [PATCH v4 1/8] nvme-fc: Update hardware queues before using them
Date:   Mon,  2 Aug 2021 11:14:12 +0200
Message-Id: <20210802091419.56425-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the number of hardware queues changes, do the update the
tagset and ctx to hctx first before using the mapping to recreate and
connnect the IO queues.

Reviewed-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7f462af1b02a..8a903769364f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2951,14 +2951,6 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->ctrl.queue_count == 1)
 		return 0;
 
-	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
-	if (ret)
-		goto out_free_io_queues;
-
-	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
-	if (ret)
-		goto out_delete_hw_queues;
-
 	if (prior_ioq_cnt != nr_io_queues) {
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
@@ -2968,6 +2960,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		nvme_unfreeze(&ctrl->ctrl);
 	}
 
+	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	if (ret)
+		goto out_free_io_queues;
+
+	ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
+	if (ret)
+		goto out_delete_hw_queues;
+
 	return 0;
 
 out_delete_hw_queues:
-- 
2.29.2

