Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8727F30B860
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 08:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhBBHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 02:07:28 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36633 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhBBHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 02:07:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNfE5k-_1612249578;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNfE5k-_1612249578)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 02 Feb 2021 15:06:26 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     kbusch@kernel.org
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] nvme: convert sysfs sprintf/snprintf family to sysfs_emit
Date:   Tue,  2 Feb 2021 15:06:17 +0800
Message-Id: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./drivers/nvme/host/core.c:3580:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:3570:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:3560:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:3526:8-16: WARNING: use scnprintf or sprintf.
./drivers/nvme/host/core.c:2833:8-16: WARNING: use scnprintf or sprintf.

Reported-by: Abaci Robot<abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4d..5abbab3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2830,7 +2830,7 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", subsys->subnqn);
+	return sysfs_emit(buf, "%s\n", subsys->subnqn);
 }
 static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
 
@@ -3523,7 +3523,7 @@ static ssize_t nvme_sysfs_show_transport(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->ops->name);
+	return sysfs_emit(buf, "%s\n", ctrl->ops->name);
 }
 static DEVICE_ATTR(transport, S_IRUGO, nvme_sysfs_show_transport, NULL);
 
@@ -3557,7 +3557,7 @@ static ssize_t nvme_sysfs_show_subsysnqn(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->subsys->subnqn);
+	return sysfs_emit(buf, "%s\n", ctrl->subsys->subnqn);
 }
 static DEVICE_ATTR(subsysnqn, S_IRUGO, nvme_sysfs_show_subsysnqn, NULL);
 
@@ -3567,7 +3567,7 @@ static ssize_t nvme_sysfs_show_hostnqn(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s\n", ctrl->opts->host->nqn);
+	return sysfs_emit(buf, "%s\n", ctrl->opts->host->nqn);
 }
 static DEVICE_ATTR(hostnqn, S_IRUGO, nvme_sysfs_show_hostnqn, NULL);
 
@@ -3577,7 +3577,7 @@ static ssize_t nvme_sysfs_show_hostid(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%pU\n", &ctrl->opts->host->id);
+	return sysfs_emit(buf, "%pU\n", &ctrl->opts->host->id);
 }
 static DEVICE_ATTR(hostid, S_IRUGO, nvme_sysfs_show_hostid, NULL);
 
-- 
1.8.3.1

