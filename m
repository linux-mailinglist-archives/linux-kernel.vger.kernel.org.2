Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B967404809
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 11:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhIIJwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 05:52:08 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:30689 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230145AbhIIJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 05:52:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UnmeS9c_1631181024;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UnmeS9c_1631181024)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 09 Sep 2021 17:50:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] nvme: Fix missing error code in nvme_configure_directives()
Date:   Thu,  9 Sep 2021 17:50:21 +0800
Message-Id: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chongjiapeng <jiapeng.chong@linux.alibaba.com>

The error code is missing in this code scenario, add the error code
'-EINVAL' to the return value 'ret'.

Eliminate the follow smatch warning:

drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
error code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: f5d118406247 ("nvme: add support for streams and directives")
Signed-off-by: chongjiapeng <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7efb31b..84abf1f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -783,6 +783,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
 		dev_info(ctrl->device, "too few streams (%u) available\n",
 					ctrl->nssa);
+		ret = -EINVAL;
 		goto out_disable_stream;
 	}
 
-- 
1.8.3.1

