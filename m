Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743D73DD4A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhHBL1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:27:23 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51212 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhHBL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:27:18 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0965C1FF5D;
        Mon,  2 Aug 2021 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627903628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZOuzvx1phja24aAWw8Llh5el782SjhEfTlnpRDPjWI=;
        b=u4PmMJMOK4YKRIa8TOVPp91ocQbWQaJtaT7ZIm29f/vGNrc0GJTeJUzKzUlPFHy2eFxmXG
        FFSgy5BaoYSTxnsVSITwOeFwGKjZNnaBwvdJI8p4Cq74jCCgAVVrUd50TQ8+K9uBQlBZde
        Utn0ZfCrxxLuQc6qe0IHTw3fQoOClcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627903628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dZOuzvx1phja24aAWw8Llh5el782SjhEfTlnpRDPjWI=;
        b=KbEvpdEoO9kyYg2dGCc6xrXCQrYismXC/xQDX0YT8bggO/lzi95xRaEmSt3cC/E8zgfddW
        JQ/EenTfAKRq6NCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id E3766A3BC0;
        Mon,  2 Aug 2021 11:27:07 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id D502D518C0A6; Mon,  2 Aug 2021 13:27:07 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Daniel Wagner <dwagner@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: [PATCH v4 1/8] nvme-fc: Update hardware queues before using them
Date:   Mon,  2 Aug 2021 13:26:51 +0200
Message-Id: <20210802112658.75875-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802112658.75875-1-dwagner@suse.de>
References: <20210802112658.75875-1-dwagner@suse.de>
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

