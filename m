Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9F3DD2BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhHBJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:15:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhHBJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 330B71FF59;
        Mon,  2 Aug 2021 09:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKKLeMvUSjTl9xhk4gs1WHWOoquSNjLGEcBM3zENZtY=;
        b=WgApY3f7Ya8WKVsxGBUlHaVoRYxHv3p/NzT+9iubg9nneWks+hZyaS54dARTuB0EIeddEf
        jLes9u2qVU+yKqnXpbcEMOr2YKj/mvVRWKCWEf2nMjmgnulP178mzv2x16qgyKyN9IgSV6
        WwIVx5dLCgZh6d1Cm5+dFeBj4mshpE4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kKKLeMvUSjTl9xhk4gs1WHWOoquSNjLGEcBM3zENZtY=;
        b=zaEeNV1wEtDqOZvI3eiplW+UAhKv7U5BUGbxjyuEh+faatBmoIR+seUayeuARakTynpVA6
        e1fHRI9Nn9cpxVAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D17F1A3BB6;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 12F81518C091; Mon,  2 Aug 2021 11:14:21 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        James Smart <jsmart2021@gmail.com>,
        Chao Leng <lengchao@huawei.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 5/8] nvme-fc: avoid race between time out and tear down
Date:   Mon,  2 Aug 2021 11:14:16 +0200
Message-Id: <20210802091419.56425-6-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
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
index dbb8ad816df8..133b87db4f1d 100644
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

