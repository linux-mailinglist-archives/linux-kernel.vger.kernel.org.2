Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058353512D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhDAJzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:55:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:38106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233845AbhDAJyV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:54:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F99AAF26;
        Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/3] nvme: Remove superflues else in nvme_ctrl_loss_tmo_store
Date:   Thu,  1 Apr 2021 11:54:11 +0200
Message-Id: <20210401095412.84254-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is an error we will leave the function early. So there
is no need for an else. Remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b94a30e7298d..d2b4c5567209 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3659,7 +3659,7 @@ static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	else if (ctrl_loss_tmo < 0)
+	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
 	else
 		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
-- 
2.29.2

