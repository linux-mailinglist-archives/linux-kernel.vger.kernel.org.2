Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D7319BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBLJbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:31:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:60342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhBLJbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:31:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 89542B141;
        Fri, 12 Feb 2021 09:30:16 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme/hwmon: Return error code when registration fails
Date:   Fri, 12 Feb 2021 10:30:15 +0100
Message-Id: <20210212093015.2846-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwmon pointer wont be NULL if the registration fails. Though the
exit code path will assign it to ctrl->hwmon_device. Later
nvme_hwmon_exit() will try to free the invalid pointer. Avoid this by
returning the error code from hwmon_device_register_with_info().

Fixes: ec420cdcfab4 ("nvme/hwmon: rework to avoid devm allocation")
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

This patch is against linux-block/for-next.

 drivers/nvme/host/hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 8f9e96986780..0a586d712920 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -248,6 +248,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 	if (IS_ERR(hwmon)) {
 		dev_warn(dev, "Failed to instantiate hwmon device\n");
 		kfree(data);
+		return PTR_ERR(hwmon);
 	}
 	ctrl->hwmon_device = hwmon;
 	return 0;
-- 
2.29.2

