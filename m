Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830F63DD2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhHBJO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:14:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58796 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbhHBJOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:14:32 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D599B1FF57;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1627895661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjJI5ui+lBKS/7eBpcH/R0Ll/x+qjOPveqmd5g+MLNM=;
        b=Pi8KRd3uR5Cnr+ySlH7qEC+QUhmfEriTe3+OdPTUOrmZgC3A1nsyedqMzvu78H4en5rYtP
        YvaT3UuDUzQ0Hdr9yfuhqrGxTB2TpdkP1udYwbJkRh2vwiUSlXHWrSkkTKEu4xLRMz6GgQ
        PJp0tiUTejJBVBDDd8Km7aGCOUQcOBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1627895661;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZjJI5ui+lBKS/7eBpcH/R0Ll/x+qjOPveqmd5g+MLNM=;
        b=mLpbGKJ8qFNcjj8NkIEoUsMt1Bgb/UJWaCTa3cYTzvZr5i+0XU8ke2zH78q3aiRxofeha+
        6yTHg0sJ+N4towDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 1C64FA3BB2;
        Mon,  2 Aug 2021 09:14:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 0CC82518C08F; Mon,  2 Aug 2021 11:14:21 +0200 (CEST)
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
Subject: [PATCH v4 4/8] nvme-fc: Wait with a timeout for queue to freeze
Date:   Mon,  2 Aug 2021 11:14:15 +0200
Message-Id: <20210802091419.56425-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210802091419.56425-1-dwagner@suse.de>
References: <20210802091419.56425-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not wait indifinitly for all queues to freeze. Instead use a
timeout and abort the operation if we get stuck.

Reviewed-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8a903769364f..dbb8ad816df8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2955,7 +2955,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
-		nvme_wait_freeze(&ctrl->ctrl);
+		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
+			/*
+			 * If we timed out waiting for freeze we are likely to
+			 * be stuck.  Fail the controller initialization just
+			 * to be safe.
+			 */
+			return -ENODEV;
+		}
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
 		nvme_unfreeze(&ctrl->ctrl);
 	}
-- 
2.29.2

