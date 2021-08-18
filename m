Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1E3F0343
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhHRMGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:06:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53540 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbhHRMGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:06:08 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3196920074;
        Wed, 18 Aug 2021 12:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629288333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJfb3xtaQFR5r/ftAJql45a44xJsCJfy582wo5ZaI48=;
        b=Wubv7qKWhxAXiZwU8pG3XpF/SsXqyRuNxZy2kxjLqCtYMZPW1n6mWnTY7KW0g6fubApyRd
        8I941Zfj1LBEFYXtSXmJ4OHUbO8XSpNqXAFJ2aF/NyixdtOokRQUfRmDRYYW0FgY7QvMAb
        okXN4YbLR0LDqIAWKxBY3kpHfG4W20o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629288333;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJfb3xtaQFR5r/ftAJql45a44xJsCJfy582wo5ZaI48=;
        b=0TZkzUP+ZV3mDd1wWMl22tSnrlft4g9eXOyb/jBSdTqEnUyA7t0ghgze/IT1qEeQHxfRz5
        PdXNQdhaotpsgvDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 553A0A3B93;
        Wed, 18 Aug 2021 12:05:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 79A88518CF7B; Wed, 18 Aug 2021 14:05:31 +0200 (CEST)
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
        Daniel Wagner <dwagner@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: [PATCH v5 1/3] nvme-fc: Wait with a timeout for queue to freeze
Date:   Wed, 18 Aug 2021 14:05:28 +0200
Message-Id: <20210818120530.130501-2-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
References: <20210818120530.130501-1-dwagner@suse.de>
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
index 7f462af1b02a..8e59e6d142c1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2963,7 +2963,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
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

