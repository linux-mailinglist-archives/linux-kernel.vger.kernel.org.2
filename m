Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838513BF796
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbhGHJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 05:31:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36018 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhGHJav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 05:30:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7BEAE21FD1;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXMw5odYC5q3FtwoS0u2DjqK6fjPg8pZT74QTDkWFwE=;
        b=Qv55vqoafuG/M0TBtVGf+0hCC9x0VbDwAz/osL6gh0wU4Xh2uThmZPoUDKAaUIUM4gnjsC
        elaDmHJnKpVbQwSF6pLR9+fBOzPl2swU3gAp9BRVl6POPPJ2G7Gkcp+6YZnyXWUUR7waU5
        iZpVfoYcSbFavPqJ6xJQxOKSEEzXIzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625736488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nXMw5odYC5q3FtwoS0u2DjqK6fjPg8pZT74QTDkWFwE=;
        b=GOcRbaYY7m+h3QxqYXNghwggvQNfKf6YAQjX/OeGUG5foxRxP20pywvX7MM6428OxvZPcR
        9xJxgEuwWQT+EtBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 71FDCA3B8A;
        Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
        id 63BBD5171152; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: [PATCH v2 4/5] nvme-fc: Wait with a timeout for queue to freeze
Date:   Thu,  8 Jul 2021 11:27:54 +0200
Message-Id: <20210708092755.15660-5-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708092755.15660-1-dwagner@suse.de>
References: <20210708092755.15660-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not wait indifinitly for all queues to freeze. Instead use a
timeout and abort the operation if we get stuck.

Reviewed-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d0eb81387d4e..8e1fc3796735 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2956,7 +2956,14 @@ nvme_fc_recreate_io_queues(struct nvme_fc_ctrl *ctrl)
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

