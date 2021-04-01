Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D153512CF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbhDAJy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:54:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:38144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233852AbhDAJyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:54:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A70BDAF5B;
        Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Chao Leng <lengchao@huawei.com>,
        Daniel Wagner <dwagner@suse.de>,
        Victor Gladkov <Victor.Gladkov@kioxia.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Himanshu Madhani <himanshu.madhaani@oracle.com>
Subject: [PATCH v2 3/3] nvme: Export fast_io_fail_tmo to sysfs
Date:   Thu,  1 Apr 2021 11:54:12 +0200
Message-Id: <20210401095412.84254-4-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 8c4dfea97f15 ("nvme-fabrics: reject I/O to offline device")
introduced fast_io_fail_tmo but didn't export the value to sysfs. The
value can be set during the 'nvme connect'. Export the timeout value
to user space via sysfs to allow runtime configuration.

Cc: Victor Gladkov <Victor.Gladkov@kioxia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhaani@oracle.com>
---
 drivers/nvme/host/core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d2b4c5567209..11fca6459812 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3696,6 +3696,36 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
 	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
 
+static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (ctrl->opts->fast_io_fail_tmo == -1)
+		return sysfs_emit(buf, "off\n");
+	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
+}
+
+static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	int fast_io_fail_tmo, err;
+
+	err = kstrtoint(buf, 10, &fast_io_fail_tmo);
+	if (err)
+		return -EINVAL;
+
+	if (fast_io_fail_tmo < 0)
+		opts->fast_io_fail_tmo = -1;
+	else
+		opts->fast_io_fail_tmo = fast_io_fail_tmo;
+	return count;
+}
+static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
+	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3715,6 +3745,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
+	&dev_attr_fast_io_fail_tmo.attr,
 	NULL
 };
 
-- 
2.29.2

