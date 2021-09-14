Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F368740AAB1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhINJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:21:55 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45414 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhINJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:21:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A5127200E4;
        Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631611209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpRcKizLVtNPGJx/gg+Q96tVErFITSxqit8PA8OfLM0=;
        b=UzQTR1Qg7KZtMSidqZo1l9+2DT1RT2Jwzz/ATXhsL98q7cuYvphTn2d2UCjWCeXcjIEF/M
        7SmYs9KU8QVPz7WHvFdHcUFCd4kZQ1d7SOAta1tuDe5v+0OeJUN+o1VUunjsyiqi9msm4k
        7N3iww/bLDdr/fztCO6YpLleIbW9D28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631611209;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpRcKizLVtNPGJx/gg+Q96tVErFITSxqit8PA8OfLM0=;
        b=ck+2B+2OA+6rNZrsXvIKh082XDcvrETbzFoey9+LwqPBKgs6Lz/dG3Usc0D8ArhYXFLK9i
        v2A0RCzXS4mqTNAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9EDC8A3BF2;
        Tue, 14 Sep 2021 09:20:09 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 8E982518E62D; Tue, 14 Sep 2021 11:20:09 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues
Date:   Tue, 14 Sep 2021 11:20:08 +0200
Message-Id: <20210914092008.40370-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210914092008.40370-1-dwagner@suse.de>
References: <20210914092008.40370-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

Remove the freeze/unfreeze around changes to the number of hardware
queues. Study and retest has indicated there are no ios that can be
active at this point so there is nothing to freeze.

nvme-fc is draining the queues in the shutdown and error recovery path
in __nvme_fc_abort_outstanding_ios.

This patch primarily reverts 88e837ed0f1f "nvme-fc: wait for queues to
freeze before calling update_hr_hw_queues". It's not an exact revert as
it leaves the adjusting of hw queues only if the count changes.

Signed-off-by: James Smart <jsmart2021@gmail.com>
[dwagner: added explanation why no IO is pending]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6ebe68396712..aa14ad963d91 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2957,9 +2957,7 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
 		dev_info(ctrl->ctrl.device,
 			"reconnect: revising io queue count from %d to %d\n",
 			prior_ioq_cnt, nr_io_queues);
-		nvme_wait_freeze(&ctrl->ctrl);
 		blk_mq_update_nr_hw_queues(&ctrl->tag_set, nr_io_queues);
-		nvme_unfreeze(&ctrl->ctrl);
 	}
 
 	ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
-- 
2.29.2

