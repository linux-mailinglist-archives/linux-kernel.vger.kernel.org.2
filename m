Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC313F49B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhHWLYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:24:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59114 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhHWLYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:24:36 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EFE1321F5C;
        Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629717832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EayIZPvEx8NBX6gVMYZJJQtq+PDoTIWp/jqWnTRrcoI=;
        b=oRNFq04/+fpitigIPbdiK59exX9c56+BEa8yZNZEXW3Bepbz+MMmxvLcBkbmwN2BfUrjzK
        m7SNRUJefhW2s1AZattSrlP9jgkXiuN3LhG92j+ByhQoeYfu+MbbuCYPlvFVeDA6DszuLn
        yGMAMNlJGrJfc+Nvuk7C/zM/P4R+bbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629717832;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EayIZPvEx8NBX6gVMYZJJQtq+PDoTIWp/jqWnTRrcoI=;
        b=tcWvOCqER0uNdYm3BipT7jlGUb5GAnKqoXJIaCXd6EukIj6/aiYxobw3YuPu8xdFO9nMep
        wbaFbKvOD39/6TBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 37286A3BC1;
        Mon, 23 Aug 2021 11:23:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 2257F518D88F; Mon, 23 Aug 2021 13:23:52 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 3/3] nvme-fc: Remove freeze/unfreeze around update_nr_hw_queues
Date:   Mon, 23 Aug 2021 13:23:51 +0200
Message-Id: <20210823112351.82899-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210823112351.82899-1-dwagner@suse.de>
References: <20210823112351.82899-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

Remove the freeze/unfreeze around changes to the number of hardware
queues. Study and retest has indicated there are no ios that can be
active at this point so there is nothing to freeze.

This patch primarily reverts 883837ed0f1f "nvme-fc: wait for queues to
freeze before calling update_hr_hw_queues". It's not an exact revert as
it leaves the adjusting of hw queues only if the count changes.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 48aaa753be44..b71d0c2d4d31 100644
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

