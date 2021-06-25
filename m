Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146E03B414F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFYKTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:19:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53304 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFYKTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:19:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6EB2C1FE7C;
        Fri, 25 Jun 2021 10:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624616218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9hSmUQi/uItysocwytSweliul09PnWtr02fcj5NE5o=;
        b=Cf/HaNyATUvsW2DAfvFHzHba4R9qgdyi9PC+WuMN9y6ExPkBdA//hw579j/8Brb3SMApfu
        oyQXn+3bd3Dp0E7CAKmNHZPGFlF9iI9YEk0xq98A2W52x7VhPCriZa3bJYUC2mP3GHm59d
        yHObh4g7i4CwD5M0I/MuqAczz4qluDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624616218;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s9hSmUQi/uItysocwytSweliul09PnWtr02fcj5NE5o=;
        b=+POG0CK7HWJx5LQeDadW35/ZB7Ib+WUKt+alw/P3wb2sRDGL3PjY2atko9LTVttF8RWnl7
        rlo+776djKcxdeBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9D42AA3BF1;
        Fri, 25 Jun 2021 10:16:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 8A32951709BF; Fri, 25 Jun 2021 12:16:57 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Date:   Fri, 25 Jun 2021 12:16:49 +0200
Message-Id: <20210625101649.49296-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210625101649.49296-1-dwagner@suse.de>
References: <20210625101649.49296-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not wait indifinitly for all queues to freeze. Instead use a
timeout and abort the operation if we get stuck.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a9645cd89eca..d8db85aa5417 100644
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

